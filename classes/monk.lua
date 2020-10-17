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
function iCD:MONK(specID)
	iCD.outOfRangeSpells = {
		main = 'Tiger Palm',
		range = 'Keg Smash',
	}

	local temp = {}
	temp.spec = {}
	temp.all = {}
	temp.all.row1 = {}
	temp.all.row2 = {}
	temp.all.row3 = {}
	temp.all.row4 = {}
	temp.all.row5 = {}
	temp.all.buffsC = {}
	temp.all.buffsI = {}
	local t = temp.spec
	t.row1 = {}
	t.row2 = {}
	t.row3 = {}
	t.row4 = {}
	t.row5 = {}
	t.buffsC = {}
	t.buffsI = {}
	if specID == 268 then --Brewmaster
		t.power = {
			pos = {
				x = -990,
				y = -8,
			},
			func = function()
				local power = UnitPower('player', 3)
				local regen = GetPowerRegen()
				--color

				local castingTimeLeft
				local _,_,_,_,_,currentcastingTimeLeft = UnitCastingInfo('player')
				if currentcastingTimeLeft then
					castingTimeLeft = currentcastingTimeLeft/1000-GetTime()
				else
					castingTimeLeft = 0
				end
				local gcdstart, gcdcooldown = GetSpellCooldown('Tiger Palm')
				local gcdLeft = gcdstart + gcdcooldown-GetTime()
				if castingTimeLeft <= gcdLeft then
					castingTimeLeft = gcdLeft
				end
				local powerAfterGCD = power + (castingTimeLeft+1)*regen
				local color = ''
				if powerAfterGCD >= 90 then
					return '|cffff0000' .. power
				else
					local KSstart, KScooldown = GetSpellCooldown('Keg Smash')
					local KSLeft = KSstart + KScooldown-GetTime()
					local powerAtKS = power + (KSLeft)*regen
					if powerAtKS-25 >= 37 then
						return '|cff00ff00' .. power
					end
				end
				return power
			end,
		}
		t.row1 = {
			[121253] = { -- Keg Smash
				order = 2,
				range = true,
				cost = true,
				showTimeAfterGCD = true,
				charges = IsEquippedItem(151788),
				stack = IsEquippedItem(151788),
			},
			[205523] = { -- Blackout Strike
				order = 4,
				range = true,
				customRangeSpell = 'Tiger Palm',
				stack = select(4, GetTalentInfo(7, 2, 1)),
				stackFunc = select(4, GetTalentInfo(7, 3, 1)) and function()
					local count, duration, expirationTime, value1, value2, value3 = iCD.UnitBuff('player', 'Blackout Combo')
					if expirationTime then
						return '+', '|cff00ff00%s'
					else
						return ' '
					end
				end or false,
				showTimeAfterGCD = true,
			},
			[115181] = { -- Breath of Fire
				order = 6,
				stack = true,
				glow = true,
				glowSound = true,
				stackFunc = function()
					local count, duration, expirationTime, value1, value2, value3 = iCD.UnitDebuff('Breath of Fire')
					if expirationTime then
						local dura = expirationTime - GetTime()
						if dura > 5 then
							--return string.format('%.0f', dura)
							return dura, '%.0f'
						else
							return dura, '|cffff1a1a%.1f'
						end
					else
						return ''
					end
				end,
				showTimeAfterGCD = true,
				level = 40,
			},
			[116847] = { -- Rushing Jade Wind
				order = 8,
				showFunc = function()
					return select(4, GetTalentInfo(6, 2, 1))
				end,
				stack = true,
				stackFunc = function()
					local count, duration, expirationTime, value1, value2, value3 = iCD.UnitBuff('player', 'Rushing Jade Wind')
					if expirationTime then
						local dura = expirationTime - GetTime()
						return dura, '%.0f'
					else
						return ''
					end
				end,
				showTimeAfterGCD = true,
			},
			[123986] = { -- Chi Burst
				order = 10,
				range = true,
				showFunc = function()
					return select(4, GetTalentInfo(1, 3, 1))
				end,
				showTimeAfterGCD = true,
			},
			[115098] = { -- Chi Wave
				order = 10,
				range = true,
				showFunc = function()
					return select(4, GetTalentInfo(1, 2, 1))
				end,
				showTimeAfterGCD = true,
			},
		}
		t.row2 = {
			[122281] = { -- Healing Elixir
				order = 3,
				stack = true,
				charges = true,
				ignoreGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(5, 2, 1))
				end,
			},
			[122278] = { -- Dampening Harm
				order = 4,
				ignoreGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(5, 3, 1))
				end,
			},
			[115295] = { -- Guard
				order = 5,
				range = true,
				showFunc = function() return select(4, GetTalentInfo(7, 2, 1)) end,
			},
			[132578] = { -- Invoke Niuzao, the Black Ox
				order = 6,
				range = true,
				showFunc = function() return select(4, GetTalentInfo(6, 3, 1)) end,
			},
			[115203] = { -- Fortifying Brew
				order = 8,
				ignoreGCD = true,
				level = 55,
			},
			[115176] = { -- Zen Meditation
				order = 10,
				ignoreGCD = true,
				level = 65,
			},

		}
		t.row3 = {
			[115072] = { -- Expel Harm
				order = 3,
				stack = true,
				stackFunc = function()
					return GetSpellCount(115072)
				end,
				cost = true,
				level = 50,
			},
			[119582] = { -- Brews
				order = 2,
				stack = true,
				charges = true,
				ignoreGCD = true,
				AM = function()
					local count, duration, expirationTime, value1, value2, value3 = iCD.UnitBuff('player', 'Ironskin Brew')
					if expirationTime then
						local dura = expirationTime - GetTime()
						if dura + 8.5 > 25.5 then
							return true
						end
					end
					return
				end,
			},
			[115399] = { --Black Ox Brew
				order = 1,
				ignoreGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(3, 3, 1))
				end,
			},
		}
		t.row4 = {
			[218164] = {}, -- Detox
			[119381] = {}, -- Leg Sweep
			[116844] = { -- Ring of Peace
				showFunc = function()
					return select(4, GetTalentInfo(4, 3, 1))
				end,
			},
			[115315] = { -- Summon Black Ox Statue
				showFunc = function()
					return select(4, GetTalentInfo(4, 2, 1))
				end,
			},
			[115078] = {}, -- Paralysis
			[115546] = {}, -- Provoke
			[101643] = {}, -- Transcendence
			[119996] = {}, -- Transcendence: Transfer
			[115008] = { -- Chi Torpedo
				stack = true,
				charges = true,
				ignoreGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(2, 2, 1))
				end,
			},
			[109132] = { -- Roll
				stack = true,
				charges = true,
				ignoreGCD = true,
				showFunc = function()
					return not select(4, GetTalentInfo(2, 2, 1))
				end,
			},
			[116841] = { -- Tiger's Lust
				showFunc = function()
					return  select(4, GetTalentInfo(2, 3, 1))
				end,
			},
		}
		t.row5 = {
			[120954] = {}, -- Fortifying Brew
			[122278] = {}, -- Dampening Harm

		}
		t.buffsC = {
			[119085] = { -- Chi Torpedo, speed buff
				stack = true,
				showFunc = function()
					return select(4, GetTalentInfo(2, 2, 1))
				end,
			},
		}
		t.buffsI = {
			[215479] = {}, -- Ironskin Brew
		}
	elseif specID == 269 then --Windwalker
		t.power = {
			pos = {
				x = -990,
				y = -8,
			},
			func = function()
					return UnitPower('player', 3)
			end,
		}
		t.row1 = {
			[107428] = { -- Rising Sun Kick
				order = 2,
				range = true,
				cost = true,
				showTimeAfterGCD = true,
			},
			[113656] = { -- First of Fury
				order = 3,
				range = true,
				cost = true,
				showTimeAfterGCD = true,
			},
			[152175] = { -- Whirling Dragon Punch
				order = 7,
				showTimeAfterGCD = true,
				cost = true,
				range = true,
				customCost = function()
					local isUsable = IsUsableSpell("Whirling Dragon Punch")
					if not isUsable then
						return true
					end
				end,
				showFunc = function()
					return select(4, GetTalentInfo(7, 2, 1))
				end,
			},
			[261947] = { -- Fist of the White Tiger
				order = 8,
				showTimeAfterGCD = true,
				cost = true,
				range = true,
				showFunc = function()
					return select(4, GetTalentInfo(3, 2, 1))
				end,
			},
			[116847] = { -- Rushing Jade Wind
				order = 10,
				cost = true,
				showTimeAfterGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(6, 2, 1))
				end,
			},
			[123986] = { -- Chi Burst
				order = 11,
				cost = true,
				showTimeAfterGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(1, 3, 1))
				end,
			},
		}
		t.row2 = {
			[122278] = { -- Dampening Harm
				order = 5,
				ignoreGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(5, 3, 1))
				end,
			},
			[122783] = { -- Diffuse Magic
				order = 5,
				ignoreGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(5, 2, 1))
				end,
			},
			[123904] = { -- Invoke Xuen, the White Tiger
				order = 1,
				showFunc = function()
					return select(4, GetTalentInfo(6, 3, 1))
				end,
			},
			[137639] = { -- Storm, Earth, and Fire
				order = 2,
				stack = true,
				charges = true,
			},
			[115080] = { -- Touch of Death
				order = 3,
			},
			[122470] = { -- Touch of Karma
				order = 4,
				ignoreGCD = true,
				range = true,
			},
		}
		t.row3 = {

		}
		t.row4 = {
			[101545] = {}, -- Flying Serpent Kick
			[115078] = {}, -- Paralysis
			[115546] = {  -- Provoke
				ignoreGCD = true,
			},
			[101643] = {}, -- Transcendence
			[119996] = {}, -- Transcendence: Transfer
			[115008] = { -- Chi Torpedo
				stack = true,
				charges = true,
				ignoreGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(2, 2, 1))
				end,
			},
			[109132] = { -- Roll
				stack = true,
				charges = true,
				ignoreGCD = true,
				showFunc = function()
					return not select(4, GetTalentInfo(2, 2, 1))
				end,
			},
			[218164] = {}, -- Detox
			[119381] = { -- Leg Sweep
			},
			[116844] = { -- Ring of Peace
				showFunc = function()
					return select(4, GetTalentInfo(4, 3, 1))
				end,
			},
			[116841] = { -- Tiger's Lust
				showFunc = function()
					return  select(4, GetTalentInfo(2, 3, 1))
				end,
			},
		}
		t.row5 = {
			[125174] = {}, -- Touch of Karma
		}
		t.buffsC = {

			[287062] = { -- Fury of Xuen
				stack = true,
				azerite = 117,
			}
		}
		t.buffsI = {
			[286587] = { -- Dance of Chi-Ji
				azerite = 391,
				stack = "+SCK",
			},
			[115080] = { -- Touch of Death
				debuff = true,
			},
			[137639] = {}, -- Storm, Earth, and Fire
			[116768] = { -- Free blackout kick
				stack = "+BOK",
			},
		}
	elseif specID == 270 then --Mistweaver
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
			[107428] = { -- Rising Sun Kick
				order = 6,
				glow = true,
				glowSound = true,
				range = true,
				showTimeAfterCast = true,
			},
			[100784] = { -- Blackout Strike
				order = 8,
				range = true,
				customRangeSpell = 'Tiger Palm',
				showTimeAfterCast = true,
				stack = true,
				stackFunc = function()
					local count, duration, expirationTime, value1, value2, value3 = iCD.UnitBuff('player', 'Teachings of the Monastery')
					--local name, _, icon, count, debuffType, duration, expirationTime, _, _, _, spellID = UnitBuff('player', 'Teachings of the Monastery', nil, 'player')
					if count and count > 0 then
						return count
					else
						return ''
					end
				end,
			},
			[196725] =  { -- Refreshing Jade Wind
				order = 10,
				showFunc = function()
					return select(4, GetTalentInfo(6, 2, 1))
				end,
				showTimeAfterCast = true,
			},
			[123986] =  { -- Chi Burst
				order = 12,
				showTimeAfterCast = true,
				showFunc = function()
					return select(4, GetTalentInfo(1, 3, 1))
				end,
			},
			[191837] = { -- Essence of Font
				order = 14,
				showTimeAfterCast = true,
			},


		}
		t.row2 = {
			[216113] = { -- Way of the Crane
				order = 1,
				showFunc = function() return iCD:Essences(32, true) end,
			},
			[116680] = { -- Thunder Focus Tea
				order = 2,
				ignoreGCD = true,
				glow = true,
				glowSound = 'text2',
			},
			[197908] = { -- Mana Tea
				order = 3,
				showFunc = function()
					return select(4, GetTalentInfo(3, 3, 1))
				end,
			},
			[122281] = { -- Healing Elixir
				order = 4,
				stack = true,
				charges = true,
				ignoreGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(5, 1, 1))
				end,

			},
			[122278] = { -- Dampening Harm
				order = 4,
				ignoreGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(5, 3, 1))
				end,
			},
			[122783] = { -- Diffuse Magic
				order = 4,
				ignoreGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(5, 2, 1))
				end,
			},
			[116849] = { -- Life Cocoon
				order = 5,
				ignoreGCD = true,
			},
			[198664] = { -- Invoke Chi-Ji the Red Crane
				order = 7,
				showFunc = function()
					return select(4, GetTalentInfo(6, 3, 1))
				end,
			},
			[115310] = { -- Revival
				order = 8,
			},
			[243435] = { -- Fortifying Brew
				order = 10,
			},
		}
		t.row3 = {
			[115151] = { -- Renewing Mist
				order = 4,
				showTimeAfterCast = true,
				charges = true,
				stack = true,
			},
		}
		t.row4 = {
			[115450] = {}, -- Detox
			[198898] = { -- Song of Chi-Ji
				showFunc = function()
					return select(4, GetTalentInfo(4, 2, 1))
				end,
			},
			[116844] = { -- Ring of Peace
				showFunc = function()
					return select(4, GetTalentInfo(4, 3, 1))
				end,
			},
			[115313] = { -- Summon Jade Serpent Statue
				showFunc = function()
					return select(4, GetTalentInfo(6, 1, 1))
				end,
			},
			[115078] = {}, -- Paralysis
			[115546] = {}, -- Provoke
			[101643] = {}, -- Transcendence
			[119996] = {}, -- Transcendence: Transfer
			[115008] = { -- Chi Torpedo
				stack = true,
				charges = true,
				ignoreGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(2, 2, 1))
				end,
			},
			[109132] = { -- Roll
				stack = true,
				charges = true,
				ignoreGCD = true,
				showFunc = function()
					return not select(4, GetTalentInfo(2, 2, 1))
				end,
			},
			[116841] = { -- Tiger's Lust
				showFunc = function()
					return  select(4, GetTalentInfo(2, 3, 1))
				end,
			},
		}
		t.row5 = {
			[122278] = {}, -- Dampening Harm
		}
		t.buffsC = {
			[119085] = { -- Chi Torpedo, speed buff
				stack = true,
				showFunc = function()
					return select(4, GetTalentInfo(2, 2, 1))
				end,
			},
		}
		t.buffsI = {
			[216113] = {
				showFunc = function() return iCD:Essences(32, true) end,
			},
			[116680] = { -- Thunder Focus Tea
				stack = select(4, GetTalentInfo(7, 2, 1))
			},
			[197206]  = {} -- Uplifting Trance
		}
	end
	return temp
end
