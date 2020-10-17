local _, iCD = ...
function iCD:PALADIN(specID)
	iCD.customSpellTimers[26573] = 0
	local temp = {}
	temp.spec = {}
	temp.all = {}
	temp.all.row1 = {}
	temp.all.row2 = {}
	temp.all.row3 = {}
	temp.all.row4 = {
		[1044] = {}, -- Blessing of Freedom
		[6940] = {}, -- Blessing of Sacrifice
		[642] = {}, -- Divine Shield
		[853] = {}, -- Hammer of Justice
		[62124] = { -- Hand of Reckoning
			ignoreGCD = true,
		},
	}
	temp.all.row5 = {
		[642] = {}, -- Divine Shield
		[221886] = {} -- Divine Steed
	}
	temp.all.buffsI = {}
	temp.all.buffsC = {}
	local t = temp.spec
	t.row1 = {}
	t.row2 = {}
	t.row3 = {}
	t.row4 = {}
	t.row5 = {}
	t.buffsC = {}
	t.buffsI = {}
	if specID == 65 then --Holy
		--gcd = 19750, -- Flash of Light
		iCD.outOfRangeSpells = {
			main = 'Crusader Strike',
			range = "Judgment",
		}
		t.customPos = {
			buffsI = {
				from = "CENTER",
				to = "CENTER",
				x = 0,
				y = -38,
				horizontal = true,
			},
		}
		t.power = {
			pos = {
				x = -990,
				y = -8,
			},
			func = function()
				return math.floor(UnitPower('player', 0)/UnitPowerMax('player', 0)*100)
			end,
		}
		t.row1 = {
			[223306] = { -- Bestow Faith
				order = 0,
				cost = true,
				showFunc = function()
					return select(4, GetTalentInfo(1, 2, 1))
				end,
				showTimeAfterGCD = true,
			},
			[20473] = { -- Holy Shock
				order = 1,
				cost = true,
				range = true,
				showTimeAfterGCD = true,
				glow = true,
				glowSound = true,
			},
			[85222] = { -- Light of Dawn
				order = 2,
				cost = true,
				glow = true,
				glowSound = "text1",
				showTimeAfterGCD = true,
			},
			[114165] = { -- Holy Prism
				order = 3,
				cost = true,
				range = true,
				showFunc = function()
					return select(4, GetTalentInfo(5, 2, 1))
				end,
			},
			[114158] = { -- Light's Hammer
				order = 3,
				cost = true,
				showFunc = function()
					return select(4, GetTalentInfo(1, 3, 1))
				end,
				showTimeAfterGCD = true,
			},
			[200025] = { -- Beacon of Virtue
				order = 4,
				cost = true,
				showFunc = function()
					return select(4, GetTalentInfo(7, 3, 1))
				end,
				showTimeAfterGCD = true,
			},
			[35395] = { -- Crusader Strike
				order = 6,
				range = true,
				stack = true,
				charges = true,
				showTimeAfterGCD = true,
			},
			[20271] = { -- Judgment
				order = 7,
				range = true,
				cost = true,
				showTimeAfterGCD = true,
			},
			[26573] = { -- Consecration
				order = 8,
				stack = true,
				stackFunc = function()
					if iCD.customSpellTimers[26573] then
						local dura =  iCD.customSpellTimers[26573] - GetTime()
						if dura <= 0 then
							return ''
						elseif dura > 5 then
							return dura,'%.0f'
						else
							return dura, '|cffff1a1a%.1f'
						end
					else
						return ''
					end
				end,
				showTimeAfterGCD = true,
			},
		}
		t.row2 = {
			[214202] = { -- Rule of Law
				order = 2,
				ignoreGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(2, 3, 1))
				end,
				charges = true,
				stack = true,
			},
			[498] = { -- Divine Protection
				order = 9,
				ignoreGCD = true,
			},
			[31884] = { -- Avenging Wrath
				order = 6,
				showFunc = function()
					return not select(4, GetTalentInfo(6, 2, 1))
				end
			},
			[216331] = { -- Avenging Crusader
				order = 6,
				showFunc = function()
					return select(4, GetTalentInfo(6, 2, 1))
				end
			},
			[105809] = { -- Holy Avenger
				order = 7,
				showFunc = function()
					return select(4, GetTalentInfo(5, 3, 1))
				end
			},
			[31821] = { -- Aura Mastery
				order = 8,
			},
			[633] = { -- Lay on Hands
				order = 11,
				ignoreGCD = true,
			},
		}
		t.row3 = {}
		t.row4 = {
			[190784] = { -- Divine Steed
				charges = true,
				stack = true,
				stackFunc = function()
					if select(4, GetTalentInfo(2, 2, 1)) then
						local c = GetSpellCharges(190784)
						return c
					else
						return ''
					end
				end
			},
			[115750] = { -- Blinding Light
				showFunc = function()
					return select(4, GetTalentInfo(3, 3, 1))
				end
			},
			[20066] = { -- Repentance
				showFunc = function()
					return select(4, GetTalentInfo(3, 2, 1))
				end
			},
			[4987] = {}, -- Cleanse
			[1022] = {}, -- Blessing of Protection
		}
		t.row5 = {
			[498] = {}, -- Divine Protection
		}
		t.buffsI = {
			[214222] = { -- Judgement
				debuff = true,
			},
			[54149] = {}, -- Infusion of Light
			[31842] = {}, -- Avenging Wrath
			[105809] = { -- Holy Avenger
				showFunc = function()
					return select(4, GetTalentInfo(5, 3, 1))
				end
			},
			[216411] = { -- Divine Purpose (Holy Shock)
				stack = "HS",
				showFunc = function()
					return select(4, GetTalentInfo(7, 1, 1))
				end
			},
			[216413] = { -- Divine Purpose (Light of Dawn)
				stack = "LD",
				showFunc = function()
					return select(4, GetTalentInfo(7, 1, 1))
				end
			},
			[294027] = { -- Critical Chance
				stack = "+C",
			},
			[216331] = { -- Avenging Crusader
				showFunc = function()
					return select(4, GetTalentInfo(6, 2, 1))
				end
			},
			[31884] = {}, -- Avenging Wrath
			[214202] = {}, -- Rule of Law
			[216331] = {}, -- Avenging Crusader
		}
		t.buffsC = {
		}
	elseif specID == 66 then --Protection
		--gcd = 19750, -- Flash of Light
		iCD.outOfRangeSpells = {
			main = 'Rebuke',
			range = "Avenger's Shield",
		}
		t.row1 = {
			[31935] = { -- Avenger's Shield
				order = 4,
				range = true,
				glow = true,
				glowSound = true,
				showTimeAfterGCD = true,
				stack = true,
				stackFunc = function()
					local count, duration, expirationTime, value1, value2, value3 = iCD.UnitBuff('player', "Avenger's Valor", nil, 'player')
					if expirationTime then
						local dura = expirationTime - GetTime()
						if dura > 5 then
							return dura,'%.0f'
						else
							return dura, '|cffff1a1a%.1f'
						end
					else
						return ''
					end

				end,
				--glow = 31935,
			},
			[204019] = { -- Blessed Hammer
				order = 5,
				stack = true,
				charges = true,
				showFunc = function()
					return select(4, GetTalentInfo(1, 3, 1))
				end,
				showTimeAfterGCD = true,
			},
			[53595] = { -- Hammer of the Righteous
				order = 5,
				stack = true,
				charges = true,
				range = true,
				customRangeSpell = 'Rebuke',
				showFunc = function()
					return not select(4, GetTalentInfo(1, 3, 1))
				end,
				showTimeAfterGCD = true,
			},
			[20271] = { -- Judgment
				order = 7,
				range = true,
				stack = select(4, GetTalentInfo(2, 2, 1)),
				charges = select(4, GetTalentInfo(2, 2, 1)),
				showTimeAfterGCD = true,
			},
			[26573] = { -- Consecration
				order = 8,
				stack = true,
				stackFunc = function()
					if iCD.customSpellTimers[26573] then
						local dura =  iCD.customSpellTimers[26573] - GetTime()
						if dura <= 0 then
							return ''
						elseif dura > 5 then
							return dura,'%.0f'
						else
							return dura, '|cffff1a1a%.1f'
						end
					else
						return ''
					end
				end,
				showTimeAfterGCD = true,
			},
		}
		t.row2 = {
			[152262] = { -- Seraphim
				order = 3,
				showFunc = function()
					return select(4, GetTalentInfo(7, 3, 1))
				end,
			},
			[31884] = { -- Avenging Wrath
				order = 6,
			},
			--[212641] = { -- Guardian of Ancient Kings
			[86659] = {
				order = 7,
				ignoreGCD = true,
			},
			[31850] = { -- Ardent Defender
				order = 8,
				ignoreGCD = true,
			},
			[115750] = { -- Blinding Light
				order= 9,
				showFunc = function()
					return select(4, GetTalentInfo(3, 3, 1))
				end,
				showTimeAfterGCD = true,
			},
			[6940] = { -- Blessing of Sacrifice
				ignoreGCD = true,
				order = 8,
			},
			[633] = { -- Lay on Hands
				order = 9,
				ignoreGCD = true,
			},
		}
		t.row3 = {
			[184092] = { -- Light of the Protector
				order = 2,
				charges = IsEquippedItem(144275),
				stack = IsEquippedItem(144275),
				showFunc = function()
					return not (select(4, GetTalentInfo(5, 3, 1)))
				end,
			},
			[213652] = { -- Hand of the Protector
				order = 2,
				charges = IsEquippedItem(144275),
				stack = IsEquippedItem(144275),
				showFunc = function()
					return select(4, GetTalentInfo(5, 3, 1))
				end,
			},
			[53600] = { -- Shield of the Righteous
				order = 3,
				stack = true,
				charges = true,
				ignoreGCD = true,
				range = true,
				AM = function()
					local count, duration, expirationTime, value1, value2, value3 = iCD.UnitBuff('player', 'Shield of the Righteous')
					if expirationTime then
						local dura = expirationTime - GetTime()
						if dura + 4.5 > 13.5 then
							return true
						end
					end
					return
				end,
			},
		}
		t.row4 = {
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
					return select(4, GetTalentInfo(2, 3, 1))
				end,
			},
			[204150] = { -- Aegis of Light
				showFunc = function()
					return select(4, GetTalentInfo(6, 1, 1))
				end,
			},
			[1022] = { -- Blessing of Protection
				showFunc = function()
					return not select(4, GetTalentInfo(4, 3, 1))
				end,
			},
			[204018] = { -- Blessing of Spellwarding
				showFunc = function()
					return select(4, GetTalentInfo(4, 3, 1))
				end,
			},
			[213644] = {}, -- Cleanse Toxins
		}
		t.row5 = {
			[31850] = {}, -- Ardent Defender
			[212641] = {}, -- Guardian of Ancient Kings
		}
		t.buffsI = {
			[132403] = {}, -- Shield of the Righteous
			[280375] = {}, -- Redoubt
		}
		t.buffsC = {
			[152262] = { -- Seraphim
				showFunc = function()
					return select(4, GetTalentInfo(7, 3, 1))
				end,
			}, -- Seraphim
			[31884] = {}, -- Avenging Wrath
		}
	elseif specID == 70 then --Retribution
		--gcd = 19750,
		iCD.outOfRangeSpells = {
			main = "Templar's Verdict",
			range = "Judgment",
		}
		t.power = {
			pos = {
				x = -990,
				y = -8,
			},
			func = function()
				return UnitPower('player', 9)
			end,
		}
		t.row1 = {
			[35395] = { -- Crusader Strike
				order = 2,
				range = true,
				stack = true,
				charges = true,
				showTimeAfterGCD = true,
			},
			[20271] = { -- Judgment
				order = 3,
				range = true,
				showTimeAfterGCD = true,
			},
			[184575] = { -- Blade of Justice
				order = 5,
				showTimeAfterGCD = true,
				range = true,
				glow = true,
				glowSound = true,
			},
			[255937] = { -- Wake of Ashes
				order = 7,
				range = true,
				showTimeAfterGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(4, 3, 1))
				end,
			},
			[24275] = { -- Hammer of Wrath
				order = 7,
				range = true,
				showTimeAfterGCD = true,
				cost = true,
				customCost = function()
					local isUsable = IsUsableSpell("Hammer of Wrath")
					if not isUsable then
						return true
					end
				end,
				glow = true,
				glowSound = "text1",
				showFunc = function()
					return select(4, GetTalentInfo(2, 3, 1))
				end,
			},
		}
		t.row2 = {
			[31884] = { -- Avenging Wrath
				order = 4,
				showFunc = function()
					return not select(4, GetTalentInfo(7, 2, 1))
				end,
			},
			[231895] = { -- Crusade
				order = 4,
				showFunc = function()
					return select(4, GetTalentInfo(7, 2, 1))
				end,
			},
			[184662] = { -- Shield of Vengeance
				order = 8,
			},
			[210191] = { -- Word of Glory
				order = 9,
				stack = true,
				charges = true,
				showFunc = function()
					return select(4, GetTalentInfo(6, 3, 1))
				end,
			},
			[633] = { -- Lay on Hands
				order = 12,
				ignoreGCD = true,
			},

		}
		t.row3 = {}
		t.row4 = {
			[115750] = { -- Blinding Light
				showFunc = function()
					return select(4, GetTalentInfo(3, 3, 1))
				end,
			},
			[213644] = {}, -- Cleanse Toxins
			[190784] = { -- Divine Steed
				charges = true,
				stack = true,
				stackFunc = function()
					if select(4, GetTalentInfo(5, 2, 1)) then
						local c = GetSpellCharges(190784)
						return c
					else
						return ''
					end
				end
			},
			[183218] = {}, -- Hand of Hindrance

		}
		t.row5 = {
			[184662] = {}, -- Shield of Vengeance
		}
		t.buffsI = {
			[197277] = {  -- Judgment
				debuff = true,
			},
			[223819] = {  -- Divine Purpose
				showFunc = function()
					return select(4, GetTalentInfo(7, 1, 1))
				end,
			},
		}
		t.buffsC = {
			[114250] = { -- Selfless Healer
				stack = true,
				showFunc = function()
					return select(4, GetTalentInfo(6, 1, 1))
				end,
			},
			[31884] = {}, -- Avenging Wrath
			[231895] = {}, -- Crusade
		}
	end
	return temp
end
