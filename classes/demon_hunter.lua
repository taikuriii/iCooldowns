local _, iCD = ...
iCD.DEMONHUNTER = {
	[577] = { --Havoc
		gcd = 162243, -- Demon's Bite
		-- Row 1
		row1 = {
			[198013] = { -- Eye Beam
				order = 2,
				cost = true,
				range = true,
			},
			[162794] = { -- Chaos Strike
				order = 3,
				cost = true,
				range = true,
			},
			[188499] = { -- Blade Dance
				order = 4,
				cost = true,
			},
			[185123] = { -- Throw Glaive
				order = 10,
				range = true,
			},
		},
		-- Row 2
		row2 = {
			[191427] = { -- Metamorphosis
				order = 5,
			},
			[198589] = { -- Blur
				order = 6,
			},
			[195072] = { -- Fel Rush
				order = 10,
				charges = true,
				stack = true,
			},
			[198793] = { -- Vengeful Retreat
				order = 8,
			},
			[196718] = { -- Darkness
				order = 12,
			},
		},
		row3 = {},
		row4 = {},
		row5 = {},
		buffsI = {},
		buffsC = {},
	},
	[581] = { --Vengeance
		-- Row 1
		gcd = 203782,
		row1 = {
			[213241] = { -- Felblade
				order = 1,
				range = true,
				glow = true,
				glowSound = true,
				showFunc = function()
					return select(4, GetTalentInfo(3, 1, 1))
				end,
			},
			[228477] = { -- Soul Cleave
				order = 2,
				cost = true,
				stackFunc = function() return GetSpellCount(228477) end,
			},
			[178740] = { -- Immolation Aura
				order = 6,
			},
			[207407] = { -- Soul Carver
				order = 7,
				range = true,
			},

			[212084] = { -- Fel Devastation
				order = 9,
				cost = true,
				showFunc = function()
					return select(4, GetTalentInfo(6, 1, 1))
				end,
			},
			[204596] = { -- Sigil of Flame
				order = 8,
			},

			[218679] = { -- Spirit Bomb
				order = 9,
				showFunc = function()
					return select(4, GetTalentInfo(6, 3, 1))
				end,
				range = true,
				stackFunc = function() return GetSpellCount(228477) end,
			},
			[204157] = { -- Throw Glaive
				order = 10,
				range = true,
			},
		},
		-- Row 2
		row2 = {
			[227225] = { -- Soul Barrier
				order = 2,
				showFunc = function()
					return select(4, GetTalentInfo(7, 3, 1))
				end,
				cost = true,
			},
			[218256] = { -- Empower Wards
				order = 3,
				ignoreGCD = true,
			},
			[204021] = { -- Fiery Brand
				order = 4,
				range = true,
				ignoreGCD = true,
			},
			[187827] = { -- Metamorphosis
				order = 5,
			},
		},
		-- Row 3
		row3 = {
			[203720] = { -- Demon Spikes
				order = 2,
				cost = true,
				stack = true,
				ignoreGCD = true,
				charges = true,
			},
		},
		row4 = {
			[217832] = {}, -- Imprison
			[189110] = { -- Infernal Strike
				stack = true,
				charges = true,
			},
			[202140] = {}, -- Sigil of Misery
			[207682] = {}, -- Sigil of Silence
			[188501] = {}, -- Specral Sight
			[185245] = {}, -- Torment
			[202138] = { -- Sigil of Chains
				showFunc = function()
					return select(4, GetTalentInfo(5, 2, 1))
				end,
			}, 
		},
		row5 = {
			[207744] = { -- Fiery Brand
				debuff = true,
			}, 
			[218256] = {}, -- Empower Wards
			[187827] = {}, -- Metamorphosis
			[227225] = { -- Soul Barrier
				showFunc = function()
					return select(4, GetTalentInfo(7, 3, 1))
				end,
			}, 
		},
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