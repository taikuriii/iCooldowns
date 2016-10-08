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
iCD.WARRIOR = {
	[71] = { --Arms
	},
	[72] = { --Fury
	},
	[73] = { --Protection
		gcd = 20243, -- Devastate
		-- Row 1
		row1 = {
			[23922] = { -- Shield Slam
				order = 3,
				row = 1,
				range = true,
				glow = true,
				glowSound = true,
			},
			[6572] = { -- Revenge
				order = 5,
				row = 1,
				range = true,
				glow = true,
				glowSound = true,
			},
			[6343] = { -- Thunder Clap
				order = 7,
				row = 1,
			},
			[46968] = { -- Shockwave
				order = 8,
				row = 1,
				showFunc = function()
					return select(4, GetTalentInfo(1, 1, 1))
				end,
			},
			[107570] = { -- Stormbolt
				order = 8,
				row = 1,
				range = true,
				showFunc = function()
					return select(4, GetTalentInfo(1, 2, 1))
				end,
			},
			[202168] = { -- Impending Victory
				order = 9,
				row = 1,
				range = true,
				showFunc = function()
					return select(4, GetTalentInfo(2, 1, 1))
				end,
			},
			[228920] = { -- Ravager
				order = 10,
				row = 1,
				showFunc = function()
					return select(4, GetTalentInfo(7, 3, 1))
				end,
			},
		},
		-- Row 2
		row2 = {
			[203524] = { -- Neltharion's Fury
				order = 2,
				row = 2,
			},
			[1160] = { -- Demoralizing Shout
				order = 4,
				row = 2,
				ignoreGCD = true,
			},
			[12975] = { -- Last Stand
				order = 5,
				row = 2,
				ignoreGCD = true,
			},
			[871] = { -- Shield Wall
				order = 7,
				row = 2,
				ignoreGCD = true,
			},
			[23920] = { -- Spell Reflection
				order = 9,
				row = 2,
				ignoreGCD = true,			
			},
			[107574] = { -- Avatar
				order = 10,
				row = 2,
				showFunc = function()
					return select(4, GetTalentInfo(3, 3, 1))
				end,
			},
		},
		-- Row3
		row3 = {
			[2565] = { -- Shield Block
				order = 1,
				row = 3,
				stack = true,
				charges = true,
				ignoreGCD = true,
				cost = true,
			},
		},
		row4 = {
			[1719] = {}, -- Battle Cry
			[18499] = {}, -- Berserker Rage
			[198304] = {}, -- Intercept
			[355] = {}, -- Taunt
			[198304] = { -- Intercept
				stack = true,
				charges = true,
			},
			[6544] = {}, -- Heroic Leap
		},
		row5 = {
			[1160] = { -- Demoralizing Shout
				debuff = true,
			},
			[12975] = {}, -- Last Stand
			[227744] = { -- Ravager
				showFunc = function()
					return select(4, GetTalentInfo(7, 3, 1))
				end,
			},
			[871] = {}, -- Shield Wall
			[23920] = {}, -- Spell Reflection
		},
		buffsI = {
			[132404] = {}, -- Shield Block
			[190456] = {}, -- Ignore Pain
			[204488] = { -- Focused Rage
				stack = true,
			},
		},
		buffsC = {
			[1719] = {}, -- Battly Cry
			[107574] = {}, -- Avatar
			[18499] = {}, -- Berserker Rage
		},
	},
	['all'] = {
		row1 = {},
		row2 = {},
		row3 = {},
		row4 = {},
		row5 = {},
		buffsI = {},
		buffsC = {},
	},
}