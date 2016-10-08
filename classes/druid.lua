local _, iCD = ...
iCD.DRUID = {
	[102] = { --Balance
	},
	[103] = { --Feral,
	},
	[104] = { --Guardian
		gcd = 8921, -- Moonfire
		-- Row 1
		row1 = {
			[6807] = { -- Maul
				order = 5,
				range = true,
				cost = true,
				ignoreGCD = true,
			},
			[77758] = { -- Trash
				order = 6,
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
				order = 4,
				range = true,
				glow = true,
			},
			[8921] = { -- Moonfire
				order = 10,
				range = true,
				glow = true,
			},
		},
		-- Row 2
		row2 = {
			[200851] = { -- Rage of the Sleeper
				order = 2,
				ignoreGCD = true,
			},
			[22812] = { -- Barkskin
				order = 3,
			},
			[61336] = { -- Survival Instincts
				order = 4,
				charges = true,
				stack = true,
			},
			[204066] = { -- Lunar Beam
				order = 6,
				showFunc = function()
					return select(4, GetTalentInfo(7, 2, 1))
				end,
			},
			[102558] = { -- Incarnation: Guardian of Ursoc
				order = 7,
				showFunc = function()
					return select(4, GetTalentInfo(5, 2, 1))
				end,
			},
			[155835] = { -- Bristling Fur
				order = 8,
				showFunc = function()
					return select(4, GetTalentInfo(1, 2, 1))
				end,
			},
		},
		-- Row 3
		row3 = {
			[22842] = { -- Frenzied Regeneration
				order = 3,
				stack = true,
				charges = true,
				ignoreGCD = true,
			},
		},
		row4 = {},
		row5 = {},
		buffsI = {},
		buffsC = {},
	},
	[105] = { --Restoration
		gcd = 8921, -- Moonfire
		-- Row 1
		row1 = {
			[18562] = { -- Swiftmend
				order = 1,
				range = true,
				cost = true,
				charges = true,
				stack = true,
			},
			[48438] = { -- Wild Growth
				order = 3,
				range = true,
				cost = true,
			},
			[197626] = { -- Starsurge
				order = 20,
				range = true,
				cost = true,
				showFunc = function()
					return select(4, GetTalentInfo(3, 1, 1))
				end,
			},
		},
		-- Row 2
		row2 = {
			[197721] = { -- Flourish
				order = 2,
				showFunc = function()
					return select(4, GetTalentInfo(7, 3, 1))
				end,
			},
			[208253] = { -- Artifact
				order = 3,
			},
			[740] =  { -- Tranquility
				order = 4,
			},
			[22812] = { -- Barkskin
				order = 5,
				ignoreGCD = true,
			},
			[102342] = { -- Ironbark
				order = 6,
				ignoreGCD = true,
			},
			[29166] = { -- Innervate
				order = 8,
				ignoreGCD = true,
			},
		},
		-- Row 3
		row3 = {},
		row4 = {},
		row5 = {},
		buffsI = {},
		buffsC = {},
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