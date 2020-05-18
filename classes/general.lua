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
-- 1 = tank, 2 = healer, 3 = dps
local roles = {
	-- Tanks
	[66] = 1, -- Protection Paladin
	[104] = 1, -- Guardian Druid
	[73] = 1, -- Protection Warrior
	[250] = 1, -- Blood DK
	[268] = 1, -- Brewmaster Monk
	[581] = 1, -- Vengeance DH
	-- Healers
	[65] = 2, -- Holy Paladin
	[105] = 2, -- Restoration Druid
	[256] = 2, -- Discipline Priest
	[257] = 2, -- Holy Priest
	[264] = 2, -- Restoration Shaman
	[270] = 2, -- Mistweaver Monk
}
local _, iCD = ...
function iCD:GetGenerals(specID)
	--iCD.general = {
		local currentRole = roles[specID] or 3
		local t = {}
		t.row1 = {
			[293031] = { -- Sphere of Suppression, essence
				order = 12,
				showFunc = function() return iCD:Essences(3, true) end,
				showTimeAfterGCD = true,
			},
			[298168] = { -- Aegis of the Deep, essence
				order = 12,
				showFunc = function() return iCD:Essences(25, true) end,
				showTimeAfterGCD = true,
			},
			[295746] = { -- Nullification Dynamo, essence
				order = 12,
				range = true,
				showFunc = function() return iCD:Essences(13, true) end,
				showTimeAfterGCD = true,
			},
			[302731] = { -- Ripple in Space, essence
				order = 12,
				range = true,
				showFunc = function() return iCD:Essences(15, true) end,
				showTimeAfterGCD = true,
			},
			[294926] = { -- Anima of Life and Death, essence
				order = 12,
				showFunc = function() return iCD:Essences(7, true) end,
				showTimeAfterGCD = true,
			},
			[296072] = { -- The Ever-Rising Tide
				order = 12,
				showFunc = function() return iCD:Essences(17, true) end,
				showTimeAfterGCD = true,
			},
			[293019] = {
				order = 12,
				showFunc = function() return iCD:Essences(2, true) end,
				showTimeAfterGCD = true,
			},
			[312725] = {
				order = 12,
				showFunc = function() return iCD:Essences(37, true) end,
				showTimeAfterGCD = true,
			},
		}
		t.row2 = {
			[295337] = { -- Purification Protocol, essence
				order = -2,
				range = true,
				showTimeAfterGCD = true,
				showFunc = function() return iCD:Essences(6, true) end,
			},
			[310690] = { -- Breath of the Dying, essence
				order = -2,
				range = true,
				showTimeAfterGCD = true,
				showFunc = function() return iCD:Essences(35, true) end,
				stack = true,
				stackFunc = function()
					local count, duration, expirationTime, value1, value2, value3 = iCD.UnitBuff('player', 'Reaping Flames')
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
			},
			[295258] = { -- Essence of the Focusing Iris, essence
				order = -2,
				range = true,
				showTimeAfterGCD = true,
				showFunc = function() return iCD:Essences(5, true) end,
			},
			[297108] = { -- Blood of the enemy, essence
				order = -2,
				range = true,
				showTimeAfterGCD = true,
				showFunc = function() return iCD:Essences(23, true) end,
			},
			[295840] = { -- Guardian of Azeroth, essence
				order = -2,
				range = true,
				showFunc = function() return iCD:Essences(14, true) end,
				showTimeAfterGCD = true,
			},
		}
		if currentRole ~= 1 then
			t.row2[295373] = { -- The Crucible of Flame, essence
				order = -2,
				range = true,
				showTimeAfterGCD = true,
				stack = iCD:Essences(12, true, 3),
				charges = iCD:Essences(12, true, 3),
				showFunc = function() return iCD:Essences(12, true) end,
			}
			t.row2[298357] = { -- Memory of Lucid Dreams, essence
				order = -2,
				range = true,
				showFunc = function() return iCD:Essences(27, true) end,
				showTimeAfterGCD = true,
			}
		else
			t.row1[295373] = { -- The Crucible of Flame, essence
				order = 12,
				range = true,
				stack = function() return iCD:Essences(12, true, 3) end,
				charges = function() return iCD:Essences(12, true, 3) end,
				showFunc = function() return iCD:Essences(12, true) end,
				showTimeAfterGCD = true,
			}
			t.row1[298357] = { -- Memory of Lucid Dreams, essence
				order = 12,
				range = true,
				showFunc = function() return iCD:Essences(27, true) end,
				showTimeAfterGCD = true,
			}
		end
		t.row3 = {}
		t.row4 = {
			[155145] = { -- Arcane Torrent
				showFunc = function()
					local _, race = UnitRace('player')
					return race == 'BloodElf'
				end,
			},
			[129597] = { -- Arcane Torrent ( Energy )
				showFunc = function()
					local _, race = UnitRace('player')
					return race == 'BloodElf'
				end,
			},
			[7744] = { -- Will of the Forsaken
				showFunc = function()
					local _, race = UnitRace('player')
					return race == 'Scourge'
				end,
			},
			[205752] = { -- Blood Fury
				showFunc = function()
					local _, race = UnitRace('player')
					return race == 'Orc'
				end,
			},
			[26297] = { -- Berserking
				showFunc = function()
					local _, race = UnitRace('player')
					return race == 'Troll'
				end,
			},
			[202719] = { -- Arcane Torrent ( Pain )
				showFunc = function()
					local _, race = UnitRace('player')
					return race == 'BloodElf'
				end,
			},
			[50613] = { -- Arcane Torrent ( Pain )
				showFunc = function()
					local _, race = UnitRace('player')
					return race == 'BloodElf'
				end,
			},
			[312411] = { -- Bag of tricks
				showFunc = function()
					local _, race = UnitRace('player')
					return race == 'Vulpera'
				end,
			},
			[232633] = { -- Arcane Torrent ( Insanity )
				showFunc = function()
					local _, race = UnitRace('player')
					return race == 'BloodElf'
				end,
			},
			[20549] = { -- War Stomp
				showFunc = function()
					local _, race = UnitRace('player')
					return race == 'Tauren'
				end,
			},
			[260364] = { -- Arcane Pulse
				showFunc = function()
					local _, race = UnitRace('player')
					return race == 'Nightborne'
				end,
			},
			[255654] = { -- Bull Rush
				showFunc = function()
					local _, race = UnitRace('player')
					return race == 'HighmountainTauren'
				end,
			},
			[291944] = { -- Regeneratin'
				showFunc = function()
					local _, race = UnitRace('player')
					return race == 'ZandalariTroll'
				end,
			},
			[58984] = { -- Shadowmeld
				showFunc = function()
					local _, race = UnitRace('player')
					return race == 'NightElf'
				end,
			},
			[-139320] = {}, -- Ravaged Seed Pod
			[-140797] = {}, -- Fang of Tichondrius
			[-140789] = {}, -- Animated Exoskeleton
			[-140808] = {}, -- Drought of Souls
			[-144259] = {}, -- Kil'jaeden's Burning Wish
			[-137400] = {}, -- Coagulated Nightwell Residue
			[-144249] = {}, --Archimonde's Hatred Reborn
			[-140807] = {}, --Infernal Contract
			[-147024] = {}, --Reliquary of the Damned
			[-147012] = {}, -- Umbral Moonglaives
			[-151977] = {}, -- Diima's Gacial Aegis
			[-151978] = {}, -- Smoldering Titanguard
			[-151975] = {}, -- Apocalypse Drive
			[-144258] = {}, -- Velen's Future Sight
			[-158367] = {}, -- Merektha's Fang
			[-159617] = {}, -- Lustrous Golden Plumage
			[-161462] = {}, -- Doom's Wake
			[-161463] = {}, -- Doom's Fury
			[-166795] = {}, -- Knot of Ancient Fury
			[-159614] = {}, -- Galecaller's Boon
			[-159627] = {}, -- Jes' Howler
			[-159618] = {}, -- Mchimba's Ritual Bandages
			[-167868] = {}, -- Idol of Indiscriminate Consumption
			[-165662] = {}, -- Kezan Stamped Bijou
			[-158163] = {}, -- First Mate's Spyglass
			[-169314] = {}, -- Azshara's Font of Power
			[-169307] = {}, -- Vision of Demise
			[-167555] = {}, -- Pocket-Sized Computation Device
			[-169311] = {}, -- Ashvane's Razor Coral
			[-169318] = {}, -- Shockbiter's Fang
			[-169223] = {}, -- Ashjra'kamas, Shroud of Resolve
			[-174277] = {}, -- Lingering Psychic Shell
			[-173940] = {}, -- Sigil of Warding
			[-174103] = {}, -- Manifesto of Madness
			[-168989] = {}, -- Hyperthread Wristwraps
			[-172666] = {}, -- Corrupted Gladiator's Medallion
			[-173944] = {}, -- Forbidden Obsidian Claw
		}
		t.row5 = { -- Buffs
			[1022] = {}, -- Blessing of Protection
			[204018] = {}, -- Blessing of Spellwarding
			[6940] = {}, -- Blessing of Sacrifice
			[1044] = {}, -- Blessing of Freedom
			[102342] = {}, -- Ironbark
			[47788] = {}, -- Guardian Spirit
			[33206] = {}, -- Pain Suppression
			[235169] = { -- Archimonde's Hatred Reborn
				stack = true,
				stackFunc = function()
					local v = select(5, iCD.UnitBuff('player', "Archimonde's Hatred Reborn", nil, 'player'))
					if v then
						return v/1e3, '%.1f'
					else
						return ''
					end
				end,
				itemReq = 144249,
			},
			[251946] = { -- Smoldering Titanguard
				stack = true,
				stackFunc = function()
					local v = select(5, iCD.UnitBuff('player', 'Bulwark of Flame', nil, 'player'))
					if v then
						return v/1e3, '%.1f'
					else
						return ''
					end
				end,
				itemReq = 151978,
			},
			[313060] = { -- Stoneskin
				stack = true,
				stackFunc = function()
					local v = select(5, iCD.UnitBuff('player', 'Stoneskin', nil, 'player'))
					if v then
						return v/1e3, '%.0f'
					else
						return ''
					end
				end,
				itemReq = 173940,
			},
			[251952] = { -- Apocalypse Drive
				stack = true,
				itemReq = 151975,
			},
			[314585] = {
				itemReq = 174277,
			},
			[295048] = { -- Touch of the Everlasting , essence
				showFunc = function() return iCD:Essences(33, true) end,
			},
		}
		t.buffsI = {
			[297108] = { -- Blood of the enemy (debuff), essence
				showFunc = function() return iCD:Essences(23, true) end,
				debuff = true,
			},
			[298168] = { -- Aegis of the Deep, essence
				showFunc = function() return iCD:Essences(25, true) end,
			},
			[312922] = { -- Will to Survive , essence
				showFunc = function() return iCD:Essences(33) end,
			},
		}
		t.buffsC = {
			[316703] = { -- Searing Flames
				stack = true, 
			},
			[317420] = { -- Obsidian Skin
				stack = true,
			},
			[208052] = { -- Sephuz's Secret
				stack = '+H',
				itemReq = 132452,
			},
			[222517] = { -- Cleansed Ancient's Blessing
				stack = '+C',
				itemReq = 139334, -- Nature's Call
			},
			[222519] = { -- Cleansed Sister's Blessing
				stack = '+H',
				itemReq = 139334, -- Nature's Call
			},
			[222518] = { -- Cleansed Wisp's Blessing
				stack = '+M',
				itemReq = 139334, -- Nature's Call
			},
			[228399] = { -- Mark of the Heavy Hide
				stack = '+A',
			},
			[188029] = { -- Unbending Potion
				stack = '+A',
			},
			[188028] = { -- Potion of the Old War
			},
			[229206] = {}, -- Potion of Prolonged Power
			[222027] = { -- Nightmarish Ichor
				stack = '+V',
				itemReq = 139324, -- Goblet of Nightmarish Ichor
			},
			[221805] = {
				stack = '+L',
				itemReq = 139320, -- Ravaged Seed Pod
			},
			[214807] = { -- Dirge of Angerboda
				stack = '+M',
				itemReq = 133644, -- Memento of Angerboda
			},
			[214802] = { -- Howl of Ingvar
				stack = '+C',
				itemReq = 133644, -- Memento of Angerboda
			},
			[214803] = { -- Wail of Svala
				stack = '+H',
				itemReq = 133644, -- Memento of Angerboda
			},
			[116841] = {}, -- Tiger's Lust
			[225130] = { -- Vampiric Aura
				stack = '+L',
				itemReq = 140797, -- Fang of Tichondrius
			},
			[221796] = { -- Blood Frenzy
				stack = '+H',
				itemReq = 139329, -- Bloodthirsty Instinct
			},
			[225726] = { -- Fiery Enchant
				stack = '+C',
				itemReq = 140796, -- Entinwed Elemental Foci
			},
			[225729] = { -- Frost Enchant
				stack = '+M',
				itemReq = 140796, -- Entinwed Elemental Foci
			},
			[225730] = { -- Arcane Enchant
				stack = '+H',
				itemReq = 140796, -- Entinwed Elemental Foci
			},
			[214128] = {
				stack = '+H',
				itemReq = 137419, -- Chrono Shard
			},
			[243096] = { -- Concordance of the Legion (Versality)
				stack = '+V',
			},
			[242584] = { -- Concordance of the Legion (Agility)
				stack = '+Agi',
			},
			[242609] = { -- Wailing Souls
				stack = '-DT',
				itemReq = 147024, --Reliquary of the Damned
			},
			[242209] = { -- Infernal Skins
				stack = '+A',
				itemReq = 147022, --Feverish Carapace
			},
			[251941] = {
				stack = '+A',
				itemReq = 151977, -- Diima's Glacial Aegis
			},
			[256816] = { -- Celestial Bulwark
				stack = '+V',
				itemReq = 154173, -- Aggramar's Conviction
			},
			[256831] = { -- Aggramar's Fortitude
				stack = '+hp',
				itemReq = 154173, -- Aggramar's Conviction
			},
			[235966] = { -- Velen's Future Sight
				stack = '+hps',
				itemReq = 144258,
			},
			[271107] = { -- Golden Luster
				stack = "+V",
				itemReq = 159617,
			},
			[268899] = { -- Mastery Weapoon enchant (stacking)
				stack = true,
			},
			[268898] = { -- Mastery Weapoon enchant (+600)
				stack = "+M",
			},
			[268887] = { -- Haste Weapoon enchant (stacking)
				stack = true,
			},
			[268893] = { -- Haste Weapoon enchant (+600)
				stack = "+H",
			},
			[202844] = { -- Gunshoes
				stack = "+M",
			},
			[271559] = { -- Shimmering Haven
				stack = "+A",
			},
			[281517] = { -- Unstable Catalyst
				stack = "+P",
			},
			[268905] = { -- Deadly navigation (stacking)
				stack = true,
			},
			[268904] = { -- Deadly navigation (+600)
				stack = "+C",
			},
			[268854] = { -- Versatile navigation (stacking)
				stack = true,
			},
			[268856] = { -- Versatile navigation (+600)
				stack = "+V",
			},
			[278317] = { -- Doom's Wake
				stack = true,
				itemReq = 161462,
			},
			[278364] = { -- Doom's Fury
				stack = true,
				itemReq = 161463,
			},
			[271550] = { -- Strength in numbers
				stack = true,
			},
			[278231] = { -- Knot of Ancient Fury
				itemReq = 166795, -- Knot of Ancient Fury
				stack = "+C",
			},
			[268311] = { -- Galecaller's Boon
				itemReq = 159614, -- Galecaller's Boon
				stack = "+H",
			},
			[271103] = { -- Rezan's Gleaming Eye
				itemReq = 158712,
				stack = "+H",
			},
			[266047] = { -- Jes' Howler
				itemReq = 159627,
				stack = "+V",
			},
			[271711] = { -- Overwhelming Power, Azerite Trait
				stack = true,
				azerite = 30,
			},
			[287471] = { -- Shadow of Elune, Azerite Trait
				stack = "+H",
				azerite = 521,
			},
			[58984] = {  -- Shadowmeld
				showFunc = function()
					local _, race = UnitRace('player')
					return race == 'NightElf'
				end,
			},
			[273685] = { -- Meticulous Scheming, Azerite trait
				stack = "3A",
				azerite = 192,
			},
			[273714] = { -- Seize the Moment!, Meticulous Scheming azerite trait
				stack = "+H",
				azerite = 192,
			},
			[278249] = { -- Razorleaf Tempest
				stack = "+C",
				itemReq = 161415, -- Forest Lord's Razorleaf
			},
			[268439] = { -- Beneficial Vibrations
				stack = "+A",
				itemReq = 159612, -- Azerokk's Resonating Hearth
			},
			[285475] = { -- Kaja'mite Surge
				stack = "+H",
				itemReq = 165662, -- Kezan Stamped Bijou
			},
			[301886] = { -- Overclocking Bit Band
				stack = "+H",
				itemReq = 169159,
			},
			[296962] = { -- Azshara's Font of Power
				stack = "+P",
				itemReq = 169314,
			},
			[303431] = { -- Vision of Demise
				stack = "+H",
				itemReq = 169307,
			},
			[303568] = { --Razor Coral
				stack = true,
				itemReq = 169311,
				debuff = true,
			},
			[298357] = { -- Memory of Lucid Dreams, essence
				showFunc = function() return iCD:Essences(27, true) end,
				stack = "+R",
			},
			[297126] = { -- Blood of the enemy (buff), essence
				showFunc = function() return iCD:Essences(23, true) end,
				stack = "+CD",
			},
			
			[280653] = { -- Engineering Head, haste
				azerite = 501, -- Relational Normalization Gizmo
				stack = "+H",
			},
			[280654] = { -- Engineering Head, primary stat
				azerite = 501, -- Relational Normalization Gizmo
				stack = "+P",
			},
			[299624] = { -- The Ever-Rising Tide, Essence
				showFunc = function() return iCD:Essences(17) end,
				stack = true,
			},
			[318216] = { -- Honed mind, corruption
				stack = "+M",
			},
			[313571] = { -- Dragon's Flight
				stack = "+H",
				itemReq = 174044,
			},
			[316823] = {  -- The End is Coming (Void ritual, corruption)
				stack = true,
			},
			[317859] = { -- Draconic Empowerment (Legendary cloak)
				stack = "+P",
			},
			[316801] = { -- Ineffable Truth (corruption)
				stack = "-CD"
			},
		}
	return t
end
