-- ATTACKPOWERDISPLAY

local APDMainFrame = CreateFrame('Button', 'APDMainFrame', UIParent)
local APDDragIcon = APDMainFrame:CreateTexture(nil, 'ARTWORK')
local APDDragBorder = CreateFrame('Frame', nil, APDMainFrame)

APDMainFrame:SetWidth(100)
APDMainFrame:SetHeight(40)
APDMainFrame:SetPoint('TOP', UIParent)

APDDragBorder:SetPoint('TOPLEFT', APDMainFrame, 'TOPLEFT')
APDDragBorder:SetPoint('BOTTOMRIGHT', APDMainFrame, 'BOTTOMRIGHT')
APDDragBorder:SetBackdrop({
    bgFile = 'Interface\\Tooltips\\UI-Tooltip-Background',
    edgeFile = 'Interface\\Tooltips\\UI-Tooltip-Border',
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
APDDragBorder:SetBackdropColor(0, 0, 0, 0.0)

APDDragIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
APDDragIcon:SetPoint('TOPLEFT', APDMainFrame, 'TOPLEFT', 4, -4)
APDDragIcon:SetPoint('BOTTOMRIGHT', APDMainFrame, 'BOTTOMRIGHT', -4, 4)

APDMainFrame:Hide()


local apdbutton = CreateFrame('Button', nil, UIParent)
local apdtext = apdbutton:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')

apdbutton.apdtext = apdtext

apdbutton:SetWidth(1)
apdbutton:SetHeight(1)
apdbutton:SetPoint('CENTER', APDMainFrame, 'CENTER')

apdtext:SetPoint('CENTER', apdbutton, 'CENTER', 0, 0)
apdtext:SetFont("Fonts\\FRIZQT__.TTF", 12)

local apdbase, apdbuff, apddebuff = UnitAttackPower("player")
apdtext:SetText('AP: ' .. (apdbase + apdbuff + apddebuff))

apdbutton:RegisterEvent('PLAYER_AURAS_CHANGED')




apdbutton:SetScript('OnEvent', function()

local apdbase, apdbuff, apddebuff = UnitAttackPower("player")
apdtext:SetText('AP: ' .. (apdbase + apdbuff + apddebuff))

end)


-- Tooltip Erstellung
CreateFrame('GameTooltip', 'APDToolTip', nil, 'GameTooltipTemplate')

-- Funktion für Bufftracking
function HasBuffName(buffName, unit)
    if not buffName or not unit then
        return false;
    end
    
    local text = getglobal(APDToolTip:GetName().."TextLeft1");
	for i=1, 32 do
		APDToolTip:SetOwner(UIParent, "ANCHOR_NONE");
		APDToolTip:SetUnitBuff(unit, i);
		name = text:GetText();
		APDToolTip:Hide();
        buffName = string.gsub(buffName, "_", " ");
		if ( name and string.find(name, buffName) ) then
			return true;
		end
    end
    
    return false;
end



-- BATTLESHOUT DISPLAY

local BSPMMainFrame = CreateFrame('Button', 'BSPMMainFrame', UIParent)
local BSPMDragIcon = BSPMMainFrame:CreateTexture(nil, 'ARTWORK')
local BSPMDragBorder = CreateFrame('Frame', nil, BSPMMainFrame)

BSPMMainFrame:SetWidth(120)
BSPMMainFrame:SetHeight(75)
BSPMMainFrame:SetPoint('CENTER', UIParent)

BSPMDragBorder:SetPoint('TOPLEFT', BSPMMainFrame, 'TOPLEFT')
BSPMDragBorder:SetPoint('BOTTOMRIGHT', BSPMMainFrame, 'BOTTOMRIGHT')
BSPMDragBorder:SetBackdrop({
    bgFile = 'Interface\\Tooltips\\UI-Tooltip-Background',
    edgeFile = 'Interface\\Tooltips\\UI-Tooltip-Border',
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
BSPMDragBorder:SetBackdropColor(0, 0, 0, 0.0)

BSPMDragIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
BSPMDragIcon:SetPoint('TOPLEFT', BSPMMainFrame, 'TOPLEFT', 4, -4)
BSPMDragIcon:SetPoint('BOTTOMRIGHT', BSPMMainFrame, 'BOTTOMRIGHT', -4, 4)

BSPMMainFrame:Hide()


local bspmbutton = CreateFrame('Button', nil, UIParent)
local bspmtextgrp1 = bspmbutton:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
local bspmtextgrp2 = bspmbutton:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
local bspmtextgrp3 = bspmbutton:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
local bspmtextgrp4 = bspmbutton:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')

bspmbutton.bspmtextgrp1 = bspmtextgrp1
bspmbutton.bspmtextgrp2 = bspmtextgrp2
bspmbutton.bspmtextgrp3 = bspmtextgrp3
bspmbutton.bspmtextgrp4 = bspmtextgrp4

bspmbutton:SetWidth(1)
bspmbutton:SetHeight(1)
bspmbutton:SetPoint('TOP', BSPMMainFrame, 'TOP')

bspmtextgrp1:SetPoint('CENTER', bspmbutton, 'CENTER', 0, -15)
bspmtextgrp1:SetFont("Fonts\\FRIZQT__.TTF", 10)

bspmtextgrp2:SetPoint('CENTER', bspmtextgrp1, 'CENTER', 0, -12)
bspmtextgrp2:SetFont("Fonts\\FRIZQT__.TTF", 10)

bspmtextgrp3:SetPoint('CENTER', bspmtextgrp2, 'CENTER', 0, -12)
bspmtextgrp3:SetFont("Fonts\\FRIZQT__.TTF", 10)

bspmtextgrp4:SetPoint('CENTER', bspmtextgrp3, 'CENTER', 0, -12)
bspmtextgrp4:SetFont("Fonts\\FRIZQT__.TTF", 10)



local partyTexts = { bspmtextgrp1, bspmtextgrp2, bspmtextgrp3, bspmtextgrp4 }


function bspmUpdate()
	if APD_Saved.bspmbuttonvisibility == 1 then
		local i, name, text
		for i = 1, 4 do
			name = UnitName("party"..i)
			text = partyTexts[i]
			if name then
				if apd_display_mode == 1 then
					if HasBuffName("Battle Shout", "party"..i) then
						text:SetText("|cff00ff00" .. name .. "|r")
					else
						text:SetText("|cffff0000" .. name .. "|r")
					end
					text:Show()
				else -- Modus 2
					if HasBuffName("Battle Shout", "party"..i) then
						text:Hide()
					else
						text:SetText("|cffff0000" .. name .. "|r")
						text:Show()
					end
				end
			else
				text:Hide()
			end
		end
	end
end


bspmbutton:RegisterEvent('UNIT_AURA')
bspmbutton:RegisterEvent('PARTY_MEMBERS_CHANGED')
bspmbutton:RegisterEvent('PLAYER_LOGIN')


bspmbutton:SetScript('OnEvent', function()
	local _,class = UnitClass('player')

	if class == 'WARRIOR' then
		bspmUpdate()
	end
end)




local locked = false
APDMainFrame:SetMovable(true)
APDMainFrame:RegisterForDrag('LeftButton')
APDMainFrame:SetScript('OnDragStart', function()
    if locked then
        return
    end
    APDMainFrame:StartMoving()
end)
APDMainFrame:SetScript('OnDragStop', function()
    APDMainFrame:StopMovingOrSizing()
	local point, relativeTo, relativePoint, xOfs, yOfs = this:GetPoint()
    APD_Saved.APDMainFrame = {point, relativePoint, xOfs, yOfs}
end)

BSPMMainFrame:SetMovable(true)
BSPMMainFrame:RegisterForDrag('LeftButton')
BSPMMainFrame:SetScript('OnDragStart', function()
    if locked then
        return
    end
    BSPMMainFrame:StartMoving()
end)
BSPMMainFrame:SetScript('OnDragStop', function()
    BSPMMainFrame:StopMovingOrSizing()
	local point, relativeTo, relativePoint, xOfs, yOfs = this:GetPoint()
    APD_Saved.BSPMMainFrame = {point, relativePoint, xOfs, yOfs}
end)


SLASH_AttackPowerDisplay1 = "/apd"
function SlashCmdList.AttackPowerDisplay(msg)
		if msg == 'lock' then
		APDMainFrame:Hide()
		BSPMMainFrame:Hide()
		elseif msg == 'unlock' then
		APDMainFrame:Show()
		BSPMMainFrame:Show()
		elseif msg == 'group hide' then
		bspmbutton:Hide()
		APD_Saved.bspmbuttonvisibility = 0
		elseif msg == 'group show' then
		bspmbutton:Show()
		APD_Saved.bspmbuttonvisibility = 1
		elseif msg == 'hide' then
		apdbutton:Hide()
		APD_Saved.apdbuttonvisibility = 0
		elseif msg == 'show' then
		apdbutton:Show()
		APD_Saved.apdbuttonvisibility = 1
		elseif msg == 'mode 1' then
		apd_display_mode = 1
		APD_Saved.apd_display_mode = 1
		elseif msg == 'mode 2' then
		apd_display_mode = 2
		APD_Saved.apd_display_mode = 2
		end
end


local apdinitFrame = CreateFrame("Frame")
apdinitFrame:RegisterEvent("PLAYER_LOGIN")
apdinitFrame:SetScript("OnEvent", function()
    if not APD_Saved then APD_Saved = {} end
    if not APD_Saved.apd_display_mode then
        APD_Saved.apd_display_mode = 1
    end
    apd_display_mode = APD_Saved.apd_display_mode

    -- Gespeicherte Positionen wiederherstellen
    if APD_Saved.APDMainFrame then
        local t = APD_Saved.APDMainFrame
        APDMainFrame:ClearAllPoints()
        APDMainFrame:SetPoint(t[1], UIParent, t[2], t[3], t[4])
    end
    if APD_Saved.BSPMMainFrame then
        local t = APD_Saved.BSPMMainFrame
        BSPMMainFrame:ClearAllPoints()
        BSPMMainFrame:SetPoint(t[1], UIParent, t[2], t[3], t[4])
    end
	if not APD_Saved.apdbuttonvisibility then
		APD_Saved.apdbuttonvisibility = 1
	end
	if not APD_Saved.bspmbuttonvisibility then
		APD_Saved.bspmbuttonvisibility = 1
	end
	if APD_Saved.apdbuttonvisibility then
		if APD_Saved.apdbuttonvisibility == 0 then
			apdbutton:Hide()
		end
	end
	if APD_Saved.bspmbuttonvisibility then
		if APD_Saved.bspmbuttonvisibility == 0 then
			bspmbutton:Hide()
		end
	end

end)