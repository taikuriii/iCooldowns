local _, iCD = ...
function iCD:WARLOCK(specID)
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
	if specID == 265 then -- Affliction
		--gcd = 162243, -- Demon's Bite
		iCD.outOfRangeSpells = {
			main = 'Corruption',
			range = 'Corruption',
		}
		t.power = {
			pos = {
				x = -990,
				y = -8,
			},
			func = function()
				return math.floor((UnitPower('player', 0)/UnitPowerMax('player', 0))*100)
			end,
		}
		t.row1 = {
			[205179] = { -- Phantom Singularity
				order = 7,
				range = true,
				showFunc = function()
					return select(4, GetTalentInfo(4, 1, 1))
				end,
			},
		}
		t.row2 = {
			[196098] = { -- Soul Harvest
				order = 3,
				showFunc = function()
					return select(4, GetTalentInfo(4, 3, 1))
				end,
				ignoreGCD = true,
			},
			[104773] = { -- Unending Resolve
				order = 5,
				ignoreGCD = true,
			},
		}
		t.row3 = {
			[216698] = { -- Reap Souls
				order = 3,
				stack = true,
				stackFunc = function()
					return GetSpellCount(216698)
				end,
				customText = function()
					local name, _, icon, count, debuffType, duration, expirationTime, _, _, _, spellID = UnitBuff('player', 'Deadwind Harvester', nil, 'player')
					if name then
						local dura = expirationTime - GetTime()
						if dura > 5 then
							return string.format('%.0f', dura)
						else
							return string.format('|cffff1a1a%.1f', dura)
						end
					else
						return ' '
					end
				end,
			},
		}
		t.row4 = {

			[111771] = {}, -- Demonic Gateway
			[6789] = { -- Mortal Coil
				showFunc = function()
					return select(4, GetTalentInfo(3,2,1))
				end,
			},
		}
		t.buffsC = {
			[196098] = { -- Soul Harvest
				showFunc = function()
					local talent = select(4, GetTalentInfo(4, 3, 1))
					local chest = IsEquippedItem(151821)
					if talent or chest then return true else return false end
				end,
			},
			[235156] = { -- Empowered Life Tap
				showFunc = function()
					return select(4, GetTalentInfo(2,3,1))
				end,
				stack = "+D",
			}
		}
		t.buffsI = {
			[233490] = { -- Unstable Affliciton #1
				debuff = true,
			},
			[233496] = { -- Unstable Affliciton #2
				debuff = true,
			},
			[233497] = { -- Unstable Affliciton #3
				debuff = true,
			},
			[233498] = { -- Unstable Affliciton #4
				debuff = true,
			},
			[233499] = { -- Unstable Affliciton #5
				debuff = true,
			},
			[172] = { -- Corruption
				debuff = true,
			},
			[146739] = { -- Corruption
				debuff = true,
			},
			[980] = { -- Agony
				stack = true,
				debuff = true,
			},
			[63106] = { -- Siphon Life
				debuff = true,
				showFunc = function()
					return select(4, GetTalentInfo(7,2,1))
				end,
			},
		}
	elseif specID == 266 then --Demonology
		iCD.outOfRangeSpells = {
			main = 'Doom',
			range = 'Doom',
		}
		t.power = {
			pos = {
				x = -990,
				y = -8,
			},
			func = function()
				return math.floor((UnitPower('player', 0)/UnitPowerMax('player', 0))*100)
			end,
		}
		t.row1 = {
			[211714] = { -- Thal'kiel's Consumption
				order = 3,
				range = true,
			},
			[104316] = { -- Call Dreadstalkers
				order = 5,
				range = true,
				cost = true,
			},
			[205180] = { -- Summon Darkglare
			order = 7,
			cost = true,
			showFunc = function()
				return select(4, GetTalentInfo(7, 1, 1))
			end,
		},
		}
		t.row2 = {
			[18540] = { -- Summon Doomguard
				order = 3,
				cost = true,
			},
			[104773] = { -- Unending Resolve
				order = 5,
				ignoreGCD = true,
			},
		}
		t.row3 = {
			[196606] = { -- Demonic Empowerment
				order = 3,
				customText = function()
					local name, _, icon, count, debuffType, duration, expirationTime, _, _, _, spellID = UnitBuff('pet', 'Demonic Empowerment', nil, 'player')
					if name then
						local dura = expirationTime - GetTime()
						if dura > 5 then
							return string.format('%.0f', dura)
						else
							return string.format('|cffff1a1a%.1f', dura)
						end
					else
						return ' '
					end
				end,
			},
		}
		t.row4 = {

			[111771] = {}, -- Demonic Gateway
			[6789] = { -- Mortal Coil
				showFunc = function()
					return select(4, GetTalentInfo(3,2,1))
				end,
			},
		}
		t.buffsC = {
		}
		t.buffsI = {
			[603] = { -- Doom
				debuff = true,
			},
		}
	elseif specID == 267 then --Destruction
				--gcd = 162243, -- Demon's Bite
				iCD.outOfRangeSpells = {
					main = 'Incinerate',
					range = 'Incinerate',
				}
				t.power = {
					pos = {
						x = -990,
						y = -8,
					},
					func = function()
						return math.floor((UnitPower('player', 0)/UnitPowerMax('player', 0))*100)
					end,
				}
				t.row1 = {
					[196586] = { -- Dimensional Rift
						order = 2,
						range = true,
						stack = true,
						charges = true,
					},
					[17962] = { -- Conmflagrate
						order = 5,
						range = true,
						stack = true,
						charges = true,
					},
					[80240] = { -- Havoc
						order = 7,
						range = true,
						cost = true,
					},
				}
				t.row2 = {
					[196098] = { -- Soul Harvest
						order = 3,
						showFunc = function()
							return select(4, GetTalentInfo(4, 3, 1))
						end,
						ignoreGCD = true,
					},
					[104773] = { -- Unending Resolve
						order = 5,
						ignoreGCD = true,
					},
				}
				t.row3 = {
				}
				t.row4 = {

					[111771] = {}, -- Demonic Gateway
					[6789] = { -- Mortal Coil
						showFunc = function()
							return select(4, GetTalentInfo(3,2,1))
						end,
					},
				}
				t.buffsC = {
					[196098] = { -- Soul Harvest
						showFunc = function()
							local talent = select(4, GetTalentInfo(4, 3, 1))
							local chest = IsEquippedItem(151821)
							if talent or chest then return true else return false end
						end,
					},
					[235156] = { -- Empowered Life Tap
						showFunc = function()
							return select(4, GetTalentInfo(2,3,1))
						end,
						stack = "+D",
					}
				}
				t.buffsI = {
					[157736] = { -- Immolate
						debuff = true,
					},
				}
	end
	return temp
end
