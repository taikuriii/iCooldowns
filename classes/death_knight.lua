local _, iCD = ...
function iCD:DEATHKNIGHT(specID)
	iCD.customSpellTimers[55233] = 0
	local temp = {}
	temp.spec = {}
	local t = temp.spec
	t.row1 = {}
	t.row2 = {}
	t.row3 = {}
	t.row4 = {}
	t.row5 = {}
	t.buffsC = {}
	t.buffsI = {}
	if specID == 250 then -- Blood

		iCD.outOfRangeSpells = {
			main = 'Death Strike',
			range = 'Death Grip',
		}
		t.gcd = 49998 -- Death Strike
		t.power = {
			pos = {
				x = -990,
				y = -8,
			},
			func = function()
				local DS = select(2, IsUsableSpell('Death Strike'))
				return (not DS and '|cff00ff00' or '') .. UnitPower('player', 6)
			end,
		}
		t.row1 = {

			[210764] = { -- Rune Strike
				order = 1,
				showTimeAfterGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(1, 3, 1))
				end,
				charges = true,
				stack = true,
				range = true,
			},
			[206931] = { -- Blooddrinker
				order = 1,
				showTimeAfterGCD = true,
				range = true,
				customText = function()
					if iCD.customSpellTimers[206931] then
						local dura =  iCD.customSpellTimers[206931] - GetTime()
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
				showFunc = function()
					return select(4, GetTalentInfo(1, 2, 1))
				end,
			},
			[50842] = { -- Blood Boil
				order = 2,
				row = 1,
				stack = true,
				charges = true,
				showTimeAfterGCD = true,
			},
			[43265] = { -- Death and Decay
				order = 4,
				glow = true,
				row = 1,
				glow = 43265,
				glowSound = true,
				stack = true,
				stackFunc = function()
					local count, duration, expirationTime, value1, value2, value3 = iCD.UnitBuff('player', 'Death and Decay')
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
				customText = function()
					if iCD.customSpellTimers[43265] then
						local s,d = GetSpellCooldown(43265)
						if s == 0 then
							return ''
						end
						local dura =  iCD.customSpellTimers[43265] - GetTime()
						if dura <= 0 then
							return ' '
						elseif dura > 5 then
							return dura,'%.0f'
						else
							return dura, '|cffff1a1a%.1f'
						end
					else
						return ''
					end
				end,
				--showTimeAfterGCD = true,
			},
			[274156] = { -- Consumption
				order = 5,
				showTimeAfterGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(2, 3, 1))
				end,
			},
		}
		t.row2 = {
			[194679] = { -- Rune Tap
				order = 3,
				stack = true,
				charges = true,
				showFunc = function()
					return select(4, GetTalentInfo(4, 3, 1))
				end,
			},
			[219809] = { -- Tombstone
				order = 4,
				showFunc = function()
					return select(4, GetTalentInfo(3, 3, 1))
				end,
				cost = true,
			},
			[55233] = { -- Vampiric Blood
				order = 5,
			},
			[48707] = { -- Anti-Magic Shell
				order = 6,
			},
			[49028] = { -- Dancing Rune Weapon
				order = 7,
				range = true,
			},
			[48792] = { -- Icebound Fortitude
				order = 8,
			},
			[194844] = { -- Bonestorm
				order = 11,
				showFunc = function()
					return select(4, GetTalentInfo(7, 3, 1))
				end,
				showTimeAfterGCD = true,
			},
		}
		t.row3 = {
		}
		t.row4 = {
			[221562] = {}, -- Asphyxiate
			[56222] = {}, -- Dark Command
			[49576] = {}, -- Death Grip
			[108199] = {}, -- Gorefiend's Grasp
			[212552] = {}, -- Wraith Walk
			[48265] = {}, -- Death's Advance
		}
		t.row5 = {
			[48707] = {}, -- Anti-Magic Shell
			[212552] = { -- Wraith Walk
				showFunc = function()
					return select(4, GetTalentInfo(5, 3, 1))
				end,
			},
			[55233] = { -- Vampiric Blood
				stack = true,
				stackFunc = function()
					if not iCD.customSpellTimers[55233] then return '' end
					return iCD.customSpellTimers[55233]/1e6*5, '%.1f'
				end,
			},
			[81256] = {}, -- Dancing Rune Weapon
			[48792] = {}, -- Icebound Fortitude
		}
		t.buffsI = {
			[195181] = { -- Bone shield
				stack = true,
			},
			[274009] = {}, -- DS Leech
			[48265] = {}, -- Death's Advance
			[194679] = { -- Rune Tap
				showFunc = function()
					return select(4, GetTalentInfo(4, 3, 1))
				end,
			},
			[206940] = { -- Mark of Blood
				showFunc = function()
					return select(4, GetTalentInfo(6, 3, 1))
				end,
				debuff = true,
			},
			--[188290] = {}, -- Death and Decay
			[77535] = { -- Blood Shield
				stack = true,
				stackFunc = function()
					local amount = select(5, iCD.UnitBuff('player', 'Blood Shield'))
					if amount then
						return math.floor((amount/UnitHealthMax('player'))*100)
					else
						return 0
					end
				end,
			},
			[235559] = { -- Heamostasis
				customText = function()
					local count = iCD.UnitBuff('player', 'Haemostasis', nil, 'player')
					if count then
						return count > 0 and count or ''
					else
						return ''
					end
				end,
				showFunc = function()
					return (IsEquippedItem(144281) or select(4, GetTalentInfo(2, 2, 1)))
				end,
			},
			[273947] = { -- Hemostasis
				customText = function()
					local count = iCD.UnitBuff('player', 'Hemostasis', nil, 'player')
					if count then
						return count > 0 and count or ''
					else
						return ''
					end
				end,
				showFunc = function()
					return (IsEquippedItem(144281) or select(4, GetTalentInfo(2, 2, 1)))
				end,
			},
			[219809] = { -- Tombstone
				showFunc = function()
					return select(4, GetTalentInfo(3, 3, 1))
				end,
				stack = true,
				stackFunc = function()
					local count, duration, expirationTime, value1, value2, value3 = iCD.UnitBuff('player', 'Tombstone', nil, 'player')
					if value2 then
						return value2/1e3, '%.0f'
					else
						return ''
					end
				end,
			},
		}
		t.buffsC = {
			[194844] = { -- Bonestorm
				showFunc = function()
					return select(4, GetTalentInfo(7, 3, 1))
				end,
			},
			[242010] = {}, -- Gravewarden
			[238698] = {
				stack = '+L',
			}
		}
	elseif specID == 251 then -- Frost
		iCD.outOfRangeSpells = {
			main = 'Death Strike',
			range = 'Death Grip',
		}
		t.power = {
			pos = {
				x = -990,
				y = -8,
			},
			func = function()
				local DS = select(2, IsUsableSpell('Frost Strike'))
				return (not DS and '|cff00ff00' or '') .. UnitPower('player', 6)
			end,
		}
		t.row1 = {
			[49184] = { -- Howling Blast
				order = 2,
				range = true,
				cost = true,
				showTimeAfterGCD = true,
				stack = true,
				stackFunc = function()
					local name, _, icon, count, debuffType, duration, expirationTime, _, _, _, spellID = UnitBuff('player', 'Rime')
					if name then
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
				glow = true,
				glowSound = 'text1',
			},
			[49020] = { -- Obliterate
				order = 3,
				range = true,
				cost = true,
				showTimeAfterGCD = true,
				stack = true,
				stackFunc = function()
					local name, _, icon, count, debuffType, duration, expirationTime, _, _, _, spellID = UnitBuff('player', 'Killing Machine')
					if name then
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
				glow = true,
				glowSound = true,
			},
			[196770] = { -- Remorless Winter
				order = 5,
				cost = true,
			},
		}
		t.row2 = {
			[51271] = { -- Pillar of Frost
				order = 3,
				ignoreGCD = true,
			},
			[47568] = { -- Empowered Rune Weapon
				order = 6,
				ignoreGCD = true,
			},
			[207256] = { -- Obliteration
				order = 4,
				showFunc = function()
					return select(4, GetTalentInfo(7, 1, 1))
				end,
			},
			[152279] = { -- Breath of Sindragosa
				order = 4,
				showFunc = function()
					return select(4, GetTalentInfo(7, 2, 1))
				end,
			},
			[190778] = { -- Sindragosa's Fury
				order = 5,
			},
			[48707] = { -- Anti-Magic Shell
				order = 7,
			},
			[48792] = { -- Icebound Fortitude
				order = 8,
			},
		}
		t.row4 = {
			[221562] = {}, -- Asphyxiate
			[56222] = {}, -- Dark Command
			[49576] = {}, -- Death Grip
			[108199] = {}, -- Gorefiend's Grasp
			[212552] = {}, -- Wraith Walk

		}
		t.row5 = {
			[48707] = {}, -- Anti-Magic Shell
			[212552] = {}, -- Wraith Walk
			[55233] = {}, -- Vampiric Blood
			[81256] = {}, -- Dancing Rune Weapon
			[48792] = {}, -- Icebound Fortitude
		}
		t.buffsI = {
			[51271] = {}, -- Pillar of Frost
			[207256] = {}, -- Obliteration
		}
		t.buffsC = {

		}
	elseif specID == 252 then --Unholy
			iCD.outOfRangeSpells = {
				main = 'Death Strike',
				range = 'Death Coil',
			}
			t.power = {
				pos = {
					x = -990,
					y = -8,
				},
				func = function()
					local DS = select(2, IsUsableSpell('Death Coil'))
					return (not DS and '|cff00ff00' or '') .. UnitPower('player', 6)
				end,
			}

			t.row1 = {
				[47541] = { -- Death Coil
					range = true,
					cost = true,
					order = 1,
					glow = true,
					glowSound = true,
				},
				[43265] = { -- Death and Decay
					order = 2,
					glow = true,
					row = 1,
					glow = 43265,
					glowSound = true,
					stack = true,
					stackFunc = function()
						local count, duration, expirationTime, value1, value2, value3 = iCD.UnitBuff('player', 'Death and Decay')
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
					showFunc = function()
						return not select(4, GetTalentInfo(7, 2, 1))
					end,
					customText = function()
						if iCD.customSpellTimers[43265] then
							local s,d = GetSpellCooldown(43265)
							if s == 0 then
								return ''
							end
							local dura =  iCD.customSpellTimers[43265] - GetTime()
							if dura <= 0 then
								return ' '
							elseif dura > 5 then
								return dura,'%.0f'
							else
								return dura, '|cffff1a1a%.1f'
							end
						else
							return ''
						end
					end,
					--showTimeAfterGCD = true,
				},
				[63560] = { -- Dark Transformation
					range = true,
					order = 3,
				},

				[275699] = { --Apocalypse
					range = true,
					order = 5,
				},
			}
			t.row2 = {
				[42650] = { -- Army of the Dead
					order = 4,
					cost = true,
				},
				[48707] = { -- Anti-Magic Shell
					order = 6,
					ignoreGCD = true,
				},
				[48792] = { -- Icebound Fortitude
					order = 8,
					ignoreGCD = true,
				}

			}
			t.row4 = {
				[46584] = {}, -- Raise Dead
				[212552] = {  -- Wraith Walk
					showFunc = function()
						return select(4, GetTalentInfo(5, 2, 1))
					end,
				},
				[56222] = { -- Dark Command
					ignoreGCD = true,
				},
				[46584] = {}, -- Raise Dead
				[48265] = {}, -- Death Advance
				[49576] = {}, -- Death Grip
			}
			t.buffsC = {
				[274373] = { -- Festermight (trait)
					stack = true,
				},
			}
			t.buffsI = {
				[194310] = { -- Festering Wound
					debuff = true,
					stack = true,
				},
				[191587] = { -- Virulent Plague
					debuff = true,
				},
				[196782] = { -- Outbreak
					debuff = true,
				}
			}

	end
	temp.all = {}
	temp.all.row1 = {}
	temp.all.row2 = {}
	temp.all.row3 = {}
	temp.all.row4 = {
		[20572] = {}, -- Blood Fury
	}
	temp.all.row5 = {}
	temp.all.buffsC = {}
	temp.all.buffsI = {}
	return temp
end
