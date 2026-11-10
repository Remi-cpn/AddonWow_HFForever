-- Toasts de haut fait obtenu (cadre dans UI/Toasts.xml).
-- File d'attente propre : au plus MAX_VISIBLE à l'écran, empilés vers le
-- haut. Le système AlertFrame de Blizzard n'est pas utilisé, pour ne
-- modifier aucune de ses tables (taint).
local _, ns = ...

local L = ns.L
local Log = ns.Log

local Toasts = {}
ns.Toasts = Toasts

local TEMPLATE = "HFFAchievementToastTemplate"
local MAX_VISIBLE = 3
local TOAST_HEIGHT = 101
local SPACING = 4
-- Au-dessus des alertes Blizzard (butin), qui commencent à 128.
local ANCHOR_Y = 250
-- sound/spells/achievmentsound1.ogg. Le kit retail 12891 n'existe pas sur
-- Forever, et un fichier hors de Interface\ ne se joue que par FileDataID.
local ACHIEVEMENT_SOUND_FILE = 569143
-- Un seul son pour plusieurs toasts simultanés : les sons superposés
-- montent fort.
local MIN_SOUND_INTERVAL = 1
local lastSoundTime = 0

local REQUIRED_ATLASES = {
	"ui-achievement-alert-background",
	"ui-achievement-iconframe",
	"ui-achievement-shield-2",
	"ui-achievement-alert-glow-glow",
	"ui-achievement-alert-glow-shine",
}

-- Bouclier des hauts faits à 0 point. Absent du client Forever : le
-- bouclier normal, sans chiffre, le remplace.
local SHIELD_NO_POINTS_ATLAS = "UI-Achievement-Shield-NoPoints"
local hasNoPointsShield = false

local pool = {}     -- toasts libres, réutilisés
local visible = {}  -- du bas vers le haut
local queue = {}    -- { title, name, icon, points, achievementID }

local ShowNext -- Release et ShowNext s'appellent l'une l'autre

local function Relayout()
	for index, frame in ipairs(visible) do
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOM", UIParent, "BOTTOM", 0,
			ANCHOR_Y + (index - 1) * (TOAST_HEIGHT + SPACING))
	end
end

local function Release(frame)
	for index = #visible, 1, -1 do
		if visible[index] == frame then
			table.remove(visible, index)
		end
	end
	frame.waitAndAnimOut:Stop()
	frame:Hide()
	pool[#pool + 1] = frame
	Relayout()
	ShowNext()
end

-- AchievementShield_SetPoints : police plus petite à partir de 100 points.
local function SetShield(frame, points)
	local pointString = frame.Shield.Points
	if points == 0 then
		frame.Shield.Icon:SetAtlas(hasNoPointsShield and SHIELD_NO_POINTS_ATLAS
			or "ui-achievement-shield-2", true)
		pointString:SetText("")
		return
	end
	frame.Shield.Icon:SetAtlas("ui-achievement-shield-2", true)
	pointString:SetFontObject(points < 100 and GameFontNormal or GameFontNormalSmall)
	pointString:SetText(points)
end

-- Clic gauche : ouvre le haut fait, ou juste la fenêtre pour le toast
-- résumé (sans id). Toggle fermerait une fenêtre déjà ouverte.
-- Clic droit : ferme le toast.
local function OnClick(frame, mouseButton)
	Log.Debug("Toasts: clic", mouseButton, frame.achievementID)
	if mouseButton == "LeftButton" then
		if not (frame.achievementID and ns.MainWindow:ShowAchievement(frame.achievementID)) then
			ns.MainWindow:Show()
		end
	end
	Release(frame)
end

local function CreateToast()
	local frame = CreateFrame("Button", nil, UIParent, TEMPLATE)
	frame.waitAndAnimOut.animOut:SetScript("OnFinished", function()
		Release(frame)
	end)
	frame.glow.animIn:SetScript("OnFinished", function()
		frame.glow:Hide()
	end)
	frame.shine.animIn:SetScript("OnFinished", function()
		frame.shine:Hide()
	end)
	-- Le toast ne disparaît pas tant que la souris est dessus.
	frame:SetScript("OnEnter", function(self)
		self.waitAndAnimOut:Stop()
		self:SetAlpha(1)
	end)
	frame:SetScript("OnLeave", function(self)
		self.waitAndAnimOut:Play()
	end)
	frame:SetScript("OnClick", OnClick)
	return frame
end

local function Display(entry)
	local frame = table.remove(pool) or CreateToast()
	frame.achievementID = entry.achievementID
	frame.Unlocked:SetText(entry.title)
	frame.Name:SetText(entry.name)
	frame.Icon.Texture:SetTexture(entry.icon)
	SetShield(frame, entry.points)

	visible[#visible + 1] = frame
	Relayout()
	frame:SetAlpha(1)
	frame:Show()
	frame.animIn:Play()
	frame.glow:Show()
	frame.glow.animIn:Play()
	frame.shine:Show()
	frame.shine.animIn:Play()
	frame.waitAndAnimOut:Play()
	local now = GetTime()
	if ns.Database:IsToastSoundEnabled() and now - lastSoundTime >= MIN_SOUND_INTERVAL then
		PlaySoundFile(ACHIEVEMENT_SOUND_FILE)
		lastSoundTime = now
	end
	Log.Debug("Toasts: affiché", entry.name)
end

ShowNext = function()
	while #visible < MAX_VISIBLE and #queue > 0 do
		Display(table.remove(queue, 1))
	end
end

local function Enqueue(entry)
	queue[#queue + 1] = entry
	ShowNext()
end

function Toasts:ShowAchievement(achievementID)
	local id, name, points, _, _, _, _, _, _, icon = ns.API.GetAchievementInfo(achievementID)
	if not id then
		Log.Debug("Toasts: haut fait inconnu", achievementID)
		return
	end
	Enqueue({
		title = L.TOAST_UNLOCKED,
		name = name,
		icon = icon,
		points = points,
		achievementID = id,
	})
end

-- Un seul toast pour les hauts faits détectés à la connexion.
function Toasts:ShowSummary(count, points)
	Enqueue({
		title = L.TOAST_RETRO_TITLE,
		name = L.TOAST_RETRO_NAME:format(count),
		icon = ns.icon,
		points = points,
	})
end

-- Un toast par haut fait obtenu en direct, un seul résumé pour une
-- détection rétroactive. Désactivé dans les options, plus de toast : le
-- moteur écrit toujours dans le chat, et /hff toast passe outre.
local function OnAchievementsEarned(achievementIDs, retroactive)
	if not ns.Database:IsToastEnabled() then
		return
	end
	if retroactive then
		local points = 0
		for _, id in ipairs(achievementIDs) do
			points = points + (select(3, ns.API.GetAchievementInfo(id)) or 0)
		end
		Toasts:ShowSummary(#achievementIDs, points)
		return
	end
	for _, id in ipairs(achievementIDs) do
		Toasts:ShowAchievement(id)
	end
end

-- Appelé une fois à ADDON_LOADED.
function Toasts:Init()
	for _, atlas in ipairs(REQUIRED_ATLASES) do
		if not C_Texture.GetAtlasInfo(atlas) then
			Log.Error(L.TOAST_ATLAS_MISSING, atlas)
		end
	end
	hasNoPointsShield = C_Texture.GetAtlasInfo(SHIELD_NO_POINTS_ATLAS) ~= nil
	Log.Debug("Toasts: bouclier 0 point disponible =", hasNoPointsShield)
	ns.Engine:RegisterListener(OnAchievementsEarned)
end
