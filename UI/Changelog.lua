-- Onglet « Notes de version » : texte de Data/Changelog.lua à droite,
-- colonne des versions à gauche (UI/ChangelogCategories.lua).
-- La pastille de l'onglet est gérée par UI/MainWindow.lua avec HasUnseen /
-- MarkSeen.
local _, ns = ...

local L = ns.L
local Log = ns.Log

local Changelog = {}
ns.Changelog = Changelog

local HEADER_TEMPLATE = "HFFChangelogHeaderTemplate"
local HEADER_HEIGHT = 20
local HEADER_INSET = 20      -- le bandeau déborde de 20 de chaque côté (voir le modèle)
local AFTER_HEADER = 6       -- sous le bandeau, en plus de l'espace du premier bloc
local VERSION_GAP = 22       -- entre deux versions affichées à la suite
local BULLET_INDENT = 14     -- retrait du texte d'une puce
local LINE_SPACING = 2       -- interligne dans un texte sur plusieurs lignes

-- Espace avant chaque type de bloc.
local SPACE_BEFORE = {
	heading = 14,
	subheading = 10,
	bullet = 5,
	paragraph = 8,
}

local panel = nil            -- HFFAchievementFrame.Changelog
local content = nil          -- enfant défilant de panel.Scroll
local headerPool = nil
local fontStrings = {}       -- réutilisés d'un affichage à l'autre
local usedFontStrings = 0

local TEXT_KEY = GetLocale() == "frFR" and "frFR" or "enUS"

-- Texte -> blocs { kind, text }. Format décrit dans Data/Changelog.lua.
local function Parse(text)
	local blocks = {}
	for line in (text .. "\n"):gmatch("(.-)\n") do
		line = line:gsub("%s+$", "")
		if line ~= "" then
			local block
			if line:match("^### ") then
				block = { kind = "heading", text = line:sub(5) }
			elseif line:match("^%*%*[^*]+%*%*$") then
				block = { kind = "subheading", text = line:match("^%*%*(.-)%*%*$") }
			elseif line:match("^%- ") then
				block = { kind = "bullet", text = line:sub(3) }
			else
				block = { kind = "paragraph", text = line }
			end
			blocks[#blocks + 1] = block
		end
	end
	return blocks
end

-- **mot** dans une ligne : gras dans CHANGELOG.md, texte normal en jeu
-- (seuls les titres et sous-titres sont dorés).
local function StripBold(text)
	return (text:gsub("%*%*(.-)%*%*", "%1"))
end

local function AcquireFontString(fontObject)
	usedFontStrings = usedFontStrings + 1
	local fontString = fontStrings[usedFontStrings]
	if not fontString then
		fontString = content:CreateFontString(nil, "ARTWORK")
		fontString:SetJustifyH("LEFT")
		fontString:SetJustifyV("TOP")
		fontString:SetWordWrap(true)
		fontString:SetSpacing(LINE_SPACING)
		fontStrings[usedFontStrings] = fontString
	end
	fontString:SetFontObject(fontObject)
	fontString:ClearAllPoints()
	fontString:Show()
	return fontString
end

-- Pose un texte à (x, -y), renvoie sa hauteur.
local function PlaceText(fontObject, text, x, y, width)
	local fontString = AcquireFontString(fontObject)
	fontString:SetWidth(width)
	fontString:SetText(text)
	fontString:SetPoint("TOPLEFT", content, "TOPLEFT", x, -y)
	return fontString:GetStringHeight()
end

local function Clear()
	for i = 1, usedFontStrings do
		fontStrings[i]:Hide()
		fontStrings[i]:SetText("")
	end
	usedFontStrings = 0
	headerPool:ReleaseAll()
end

-- Affiche les versions données, à la suite, en haut du panneau.
local function Render(versions)
	Clear()
	local width = panel.Scroll:GetWidth()
	content:SetWidth(width)

	local y = 0
	for index, entry in ipairs(versions) do
		if index > 1 then
			y = y + VERSION_GAP
		end
		local header = headerPool:Acquire()
		header:ClearAllPoints()
		header:SetPoint("TOPLEFT", content, "TOPLEFT", HEADER_INSET, -y)
		header:SetPoint("TOPRIGHT", content, "TOPRIGHT", -HEADER_INSET, -y)
		header.Title:SetText(L.CHANGELOG_VERSION:format(entry.version))
		header:Show()
		y = y + HEADER_HEIGHT + AFTER_HEADER

		for _, block in ipairs(Parse(entry[TEXT_KEY] or entry.enUS or "")) do
			y = y + SPACE_BEFORE[block.kind]
			if block.kind == "heading" then
				y = y + PlaceText("GameFontNormalLarge", block.text, 0, y, width)
			elseif block.kind == "subheading" then
				y = y + PlaceText("GameFontNormal", block.text, 0, y, width)
			elseif block.kind == "bullet" then
				PlaceText("GameFontHighlight", "•", 4, y, BULLET_INDENT)
				y = y + PlaceText("GameFontHighlight", StripBold(block.text), BULLET_INDENT, y, width - BULLET_INDENT)
			else
				y = y + PlaceText("GameFontHighlight", StripBold(block.text), 0, y, width)
			end
		end
	end

	content:SetHeight(math.max(y + 8, 1))
	panel.Scroll:SetVerticalScroll(0)
	Log.Debug("Changelog:", #versions, "version(s) affichée(s)")
end

-- Une version plus récente que la dernière lue dans l'onglet.
function Changelog:HasUnseen()
	local latest = ns.Data.changelog[1]
	return latest ~= nil and ns.Database:GetChangelogSeen() ~= latest.version
end

function Changelog:MarkSeen()
	local latest = ns.Data.changelog[1]
	if latest then
		ns.Database:SetChangelogSeen(latest.version)
	end
end

-- À chaque arrivée sur l'onglet, panneau déjà affiché (sa largeur sert à la
-- mise en page).
function Changelog:OnTabShown()
	ns.ChangelogCategories:SelectLatest()
	self:MarkSeen()
end

-- Appelé une fois par MainWindow:Init.
function Changelog:Init(window)
	panel = window.Changelog
	content = panel.Scroll.Content
	headerPool = CreateFramePool("Frame", content, HEADER_TEMPLATE)
	ScrollUtil.InitScrollFrameWithScrollBar(panel.Scroll, panel.ScrollBar)
	ns.ChangelogCategories:Init(window.ChangelogCategories, Render)
	Log.Debug("Changelog: prêt")
end
