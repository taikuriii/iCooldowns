local _, iCD = ...
function iCD:SHAMAN(specID)
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
	if specID == 262 then -- Elemental
		iCD.outOfRangeSpells = {
			main = "Lightning Bolt",
			range = "Lightning Bolt"
		}
		t.power = {
			func = function()
				local ES = select(2, IsUsableSpell('Earth Shock'))
				return (not ES and '|cff00ff00' or '') .. UnitPower('player', 11)
			end
		}
		t.row1 = {
			[188389] = { -- Flame Shock
				order = 1,
				range = true,
				showTimeAfterGCD = true,
			},
			[51505] = {
				-- Lava Burst
				order = 3,
				range = true,
				stack = select(4, GetTalentInfo(1, 2, 1)),
				charges = select(4, GetTalentInfo(1, 2, 1)),
				glow = true,
				glowSound = true,
				showTimeAfterGCD = true,
			},
			[117014] = {
				-- Elemental Blast
				order = 5,
				range = true,
				showFunc = function()
					return select(4, GetTalentInfo(1, 3, 1))
				end
			},
			[192222] = {
				-- Liquid Magma Totem
				order = 3,
				showFunc = function()
					return select(4, GetTalentInfo(4, 3, 1))
				end,
				showTimeAfterGCD = true,
			},
		}
		t.row2 = {
			[191634] = { -- Stormkeeper
				order = 2,
				showFunc = function()
					return select(4, GetTalentInfo(7, 2, 1))
				end
			},
			[114050] = { -- Ascendance
				order = 4,
				showFunc = function()
					return select(4, GetTalentInfo(7, 3, 1))
				end
			},
			[198067] = {
				-- Fire Elemental
				order = 5
			},
			[108281] = { -- Ancestral Guidance
				order = 7,
				showFunc = function()
					return select(4, GetTalentInfo(5, 2, 1))
				end
			},
			[108271] = {
				-- Astral Shift
				order = 10,
				ignoreGCD = true
			},
			[198103] = {
				-- Earth Elemental
				order = 6
			}
		}
		t.row4 = {
			[51886] = {}, -- Cleanse Spirit
			[2484] = {}, -- Earthbind Totem
			[51514] = {}, -- Hex
			[192058] = {}, -- Lightning Surge Totem
			[51490] = {}, -- Thunderstorm
			[8143] = {}, -- Tremor Totem

		}
		t.buffsC = {
			[114050] = { -- Ascendance
				showFunc = function()
					return select(4, GetTalentInfo(7, 3, 1))
				end
			},
			[16246] = {
				-- Elemental Focus
				stack = true
			},
			[191634] = {
				-- Stormkeeper
				stack = true,
				showFunc = function()
					return select(4, GetTalentInfo(7, 2, 1))
				end
			},
			[273453] = { -- Lava Shock, Azerite trait
				stack = true,
				azerite = 178,
			},
		}
		t.buffsI = {
			[188389] = { -- Flame Shock
				debuff = true
			},
			[286976] = { -- Tectonic Thunder, Azerite trait, instant chain lightning
				azerite = 417,
			},
		}
	elseif specID == 263 then -- Enhancement
		iCD.outOfRangeSpells = {
			main = "Lava Lash",
			range = "Lightning Bolt"
		}
		t.power = {
			func = function()
				return UnitPower("player", 11)
			end
		}
		t.row1 = {
			[193786] = { -- Rockbiter
				order = 3,
				range = true,
				charges = true,
				stack = true,
				showTimeAfterGCD = true,
			},
			[17364] = { -- Stormstrike
				order = 5,
				range = true,
				stack = true,
				glow = true,
				glowSound = true,
				stackFunc = function()
					local c = GetSpellCount(17364)
					return c > 0 and c or ""
				end,
				cost = true,
				showTimeAfterGCD = true,
			},
			[188089] = { -- Earthen Spike
				order = 7,
				range = true,
				cost = true,
				showTimeAfterGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(7, 3, 1))
				end
			},
			[193796] = { -- Flametongue
				order = 10,
				range = true,
				showTimeAfterGCD = true,
				stack = true,
				stackFunc = function()
					local count, duration, expirationTime, value1, value2, value3 = iCD.UnitBuff('player', "Flametongue", nil, 'player')
					if expirationTime then
						local dura = expirationTime - GetTime()
						return dura, '%.0f'
					else
						return ''
					end
				end,
			},
			[187874] = { -- Crash Lightning
				order = 10,
				range = true,
				cost = true,
				showTimeAfterGCD = true,
			},
		}
		t.row2 = {
			[204945] = { -- Doom Winds
				order = 3,
				ignoreGCD = true,
			},
			[51533] = { -- Feral Spirits
				order = 5,
				showTimeAfterGCD = true,
			},
			[108271] = { -- Astral Shift
				order = 7,
				ignoreGCD = true
			}
		}
		t.row4 = {
			[196884] = {-- Feral Lunge
				showFunc = function()
					return select(4, GetTalentInfo(2, 2, 1))
				end
			},
			[136037] = {-- Rainfall
				showFunc = function()
					return select(4, GetTalentInfo(2, 1, 1))
				end
			},
			[2825] = {}, -- Bloodlust
			[51886] = {}, -- Cleanse Spirit
			[2484] = {}, -- Earthbind Totem
			[192063] = {-- Gust of Wind
				showFunc = function()
					return select(4, GetTalentInfo(2, 1, 1))
				end
			},
			[51514] = {}, -- Hex
			[192058] = { -- Lightning Surge Totem
				showFunc = function()
					return select(4, GetTalentInfo(3, 1, 1))
				end
			},
			[58875] = {}, --Spirit Walk
		}
		t.buffsC = {
			[114051] = { -- Ascendance

				showFunc = function()
					return select(4, GetTalentInfo(7, 1, 1))
				end
			},
			[58875] = {} -- Spirit Walk
		}
		t.buffsI = {
			[215864] = { -- Rainfall
				showFunc = function()
					return select(4, GetTalentInfo(2, 1, 1))
				end
			},
			[204945] = {}, -- Doom Winds (artifact)
			[187878] = {}, -- Crash Lightning (cleave)
		}
	elseif specID == 264 then -- Restoration
		iCD.outOfRangeSpells = {
			main = "Flame Shock",
			range = "Flame Shock"
		}
		t.power = {
			func = function()
				return math.floor((UnitPower("player", 0) / UnitPowerMax("player", 0)) * 100)
			end
		}
		t.row1 = {
			[51505] = {
				-- Lava Burst
				order = 3,
				range = true,
				cost = true,
				stack = select(4, GetTalentInfo(2, 1, 1)),
				charges = select(4, GetTalentInfo(2, 1, 1)),
				glow = true,
				glowSound = true
			},
				[188838] = { -- Flame Shock
				order = 4,
				range = true,
				cost = true,
			},
			[61295] = {
				-- Riptide
				order = 2,
				range = true,
				cost = true,
				charges = select(4, GetTalentInfo(2, 1, 1)),
				stack = select(4, GetTalentInfo(2, 1, 1)),
			},
			[73920] = { -- Healing Rain
				order = 6,
				cost = true,
				range = true
			},
			[5394] = {
				-- Healing Stream Totem
				order = 7,
				range = true,
				charges =  select(4, GetTalentInfo(2, 1, 1)),
				stack = select(4, GetTalentInfo(2, 1, 1)),
				showFunc = function()
					return not select(4, GetTalentInfo(6, 3, 1))
				end
			},
			[198838] = { -- Earthen Wall Totem
				order = 8,
				showFunc = function()
					return select(4, GetTalentInfo(4, 2, 1))
				end
			},
		}
		t.row2 = {
			[79206] = {
				-- Spiritwalker's grace
				order = 2
			},

			[108280] = {
				-- Healing tide totem
				order = 4
			},
			[98008] = {
				-- Spirit Link Totem
				order = 5
			},
			[108271] = {
				-- Astral Shift
				order = 7,
				ignoreGCD = true
			}
		}
		t.row4 = {
			[77130] = {}, -- Cleanse Spirit
			[2484] = {}, -- Earthbind Totem
			[51514] = {}, -- Hex
			[192058] = {}, -- Capacitor Totem
			[192077] = { -- Wind Rush Totem
			showFunc = function()
				return select(4, GetTalentInfo(5, 3, 1))
			end
			},
			[8143] = {}, -- Tremor Totem
		}
		t.buffsC = {
			[114050] = {
				-- Ascendance
				showFunc = function()
					return select(4, GetTalentInfo(7, 1, 1))
				end
			},
			[16246] = {
				-- Elemental Focus
				stack = true
			},
			[205495] = {
				-- Stormkeeper
				stack = true
			},
			[79206] = {}, -- Spirit Walker's Grace

		}
		t.buffsI = {
			[288675] = { -- High Tide
				stack = true,
				showFunc = function()
					return select(4, GetTalentInfo(7, 1, 1))
				end
			},
			[157504] = {  -- Cloudburst Totem
				showFunc = function()
					return select(4, GetTalentInfo(6, 3, 1))
				end
			},
			[188838] = {
				-- Flame Shock
				debuff = true
			},
			[53390] = {
				-- Tidal Waves
				stack = true
			}
		}
	end

	return temp
end
