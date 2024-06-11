local addonName, addon = ...
addon.spellBars = addon.spellBars ~= nil and addon.spellBars or {}
addon.frameFactory = {}

function addon.frameFactory.infoFrame()
	local frameKey = addonName .. "_infoFrame"
	local infoFrame = CreateFrame("Frame", frameKey, UIParent)

	infoFrame:SetFrameStrata("BACKGROUND")
	infoFrame:Show()
	infoFrame:SetMovable(false)
	infoFrame:EnableMouse(false)
    infoFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)

	infoFrame.Text = infoFrame:CreateFontString()
	infoFrame.Text:SetFontObject(GameFontNormalLarge)

	infoFrame.Text:SetJustifyH("CENTER")
	infoFrame.Text:SetJustifyV("MIDDLE")	
	infoFrame.Text:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)

    local font = infoFrame.Text:GetFont()
	infoFrame.Text:SetFont(font, "50")
    infoFrame.Text:SetText("/rct lock")

	return infoFrame
end