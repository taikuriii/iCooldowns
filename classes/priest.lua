local _, iCD = ...
function iCD:PRIEST(specID)
	local temp = {}
	temp.spec = {}
	temp.all = {}
	temp.all.row1 = {

	}
	temp.all.row2 = {
		[327661] = { -- Fae Guardians
		order = 0, --Always first
		showTimeAfterCast = true,
		covenant = iCD.covenants.NIGHTFAE
		},
	}
	temp.all.row3 = {}
	temp.all.row4 = {
		[19236] = {}, -- Desperate Prayer
	}
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
	if specID == 256 then -- Discipline
		iCD.outOfRangeSpells = {
			main = 'Shadow Word: Pain',
			range = 'Shadow Word: Pain',
		}
		t.power = {
			func = function()
				return math.floor((UnitPower('player', 0)/UnitPowerMax('player', 0))*100)
			end,
		}
		t.row1 = {
			[8092] = { -- Mind Blast
				order = 1,
				range = true,
				showTimeAfterGCD = true,
			},
			[47540] = { -- Penance
				order = 2,
				cost = true,
				range = true,
				showTimeAfterCast = true,
			},
			[129250] = { -- Power Word: Solace
				order = 4,
				range = true,
				showTimeAfterCast = true,
				showFunc = function()
					return select(4, GetTalentInfo(3, 3, 1))
				end,
			},
			[32379] = { -- Shadow Word: Death
				range = true,
				order = 3,
				glow = true,
				glowSound = "text2",
			},
			[214621] = { -- Schism
				order = 5,
				range = true,
				cost = true,
				showTimeAfterCast = true,
				showFunc = function()
					return select(4, GetTalentInfo(1, 3, 1))
				end,
			},
			[194509] = { -- Power Word: Radiance
				order = 7,
				cost = true,
				charges = true,
				stack = true,
			},
			[110744] = { -- Divine Star
				order = 6,
				range  = true,
				cost = true,
				showFunc = function()
				return select(4, GetTalentInfo(6, 2, 1))
			end,
			},
			[120517] = { -- Halo
				order = 8,
				range  = true,
				cost = true,
				showFunc = function()
					return select(4, GetTalentInfo(6, 3, 1))
				end,
			},
		}
		t.row2 = {
			[62618] = { -- Power Word: Barrier
				order = 5,
				cost = true,
			},
			[47536] = { -- Rapture
				order = 8,
				cost = true,
			},

			[34433] = { -- Shadowfiend
				order = 4,
				showFunc = function()
					return not select(4, GetTalentInfo(3, 2, 1))
				end,
			},
			[123040] = { -- Mindbender
				order = 4,
				range = true,
				showFunc = function()
					return select(4, GetTalentInfo(3, 2, 1))
				end,
			},
			[19236] = { -- Desperate Prayer
				order = 2,
				ignoreGCD = true,
			},
			[586] = { -- Fade
				order = 20,
				ignoreGCD = true,
			},
			[33206] = { -- Pain Suppression
				order = 7,
			},
			[246287] = { -- Evangelism
				order = 9,
				range = true,
				showFunc = function()
					return select(4, GetTalentInfo(7, 3, 1))
				end,
			},
		}
		t.row3 = {
		}
		t.row4 = {
			[8122] = {}, -- Psychis Scream
			[528] = {}, -- Dispel Magic
			[213634] = {}, -- Purify Disease
			[32375] = {}, -- Mass Dispel
		}
		t.buffsC = {
		}
		t.buffsI = {
			[589] = { -- Shadow Word: Pain
				debuff = true,
			},
			[204213] = { -- Purge the Wicked
				debuff = true,
				showFunc = function()
					return select(4, GetTalentInfo(6, 1, 1))
				end,
			},
			[214621] = { -- Schism
				debuff = true,
				showFunc = function()
					return select(4, GetTalentInfo(1, 3, 1))
				end,
			},
			[47536] = {}, -- Rapture
		}
	elseif specID == 257 then --Holy
		iCD.outOfRangeSpells = {
			main = 'Shadow Word: Pain',
			range = 'Shadow Word: Pain',
		}
		t.power = {
			func = function()
				return math.floor((UnitPower('player', 0)/UnitPowerMax('player', 0))*100)
			end,
		}
		t.row1 = {
			[33076] = { -- Prayer of Mending
				order = 1,
				cost = true,
			},
			[208065] = { -- Light of T'uure (artifact)
				order = 2,
				charges = true,
				stack = true,
			},
			[2050] = { -- Holy Word: Serenity
				order = 3,
				cost = true,
			},
			[34861] = { -- Holy Word: Sanctify
				order = 4,
				cost = true,
			},
			[14914] = { -- Holy Fire
				order = 7,
				cost = true,
				range = true,
				glow = true,
				glowSound = true,
			},
		}
		t.row2 = {
			[200183] = { -- Apotheosis
				order = 5,
				ignoreGCD = true,
				showFunc = function()
					return select(4, GetTalentInfo(7, 1, 1))
				end,
			},
			[19236] = { -- Desperate Prayer
				order = 7,
				ignoreGCD = true,
			},
			[64843] = { -- Divine Hymn
				order = 8,
				cost = true,
			},
			[586] = { -- Fade
				order = 20,
				ignoreGCD = true,
			},
			[47788] = { -- Guardian Spirit
				order = 10,
				ignoreGCD = true,
			},
		}
		t.row3 = {
		}
		t.row4 = {
			[73325] = {}, -- Leap of Faith
			[528] = {}, -- Dispel Magic
			[213634] = {}, -- Purify Disease
			[32375] = {}, -- Mass Dispel
			[88625] = {}, -- Holy Word: Chastise
		}
		t.buffsC = {
		}
		t.buffsI = {
			[589] = { -- Shadow Word: Pain
				debuff = true,
			},
			[200183] = { -- Apotheosis
				showFunc = function()
					return select(4, GetTalentInfo(7, 1, 1))
				end,
			}
		}
	elseif specID == 258 then --Shadow
		iCD.outOfRangeSpells = {
			main = 'Shadow Word: Pain',
			range = 'Shadow Word: Pain',
		}
		t.power = {
			func = function()
				return math.floor((UnitPower('player', 13)/UnitPowerMax('player', 13))*100)
			end,
		}
		t.row1 = {
			[205448] = { -- Void Bolt
				order = 2,
				range = true,
				stack = true,
				stackFunc = function()
						local count, duration, expirationTime, value1, value2, value3 = iCD.UnitBuff('player', 'Voidform', true)
						if expirationTime then
							return "+"
						else
							return ''
						end
				end,
				showTimeAfterCast = true,
			},
			[8092] = { -- Mind Blast
				order = 3,
				range = true,
				glow = true,
				glowSound = true,
				range = true,
				showTimeAfterGCD = true,
				charges = true,
				stack = true,
			},
			[32379] = { -- Shadow Word: Death
				range = true,
				order = 6,
				glow = true,
				glowSound = "text2",
			},
			[205385] = { -- Shadow Crash
				order = 7,
				range = true,
				showFunc = function()
					return select(4, GetTalentInfo(5, 3, 1))
				end,
				showTimeAfterGCD = true,
			},
			[341374] = { -- Damnation
				order = 7,
				range = true,
				showFunc = function()
					return select(4, GetTalentInfo(6, 1, 1))
				end,
				showTimeAfterGCD = true,
			},

		}
		t.row2 = {
			[228260] = { -- Void Eruption
				order = 4,
				showTimeAfterCast = true,
			},
			[10060] = { -- Power Infusion
				order = 6, 
				showTimeAfterCast = true,
			},
			[34433] = { -- Shadowfiend
				order = 7,
				showTimeAfterCast = true,
			},
			[17] = { -- Power Word: Shield
				order = 8,
			},
			[586] = { -- Fade
				order = 9,
				ignoreGCD = true,
			},
			[47585] = { -- Dispersion
				order = 10,
			},
			[15286] = { -- Vampiric Embrace
				order = 23,
			},
		}
		t.row3 = {
			[34914] = { -- Vampiric Touch
				order = 4,
				customText = function()
					local count, duration, expirationTime, value1, value2, value3 = iCD.UnitDebuff('target', 'Vampiric Touch', true)
					if expirationTime then
						local dura = expirationTime - GetTime()
						if dura > 5 then
							return dura, '%.0f'
						else
							return dura, '|cffff1a1a%.1f'
						end
					else
						return ''
					end
				end,
			},
			[589] = { -- Shadow Word:Pain
				order = 3,
				customText = function()
					local count, duration, expirationTime, value1, value2, value3 = iCD.UnitDebuff('target', 'Shadow Word: Pain', true)
					if expirationTime then
						local dura = expirationTime - GetTime()
						if dura > 5 then
							return dura, '%.0f'
						else
							return dura, '|cffff1a1a%.1f'
						end
					else
						return ''
					end
				end,
			},
			[335467] = { -- Devouring Plague
				order = 5,
				customText = function()
					local count, duration, expirationTime, value1, value2, value3 = iCD.UnitDebuff('target', 'Devouring Plague', true)
					if expirationTime then
						local dura = expirationTime - GetTime()
						if dura > 5 then
							return dura, '%.0f'
						else
							return dura, '|cffff1a1a%.1f'
						end
					else
						return ''
					end
				end,
			},
		}
		t.row4 = {
			[528] = {}, -- Dispel Magic
			[213634] = {}, -- Purify Disease
			[32375] = {}, -- Mass Dispel
			[205369] = { -- Mind Bomb
				showFunc = function()
					return select(4, GetTalentInfo(4, 2, 1))
				end,
			},
			[8122] = { -- Psychic Scream
				showFunc = function()
					return not select(4, GetTalentInfo(4, 2, 1))
				end,
			},
			[64044] = { -- Psychic Horror
				showFunc = function()
					return select(4, GetTalentInfo(4, 3, 1))
				end,
			},
		}
		t.buffsC = {
		}
		t.buffsI = {
		}
	end
	return temp
end
