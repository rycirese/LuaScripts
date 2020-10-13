mdword = memory.read_u32_le
mword = memory.read_u16_le
mbyte = memory.readbyte
rshift = bit.rshift
bxor = bit.bxor
band = bit.band
floor = math.floor

local natureorder = {"Atk", "Def", "Spd", "SpAtk", "SpDef"}
local naturename = {
 "Hardy", "Lonely", "Brave", "Adamant", "Naughty",
 "Bold", "Docile", "Relaxed", "Impish", "Lax",
 "Timid", "Hasty", "Serious", "Jolly", "Naive",
 "Modest", "Mild", "Quiet", "Bashful", "Rash",
 "Calm", "Gentle", "Sassy", "Careful", "Quirky"}
local typeorder = {
 "Fighting", "Flying", "Poison", "Ground",
 "Rock", "Bug", "Ghost", "Steel",
 "Fire", "Water", "Grass", "Electric",
 "Psychic", "Ice", "Dragon", "Dark"}
local movename = {
 "--" , "Pound", "Karate Chop", "Double Slap", "Comet Punch", "Mega Punch", "Pay Day", "Fire Punch", "Ice Punch", "Thunder Punch", 
 "Scratch", "Vice Grip", "Guillotine", "Razor Wind", "Swords Dance", "Cut", "Gust", "Wing Attack", "Whirlwind", "Fly", 
 "Bind", "Slam", "Vine Whip", "Stomp", "Double Kick", "Mega Kick", "Jump Kick", "Rolling Kick", "Sand Attack", "Headbutt", 
 "Horn Attack", "Fury Attack", "Horn Drill", "Tackle", "Body Slam", "Wrap", "Take Down", "Thrash", "Double-Edge",
 "Tail Whip", "Poison Sting", "Twineedle", "Pin Missile", "Leer", "Bite", "Growl", "Roar", "Sing", "Supersonic", "Sonic Boom", 
 "Disable", "Acid", "Ember", "Flamethrower", "Mist", "Water Gun", "Hydro Pump", "Surf", "Ice Beam", "Blizzard", "Psybeam", 
 "Bubble Beam", "Aurora Beam", "Hyper Beam", "Peck", "Drill Peck", "Submission", "Low Kick", "Counter", "Seismic Toss", 
 "Strength", "Absorb", "Mega Drain", "Leech Seed", "Growth", "Razor Leaf", "Solar Beam", "Poison Powder", "Stun Spore", 
 "Sleep Powder", "Petal Dance", "String Shot", "Dragon Rage", "Fire Spin", "Thunder Shock", "Thunderbolt", "Thunder Wave", 
 "Thunder", "Rock Throw", "Earthquake", "Fissure", "Dig", "Toxic", "Confusion", "Psychic", "Hypnosis", "Meditate", 
 "Agility", "Quick Attack", "Rage", "Teleport", "Night Shade", "Mimic", "Screech", "Double Team", "Recover", "Harden", 
 "Minimize", "Smokescreen", "Confuse Ray", "Withdraw", "Defense Curl", "Barrier", "Light Screen", "Haze", "Reflect",
 "Focus Energy", "Bide", "Metronome", "Mirror Move", "Self-Destruct", "Egg Bomb", "Lick", "Smog", "Sludge", "Bone Club",
 "Fire Blast", "Waterfall", "Clamp", "Swift", "Skull Bash", "Spike Cannon", "Constrict", "Amnesia", "Kinesis", "Soft-Boiled", 
 "High Jump Kick", "Glare", "Dream Eater", "Poison Gas", "Barrage", "Leech Life", "Lovely Kiss", "Sky Attack", "Transform", 
 "Bubble", "Dizzy Punch", "Spore", "Flash", "Psywave", "Splash", "Acid Armor", "Crabhammer", "Explosion", "Fury Swipes", 
 "Bonemerang", "Rest", "Rock Slide", "Hyper Fang", "Sharpen", "Conversion", "Tri Attack", "Super Fang", "Slash", 
 "Substitute", "Struggle", "Sketch", "Triple Kick", "Thief", "Spider Web", "Mind Reader", "Nightmare", "Flame Wheel", 
 "Snore", "Curse", "Flail", "Conversion 2", "Aeroblast", "Cotton Spore", "Reversal", "Spite", "Powder Snow", "Protect", 
 "Mach Punch", "Scary Face", "Feint Attack", "Sweet Kiss", "Belly Drum", "Sludge Bomb", "Mud-Slap", "Octazooka", "Spikes", 
 "Zap Cannon", "Foresight", "Destiny Bond", "Perish Song", "Icy Wind", "Detect", "Bone Rush", "Lock-On", "Outrage", 
 "Sandstorm", "Giga Drain", "Endure", "Charm", "Rollout", "False Swipe", "Swagger", "Milk Drink", "Spark", "Fury Cutter", 
 "Steel Wing", "Mean Look", "Attract", "Sleep Talk", "Heal Bell", "Return", "Present", "Frustration", "Safeguard",
 "Pain Split", "Sacred Fire", "Magnitude", "Dynamic Punch", "Megahorn", "Dragon Breath", "Baton Pass", "Encore", "Pursuit",
 "Rapid Spin", "Sweet Scent", "Iron Tail", "Metal Claw", "Vital Throw", "Morning Sun", "Synthesis", "Moonlight", "Hidden Power", 
 "Cross Chop", "Twister", "Rain Dance", "Sunny Day", "Crunch", "Mirror Coat", "Psych Up", "Extreme Speed", "Ancient Power", 
 "Shadow Ball", "Future Sight", "Rock Smash", "Whirlpool", "Beat Up", "Fake Out", "Uproar", "Stockpile", "Spit Up", 
 "Swallow", "Heat Wave", "Hail", "Torment", "Flatter", "Will-O-Wisp", "Memento", "Facade", "Focus Punch", "Smelling Salts", 
 "Follow Me", "Nature Power", "Charge", "Taunt", "Helping Hand", "Trick", "Role Play", "Wish", "Assist", "Ingrain", 
 "Superpower", "Magic Coat", "Recycle", "Revenge", "Brick Break", "Yawn", "Knock Off", "Endeavor", "Eruption", "Skill Swap", 
 "Imprison", "Refresh", "Grudge", "Snatch", "Secret Power", "Dive", "Arm Thrust", "Camouflage", "Tail Glow", "Luster Purge", 
 "Mist Ball", "Feather Dance", "Teeter Dance", "Blaze Kick", "Mud Sport", "Ice Ball", "Needle Arm", "Slack Off",
 "Hyper Voice", "Poison Fang", "Crush Claw", "Blast Burn", "Hydro Cannon", "Meteor Mash", "Astonish", "Weather Ball", 
 "Aromatherapy", "Fake Tears", "Air Cutter", "Overheat", "Odor Sleuth", "Rock Tomb", "Silver Wind", "Metal Sound",
 "Grass Whistle", "Tickle", "Cosmic Power", "Water Spout", "Signal Beam", "Shadow Punch", "Extrasensory", "Sky Uppercut",
 "Sand Tomb", "Sheer Cold", "Muddy Water", "Bullet Seed", "Aerial Ace", "Icicle Spear", "Iron Defense", "Block", "Howl",
 "Dragon Claw", "Frenzy Plant", "Bulk Up", "Bounce", "Mud Shot", "Poison Tail", "Covet", "Volt Tackle", "Magical Leaf",
 "Water Sport", "Calm Mind", "Leaf Blade", "Dragon Dance", "Rock Blast", "Shock Wave", "Water Pulse", "Doom Desire",
 "Psycho Boost"}

local mode = {"None", "Capture", "Breeding", "Pandora", "Pokemon Info"}
local index = 1
local gameLang = mbyte(0x080000AF)
local gameVersion = mbyte(0x080000AE)
local language
local monInfo
local pointers
local eggInfo
local boxcheckOff
local startboxInfo
local partyScreen
local partyCursor
local hpiv
local atkiv
local defiv
local spdiv
local spatkiv
local spdefiv
local personality
local nature
local natinc
local natdec
local hidpowtype
local hidpowbase
local tid
local sid

if gameLang == 0x4A then  -- Check game language
 language = "JPN"
 monInfo = 0
 pointers = 0
 battleseedInfo = 0
 eggInfo = 0
 eggInfo2 = 0xA0
 boxcheckOff = 0
 startboxInfo = 0
else
 language = "EUR/USA"
 monInfo = 0x35C
 pointers = 0x2A0
 battleseedInfo = 0x334
 eggInfo = 0x360
 eggInfo2 = 0
 boxcheckOff = 0xFFFF00
 startboxInfo = 0x2C8
end

if gameVersion == 0x56 then  -- Check game version
 game = "Ruby"
elseif gameVersion == 0x50 then
 game = "Sapphire"
elseif gameVersion == 0x52 then
 game = "FireRed"
elseif gameVersion == 0x47 then
 game = "LeafGreen"
elseif gameVersion == 0x45 then
 game = "Emerald"
end

if game ~= 'Emerald' then
 warning = ' - Wrong game version! Use Emerald instead'
else
 warning = ''
end

console.clear()
print("New Order of Breeding x Real.96")
print("") 
print("Game Version: "..game..warning)
print("Language: "..language)

local start = 0x020243E8 + monInfo
local moveStart = 0x02023D8C + monInfo
local ppStart = 0x02023DA4 + monInfo
local eggpidpointerAddr = 0x0203B944 + battleseedInfo
local partyStart = 0x02024190 + monInfo
local boxpointerAddr = 0x03005AF4 + pointers
local currentboxpidSelected = 0x02000CF0
local boxCheck = false
local initSeed = 0
local currSeed = 0
local tempInit = 0
local tempCurr = 0
local frame = 0
local adjustFrame = 0
local eggCheck = 0
local iter = 0
local base = 0
local key = {}
local prevKey = {}

joypad.set({Power = true})

function next(s)	
 local a = 0x41C6 * (s % 65536) + rshift(s, 16) * 0x4E6D
 local b = 0x4E6D * (s % 65536) + (a % 65536) * 65536 + 0x6073
 local c = b % 4294967296
 return c
end

function back(s)	
 local a = 0xEEB9 * (s % 65536) + rshift(s, 16) * 0xEB65
 local b = 0xEB65 * (s % 65536) + (a % 65536) * 65536 + 0x0A3561A1
 local c = b % 4294967296
 return c
end

function shinyCheck(t, s, p)
 highPid = floor(p / 65536)
 lowPid = p % 0x10000
 return bxor(bxor(s, t), bxor(lowPid, highPid)) < 8
end

function showStats()
 gui.text(0, 21, "Stats:")
 gui.text(90, 21, "HP "..mword(start + 86))
 gui.text(176, 21, "Atk "..mword(start + 90))
 gui.text(272, 21, "Def "..mword(start + 92))
 gui.text(366, 21, "SpA "..mword(start + 96))
 gui.text(460, 21, "SpD "..mword(start + 98))
 gui.text(554, 21, "Spe "..mword(start + 94))
end

function showhiddenInfo()
 gui.text(0, 41, "IVs:")
 gui.text(90, 41, "HP ")
 if hpiv >= 30 then
  gui.text(120, 41, hpiv, "LIMEGREEN")
 elseif hpiv >= 1 and hpiv <= 5 then
  gui.text(120, 41, hpiv, "orange")
 elseif hpiv < 1 then
  gui.text(120, 41, hpiv, "red")
 else
  gui.text(120, 41, hpiv)
 end
 gui.text(176, 41, "Atk ")
 if atkiv >= 30 then
  gui.text(216, 41, atkiv, "LIMEGREEN")
 elseif atkiv >= 1 and atkiv <= 5 then
  gui.text(216, 41, atkiv, "orange")
 elseif atkiv < 1 then
  gui.text(216, 41, atkiv, "red")
 else
  gui.text(216, 41, atkiv)
 end
 gui.text(272, 41, "Def ")
 if defiv >= 30 then
  gui.text(312, 41, defiv, "LIMEGREEN")
 elseif defiv >= 1 and defiv <= 5 then
  gui.text(312, 41, defiv, "orange")
 elseif defiv < 1 then
  gui.text(312, 41, defiv, "red")
 else
  gui.text(312, 41, defiv)
 end
 gui.text(366, 41, "SpA ")
 if spatkiv >= 30 then
  gui.text(406, 41, spatkiv, "LIMEGREEN")
 elseif spatkiv >= 1 and spatkiv <= 5 then
  gui.text(406, 41, spatkiv, "orange")
 elseif spatkiv < 1 then
  gui.text(406, 41, spatkiv, "red")
 else
  gui.text(406, 41, spatkiv)
 end
 gui.text(460, 41, "SpD ")
 if spdefiv >= 30 then
  gui.text(500, 41, spdefiv, "LIMEGREEN")
 elseif spdefiv >= 1 and spdefiv <= 5 then
  gui.text(500, 41, spdefiv, "orange")
 elseif spdefiv < 1 then
  gui.text(500, 41, spdefiv, "red")
 else
  gui.text(500, 41, spdefiv)
 end
 gui.text(554, 41, "Spe ")
 if spdiv >= 30 then
  gui.text(594, 41, spdiv, "LIMEGREEN")
 elseif spdiv >= 1 and spdiv <= 5 then
  gui.text(594, 41, spdiv, "orange")
 elseif spdiv < 1 then
  gui.text(594, 41, spdiv, "red")
 else
  gui.text(594, 41, spdiv)
 end

 gui.text(0, 120, "PID: ")
 if shinyCheck(tid, sid, personality) then
  gui.text(50, 120, string.format("%08X", personality), "LIMEGREEN")
 else
  gui.text(50, 120, string.format("%08X", personality))
 end
 gui.text(0, 140, "Nature: "..naturename[nature + 1])
 gui.text(0, 160, natureorder[natinc + 1].."+ "..natureorder[natdec + 1].."-")
 gui.text(487, 56, "HP "..typeorder[hidpowtype + 1].." "..hidpowbase)
end

function showMoves()
 if mword(moveStart) + 1 <= 355 then
  gui.text(0, 190, "Move: "..movename[mword(moveStart) + 1])
 end
 if mword(moveStart + 2) + 1 <= 355 then
  gui.text(0, 210, "Move: "..movename[mword(moveStart + 2) + 1])
 end
 if mword(moveStart + 4) + 1 <= 355 then
  gui.text(0, 230, "Move: "..movename[mword(moveStart + 4) + 1])
 end
 if mword(moveStart + 6) + 1 <= 355 then
  gui.text(0, 250, "Move: "..movename[mword(moveStart + 6) + 1])
 end
end

function showPP()
 gui.text(225, 190, "PP: "..mbyte(ppStart))
 if mbyte(ppStart) >= 1 and mbyte(ppStart) <= 4 then
  gui.text(265, 190, mbyte(ppStart), "orange")
 elseif mbyte(ppStart) < 1 then
  gui.text(265, 190, mbyte(ppStart), "red")
 else
  gui.text(265, 190, mbyte(ppStart))
 end
 gui.text(225, 210, "PP: ")
 if mbyte(ppStart + 1) >= 1 and mbyte(ppStart + 1) <= 4 then
  gui.text(265, 210, mbyte(ppStart + 1), "orange")
 elseif mbyte(ppStart + 1) < 1 then
  gui.text(265, 210, mbyte(ppStart + 1), "red")
 else
  gui.text(265, 210, mbyte(ppStart + 1))
 end
 gui.text(225, 230, "PP: ")
 if mbyte(ppStart + 2) >= 1 and mbyte(ppStart + 2) <= 4 then
  gui.text(265, 230, mbyte(ppStart + 2), "orange")
 elseif mbyte(ppStart + 2) < 1 then
  gui.text(265, 230, mbyte(ppStart + 2), "red")
 else
  gui.text(265, 230, mbyte(ppStart + 2))
 end
 gui.text(225, 250, "PP: ")
 if mbyte(ppStart + 3) >= 1 and mbyte(ppStart + 3) <= 4 then
  gui.text(265, 250, mbyte(ppStart + 3), "orange")
 elseif mbyte(ppStart + 3) < 1 then
  gui.text(265, 250, mbyte(ppStart + 3), "red")
 else
  gui.text(265, 250, mbyte(ppStart + 3))
 end
end

function showrngInfo()
 gui.text(0, 403, frame - adjustFrame)
 gui.text(0, 423, "Initial Seed: "..string.format("%04X", initSeed))
 gui.text(0, 443, "Current Seed: "..string.format("%08X", currSeed))
end

function showtrainerInfo()
 gui.text(618, 443, string.format("TID: %d", tid))
 gui.text(618, 463, string.format("SID: %d", sid))
end

function setinitseed()
 initSeed = userdata.get('seed')
 adjustFrame = userdata.get('frame')
end

event.onloadstate(setinitseed)

while true do
 initseedIDS = mword(0x2020000)
 currSeed = mdword(0x03005AE0 + pointers)
 frame = mdword(0x02024664 + monInfo)
 battlevideoSeed1 = mdword(0x0203B9F8 + battleseedInfo)
 battlevideoSeed2 = mdword(0x0203AD74 + battleseedInfo)
 screenCheck = mdword(0x02020004)
 statsScreen = screenCheck == 0x09000100 or screenCheck == 0x0B000000

 key = input.get()
 if key["Number1"] and not prevKey["Number1"] then
  index = index - 1
  if index < 1 then
   index = 5
  end
 elseif key["Number2"] and not prevKey["Number2"] then
  index = index + 1
  if index > 5 then
   index = 1
  end
 end

 prevKey = key

 if battlevideoSeed1 == battlevideoSeed2 and battlevideoSeed2 == currSeed then
  initSeed = battlevideoSeed2
  adjustFrame = frame
  userdata.set('frame', adjustFrame)
  userdata.set('seed', initSeed)
 elseif battlevideoSeed1 == 0 and currSeed == initseedIDS then
  initSeed = initseedIDS
  adjustFrame = frame
  userdata.set('frame', adjustFrame)
  userdata.set('seed', initSeed)
 end

 if mode[index] == "Capture" then
  start = 0x020243E8 + monInfo
  moveStart = 0x02023D8C + monInfo
  ppStart = 0x02023DA4 + monInfo
 elseif mode[index] == "Breeding" then
  partyCounter = mbyte(0x0202418D + monInfo) - 1
  eggpartypidStart = partyStart + (partyCounter) * 0x64
  start = eggpartypidStart
 elseif mode[index] == "Pokemon Info" then
  partyScreen = screenCheck == 0x0A030100
  partyCursor = mbyte(0x0203CB9D + battleseedInfo)
  boxNum = mbyte(mdword(boxpointerAddr))
  boxStart = mdword(boxpointerAddr) + 4
  boxPosition = mbyte(0x02039A19 + eggInfo)
  boxpidStart = boxStart + (0x1E * boxNum * 0x50) + (boxPosition * 0x50)
  boxCheck = mdword(currentboxpidSelected) == mdword(boxpidStart) and screenCheck == 0x080B0101 + boxcheckOff
  
  if boxCheck and not partyScreen then
   start = boxpidStart
  elseif partyScreen then
   if partyCursor ~= 0x7 then
    start = partyStart + partyCursor * 0x64
   end
  elseif statsScreen then
   if mdword(0x0200E808) == mdword(0x0200E878) and  mdword(0x0200E804) ~= 0 then
    start = 0x0200E808
    moveStart = 0x0200E880
   elseif mdword(0x02002FE0 + startboxInfo) == mdword(0x02003050 + startboxInfo) and mdword(0x02002FDC + startboxInfo) ~= 0 then  -- 1st floor box / party check
    start = 0x02002FE0 + startboxInfo
    moveStart = 0x02003058 + startboxInfo
   else  -- 2nd floor box / daycare box check
    start = 0x0200001C
    moveStart = 0x02000094
   end
  end
 end

 personality = mdword(start)
 trainerid = mdword(start + 4)
 isEgg = mword(start + 0x12) == 0x0601
 magicword = bxor(personality, trainerid)

 if mode[index] == "Pokemon Info" then
  tid = trainerid % 0x10000
  sid = floor(trainerid / 65536)
 else
  idsPointer = mdword(0x03005AF0 + pointers) + 0xA
  ids = mdword(idsPointer)
  tid = ids % 0x10000
  sid = floor(ids / 65536)
 end

 i = personality % 24

 if i >= 18 then
  miscoffset = 0
 elseif i % 6 >= 4 then
  miscoffset = 12
 elseif i % 2 == 1 then
  miscoffset = 24
 else
  miscoffset = 36
 end

 ivs = bxor(mdword(start + 32 + miscoffset + 4), magicword)

 hpiv = band(ivs, 0x1F)
 atkiv = band(ivs, 0x1F * 0x20) / 0x20
 defiv = band(ivs, 0x1F * 0x400) / 0x400
 spdiv = band(ivs, 0x1F * 0x8000) / 0x8000
 spatkiv = band(ivs, 0x1F * 0x100000) / 0x100000
 spdefiv = band(ivs, 0x1F * 0x2000000) / 0x2000000

 nature = personality % 25
 natinc = floor(nature / 5)
 natdec = nature % 5

 hidpowtype=floor(((hpiv%2 + 2*(atkiv%2) + 4*(defiv%2) + 8*(spdiv%2) + 16*(spatkiv%2) + 32*(spdefiv%2))*15)/63)
 hidpowbase=floor(((band(hpiv,2)/2 + band(atkiv,2) + 2*band(defiv,2) + 4*band(spdiv,2) + 8*band(spatkiv,2) + 16*band(spdefiv,2))*40)/63 + 30)

 gui.text(2, 1, "Mode: "..mode[index])

 if mode[index] == "Capture" then
  battleScreen = mdword(0x0600D000) ~= 0
  roamerPointer = mdword(0x03005AEC + pointers) + 0x31E0
  roamerCheck = mdword(roamerPointer)

  if battleScreen and not statsScreen then
   showStats()
   showhiddenInfo()
   showMoves()
   showPP()
  end

  if roamerCheck == 0 then 
   gui.text(566, 120, string.format("Roamer? No"))
  else
   gui.text(566, 120, string.format("Roamer? Yes"))
   gui.text(566, 140, string.format("PID: %08X", roamerCheck))
   gui.text(566, 160, "Nature: "..naturename[(roamerCheck % 25) + 1])
  end

  showrngInfo()
  showtrainerInfo()
 elseif mode[index] == "Breeding" then
  a = mdword(0x03005AE4 + pointers)
  timer = mdword(0x030022E4 + eggInfo2)
  offset = (frame - adjustFrame) - timer
  eggpidPointer = mdword(eggpidpointerAddr) + 0x988
  eggPid = mdword(eggpidPointer)
  eggNature = eggPid % 0x19
  tempeggPID = mdword(0x03007D98)
  eggstepCounter = mbyte(eggpidPointer - 0x4)

  if mdword(eggpidpointerAddr) > 0 then
   eggCheck = mdword(eggpidpointerAddr) - 0x1540
  end

  eggReady = mbyte(eggCheck) == 0x4E or mbyte(eggCheck) == 0x7E
  gui.text(2, 190, "Step Counter: "..eggstepCounter)

  if a == 0 then
   base = offset
   iter = 0
  elseif a > 0 then
   if base == base and iter < 1 then
    iter = offset - base - 5
   else
    base = offset
   end
  end

  if a == 0 then
   if not eggReady then
    gui.text(2, 230, "No Egg")
   else
    gui.text(2, 230, string.format("Egg PID: "))

	if shinyCheck(tid, sid, eggPid) then
     gui.text(92, 230, string.format("%08X", eggPid), "green")
    else
     gui.text(92, 230, string.format("%08X", eggPid))
    end

	gui.text(2, 250, "Nature: "..naturename[eggNature + 1])
   end
  elseif a < 65536 then
    gui.text(2, 230, string.format("Egg Generating... please advance another frame!"))
    gui.text(2, 250, string.format("TempRNG seeded, no temporary PID testing yet..."))
  elseif floor(tempeggPID / 65536) == floor(a / 65536) then
   gui.text(2, 230, string.format("Egg Generating... please advance another frame!"))
   gui.text(2, 250, string.format("TempPID %08X", tempeggPID))
  elseif eggReady then
   gui.text(2, 230, string.format("Egg PID: "))

   if shinyCheck(tid, sid, eggPid) then
    gui.text(92, 230, string.format("%08X", eggPid), "green")
   else
    gui.text(92, 230, string.format("%08X", eggPid))
   end

   gui.text(2, 250, "Nature: "..naturename[eggNature + 1])

   if iter > 1 then
    gui.text(250, 230, string.format("Approx iter: %d", iter))
    gui.text(250, 250, string.format("Stone worked!"))
   else
    gui.text(250, 230, string.format("First egg PID result"))
    gui.text(250, 250, string.format("Stone failed?"))
   end
  end

  if eggReady then
   gui.text(2, 210, "Egg generated, go get it!")
  elseif eggstepCounter == 254 then
   gui.text(2, 210, "Next step might generate an egg!")
  elseif eggstepCounter == 255 then
   gui.text(2, 210, "255th step taken")
  else
   gui.text(2, 210, "Keep on steppin'")
   gui.text(2, 230, "No Egg")
  end

  if isEgg then
   showStats()
   showhiddenInfo()
  end

  showrngInfo()
  showtrainerInfo()
 elseif mode[index] == "Pandora" then
  gui.text(2, 463, "TempTID: "..initSeed)
  showrngInfo()
  showtrainerInfo()
 elseif mode[index] == "Pokemon Info" then
  if (partyScreen and partyCursor ~= 0x7) or statsScreen or boxCheck then
   if not boxCheck then
    showStats()
   end
   showhiddenInfo()
   showtrainerInfo()
  end

  if statsScreen and not isEgg then
   showMoves()
  end
 end

 emu.frameadvance()
end