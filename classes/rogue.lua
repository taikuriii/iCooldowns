local _, iCD = ...
function iCD:ROGUE(specID)
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
	if specID == 259 then -- Assasination
		iCD.outOfRangeSpells = {
			main = 'Mutilate',
			range = 'Poisoned Knife',
		}
		t.power = {
			pos = {
				x = -990,
				y = -8,
			},
			func = function()
				local p = UnitPower('player', 3)
				if p < 40 then
					return p
				elseif p >= 90 then
					return '|cffff0000'..p
				else
					return '|cff00ff00'..p
				end
			end,
		}
		-- Row 1
		t.row1 = {
			[192759] = { -- Kingsbane
				order = 1,
				cost = true,
				range = true,
			},
			[703] = { -- Garrote
				order = 5,
				cost = true,
				range = true,
			},
			[137619] = { -- Marked for Death
				order = 10,
				showFunc = function()
					return select(4, GetTalentInfo(7, 2, 1))
				end,
				range = true,
			},
			[152150] = { -- Death from Above
				order = 15,
				showFunc = function()
					return select(4, GetTalentInfo(7, 3, 1))
				end,
				range = true,
			},
		}
		t.row2 = {
			[79140] = { -- Vendetta
				order = 1,
				ignoreGCD = true,
			},
			[36554] = { -- Shadow Step
				order = 8,
				ignoreGCD = true,
				charges = true,
				stack = true,
				range = true,
			},
			[185311] = { -- Crimson Vial
				order = 10,
				ignoreGCD = true,
				cost = true,
			},


		}
		t.row4 = {
			[2094] = {}, -- Blind
			[2983] = {}, -- Sprint
			[1856] = {}, -- Vanish
			[408] = {}, -- Kidney Shot
			[31224] = {}, -- Cloak of Shadows
			[5277] = {}, -- Evasion
		}
		t.buffsI = {
			[703] = { -- Garrote
				debuff = true,
			},
			[1943] = { -- Rupture
				debuff = true,
			},
			[79140] = { -- Vendetta
				debuff = true,
			},
		}
		t.buffsC = {
			[5277] = {}, -- Evasion
			[1966] = {}, -- Feint
			[2983] = {}, -- Sprint
		}
	elseif specID == 260 then --Outlaw
		iCD.outOfRangeSpells = {
			main = 'Sinister Strike',
			range = 'Pistol Shot',
		}
		t.power = {
			pos = {
				x = -990,
				y = -8,
			},
			func = function()
				local p = UnitPower('player', 3)
				if p < 50 then
					return p
				elseif p >= 120 then
					return '|cffff0000'..p
				else
					return '|cff00ff00'..p
				end
			end,
		}
		-- Row 1
		t.row1 = {
			[271877] = { -- Blade Rush
				order = 1,
				showFunc = function()
					return select(4, GetTalentInfo(7, 2, 1))
				end,
				range = true,
			},
			[185763] = { -- Pistol Shot
				order = 2,
				cost = true,
				range = true,
				glow = true,
				glowSound = true,

			},
			[199804] = { -- Between the Eyes
				order = 3,
				cost = true,
				range = true,
			},
			[13877] = { -- Blade Flurry
				order = 5,
				stack = true,
				charges = true,
			},
			[137619] = { -- Marked for Death
				order = 10,
				showFunc = function()
					return select(4, GetTalentInfo(3, 3, 1))
				end,
				range = true,
			},
		}
		t.row2 = {
			[13750] = { --Adrenaline Rush
				order = 3,
			},
			[1966] = { -- Feint
				order = 5,
				cost = true,
			},
			[31224] = { -- Cloak of Shadows
				order = 10,
				ignoreGCD = true,
			},
			[185311] = { -- Crimson Vial
				order = 7,
			},
			[199754] = { -- Riposte
				order = 12,
				ignoreGCD = true,
			},
		}
		t.row4 = {
			[2094] = {}, -- Blind
			[1776] = {}, -- Gouge
			[2983] = {}, -- Sprint
			[1856] = {}, -- Vanish
			[199804] = {}, -- Between the Eyes
			[195457] = {}, -- Grappling Hook
		}
		t.buffsI = {
			[13877] = {}, -- Blade Flurry
			[5171] = {}, -- Slice and dice

			[193359] = {  -- True Bearing
				stack = "-CD",
			},
			[193357] = {  -- Ruthless Precision
				stack = "+CC",
			},
			[199603] = {  -- Skull and Crossbones
				stack = "+SS",
			},
			[193358] = {  -- Grand Melee
				stack = "+H",
			},
			[193356] = {  -- Broadside
				stack = "+CB",
			},
			[199600] = {  -- Buried Treasure
				stack = "+ER",
			},
		}
		t.buffsC = {
			[13750] = {}, -- Adrenaline Rush
			[199754] = {}, -- Riposte
			[2983] = {}, -- Sprint
		}
	elseif specID == 261 then --Sublety
		iCD.outOfRangeSpells = {
			main = 'Backstab',
			range = 'Shuriken Toss',
		}
		t.power = {
			pos = {
				x = -990,
				y = -8,
			},
			func = function()
				local p = UnitPower('player', 3)
				if p < 40 then
					return p
				elseif p >= 90 then
					return '|cffff0000'..p
				else
					return '|cff00ff00'..p
				end
			end,
		}
		-- Row 1
		t.row1 = {
			[137619] = { -- Marked for Death
				order = 2,
				showFunc = function()
					return select(4, GetTalentInfo(7, 2, 1))
				end,
				range = true,
			},
			[152150] = { -- Death from Above
				order = 2,
				showFunc = function()
					return select(4, GetTalentInfo(7, 3, 1))
				end,
				range = true,
			},
		}
		t.row2 = {
			[121471] = { -- Shadow Blades
				order = 5,
			},
			[185313] = { -- Shadow Dance
				charges = true,
				stack = true,
				order = 3,
				ignoreGCD = true,
			},
			[212283] = { -- Symbols of Death
				order = 6,
				ignoreGCD = true,
			},
			[36554] = { -- Shadow Step
				order = 8,
				ignoreGCD = true,
				charges = true,
				stack = true,
				range = true,
			},
			[185311] = { -- Crimson Vial
				order = 10,
				ignoreGCD = true,
				cost = true,
			},


		}
		t.row4 = {
			[2094] = {}, -- Blind
			[2983] = {}, -- Sprint
			[1856] = {}, -- Vanish
			[408] = {}, -- Kidney Shot
			[31224] = {}, -- Cloak of Shadows
			[5277] = {}, -- Evasion
		}
		t.buffsI = {
			[185422] = {}, -- Shadow Dance
			[245640] = {  -- Shuriken Storm
				stack = true,
			},
		}
		t.buffsC = {
			[5277] = {}, -- Evasion
			[1966] = {}, -- Feint
			[2983] = {}, -- Sprint
		}
	end
	return temp
end
