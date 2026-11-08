-- Toasts (popups) de haut fait obtenu, sur le modèle de retail.
-- Le visuel vient de UI/Toasts.xml (clone du modèle Blizzard).
--
-- File d'attente propre à l'addon : au plus MAX_VISIBLE toasts à l'écran,
-- empilés vers le haut ; les suivants attendent qu'une place se libère.
-- On n'utilise pas le système AlertFrame de Blizzard pour ne modifier
-- aucune de ses tables (risque de taint).
local _, ns = ...

local L = ns.L
local Log = ns.Log

local Toasts = {}
ns.Toasts = Toasts

local TEMPLATE = "HFFAchievementToastTemplate"
local MAX_VISIBLE = 3
local TOAST_HEIGHT = 101
local SPACING = 4
-- Au-dessus de la zone des alertes Blizzard (butin, etc.), qui commence à 128.
local ANCHOR_Y = 250
-- Son de haut fait : fichier sound/spells/achievmentsound1.ogg (FileDataID
-- trouvé dans la listfile communautaire wowdev/wow-listfile).
-- Sur Forever, le kit de son retail 12891 n'existe pas, et un fichier hors
-- du dossier Interface ne se joue que par son numéro, pas par son chemin.
local ACHIEVEMENT_SOUND_FILE = 569143
-- Plusieurs toasts affichés en même temps ne jouent le son qu'une fois
-- (sinon les sons s'additionnent et le volume explose).
local MIN_SOUND_INTERVAL = 1
local lastSoundTime = 0

-- Atlas utilisés par le modèle : vérifiés au démarrage.
local REQUIRED_ATLASES = {
	"ui-achievement-alert-background",
	"ui-achievement-iconframe",
	"ui-achievement-shield-2",
	"ui-achievement-alert-glow-glow",
	"ui-achievement-alert-glow-shine",
}

-- Bouclier sans chiffre (hauts faits à 0 point). Absent du client Forever
-- (vérifié en jeu) : on garde le bouclier normal, sans texte, à la place.
local SHIELD_NO_POINTS_ATLAS = "UI-Achievement-Shield-NoPoints"
local hasNoPointsShield = false

local pool = {}     -- toasts créés mais libres
local visible = {}  -- toasts affichés, du bas vers le haut
local queue = {}    -- toasts en attente : { title, name, icon, points, achievementID }

local ShowNext -- déclarée plus bas, utilisée par Release

-- Replace les toasts visibles les uns au-dessus des autres.
local function Relayout()
	for index, frame in ipairs(visible) do
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOM", UIParent, "BOTTOM", 0,
			ANCHOR_Y + (index - 1) * (TOAST_HEIGHT + SPACING))
	end
end

-- Retire un toast de l'écran et le remet dans la réserve.
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

-- Points dans le bouclier, comme AchievementShield_SetPoints de Blizzard :
-- police plus petite à partir de 100, bouclier sans chiffre pour 0 point.
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

local function OnClick(frame, mouseButton)
	Log.Debug("Toasts: clic", mouseButton, frame.achievementID)
	if mouseButton == "LeftButton" then
		ns.MainWindow:Toggle(frame.achievementID)
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
	-- Survol : le toast reste affiché tant que la souris est dessus.
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

-- Toast d'un haut fait obtenu.
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

-- Toast de résumé pour les hauts faits détectés à la connexion.
function Toasts:ShowSummary(count, points)
	Enqueue({
		title = L.TOAST_RETRO_TITLE,
		name = L.TOAST_RETRO_NAME:format(count),
		icon = ns.icon,
		points = points,
	})
end

-- Abonné du moteur : un toast par haut fait obtenu en direct, un seul
-- toast de résumé pour une détection rétroactive.
local function OnAchievementsEarned(achievementIDs, retroactive)
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

-- Appelé au chargement : vérifie les atlas et s'abonne au moteur.
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
