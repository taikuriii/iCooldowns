local _, iCD = ...
--options---------
iCD.font = 'Interface\\AddOns\\iMedia\\ap.ttf'
iCD.fontSize = 14
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
iCD.spells = {}
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
--row1
iCD.row1 = CreateFrame('frame', nil, UIParent)
iCD.row1:SetSize(100,20)
--iCD.row1:SetBackdrop(iCD.backdrop)
--iCD.row1:SetBackdropBorderColor(0,0,0,1)
--iCD.row1:SetBackdropColor(0.2,0.2,0.2,0.5)
iCD.row1:SetPoint('CENTER', UIParent, 'CENTER',0,-138)
--row2
iCD.row2 = CreateFrame('frame', nil, UIParent)
iCD.row2:SetSize(100,20)
--iCD.row2:SetBackdrop(iCD.backdrop)
--iCD.row2:SetBackdropBorderColor(0,0,0,1)
--iCD.row2:SetBackdropColor(0.2,0.2,0.2,0.5)
iCD.row2:SetPoint('CENTER', iCD.row1, 'CENTER',0,-21)

iCD.frames = {
	row1 = {},
	row2 = {},
}
function iCD:updateFrame(id, row)
	local data = iCD.frames[row][id].data
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
		local s, cd
		if data.charges then
			local c,m,sd,d = GetSpellCharges(data.usedBy)
			if c == m then
				s = 0
				cd = d
			else
				s = sd
				cd = d
			end
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
	end
	if data.stackFunc then
		iCD.frames[row][id].stackText:SetText(data.stackFunc())
	elseif data.stack then
		local c,m,sd,d = GetSpellCharges(data.usedBy)
		iCD.frames[row][id].stackText:SetText(c)
	end
end
function iCD:CreateNewFrame(id, row)
	--row = 'row' .. row
	--Create frame
	if iCD.frames[row][id] then
		return
	end
	iCD.frames[row][id] = CreateFrame('frame',nil,iCD[row])
	iCD.frames[row][id]:SetSize(20,20)
	--Backdrop
	iCD.frames[row][id]:SetBackdrop(iCD.backdrop)
	iCD.frames[row][id]:SetBackdropColor(0.2,0.2,0.2,0.5)
	iCD.frames[row][id]:SetBackdropBorderColor(0,0,0,1)
	iCD.frames[row][id]:SetFrameStrata('MEDIUM')
	if id == 1 then
		iCD.frames[row][id]:SetPoint('LEFT', iCD[row] , 'LEFT', 0, 0)
	else
		iCD.frames[row][id]:SetPoint('LEFT', iCD.frames[row][id-1], 'RIGHT', 1, 0)
	end
	--Icon
	iCD.frames[row][id].tex = iCD.frames[row][id]:CreateTexture()
	iCD.frames[row][id].tex:SetAllPoints(iCD.frames[row][id])
	--Cooldown
	iCD.frames[row][id].cooldownText = iCD.frames[row][id]:CreateFontString()
	iCD.frames[row][id].cooldownText:SetFont(iCD.font, iCD.fontSize, 'OUTLINE')
	iCD.frames[row][id].cooldownText:SetPoint('BOTTOM', iCD.frames[row][id], 'BOTTOM', 0,0)
	iCD.frames[row][id].cooldownText:SetTextColor(1,1,0.1,1)
	--Stack
	iCD.frames[row][id].stackText = iCD.frames[row][id]:CreateFontString()
	iCD.frames[row][id].stackText:SetFont(iCD.font, 12, 'OUTLINE')
	iCD.frames[row][id].stackText:SetPoint('CENTER', iCD.frames[row][id], 'TOPRIGHT', 0,0)
	iCD.frames[row][id].stackText:SetTextColor(1,1,1,1)
end
function iCD:UpdateSkills()
	local temp = {row1 = {}, row2 = {}}
	local function add(k,v)
		if not v.showFunc or (v.showFunc and v.showFunc()) then
			if v.row == 1 then
				temp.row1[k] = v
			else
				temp.row2[k] = v
			end
		end
	end
	for k,v in pairs(iCD[iCD.class][iCD.specID]) do
		if k == 'gcd' then
			iCD.gcd = v
		else
			add(k,v)
		end
	end
	for k,v in pairs(iCD[iCD.class].all) do
		add(k,v)
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
			iCD.frames[row][id].tex:SetTexture(GetSpellTexture(k))
			iCD.frames[row][id].tex:SetVertexColor(1,1,1,1)
			iCD.frames[row][id].data.unMod = 'none'
			--Re center
			iCD[row]:SetWidth(id*21-1)
			id = id + 1			
		end
	end
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
end
addon:RegisterEvent('PLAYER_LOGIN')
addon:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED')
function addon:PLAYER_LOGIN()
	iCD.class = select(2,UnitClass('player'))
	iCD.specID = GetSpecializationInfo(GetSpecialization())
	iCD:UpdateSkills()
end
function addon:PLAYER_SPECIALIZATION_CHANGED()
	iCD.class = select(2,UnitClass('player'))
	iCD.specID = GetSpecializationInfo(GetSpecialization())
	iCD:UpdateSkills()
end
iCD.row1:SetScript('OnUpdate', iCD.onUpdate)