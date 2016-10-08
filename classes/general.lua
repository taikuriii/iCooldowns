--[[
order = 5,
row = 2,
ignoreGCD = true,
cost = true,
stack = true,
glow = true,
glowSound = true,
stackFunc = function() return GetSpellCount(228477) end,
charges = true,
showFunc = function()
	return select(4, GetTalentInfo(5, 1, 1))
end,
range = true,
customRange = function()
	if UnitExists('target') then
		return IsSpellInRange('Maul', 'target') == 1
	else
		return true
	end
end,			
--]]
local _, iCD = ...
iCD.general = {
	row1 = {},
	row2 = {},
	row3 = {},
	row4 = {},
	row5 = { -- Buffs
		[1022] = {}, -- Blessing of Protection
		[204018] = {}, -- Blessing of Spellwarding
		[6940] = {}, -- Blessing of Sacrifice
		[1044] = {}, -- Blessing of Freedom
		[102342] = {}, -- Ironbark
		[47788] = {}, -- Guardian Spirit
		[33206] = {}, -- Pain Suppression
	},
	buffsI = {},
	buffsC = {
		[208052] = { -- Sephuz's Secret
			stack = '+H',
			itemReq = 132452,
		},
		[222517] = { -- Cleansed Ancient's Blessing
			stack = '+C',
			itemReq = 139334, -- Nature's Call
		},
		[222519] = { -- Cleansed Sister's Blessing
			stack = '+H',
			itemReq = 139334, -- Nature's Call
		},
		[222518] = { -- Cleansed Wisp's Blessing
			stack = '+M',
			itemReq = 139334, -- Nature's Call
		},
		[228399] = { -- Mark of the Heavy Hide
			stack = '+A',
		},
		[188029] = { -- Unbending Potion
			stack = '+A',
		},
		[188028] = { -- Potion of the Old War
		},
		[222027] = { -- Nightmarish Ichor
			stack = '+V',
			itemReq = 139324, -- Goblet of Nightmarish Ichor
		},
	},
}