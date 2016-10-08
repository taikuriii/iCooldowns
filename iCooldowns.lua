local _, iCD = ...
--options---------
iCD.font = 'Interface\\AddOns\\iMedia\\ap.ttf'
iCD.fontSize = 14
local sounds = {
	default = 'Interface\\AddOns\\iCooldowns\\Media\\Kachink.ogg',
	text1 = 'Interface\\AddOns\\iCooldowns\\Media\\Text1.ogg',
	text2 = 'Interface\\AddOns\\iCooldowns\\Media\\Text2.ogg',
}
iCD.rowSizes = {
	['row1'] = 20,
	['row2'] = 20,
	['row3'] = 20,
	['row4'] = 24,
	['row5'] = 32,
	['buffsI'] = 20,
	['buffsC'] = 20,
}
iCD.direction = { -- horizontal = true
	['row1'] = true,
	['row2'] = true,
	['row3'] = true,
	['row4'] = true,
	['row5'] = false,
	['buffsI'] = true,
	['buffsC'] = true,
}
--end-of-options--
iCD.backdrop = {
	bgFile = 'Interface\\Buttons\\WHITE8x8',
	edgeFile = 'Interface\\Buttons\\WHITE8x8',
	edgeSize = 1,
	insets = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	}
}
iCD.barBD = {
	bgFile = 'Interface\\Buttons\\WHITE8x8',
	edgeFile = 'Interface\\Buttons\\WHITE8x8',
	edgeSize = 1,
	insets = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	}
}
iCD.onCD = {}
iCD.buffs = {}
iCD.BuffsI = {}
iCD.BuffsC = {}
iCD.debuffs = {}
iCD.DebuffsI = {}
iCD.DebuffsC = {}
iCD.spells = {}
iCD.extras = {}
local buffFrames = {
	['row5'] = true,
	['buffsI'] = true,
	['buffsC'] = true,
}
local function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end
local addon = CreateFrame('Frame')
addon:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

--Health bar

iCD.hpBar = CreateFrame('Statusbar', 'iCD_Health', UIParent)
iCD.hpBar:SetStatusBarTexture('Interface\\Buttons\\WHITE8x8')
iCD.hpBar:SetWidth(220)
iCD.hpBar:SetHeight(16)
iCD.hpBar:SetStatusBarColor(0.1,0.1,0.1,1)
iCD.hpBar:SetMinMaxValues(0,1)
iCD.hpBar:SetValue(0)
iCD.hpBar:SetPoint('TOP', UIParent, 'CENTER', 0,-150)
iCD.hpBar:SetBackdrop(iCD.barBD)
iCD.hpBar:SetBackdropBorderColor(0,0,0,1)
iCD.hpBar:SetBackdropColor(0,0,0,0)

iCD.hpBar.flash = iCD.hpBar:CreateAnimationGroup()
iCD.hpBar.flash:SetLooping('REPEAT')
iCD.hpBar.flash:HookScript('OnPlay', function()
	iCD.hpBar.anim = true
end)
iCD.hpBar.flash:HookScript('OnStop', function()
	iCD.hpBar.anim = false
end)
iCD.hpBar.fadeOut = iCD.hpBar.flash:CreateAnimation('Alpha')
iCD.hpBar.fadeOut:SetDuration(0.15)
iCD.hpBar.fadeOut:SetFromAlpha(1)
iCD.hpBar.fadeOut:SetToAlpha(0)
iCD.hpBar.fadeOut:SetOrder(1)

iCD.hpBar.fadeIn = iCD.hpBar.flash:CreateAnimation('Alpha')
iCD.hpBar.fadeIn:SetDuration(0.15)
iCD.hpBar.fadeIn:SetFromAlpha(0)
iCD.hpBar.fadeIn:SetToAlpha(1)
iCD.hpBar.fadeIn:SetOrder(2)

--EH text
iCD.EHtext = iCD.hpBar:CreateFontString()
iCD.EHtext:SetFont(iCD.font, 16, 'OUTLINE')
iCD.EHtext:SetPoint('BOTTOM', iCD.hpBar, 'TOP', 0,115)
iCD.EHtext:SetText('')

--row1
iCD.row1 = CreateFrame('frame', nil, UIParent)
iCD.row1:SetSize(100,20)
--iCD.row1:SetBackdrop(iCD.backdrop)
--iCD.row1:SetBackdropBorderColor(0,0,0,1)
--iCD.row1:SetBackdropColor(0.2,0.2,0.2,0.5)
iCD.row1:SetPoint('BOTTOM', iCD.hpBar, 'TOP',0,63)
--row2
iCD.row2 = CreateFrame('frame', nil, UIParent)
iCD.row2:SetSize(100,20)
--iCD.row2:SetBackdrop(iCD.backdrop)
--iCD.row2:SetBackdropBorderColor(0,0,0,1)
--iCD.row2:SetBackdropColor(0.2,0.2,0.2,0.5)
iCD.row2:SetPoint('BOTTOM', iCD.hpBar, 'TOP',0,42)
-- Row 3
iCD.row3 = CreateFrame('frame', nil, UIParent)
iCD.row3:SetSize(100,20)
iCD.row3:SetPoint('BOTTOMRIGHT', iCD.hpBar, 'TOP',-25,115)
-- Row 4 (only on cd)
iCD.row4 = CreateFrame('frame', nil, UIParent)
iCD.row4:SetSize(iCD.rowSizes.row4,iCD.rowSizes.row4)
iCD.row4:SetPoint('BOTTOM', iCD.hpBar, 'TOP',0,17)
-- Row 5 Big Buffs
iCD.row5 = CreateFrame('frame', nil, UIParent)
iCD.row5:SetSize(iCD.rowSizes.row5,iCD.rowSizes.row5)
iCD.row5:SetPoint('BOTTOMRIGHT', iCD.hpBar, 'BOTTOMLEFT',0,100)

-- Buffs (Important)
iCD.buffsI = CreateFrame('frame', nil, UIParent)
iCD.buffsI:SetSize(iCD.rowSizes.buffsI,iCD.rowSizes.buffsI)
iCD.buffsI:SetPoint('BOTTOMLEFT', iCD.hpBar, 'TOP',25,115)

-- Buffs (center)
iCD.buffsC = CreateFrame('frame', nil, UIParent)
iCD.buffsC:SetSize(iCD.rowSizes.buffsC,iCD.rowSizes.buffsC)
iCD.buffsC:SetPoint('BOTTOM', iCD.hpBar, 'TOP',0,88)

-- GCD
iCD.GCD = CreateFrame('Statusbar', nil, UIParent)
iCD.GCD:SetStatusBarTexture('Interface\\Buttons\\WHITE8x8')
iCD.GCD:SetWidth(109)
iCD.GCD:SetHeight(11)
iCD.GCD:SetStatusBarColor(1,0.5,0,1)
iCD.GCD:SetMinMaxValues(0,1)
iCD.GCD:SetValue(0)
iCD.GCD:SetPoint('TOPLEFT', iCD.hpBar, 'BOTTOMLEFT', 0,-1)
iCD.GCD:SetBackdrop(iCD.barBD)
iCD.GCD:SetBackdropBorderColor(0,0,0,1)
iCD.GCD:SetBackdropColor(0,0,0,0)

-- Anchor for texts above health bar
iCD.textAnchor = CreateFrame('frame', nil, UIParent)
iCD.textAnchor:SetSize(40,20)
iCD.textAnchor:SetPoint('BOTTOM', iCD.hpBar, 'TOP',0,2)

--Power Text
iCD.powerText = iCD.GCD:CreateFontString('iCD_powerText')
iCD.powerText:SetFont(iCD.font, 16, 'OUTLINE')
iCD.powerText:SetJustifyH('RIGHT')
iCD.powerText:SetPoint('BOTTOMRIGHT', UIParent, 'CENTER', -120, -150)
iCD.powerText:SetText('')

iCD.frames = {
	row1 = {},
	row2 = {},
	row3 = {},
	row4 = {},
	row5 = {},
	buffsI = {},
	buffsC = {},
}
iCD.textFrames = {}
function iCD:createTextString(id)
	if not iCD.textFrames[id] then
		iCD.textFrames[id] = iCD.textAnchor:CreateFontString()
		iCD.textFrames[id]:SetFont(iCD.font, 12, 'OUTLINE')
		iCD.textFrames[id]:SetWidth(25)
		if id == 1 then
			iCD.textFrames[id]:SetPoint('LEFT', iCD.textAnchor, 'LEFT', 0,0)
		else
			iCD.textFrames[id]:SetPoint('LEFT', iCD.textFrames[id-1], 'RIGHT', 0,0)
		end
	end
end
function iCD:updateFrame(id, row)
	local data = iCD.frames[row][id].data
	if buffFrames[row] then
		local text = data.endTime-GetTime()
		if text > 60 then
			local s = (math.floor(text * 10 + 0.5) / 10)%60
			local m = math.floor(text/60)
			iCD.frames[row][id].cooldownText:SetFormattedText('%d:%.2d', m,s)
		elseif text > 5 then
			iCD.frames[row][id].cooldownText:SetFormattedText('%.0f', text)
		elseif text > 0 then
			iCD.frames[row][id].cooldownText:SetFormattedText('|cffff1a1a%.1f', text)
		else
			iCD.frames[row][id].cooldownText:SetText('')
		end
		if text <= 3 then
			if not iCD.frames[row][id].anim then
				iCD.frames[row][id]:SetAlpha(1)
				iCD.frames[row][id].flash:Play()
			end
		elseif iCD.frames[row][id].anim then
			iCD.frames[row][id]:SetAlpha(1)
			iCD.frames[row][id].flash:Stop()
		end
	else
		local cost = false
		local range = false
		if data.customCost then
			if not data.customCost() then
				cost = true
			end
		elseif data.cost then 
			if select(2, IsUsableSpell(data.spellName)) then
				cost = true
			end
		end
		if data.customRange then
			if not data.customRange() then
				range = true
			end
		elseif data.range then
			if IsSpellInRange(data.spellName, 'target') == 0 then
				range = true
			end
		end
		if range then 
			if data.unMod ~= 'range' then
				iCD.frames[row][id].tex:SetVertexColor(1,0,0,1)
				iCD.frames[row][id].data.unMod = 'range'
			end
		elseif cost then
			if data.unMod ~= 'cost' then
				iCD.frames[row][id].tex:SetVertexColor(0.5,0.5,1,1)
				iCD.frames[row][id].data.unMod = 'cost'
			end
		else
			if data.unMod ~= 'none' then
				iCD.frames[row][id].tex:SetVertexColor(1,1,1,1)
				iCD.frames[row][id].data.unMod = 'none'
			end
		end
		local text = 0
		if data.customText then
			text = data.customText()
			iCD.frames[row][id].cooldownText:SetText(text)
		else
			local s, cd = 0,0
			if data.customDuration then
				text = data.customDuration - GetTime()
			else
				if data.charges then
					local c,m,sd,d = GetSpellCharges(data.usedBy)
					if c == m then
						s = 0
						cd = d
					else
						s = sd
						cd = d
					end
				elseif data.item then
					s,cd = GetItemCooldown(data.usedBy)				
				else
					s,cd = GetSpellCooldown(data.usedBy)
				end
				local cdD = s+cd-GetTime()
				if s > 0 then
					if data.ignoreGCD then
						text = cdD
					else
						local gS, gcdD = GetSpellCooldown(iCD.gcd)
						local gCD = gS+gcdD-GetTime()
						if (gCD + 0.05) < cdD then
							text = cdD
						end
					end
				end
			end
			if row == 'row2' then
				if not iCD.frames[row][id].onCD and text > 0 then
					iCD.frames[row][id]:SetAlpha(0.35)
					iCD.frames[row][id].onCD = true
				elseif text == 0 and iCD.frames[row][id].onCD then
					iCD.frames[row][id]:SetAlpha(1)
					iCD.frames[row][id].onCD = false
				end
			end
				
			if text > 60 then
				local s = (math.floor(text * 10 + 0.5) / 10)%60
				local m = math.floor(text/60)
				iCD.frames[row][id].cooldownText:SetFormattedText('%d:%.2d', m,s)
			elseif text > 5 then
				iCD.frames[row][id].cooldownText:SetFormattedText('%.0f', text)
			elseif text > 0 then
				iCD.frames[row][id].cooldownText:SetFormattedText('|cffff1a1a%.1f', text)
			else
				if row == 'row4' then
					iCD:updateCDs()
				else
					iCD.frames[row][id].cooldownText:SetText('')
				end
			end
		end
		if data.stackFunc then
			iCD.frames[row][id].stackText:SetText(data.stackFunc())
		elseif data.stack then
			local c,m,sd,d = GetSpellCharges(data.usedBy)
			iCD.frames[row][id].stackText:SetText(c)
		end
	end
end
function iCD:CreateNewFrame(id, row)
	--row = 'row' .. row
	--Create frame
	if iCD.frames[row][id] then
		iCD.frames[row][id].cooldownText:SetText('')
		iCD.frames[row][id].stackText:SetText('')
		iCD.frames[row][id]:SetAlpha(1)
		return
	end
	iCD.frames[row][id] = CreateFrame('frame',nil,iCD[row])
	iCD.frames[row][id]:SetSize(iCD.rowSizes[row],iCD.rowSizes[row])
	--Backdrop
	iCD.frames[row][id]:SetBackdrop(iCD.backdrop)
	iCD.frames[row][id]:SetBackdropColor(0.2,0.2,0.2,0.5)
	iCD.frames[row][id]:SetBackdropBorderColor(0,0,0,1)
	iCD.frames[row][id]:SetFrameStrata('MEDIUM')
	if iCD.direction[row] then
		if id == 1 then
			iCD.frames[row][id]:SetPoint('LEFT', iCD[row] , 'LEFT', 0, 0)
		else
			iCD.frames[row][id]:SetPoint('LEFT', iCD.frames[row][id-1], 'RIGHT', 1, 0)
		end
	else
		if id == 1 then
			iCD.frames[row][id]:SetPoint('BOTTOM', iCD[row] , 'BOTTOM', 0, 0)
		else
			iCD.frames[row][id]:SetPoint('BOTTOM', iCD.frames[row][id-1], 'TOP', 0, 1)
		end	
	end
	--Icon
	iCD.frames[row][id].tex = iCD.frames[row][id]:CreateTexture()
	iCD.frames[row][id].tex:SetAllPoints(iCD.frames[row][id])
	--Cooldown
	iCD.frames[row][id].cooldownText = iCD.frames[row][id]:CreateFontString()
	
	if row == 'row5' then
		iCD.frames[row][id].cooldownText:SetFont(iCD.font, iCD.fontSize+4, 'OUTLINE')
		iCD.frames[row][id].cooldownText:SetPoint('CENTER', iCD.frames[row][id], 'CENTER', 0,0)
	else
		iCD.frames[row][id].cooldownText:SetFont(iCD.font, iCD.fontSize, 'OUTLINE')
		iCD.frames[row][id].cooldownText:SetPoint('BOTTOM', iCD.frames[row][id], 'BOTTOM', 0,0)
	end
	iCD.frames[row][id].cooldownText:SetTextColor(1,1,0.1,1)
	--Stack
	iCD.frames[row][id].stackText = iCD.frames[row][id]:CreateFontString()
	iCD.frames[row][id].stackText:SetFont(iCD.font, 12, 'OUTLINE')
	if row == 'row4' then
		iCD.frames[row][id].stackText:SetPoint('TOPRIGHT', iCD.frames[row][id], 'TOPRIGHT', 0,0)
	elseif row == 'buffsI' or row == 'buffsC' then
		iCD.frames[row][id].stackText:SetPoint('RIGHT', iCD.frames[row][id], 'TOPRIGHT', 0,0)
	else
		iCD.frames[row][id].stackText:SetPoint('CENTER', iCD.frames[row][id], 'TOPRIGHT', 0,0)
	end
	iCD.frames[row][id].stackText:SetTextColor(1,1,1,1)
	--Flash (glow)
	iCD.frames[row][id].flash = iCD.frames[row][id]:CreateAnimationGroup()
	iCD.frames[row][id].flash:SetLooping('REPEAT')
	iCD.frames[row][id].flash:HookScript('OnPlay', function()
		iCD.frames[row][id].anim = true
	end)
	iCD.frames[row][id].flash:HookScript('OnStop', function()
		iCD.frames[row][id].anim = false
	end)
	iCD.frames[row][id].fadeOut = iCD.frames[row][id].flash:CreateAnimation('Alpha')
	iCD.frames[row][id].fadeOut:SetDuration(0.25)
	iCD.frames[row][id].fadeOut:SetFromAlpha(1)
	iCD.frames[row][id].fadeOut:SetToAlpha(0)
	iCD.frames[row][id].fadeOut:SetOrder(1)

	iCD.frames[row][id].fadeIn = iCD.frames[row][id].flash:CreateAnimation('Alpha')
	iCD.frames[row][id].fadeIn:SetDuration(0.25)
	iCD.frames[row][id].fadeIn:SetFromAlpha(0)
	iCD.frames[row][id].fadeIn:SetToAlpha(1)
	iCD.frames[row][id].fadeIn:SetOrder(2)
end
function iCD:updateCDs()
	local temp = {}
	local tempExtras
	for k,v in pairs(iCD.extras) do
		local dura = v.customDuration - GetTime()
		if dura > 0 then
			temp[k] = v
			temp[k].duration = dura
		end
	end
	for k,v in pairs(iCD.onCD) do
		local s, cd
		if v.charges then
			local c,m,sd,d = GetSpellCharges(k)
			if c == m then
				s = 0
				cd = d
			else
				s = sd
				cd = d
			end
		elseif v.item then
			s, cd = GetItemCooldown(k)
		else
			s,cd = GetSpellCooldown(k)
		end
		local cdD = s+cd-GetTime()
		local dura = 0
		if s > 0 then
			if v.ignoreGCD then
				dura = cdD
			else
				local gS, gcdD = GetSpellCooldown(iCD.gcd)
				local gCD = gS+gcdD-GetTime()
				if (gCD + 0.05) < cdD then
					dura = cdD
				end
			end
		end
		if dura > 0 then
			v.duration = dura
			temp[k] = v
		end
	end
	local id = 1
	for k,v in spairs(temp, function(t,a,b) return t[b].duration > t[a].duration end) do
		iCD:CreateNewFrame(id, 'row4')
		iCD.frames.row4[id].data = {}
		iCD.frames.row4[id].data.usedBy = k
		--iCD.frames.row4[id].data.spellName = GetSpellInfo(k)
		if v.customDuration then
			iCD.frames.row4[id].data.customDuration = v.customDuration
		end
		if v.item then
			iCD.frames.row4[id].data.item = true
			local itemName,_,_,_,_,_,_,_,_,icon = GetItemInfo(k)
			iCD.frames.row4[id].data.spellName = itemName
			iCD.frames.row4[id].tex:SetTexture(icon)
		else
			iCD.frames.row4[id].data.spellName = GetSpellInfo(k)
			iCD.frames.row4[id].tex:SetTexture(GetSpellTexture(k))
		end
		if v.stackFunc then
			iCD.frames.row4[id].data.stackFunc = v.stackFunc
		elseif v.stack then
			iCD.frames.row4[id].data.stack = true
		end
		if v.customText then
			iCD.frames.row4[id].data.customText = v.customText
		end
		if v.ignoreGCD then
			iCD.frames.row4[id].data.ignoreGCD = true
		end
		if v.charges then
			iCD.frames.row4[id].data.charges = true
		end
		iCD.frames.row4[id].tex:SetVertexColor(1,1,1,1)
		iCD.frames.row4[id].data.unMod = 'none'
		iCD.frames.row4[id]:Show()
		id = id + 1
	end
	iCD.row4:SetWidth((id-1)*(iCD.rowSizes.row4+1)-1)
	for i = id, #iCD.frames.row4 do
		iCD.frames.row4[i].data = {}
		iCD.frames.row4[i]:Hide()
	end
end
function iCD:updateOnCD()
	if not iCD.class or not iCD.specID then
		return
	end
	local temp = {}
	for k,v in pairs(iCD[iCD.class][iCD.specID].row4) do
		if not v.showFunc or (v.showFunc and v.showFunc()) then
			temp[k] = v
		end
	end	
	for k,v in pairs(iCD[iCD.class].all.row4) do
		if not v.showFunc or (v.showFunc and v.showFunc()) then
			temp[k] = v
		end
	end	
	iCD.onCD = temp
	iCD:updateCDs()
end
function iCD:updateBuffs()
	local temp = {}
	local tempI = {}
	local tempC = {}
	for i = 1, 41 do -- Buffs
		local name, _, icon, count, debuffType, duration, expirationTime, _, _, _, spellID = UnitBuff('player', i)
		if not name then
			break
		else
			if iCD.buffs[spellID] then
				local data = {
					endTime = expirationTime,
					texture = icon,
				}
				if iCD.buffs[spellID].stack then
					if type(iCD.buffs[spellID].stack) == 'string' then
						data.stack = iCD.buffs[spellID].stack
					else
						data.stack = count
					end
				end
				temp[spellID] = data
			end
			if iCD.BuffsI[spellID] then
				local data = {
					endTime = expirationTime,
					texture = icon,
				}
				if iCD.BuffsI[spellID].stack then
					if type(iCD.BuffsI[spellID].stack) == 'string' then
						data.stack = iCD.BuffsI[spellID].stack
					else
						data.stack = count
					end
				end
				tempI[spellID] = data
			end
			if iCD.BuffsC[spellID] then
				local data = {
					endTime = expirationTime,
					texture = icon,
				}
				if iCD.BuffsC[spellID].stack then
					if type(iCD.BuffsC[spellID].stack) == 'string' then
						data.stack = iCD.BuffsC[spellID].stack
					else
						data.stack = count
					end
				end
				tempC[spellID] = data
			end
		end
	end
	for i = 1, 41 do -- Debuffs
		local name, _, icon, count, debuffType, duration, expirationTime, _, _, _, spellID = UnitDebuff('target', i, 'player')
		if not name then
			break
		else
			if iCD.debuffs[spellID] then
				local data = {
					endTime = expirationTime,
					texture = icon,
				}
				if iCD.debuffs[spellID].stack then
					if type(iCD.debuffs[spellID].stack) == 'string' then
						data.stack = iCD.debuffs[spellID].stack
					else
						data.stack = count
					end
				end
				temp[spellID] = data
				
			end
			if iCD.DebuffsI[spellID] then
				local data = {
					endTime = expirationTime,
					texture = icon,
				}
				if iCD.DebuffsI[spellID].stack then
					if type(iCD.DebuffsI[spellID].stack) == 'string' then
						data.stack = iCD.DebuffsI[spellID].stack
					else
						data.stack = count
					end
				end
				tempI[spellID] = data
			end
			if iCD.DebuffsC[spellID] then
				local data = {
					endTime = expirationTime,
					texture = icon,
				}
				if iCD.DebuffsC[spellID].stack then
					if type(iCD.DebuffsC[spellID].stack) == 'string' then
						data.stack = iCD.DebuffsC[spellID].stack
					else
						data.stack = count
					end
				end
				tempC[spellID] = data
			end
		end
	end
	local id = 1
	for k,v in spairs(temp, function(t,a,b) return t[b].endTime > t[a].endTime end) do
		iCD:CreateNewFrame(id, 'row5')
		iCD.frames.row5[id].data = {}
		iCD.frames.row5[id].data.usedBy = k
		iCD.frames.row5[id].data.endTime = v.endTime
		iCD.frames.row5[id].data.spellName = GetSpellInfo(k)
		if v.stackFunc then
			iCD.frames.row5[id].data.stackFunc = v.stackFunc
		elseif v.stack then
			iCD.frames.row5[id].stackText:SetText(v.stack)
		else
			iCD.frames.row5[id].stackText:SetText('')
		end
		if v.customText then
			iCD.frames.row5[id].data.customText = v.customText
		end
		iCD.frames.row5[id].tex:SetTexture(GetSpellTexture(k))
		iCD.frames.row5[id].tex:SetVertexColor(1,1,1,1)
		iCD.frames.row5[id].data.unMod = 'none'
		iCD.frames.row5[id]:Show()
		id = id + 1
	end
	iCD.row5:SetHeight((id-1)*(iCD.rowSizes.row5+1)-1)
	for i = id, #iCD.frames.row5 do
		iCD.frames.row5[i].data = {}
		iCD.frames.row5[i]:Hide()
	end
	id = 1
	for k,v in spairs(tempI, function(t,a,b) return t[b].endTime > t[a].endTime end) do
		iCD:CreateNewFrame(id, 'buffsI')
		iCD.frames.buffsI[id].data = {}
		iCD.frames.buffsI[id].data.usedBy = k
		iCD.frames.buffsI[id].data.endTime = v.endTime
		iCD.frames.buffsI[id].data.spellName = GetSpellInfo(k)
		if v.stackFunc then
			iCD.frames.buffsI[id].data.stackFunc = v.stackFunc
		elseif v.stack then
			iCD.frames.buffsI[id].stackText:SetText(v.stack)
		else
			iCD.frames.buffsI[id].stackText:SetText('')
		end
		if v.customText then
			iCD.frames.buffsI[id].data.customText = v.customText
		end
		iCD.frames.buffsI[id].tex:SetTexture(GetSpellTexture(k))
		iCD.frames.buffsI[id].tex:SetVertexColor(1,1,1,1)
		iCD.frames.buffsI[id].data.unMod = 'none'
		iCD.frames.buffsI[id]:Show()
		id = id + 1
	end
	iCD.buffsI:SetWidth((id-1)*(iCD.rowSizes.buffsI+1)-1)
	for i = id, #iCD.frames.buffsI do
		iCD.frames.buffsI[i].data = {}
		iCD.frames.buffsI[i]:Hide()
	end
	
	id = 1
	for k,v in spairs(tempC, function(t,a,b) return t[b].endTime > t[a].endTime end) do
		iCD:CreateNewFrame(id, 'buffsC')
		iCD.frames.buffsC[id].data = {}
		iCD.frames.buffsC[id].data.usedBy = k
		iCD.frames.buffsC[id].data.endTime = v.endTime
		iCD.frames.buffsC[id].data.spellName = GetSpellInfo(k)
		if v.stackFunc then
			iCD.frames.buffsC[id].data.stackFunc = v.stackFunc
		elseif v.stack then
			iCD.frames.buffsC[id].stackText:SetText(v.stack)
		else
			iCD.frames.buffsC[id].stackText:SetText('')
		end
		if v.customText then
			iCD.frames.buffsC[id].data.customText = v.customText
		end
		iCD.frames.buffsC[id].tex:SetTexture(GetSpellTexture(k))
		iCD.frames.buffsC[id].tex:SetVertexColor(1,1,1,1)
		iCD.frames.buffsC[id].data.unMod = 'none'
		iCD.frames.buffsC[id]:Show()
		id = id + 1
	end
	iCD.buffsC:SetWidth((id-1)*(iCD.rowSizes.buffsC+1)-1)
	for i = id, #iCD.frames.buffsC do
		iCD.frames.buffsC[i].data = {}
		iCD.frames.buffsC[i]:Hide()
	end
end
function iCD:updateBuffList()
	if not iCD.class or not iCD.specID then
		return
	end
	local function addIfEligible(spellID,v,b,d)
		if v.showFunc then
			if not v.showFunc() then return end
		end
		if v.itemReq then
			if type(v.itemReq) == 'table' then
				for k,_ in pairs(v.itemReq) do
					if not IsEquippedItem(k) then return end
				end
			else
				if not IsEquippedItem(v.itemReq) then return end
			end
		end
		if v.debuff then
			d[spellID] = v
		else
			b[spellID] = v
		end
	end
	local tempBuffs = {}
	local tempDebuffs = {}

	for k,v in pairs(iCD[iCD.class][iCD.specID].row5) do
		addIfEligible(k,v, tempBuffs, tempDebuffs)
	end	
	for k,v in pairs(iCD[iCD.class].all.row5) do
		addIfEligible(k,v, tempBuffs, tempDebuffs)
	end
	for k,v in pairs(iCD.general.row5) do
		addIfEligible(k,v, tempBuffs, tempDebuffs)
	end
	iCD.buffs = tempBuffs
	iCD.debuffs = tempDebuffs
	-- buffsI
	local tempDebuffsI = {}
	local tempBuffsI = {}
	for k,v in pairs(iCD[iCD.class][iCD.specID].buffsI) do
		addIfEligible(k,v, tempBuffsI, tempDebuffsI)
	end	
	for k,v in pairs(iCD[iCD.class].all.buffsI) do
		addIfEligible(k,v, tempBuffsI, tempDebuffsI)
	end
	for k,v in pairs(iCD.general.buffsI) do
		addIfEligible(k,v, tempBuffsI, tempDebuffsI)
	end
	iCD.BuffsI = tempBuffsI
	iCD.DebuffsI = tempDebuffsI
	
	local tempDebuffsC = {}
	local tempBuffsC = {}
	for k,v in pairs(iCD[iCD.class][iCD.specID].buffsC) do
		addIfEligible(k,v, tempBuffsC, tempDebuffsC)
	end	
	for k,v in pairs(iCD[iCD.class].all.buffsC) do
		addIfEligible(k,v, tempBuffsC, tempDebuffsC)
	end
	for k,v in pairs(iCD.general.buffsC) do
		addIfEligible(k,v, tempBuffsC, tempDebuffsC)
	end
	iCD.BuffsC = tempBuffsC
	iCD.DebuffsC = tempDebuffsC
	
	iCD:updateBuffs()
end
function iCD:UpdateSkills()
	iCD.glowEffects = {}
	iCD.glowSoundEffects = {}
	local temp = {row1 = {}, row2 = {}, row3 = {}}
	local function add(k,v, row)
		if not v.showFunc or (v.showFunc and v.showFunc()) then
			temp[row][k] = v
		end
	end
	if not iCD.class or not iCD.specID then
		return
	end
	iCD.gcd = iCD[iCD.class][iCD.specID].gcd
	for row,t in pairs(iCD[iCD.class][iCD.specID]) do
		if row == 'row1' or row == 'row2' or row == 'row3' then
			for k,v in pairs(t) do
				add(k,v,row)
			end
		end
	end
	for k,v in pairs(iCD[iCD.class].all) do
		if row == 'row1' or row == 'row2' or row == 'row3' then
			for k,v in pairs(t) do
				add(k,v,row)
			end
		end
	end
	iCD.spells = temp
	for row, v in pairs(temp) do
		local id = 1
		for k,v in spairs(v, function(t,a,b) return t[b].order > t[a].order end) do
			iCD:CreateNewFrame(id, row)
			iCD.frames[row][id].data = {}
			iCD.frames[row][id].data.usedBy = k
			iCD.frames[row][id].data.spellName = GetSpellInfo(k)
			if v.stackFunc then
				iCD.frames[row][id].data.stackFunc = v.stackFunc
			elseif v.stack then
				iCD.frames[row][id].data.stack = true
			end
			if v.customText then
				iCD.frames[row][id].data.customText = v.customText
			end
			if v.range then
				if v.customRange then
					iCD.frames[row][id].data.customRange = v.customRange
				else
					iCD.frames[row][id].data.range = true
				end
			end
			if v.cost then
				if v.customCost then
					iCD.frames[row][id].data.customCost = v.customCost
				else
					iCD.frames[row][id].data.cost = true
				end
			end
			if v.ignoreGCD then
				iCD.frames[row][id].data.ignoreGCD = true
			end
			if v.charges then
				iCD.frames[row][id].data.charges = true
			end
			if v.glow then
				local glow = v.glow
				if type(v.glow) == 'boolean' then
					glow = k
				end
				if not iCD.glowEffects[glow] then
					iCD.glowEffects[glow] = {{['row'] = row, ['id'] = id}}
				else
					table.insert(iCD.glowEffects[glow], {['row'] = row, ['id'] = id})
				end
			end
			if v.glowSound then
				if type(v.glowSound) == 'boolean' then
					iCD.glowSoundEffects[k] = sounds.default
				else
					if sounds[v.glowSound] then
						iCD.glowSoundEffects[k] = sounds[v.glowSound]
					else
						iCD.glowSoundEffects[k] = v.glowSound
					end
				end
			end
			iCD.frames[row][id].tex:SetTexture(GetSpellTexture(k))
			iCD.frames[row][id].tex:SetVertexColor(1,1,1,1)
			iCD.frames[row][id].data.unMod = 'none'
			--Re center
			iCD[row]:SetWidth(id*21-1)
			iCD.frames[row][id]:Show()
			id = id + 1			
		end
		for i = id, #iCD.frames[row] do
			iCD.frames[row][i].data = {}
			iCD.frames[row][i]:Hide()
		end
	end
end
function iCD:updateEH()
	local hp = UnitHealth('player')
	local a = UnitGetTotalAbsorbs('player')
	local ha = UnitGetTotalHealAbsorbs('player')
	if ha > 0 then
		iCD.EHtext:SetFormattedText('-%.0f\n%.0f', ha/1000,(hp+a)/1000)
	else
		iCD.EHtext:SetFormattedText('%.0f', (hp+a)/1000)
	end
end
function iCD:updateCombatLogStuff()
end
function iCD:addToRow4(spellID, isItem, dura)
	iCD.extras[spellID] = {
		item = isItem or nil,
		customDuration = dura + GetTime()
	}
end
function iCD.onUpdate()
	for k,v in pairs(iCD.frames.row1) do
		if v.data.usedBy then
			iCD:updateFrame(k, 'row1')
		end
	end
	for k,v in pairs(iCD.frames.row2) do
		if v.data.usedBy then
			iCD:updateFrame(k, 'row2')
		end
	end
	for k,v in pairs(iCD.frames.row3) do
		if v.data.usedBy then
			iCD:updateFrame(k, 'row3')
		end
	end
	for k,v in pairs(iCD.frames.row4) do
		if v.data.usedBy then
			iCD:updateFrame(k, 'row4')
		end
	end
	for k,v in pairs(iCD.frames.row5) do
		if v.data.usedBy then
			iCD:updateFrame(k, 'row5')
		end
	end
	for k,v in pairs(iCD.frames.buffsI) do
		if v.data.usedBy then
			iCD:updateFrame(k, 'buffsI')
		end
	end
	for k,v in pairs(iCD.frames.buffsC) do
		if v.data.usedBy then
			iCD:updateFrame(k, 'buffsC')
		end
	end
	
	--- dh stuff
	local gS, gcdD = GetSpellCooldown(iCD.gcd)
	local gCD = (gS+gcdD-GetTime())/gcdD
	iCD.GCD:SetValue(gCD)
	if iCD.textTimers then
		local gcdEnd = gS + gcdD
		local temp = {}
		for i = 1, #iCD.textTimers do
			if iCD.textTimers[i] > GetTime() then
				temp[#temp+1] = iCD.textTimers[i]
			end
		end
		local id = 0
		for i = 1, #temp do
			iCD:createTextString(i)
			if gcdEnd < temp[i] then
				if not iCD.textFrames[i].colored then
					iCD.textFrames[i]:SetTextColor(1,0,0,1)
					iCD.textFrames[i].colored = true
				end
			else
				if iCD.textFrames[i].colored then
					iCD.textFrames[i]:SetTextColor(1,1,1,1)
					iCD.textFrames[i].colored = false
				end
			end
			local timeLeft = temp[i]-GetTime()
			iCD.textFrames[i]:SetFormattedText('%.1f', timeLeft)
			iCD.textFrames[i]:Show()
			id = i
		end
		for i = id+1, #iCD.textFrames do
			iCD.textFrames[i]:Hide()
		end
			iCD.textAnchor:SetWidth(id*40)
		iCD.textTimers = temp
	end
end
addon:RegisterEvent('PLAYER_LOGIN')
addon:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED')
addon:RegisterEvent('SPELL_ACTIVATION_OVERLAY_GLOW_SHOW')
addon:RegisterEvent('SPELL_ACTIVATION_OVERLAY_GLOW_HIDE')
addon:RegisterEvent('SPELL_UPDATE_COOLDOWN')
addon:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
addon:RegisterEvent('PLAYER_EQUIPMENT_CHANGED')
addon:RegisterUnitEvent('UNIT_ABSORB_AMOUNT_CHANGED', 'player')
addon:RegisterUnitEvent('UNIT_HEAL_ABSORB_AMOUNT_CHANGED', 'player')
addon:RegisterUnitEvent('UNIT_AURA', 'player')
addon:RegisterUnitEvent('UNIT_HEALTH', 'player')
addon:RegisterUnitEvent('UNIT_HEALTH_FREQUENT', 'player')
local function updateHealth()
	local hp = UnitHealth('player')
	local maxHP = UnitHealthMax('player')
	local value = 0
	if hp and maxHP then
		value = hp/maxHP
	end
	if value <= 0.5 then
		if not iCD.hpBar.anim then
			iCD.hpBar.flash:Play()
		end
	elseif iCD.hpBar.anim then
		iCD.hpBar.flash :Stop()
	end
	iCD.hpBar:SetValue(value)
	local r = math.max(1-value+0.1, 0.1)
	iCD.hpBar:SetStatusBarColor(r,0.1,0.1,1)
	iCD.hpBar:SetBackdropBorderColor(1-value,0,0,1)
	iCD:updateEH()
end
function addon:UNIT_HEALTH()
	updateHealth()
end
function addon:UNIT_HEALTH_FREQUENT()
	updateHealth()
end
function addon:UNIT_ABSORB_AMOUNT_CHANGED()
	iCD:updateEH()
end
function addon:UNIT_HEAL_ABSORB_AMOUNT_CHANGED()
	iCD:updateEH()
end
function addon:UNIT_POWER()
	iCD.powerText:SetText(iCD.powerFunc())
end
function addon:UNIT_POWER_FREQUENT()
	iCD.powerText:SetText(iCD.powerFunc())
end
function addon:PLAYER_LOGIN()
	iCD.class = select(2,UnitClass('player'))
	iCD.player = UnitGUID('player')
	iCD.specID = GetSpecializationInfo(GetSpecialization())
	iCD:UpdateSkills()
	iCD:updateBuffList()
	iCD:updateOnCD()
	iCD:updateCombatLogStuff()
	updateHealth()
	if iCD.specID == 581 then
		iCD.textTimers = {}
	end
	if iCD[iCD.class][iCD.specID].power then
		if iCD[iCD.class][iCD.specID].power.pos then
			iCD.powerText:SetPoint('BOTTOMRIGHT', UIParent, 'CENTER', iCD[iCD.class][iCD.specID].power.pos.x, iCD[iCD.class][iCD.specID].power.pos.y)
		else
			iCD.powerText:SetPoint('BOTTOMRIGHT', UIParent, 'CENTER', -120, -150)
		end
		iCD.powerFunc = iCD[iCD.class][iCD.specID].power.func
		addon:RegisterUnitEvent('UNIT_POWER', 'player')
		addon:RegisterUnitEvent('UNIT_POWER_FREQUENT', 'player')
		iCD.powerText:SetText(iCD.powerFunc())
	else
		addon:UnregisterEvent('UNIT_POWER')
		addon:UnregisterEvent('UNIT_POWER_FREQUENT')
		iCD.powerText:SetText('')
		iCD.powerFunc = nil
	end
end
function addon:PLAYER_SPECIALIZATION_CHANGED()
	iCD.class = select(2,UnitClass('player'))
	iCD.specID = GetSpecializationInfo(GetSpecialization())
	iCD:UpdateSkills()
	iCD:updateBuffList()
	iCD:updateCombatLogStuff()
	iCD:updateOnCD()
	if iCD.class and iCD.specID and iCD[iCD.class][iCD.specID].power then
		if iCD[iCD.class][iCD.specID].power.pos then
			iCD.powerText:SetPoint('BOTTOMRIGHT', UIParent, 'CENTER', iCD[iCD.class][iCD.specID].power.pos.x, iCD[iCD.class][iCD.specID].power.pos.y)
		else
			iCD.powerText:SetPoint('BOTTOMRIGHT', UIParent, 'CENTER', -120, -150)
		end
		iCD.powerFunc = iCD[iCD.class][iCD.specID].power.func
		addon:RegisterUnitEvent('UNIT_POWER', 'player')
		addon:RegisterUnitEvent('UNIT_POWER_FREQUENT', 'player')
		iCD.powerText:SetText(iCD.powerFunc())
	else
		addon:UnregisterEvent('UNIT_POWER')
		addon:UnregisterEvent('UNIT_POWER_FREQUENT')
		iCD.powerText:SetText('')
		iCD.powerFunc = nil
	end
	if iCD.specID == 581 then
		iCD.textTimers = {}
	else
		iCD.textTimers = nil
	end
end
function addon:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(spellID)
	if iCD.glowEffects[spellID] then
		for i = 1, #iCD.glowEffects[spellID] do
			if not iCD.frames[iCD.glowEffects[spellID][i].row][iCD.glowEffects[spellID][i].id].anim then
				iCD.frames[iCD.glowEffects[spellID][i].row][iCD.glowEffects[spellID][i].id]:SetAlpha(1)
				iCD.frames[iCD.glowEffects[spellID][i].row][iCD.glowEffects[spellID][i].id].flash:Play()
			end
		end
	end
	if iCD.glowSoundEffects[spellID] then
		PlaySoundFile(iCD.glowSoundEffects[spellID], 'master')
	end
end
function addon:SPELL_ACTIVATION_OVERLAY_GLOW_HIDE(spellID)
	if iCD.glowEffects[spellID] then
		for i = 1, #iCD.glowEffects[spellID] do
			if iCD.frames[iCD.glowEffects[spellID][i].row][iCD.glowEffects[spellID][i].id].anim then
				iCD.frames[iCD.glowEffects[spellID][i].row][iCD.glowEffects[spellID][i].id].flash:Stop()
				iCD.frames[iCD.glowEffects[spellID][i].row][iCD.glowEffects[spellID][i].id]:SetAlpha(1)
			end
		end
	end
end
function addon:COMBAT_LOG_EVENT_UNFILTERED(timestamp,event,hideCaster,sourceGUID,sourceName,sourceFlags,sourceRaidFlags,destGUID,destName,destFlags,destRaidFlags,spellID, spellName,spellSchool, auraType, stacks)
	if sourceGUID and sourceGUID == iCD.player then
		--if event == 'SPELL_CAST_SUCCESS' then
		--	if spellID and spellID == 204255 then
		--		table.insert(iCD.textTimers, GetTime()+1.05)
		--	end
		--end
		if event == 'SPELL_AURA_APPLIED' then
			if spellID then
				if spellID == 208052 then
					iCD:addToRow4(spellID, false, 30)
				end
			end
		elseif event == 'SPELL_CAST_SUCCESS' then
			if spellID then
				if spellID == 214584 then
					iCD:addToRow4(spellID, false, 60)
				end
			end
		end
	end
	-- BW NL test
end
function addon:SPELL_UPDATE_COOLDOWN()
	iCD:updateOnCD()
end
function addon:UNIT_AURA(unitID)
	iCD:updateBuffs()
	iCD:updateEH()
end
function addon:PLAYER_EQUIPMENT_CHANGED()
	iCD:updateBuffList()
end


iCD.row1:SetScript('OnUpdate', iCD.onUpdate)