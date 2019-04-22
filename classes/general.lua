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
iCD.general = {
	row1 = {},
	row2 = {},
	row3 = {},
	row4 = {
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
	},
	row5 = { -- Buffs
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
		[251952] = { -- Apocalypse Drive
			stack = true,
			itemReq = 151975,
		},
	},
	buffsI = {},
	buffsC = {
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
	},
}
