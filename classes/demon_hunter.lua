local _, iCD = ...
iCD.DEMONHUNTER = {
	[577] = { --Havoc
		gcd = 162243, -- Demon's Bite
		-- Row 1
		[198013] = { -- Eye Beam
			order = 2,
			row = 1, 
			cost = true,
			range = true,
		},
		[162794] = { -- Chaos Strike
			order = 3,
			row = 1,
			cost = true,
			range = true,
		},
		[188499] = { -- Blade Dance
			order = 4,
			row = 1,
			cost = true,
		},
		[185123] = { -- Throw Glaive
			order = 10,
			row = 1,
			range = true,
		},
		-- Row 2
		[191427] = { -- Metamorphosis
			order = 5,
			row = 2,
		},
		[198589] = { -- Blur
			order = 6,
			row = 2,
		},
		[195072] = { -- Fel Rush
			order = 10,
			row = 2,
			charges = true,
			stack = true,
		},
		[198793] = { -- Vengeful Retreat
			order = 8,
			row = 2,
		},
		[196718] = { -- Darkness
			order = 12,
			row = 2,
		},

	},
	[581] = { --Vengeance
		-- Row 1
		gcd = 203782,
		[228477] = { -- Soul Cleave
			order = 2,
			row = 1,
			cost = true,
			stackFunc = function() return GetSpellCount(228477) end,
		},
		[178740] = { -- Immolation Aura
			order = 6,
			row = 1,
		},
		[207407] = { -- Soul Carver
			order = 7,
			row = 1,
			range = true,
		},
		[204596] = { -- Sigil of Flame
			order = 8,
			row = 1,
		},
		[212084] = { -- Fel Devastation
			order = 9,
			row = 1,
			cost = true,
			showFunc = function()
				return select(4, GetTalentInfo(6, 1, 1))
			end,
		},
		[218679] = { -- Spirit Bomb
			order = 9,
			row = 1,
			showFunc = function()
				return select(4, GetTalentInfo(6, 3, 1))
			end,
			range = true,
			stackFunc = function() return GetSpellCount(228477) end,
		},
		[204157] = { -- Throw Glaive
			order = 10,
			row = 1,
			range = true,
		},
		
		-- Row 2
		[203720] = { -- Demon Spikes
			order = 2,
			row = 2,
			cost = true,
			stack = true,
			ignoreGCD = true,
			charges = true,
		},
		[227225] = { -- Soul Barrier
			order = 2,
			row = 2,
			showFunc = function()
				return select(4, GetTalentInfo(7, 3, 1))
			end,
			cost = true,
		},
		[218256] = { -- Empower Wards
			order = 3,
			row = 2,
			ignoreGCD = true,
		},
		[204021] = { -- Fiery Brand
			order = 4,
			row = 2,
			range = true,
			ignoreGCD = true,
		},

		[187827] = { -- Metamorphosis
			order = 5,
			row = 2, 
		},
	},
	['all'] = {}
}