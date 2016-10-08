local _, iCD = ...
iCD.PALADIN = {
	[65] = { --Holy
		gcd = 19750, -- Flash of Light
		row1 = {
			[20473] = { -- Holy Shock
				order = 1,
				cost = true,
				range = true,
			},
			[85222] = { -- Light of Dawn
				order = 2,
				cost = true,			
			},
			[114165] = { -- Holy Prism
				order = 3,
				cost = true,
				range = true,
				showFunc = function()
					return select(4, GetTalentInfo(5, 3, 1))
				end,
			},
			[114158] = { -- Light's Hammer
				order = 3,
				cost = true,
				showFunc = function()
					return select(4, GetTalentInfo(1, 2, 1))
				end,
			
			},
			[200025] = { -- Beacon of Virtue
				order = 4,
				cost = true,
				showFunc = function()
					return select(4, GetTalentInfo(7, 3, 1))
				end,
			},
			[35395] = { -- Crusader Strike
				order = 6,
				range = true,
				stack = true,
				charges = true,
				ignoreGCD = true,
			},
			[20271] = { -- Judgment
				order = 7,
				range = true,
				cost = true,
			},
			[26573] = { -- Consecration
				order = 8,
				cost = true,
			},
		},
		row2 = {
			[498] = { -- Divine Protection
				order = 3,
				ignoreGCD = true,			
			},
			[200652] = { -- Tyr's Deliverance
				order = 4,
			},
			[31842] = { -- Avenging Wrath
				order = 6,
				ignoreGCD = true,
			},
			[31821] = { -- Aura Mastery
				order = 7,
				ignoreGCD = true,
			},
		},
		-- Row 3
		row3 = {},
		row4 = {
			[190784] = { -- Divine Steed
				charges = true,
				stack = true,
				stackFunc = function()
					if select(4, GetTalentInfo(2, 1, 1)) then
						local c = GetSpellCharges(190784)
						return c
					else
						return ''
					end
				end
			},
			[115750] = {
				showFunc = function()
					return select(4, GetTalentInfo(3, 3, 1))
				end
			},
		},
		row5 = {
			[498] = {}, -- Divine Protection
		},
		buffsI = {},
		buffsC = {},
	},
	[66] = { --Protection
		gcd = 19750, -- Flash of Light
		-- Row 1
		row1 = {
			[31935] = { -- Avenger's Shield
				order = 4,
				range = true,
				glow = true,
				glowSound = true,
				--glow = 31935,
			},
			[204019] = { -- Blessed Hammer
				order = 5,
				stack = true,
				charges = true,
				showFunc = function()
					return select(4, GetTalentInfo(1, 2, 1))
				end,
			},
			[53595] = { -- Hammer of the Righteous
				order = 5,
				stack = true,
				charges = true,
				showFunc = function()
					return select(4, GetTalentInfo(1, 1, 1))
				end,
			},
			[20271] = { -- Judgment
				order = 7,
				range = true,
			},
			[26573] = { -- Consecration
				order = 8,
			},
		},
		row2 = {
			[152262] = { -- Seraphim
				order = 3,
				showFunc = function()
					return select(4, GetTalentInfo(7, 2, 1))
				end,
			},
			[209202] = { --Eye of Tyr
				order = 4,
			},
			[31884] = { -- Avenging Wrath
				order = 6,
				ignoreGCD = true,
			},
			[212641] = { -- Guardian of Ancient Kings
				order = 7,
				ignoreGCD = true,
			},
			[31850] = { -- Ardent Defender
				order = 8,
				ignoreGCD = true,
			},
			[633] = { -- Lay on Hands
				order = 9,
				ignoreGCD = true,
			},
		},
		row3 = {
			[184092] = { -- Light of the Protector
				order = 2,
				ignoreGCD = true,
				showFunc = function()
					return not (select(4, GetTalentInfo(5, 1, 1)))
				end,
			},
			[213652] = { -- Hand of the Protector
				order = 2,
				ignoreGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(5, 1, 1))
				end,
			},
			[53600] = { -- Shield of the Righteous
				order = 3,
				stack = true,
				charges = true,
				ignoreGCD = true,
				range = true,
			},
		},
		row4 = {
			[190784] = { -- Divine Steed
				charges = true,
				stack = true,
				stackFunc = function()
					if select(4, GetTalentInfo(4, 2, 1)) then
						local c = GetSpellCharges(190784)
						return c
					else
						return ''
					end
				end
			},
			[204035] = { -- Bastion of Light
				showFunc = function()
					return select(4, GetTalentInfo(2, 2, 1))
				end,
			},
			[115750] = { -- Blinding Light
				showFunc = function()
					return select(4, GetTalentInfo(3, 3, 1))
				end,
			},
			[204150] = { -- Aegis of Light
				showFunc = function()
					return select(4, GetTalentInfo(6, 1, 1))
				end,
			},
			[1022] = { -- Blessing of Protection
				showFunc = function()
					return not select(4, GetTalentInfo(4, 1, 1))
				end,
			}, 
			[204018] = { -- Blessing of Spellwarding
				showFunc = function()
					return select(4, GetTalentInfo(4, 1, 1))
				end,
			}, 
			[213644] = {}, -- Cleanse Toxins
			[215652] = {}, -- Shield of Virtue
		},
		row5 = {
			[31850] = {}, -- Ardent Defender
			[212641] = {}, -- Guardian of Ancient Kings
			[209202] = { -- Eye of Tyr
				debuff = true,
			},
		},
		buffsI = {
			[132403] = {}, -- Shield of the Righteous
		},
		buffsC = {
			[152262] = {
				showFunc = function()
					return select(4, GetTalentInfo(7, 2, 1))
				end,
			}, -- Seraphim
		},
	},
	[70] = { --Retribution
		gcd = 19750,
		row1 = {},
		row2 = {},
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
		row4 = {
			[1044] = {}, -- Blessing of Freedom
			[6940] = {}, -- Blessing of Sacrifice
			[642] = {}, -- Divine Shield
			[853] = {}, -- Hammer of Justice
			[62124] = { -- Hand of Reckoning
				ignoreGCD = true,
			}, 
		},
		row5 = {
			[642] = {}, -- Divine Shield
			[221886] = {} -- Divine Steed
		},
		buffsI = {},
		buffsC = {
			[31884] = {}, -- Avenging Wrath
		},
	},
}