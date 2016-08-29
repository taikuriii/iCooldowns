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
		[203720] = { -- Demon Spikes
			order = 1,
			row = 1,
			cost = true,
			stack = true,
			ignoreGCD = true,
			charges = true,
		},
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
		[204596] = { -- Sigil of Flame
			order = 8,
			row = 1,
		},
		[204157] = { -- Throw Glaive
			order = 10,
			row = 1,
			range = true,
		},
		
		-- Row 2
		[204021] = { -- Fiery Brand
			order = 3,
			row = 2,
			range = true,
		},
		[218256] = { -- Empower Wards
			order = 4,
			row = 2, 
		},
		[187827] = { -- Metamorphosis
			order = 5,
			row = 2, 
		},
	},
	['all'] = {}
}