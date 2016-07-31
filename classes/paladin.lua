local _, iCD = ...
iCD.PALADIN = {
	[65] = { --Holy
	},
	[66] = { --Protection
		gcd = 19750, -- Flash of Light
		-- Row 1
		[31935] = { -- Avenger's Shield
			order = 4,
			range = true,
			glow = true,
			row = 1,
		},
		[204019] = { -- Blessed Hammer
			order = 5,
			row = 1,
			stack = true,
			charges = true,
		},
		[53600] = { -- Shield of the Righteous
			order = 6,
			row = 1,
			stack = true,
			charges = true,
			ignoreGCD = true,
			range = true,
		},
		[20271] = { -- Judgment
			order = 7,
			row = 1,
			range = true,
		},
		[26573] = { -- Consecration
			order = 8,
			row = 1,
		},
		-- Row 2
		[152262] = { -- Seraphim
			order = 3,
			row = 2,
		},
		[184092] = { -- Light of the Protector
			order = 5,
			row = 2,
		},
		[31884] = { -- Avenging Wrath
			order = 6,
			row = 2,
		},
		[86659] = { -- Guardian of Ancient Kings
			order = 7,
			row = 2,
		},
		[31850] = { -- Ardent Defender
			order = 8,
			row = 2,
		},
		[633] = { -- Lay on Hands
			order = 9,
			row = 2,
		},
	},
	[70] = { --Retribution
	},
	['all'] = {
	},
}