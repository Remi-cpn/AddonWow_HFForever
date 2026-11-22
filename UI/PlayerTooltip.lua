-- Ligne « Haut fait : <points> <icône> » dans l'infobulle d'un joueur, s'il
-- a HF Forever (résumé demandé par Core/Comm.lua).
-- Pour soi-même, lu directement. Rien pour un joueur de l'autre camp : les
-- messages chuchotés ne passent pas d'un camp à l'autre.
local _, ns = ...

local L = ns.L

local PlayerTooltip = {}
ns.PlayerTooltip = PlayerTooltip

-- Place de la ligne : juste après les lignes écrites par le jeu, avant
-- celles des autres addons, sans jamais en déplacer une (un addon peut
-- retenir le numéro des siennes).
--   1. Crochet de ligne (AddLinePostCall) : appelé à chaque ligne écrite par
--      le jeu, avant les crochets d'infobulle des addons. La ligne est
--      ajoutée après la dernière ligne du jeu.
--   2. Secours, crochet d'infobulle (AddTooltipPostCall) : si la dernière
--      ligne du jeu n'a pas été écrite (masquée par un autre addon), la
--      ligne est ajoutée à la fin.
-- Une réponse arrivée après l'affichage reconstruit l'infobulle
-- (RefreshData) : la ligne, en mémoire cette fois, se place comme en 1.

-- Joueur dont la réponse est attendue pour l'infobulle affichée.
local pendingName = nil
-- true quand le crochet de ligne a agi pour l'infobulle en cours : le
-- secours ne la traite pas une seconde fois. Remis à zéro au vidage.
local handled = false
-- Ligne mise en gras, et sa police d'origine, rétablie au vidage de
-- l'infobulle (les lignes servent aussi aux autres infobulles).
local boldLine, boldFont = nil, nil

local function IsSecret(value)
	return issecretvalue ~= nil and issecretvalue(value)
end

-- « Haut fait : » en bleu, les points en blanc, puis le bouclier des points.
local LABEL_COLOR = "ff4da6ff"
local ICON_SIZE = 14
-- Pas de vrai gras dans les infobulles : un contour épaissit le texte.
local BOLD_FLAGS = "OUTLINE"

local function RestoreFont()
	if boldLine and boldFont then
		boldLine:SetFont(unpack(boldFont))
	end
	boldLine, boldFont = nil, nil
end

local function AddSummaryLine(tooltip, points)
	local text = ("|c%s%s|r %s %s"):format(LABEL_COLOR, L.TOOLTIP_LABEL,
		BreakUpLargeNumbers(points), ns.ShieldMarkup(ICON_SIZE))
	tooltip:AddLine(text, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	local line = _G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()]
	if line then
		RestoreFont()
		local path, size = line:GetFont()
		if path and size then
			boldLine, boldFont = line, { line:GetFont() }
			line:SetFont(path, size, BOLD_FLAGS)
		end
	end
end

-- « Nom-Royaume » du joueur de cette unité, ou nil (pas un joueur, autre
-- camp, valeur secrète). Sert aussi à UI/Inspect.lua.
function PlayerTooltip.GetPlayerName(unit)
	local isPlayer = UnitIsPlayer(unit)
	if IsSecret(isPlayer) or not isPlayer then
		return nil
	end
	local faction, myFaction = UnitFactionGroup(unit), UnitFactionGroup("player")
	if IsSecret(faction) or faction ~= myFaction then
		return nil
	end
	return ns.Comm.FullName(UnitFullName(unit))
end

-- Ajoute la ligne pour l'unité de l'infobulle, ou demande le résumé.
local function AddLineForUnit(tooltip)
	pendingName = nil
	local _, unit = tooltip:GetUnit()
	if not unit or IsSecret(unit) then
		return
	end
	local isMe = UnitIsUnit(unit, "player")
	if IsSecret(isMe) then
		return
	end
	if isMe then
		AddSummaryLine(tooltip, (ns.API.GetOwnSummary()))
		return
	end
	local name = PlayerTooltip.GetPlayerName(unit)
	if not name then
		return
	end
	local points = ns.Comm:GetSummary(name)
	if points then
		AddSummaryLine(tooltip, points)
	else
		pendingName = name
		ns.Comm:RequestSummary(name)
	end
end

-- 1. Après chaque ligne écrite par le jeu : agit sur la dernière d'une
-- infobulle d'unité. Le jeu note dans lineIndex le numéro de chaque ligne
-- écrite : la dernière ligne des données porte le numéro de la ligne qui
-- vient d'être écrite. (Comparaison par numéro : les données reçues peuvent
-- être une copie.)
local function OnLine(tooltip)
	if tooltip ~= GameTooltip or handled or not ns.Comm.ready then
		return
	end
	local info = tooltip.processingInfo
	local data = info and info.tooltipData
	if type(data) ~= "table" or data.type ~= Enum.TooltipDataType.Unit then
		return
	end
	local lines = data.lines
	local last = type(lines) == "table" and lines[#lines]
	if type(last) ~= "table" or last.lineIndex ~= tooltip:NumLines() then
		return
	end
	handled = true
	AddLineForUnit(tooltip)
end

-- 2. Secours, une fois toutes les lignes écrites.
local function OnUnitTooltip(tooltip)
	if tooltip ~= GameTooltip or handled or not ns.Comm.ready then
		return
	end
	handled = true
	AddLineForUnit(tooltip)
end

-- Réponse arrivée : l'infobulle est reconstruite si elle montre encore ce
-- joueur.
local function OnSummary(name)
	if name ~= pendingName or not GameTooltip:IsShown() then
		return
	end
	pendingName = nil
	local _, unit = GameTooltip:GetUnit()
	if not unit or IsSecret(unit) or PlayerTooltip.GetPlayerName(unit) ~= name then
		return
	end
	if GameTooltip.RefreshData then
		GameTooltip:RefreshData()
	else
		local points = ns.Comm:GetSummary(name)
		if points then
			AddSummaryLine(GameTooltip, points)
			GameTooltip:Show()
		end
	end
end

-- Crochets posés dès le chargement du fichier. Ils ne font rien avant
-- Comm:Init.
TooltipDataProcessor.AddLinePostCall(TooltipDataProcessor.AllTypes, OnLine)
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, OnUnitTooltip)

-- Appelé au PLAYER_LOGIN, après Comm:Init.
function PlayerTooltip:Init()
	GameTooltip:HookScript("OnTooltipCleared", function()
		pendingName = nil
		handled = false
		RestoreFont()
	end)
	ns.Comm:RegisterListener(OnSummary)
end
