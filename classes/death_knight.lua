local _, iCD = ...
iCD.DEATHKNIGHT = {
	[250] = { --Blood
		gcd = 49998, -- Death Strike
		-- Row 1
		[50842] = { -- Blood Boil
			order = 5,
			row = 1,
			stack = true,
			charges = true,
		},
		[43265] = { -- Death and Decay
			order = 6,
			glow = true,
			row = 1,
			glow = 43265,
		},
		[194679] = { -- Rune Tap
			order = 7,
			row = 1,
			stack = true,
			charges = true,
			showFunc = function()
				return select(4, GetTalentInfo(6, 2, 1))
			end,
		},		
		-- Row 2
		[206940] = { -- Mark of Blood
			order = 5,
			row = 2,
			showFunc = function()
				return select(4, GetTalentInfo(4, 1, 1))
			end,
			range = true,
		},
		[55233] = { -- Vampiric Blood
			order = 5,
			row = 2,
		},
		[48707] = { -- Anti-Magic Shell
			order = 6,
			row = 2,
		},
		[49028] = { -- Dancing Rune Weapon
			order = 7,
			row = 2,
			range = true,
		},

	},
	[251] = { --Frost
	},
	[252] = { --Unholy,
	},
	['all'] = {}
}