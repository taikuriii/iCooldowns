local _, iCD = ...
iCD.DRUID = {
	[102] = { --Balance
	},
	[103] = { --Feral,
	},
	[104] = { --Guardian
		gcd = 8921, -- Moonfire
		-- Row 1
		[22842] = { -- Frenzied Regeneration
			order = 3,
			row = 1,
			stack = true,
			charges = true,
			ignoreGCD = true,
		},
		[6807] = { -- Maul
			order = 3,
			row = 1,
			range = true,
			cost = true,
			ignoreGCD = true,
		},
		[77758] = { -- Trash
			order = 4,
			row = 1,
			range = true,
			customRange = function()
				if UnitExists('target') then
					return IsSpellInRange('Maul', 'target') == 1
				else
					return true
				end
			end,
		},
		[33917] = { -- Mangle
			order = 6,
			row = 1,
			range = true,
			glow = true,
		},
		[8921] = { -- Moonfire
			order = 10,
			row = 1,
			range = true,
			glow = true,
		},
		-- Row 2
		[22812] = { -- Barkskin
			order = 3,
			row = 2,
		},
		[61336] = { -- Survival Instincts
			order = 4,
			row = 2,
			charges = true,
			stack = true,
		},
		[204066] = { -- Lunar Beam
			order = 6,
			row = 2,
			showFunc = function()
				return select(4, GetTalentInfo(7, 2, 1))
			end,
		},
		[102558] = { -- Incarnation: Guardian of Ursoc
			order = 7,
			row = 2,
			showFunc = function()
				return select(4, GetTalentInfo(5, 2, 1))
			end,
		},
		[155835] = { -- Bristling Fur
			order = 8,
			row = 2,
			showFunc = function()
				return select(4, GetTalentInfo(1, 2, 1))
			end,
		},
	},
	[105] = { --Restoration
	},
	['all'] = {}
}