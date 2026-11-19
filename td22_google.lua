-- TD2 startup compatibility edition for ks-gui with unbudgeted OnUpdate.
-- The runtime initializes during the first update, outside the startup deadline.
local pending_source = [====[
-- HOTKEY CONFIGURATION
local KEY = {
  SILENT = "Numpad7", MAGIC_BULLET = "Numpad8",
  RPM = "Numpad9", RPM_UP = "Add",
  RPM_DOWN = "Subtract", ESP = "",
  ESP_PLAYERS = "", NO_RECOIL = "",
  NO_SPREAD = "", INSTANT_RELOAD = "",
  NO_SWAY = "", CROSSHAIR = "Decimal",
  AIM_PART = "Home", AIM_DYNAMIC = "End",
  SHOW_FOV = "Numpad0", FOV_UP = "PageUp",
  FOV_DOWN = "PageDown", NONSKELETON_UP = "Numpad5",
  NONSKELETON_LEFT = "Numpad1", NONSKELETON_DOWN = "Numpad2",
  NONSKELETON_RIGHT = "Numpad3", NONSKELETON_AWAY = "Numpad6",
  NONSKELETON_TOWARD = "Numpad4", BONELESS_AIM_FILTER = "Delete",
  ESP_BOX = "Multiply",
  ESP_LOOT = "", ESP_BONES = "Divide",
  ESP_DISTANCE = "", ESP_SNAPLINES = "",
  ESP_TYPE = "", ESP_NAME = "",
  MOVE_SPEED = "", EXTENDED_RANGE = "",
  ESP_BONE_IDS = "", COUNTER_COLLAPSE = "F8", MASTER = "f1",
  PRESETS = {"F9", "F10", "F11", "F12"},
}
 
-- HUD PANEL LAYOUT
local HUD_PANEL_LAYOUT = {
  width = 340, height = 820, margin_right = 20, margin_top = 50,
  padding_left = 12, padding_right = 12, padding_top = 12,
  function_column_width = 140, status_column_width = 80, shortcut_column_width = 80,
  column_header_height = 20, column_header_gap = 10, row_height = 19,
  section_height = 19, section_gap = 4, column_header_font = 13,
  section_font = 13, row_font = 12, background_alpha = 150, border_enabled = true,
}
 
-- SHARED RVA / OFF (Updated & Synchronized with td2)
local RVA = {
  rlclient = 0x6F71508, 
  viewmatrix = 0x6F71990, 
  recoil = 0x6613724,
  spread = 0x6613720, 
  setnoon = 0x7113536,     -- Updated from td2
  setnight = 0x7113537,    -- Updated from td2
  magicbullet = 0x660B001,
}
local OFF = {
  pClient = 0x130, pObject = 0x28, entityArray = 0x550, entityCount = 0x558, entityPos = 0x80,
  localStage0 = 0x380, localStage1 = 0x10, localStage2 = 0x30, viewProj = 0x450,
  bonesBase = 0x220, boneArray = 0x170, entityType = 0x228, entityName = 0x438, relation = 0x250,
  isDowned = 0x3B8, hpPtr = 0x7D0, health = 0x5C, healthMax = 0x60, factionCtx = 0x3E0,
  entityTypeInt = 0xC10, factionTag = 0x18, aimCtrl = 0x848,
  worldAimPos = 0x3AA8,
  npcDescriptorPtr = nil,  -- Synchronized from td2 (set to nil)
  npcAgentDescriptor = 0x20, 
  npcArchetypeOffset = 0x180,  -- Updated from td2 (0x188 -> 0x180)
  npcTierOffset = 0x184,
  name = 0x438, agentarmor = 0x254, agentarmorMax = 0x258, 
  npcArmor = 0x1C4, npcArmorMax = 0x1C8, 
  weapPtr0 = 0x718, weapPtr1 = 0x38, weapPtr2 = 0x10,
  weaponRpm = 0x270, combatAimRpm = 0x3ADC, reloadField = 0x3B18, combatAimRoundsFired = 0x3AE8,
  combatAimCurrentSpread = 0x3B3C, combatAimWeaponDataPtr = 0x3A78, combatAimSpreadRadius = 0x424C,
  combatAimMoveSpreadAdd = 0x3840,
  combatAimLerpedMoveSpeed = 0x3844, weapTemplateDmgMin = 0x18, 
  weapTemplateClipSize = 0x318, weapTemplateRpm = 0x304, weapTemplateDmgMultHead = 0xA0,
  weapTemplateSwayMinH = 0x2B8, weapTemplateSwayMaxH = 0x2BC, weapTemplateSwayMinV = 0x2C0,
  weapTemplateSwayMaxV = 0x2C4, weapTemplateSwayResetDur = 0x2C8, 
  weapTemplateScopeSwaySpeed = 0x2D0, 
  weapTemplateDmgMax = 0x44,          -- Added from td2
  weapTemplateRange = 0x4C,
  lootManager = 0x80, lootCount = 0x30, lootArray = 0x28, lootPos = 0x38, lootItemsCount = 0x20,
  lootItemsBase = 0x18, lootFirstEntry = 0x18, lootItemStride = 0xE8, lootItemDisplay = 0xB0,
  lootItemDefn = 0xA8, lootItemRarity = 0xC0, lootItemObjName = 0xA0, lootItemDefnId = 0x10,
}
local BONE_STRIDE, BONE_POS_OFF = 0x40, 0x30
local ENTITY_TYPE_GADGET, ENTITY_TYPE_NPC, ENTITY_TYPE_PLAYER = -1, 5, 6
local NPC_THREAT_TIER = { Boss = 0, Heavy = 1, Standard = 2, Skill = 3, NonThreat = 4 }
local DEFAULT_RECOIL, DEFAULT_SPREAD = 30.0, 4.0
local MAGIC_BULLET_OFF, MAGIC_BULLET_ON = 0x98, 0xFF
local RPM_MIN, RPM_MAX = 60, 3000
local BATCH_MAX_ENTRIES, BATCH_MAX_BYTES = 256, 4096
local TRANSITION_FRAMES, MIN_OVERLAP_CHECK_COUNT = 120, 4
local SILENT_LOCK_DELTA = 2.0
local LOCK_ID = { silent = 10001, recoil = 10002, spread_rva = 10003, spread_a1 = 10004, spread_a2 = 10005 }
local TURRET_BOX_HEIGHT_OFFSET, DRONE_BOX_HEIGHT = 1.3, 0.8
local NONSKELETON_AIM_STEP_PX, NONSKELETON_AIM_LIMIT_WORLD, NONSKELETON_WORLD_STEP = 2, 5.0, 0.2
local WALK_SKIP_COOLDOWN = 120
local LOOT_SCAN_INTERVAL = 1.0
local MIN_USER_ADDR, MAX_USER_ADDR = 0x10000, 0x7FFFFFFFFFFF
local CFG_PREFIX = "td2.clean."
local RELATION_HOSTILE = { 0xBF, 0x06, 0x3D, 0x2C, 0x0F, 0xC0, 0x16, 0x0C }
local RELATION_FRIENDLY = { 0x0D, 0x56, 0x38, 0xF4, 0x20, 0x76, 0x01, 0x00 }
local RELATION_NEUTRAL = { 0xA4, 0x46, 0x88, 0x82, 0x54, 0xF0, 0x03, 0x00 }
 
-- NPC ARCHETYPES & SETS
local ARCHETYPE_LIST = "Unset Assault Rusher Thrower Sniper Controller HeavyWeapons Tank Support Medic Engineer Turret StaticTurret RPG Immobilizer Bomber Flamer Disruptor Shield DroneSuicide DroneTaser DroneRevive MiniTank BigDog BigDogConvoy DroneHelicopter Hunter LootGoblin Bodyguard Leader ChemicalDrone Special Civilian Dog Raven Rat Pigeon Seagull SeekerMine SupportStation Crow Raccoon Squirrel Fox Rabbit Eagle Vulture DestructibleProp Cat RCCar RCBlade Firefly FemaleDeer MaleDeer Monkey Flamingo Crocodile Parrot CatLoco RatLoco JumperCar DroneBomb MGStationary RogueAgent DroneOperator BigDogGrenadier BigDogMinigun SeagullLoco SquirrelLoco SkillDeploymentBox Trap Hive Decoy TurretCleaners AssaultDrone BigDogFlamer DogCompanion SmartCover BigDogMortar BigDogSmall"
local NPC_ARCHETYPE, ARCHETYPE_NAME_BY_ID = {}, {}
local _arc_idx = 0
for w in ARCHETYPE_LIST:gmatch("%S+") do
  NPC_ARCHETYPE[w] = _arc_idx
  ARCHETYPE_NAME_BY_ID[_arc_idx] = w
  _arc_idx = _arc_idx + 1
end
 
local function make_set(src, extra)
  local s = {}
  if type(src) == "string" then
    for w in src:gmatch("%S+") do if NPC_ARCHETYPE[w] then s[NPC_ARCHETYPE[w]] = true end end
  elseif type(src) == "table" then
    for k in pairs(src) do s[k] = true end
  end
  if extra then
    for w in extra:gmatch("%S+") do if NPC_ARCHETYPE[w] then s[NPC_ARCHETYPE[w]] = true end end
  end
  return s
end
 
local ARCHETYPE_WILDLIFE = make_set("Dog Raven Rat Pigeon Seagull Crow Raccoon Squirrel Fox Rabbit Eagle Vulture Cat FemaleDeer MaleDeer Monkey Flamingo Crocodile Parrot CatLoco RatLoco SeagullLoco SquirrelLoco")
local ARCHETYPE_WHITELIST_GLOBAL = make_set(ARCHETYPE_WILDLIFE, "Unset DestructibleProp Civilian")
local ARCHETYPE_WHITELIST_GADGET = make_set("Turret StaticTurret MGStationary TurretCleaners ChemicalDrone DroneSuicide DroneTaser DroneRevive DroneBomb AssaultDrone SeekerMine Trap Hive SupportStation SkillDeploymentBox RCCar RCBlade Firefly JumperCar Decoy SmartCover DogCompanion")
local ARCHETYPE_COMBATANT = make_set("Assault Rusher Thrower Sniper Controller HeavyWeapons Tank Support Medic Engineer RPG Immobilizer Bomber Flamer Disruptor Shield Hunter LootGoblin Bodyguard Leader Special RogueAgent DroneOperator BigDog BigDogConvoy BigDogGrenadier BigDogMinigun BigDogFlamer BigDogMortar BigDogSmall MiniTank DroneSuicide DroneTaser DroneRevive DroneBomb AssaultDrone SeekerMine ChemicalDrone Turret StaticTurret MGStationary TurretCleaners")
local ARCHETYPE_IS_DRONE = make_set("DroneSuicide DroneTaser DroneRevive DroneBomb AssaultDrone ChemicalDrone DroneHelicopter SeekerMine")
local ARCHETYPE_IS_DOG = make_set("BigDog BigDogConvoy BigDogFlamer BigDogMortar BigDogSmall BigDogGrenadier BigDogMinigun DogCompanion")
local ARCHETYPE_IS_TURRET = make_set("Turret StaticTurret MGStationary TurretCleaners SupportStation SkillDeploymentBox")
local ARCHETYPE_IS_GADGET = make_set("RCCar RCBlade Firefly JumperCar Trap Hive Decoy SmartCover")
 
local ARCHETYPE_PROFILE = {}
for w in ("Assault Rusher Thrower Sniper Controller HeavyWeapons Tank Support Medic Engineer RPG Immobilizer Bomber Flamer Disruptor Shield Hunter LootGoblin Bodyguard Leader Special Civilian RogueAgent DroneOperator"):gmatch("%S+") do
  ARCHETYPE_PROFILE[NPC_ARCHETYPE[w]] = "NPC_HUMANOID"
end
for w in ("BigDog BigDogConvoy BigDogFlamer BigDogMortar BigDogSmall DogCompanion"):gmatch("%S+") do
  ARCHETYPE_PROFILE[NPC_ARCHETYPE[w]] = "BIG_DOG"
end
ARCHETYPE_PROFILE[NPC_ARCHETYPE.BigDogGrenadier] = "WARHOUND_GRENADIER"
ARCHETYPE_PROFILE[NPC_ARCHETYPE.BigDogMinigun] = "WARHOUND_MINIGUN"
ARCHETYPE_PROFILE[NPC_ARCHETYPE.MiniTank] = "MINITANK"
 
function lc(s) return s and s:lower() or "" end
 
local NON_COMBATANT_PATTERNS = {
  "box", "crate", "canister", "barrel", "container", "loot", "supply", "yellow box", "resource", "cache",
  "stash", "drop", "package", "briefcase", "helicopter", "chopper", "drone carrier", "extraction", "balloon",
  "destructible", "prop", "barrier", "cover", "sandbag", "barricade", "generator", "antenna", "terminal", "console", "vending"
}
local ITEM_PATTERNS = {
  "battery", "power cell", "powercell", "fuel cell", "fuelcell", "energy cell", "capacitor", "reactor", "core",
  "keycard", "key card", "access card", "id card", "badge", "intel", "document", "datapad", "hard drive", "harddrive",
  "usb", "disk", "tape", "recording", "medkit", "med kit", "first aid", "bandage", "antiviral", "vaccine",
  "ration", "ammo box", "ammo crate", "shd tech", "shd cache", "shd node", "satellite", "relay",
  "beacon", "transmitter", "receiver", "uplink", "objective", "marker", "waypoint", "checkpoint",
  "supply drop", "airdrop", "cache drop"
}
local ROBOT_NAME_PATTERNS = {
  "minitank", "mini tank", "warhound minigun", "warhound grenadier", "warhound", "war hound",
  "bigdog", "big dog", "canine", "war dog",
}
 
local function str_matches_any(name, list)
  if not name or name == "" then return false end
  local ln = lc(name)
  for i = 1, #list do if ln:find(list[i], 1, true) then return true end end
  return false
end
function name_is_blacklisted(name) return str_matches_any(name, NON_COMBATANT_PATTERNS) end
function name_looks_like_item(name) return str_matches_any(name, ITEM_PATTERNS) end
function name_looks_like_robot(name) return str_matches_any(name, ROBOT_NAME_PATTERNS) end

local CACHE_NAME_PATTERNS = {
  "cache", "stash", "container", "resource", "ceramic", "component", "material",
  "yellow box", "supply", "drop", "package", "briefcase", "crate", "box", "loot",
}
local function entity_is_cache(e)
  return e and not e.is_player
    and (str_matches_any(e.ent_name, CACHE_NAME_PATTERNS) or str_matches_any(e.type_str, CACHE_NAME_PATTERNS))
end
 
function is_rogue_npc(e)
  return not e.is_player and e.entity_type_int ~= ENTITY_TYPE_PLAYER
    and (e.entity_type_int == ENTITY_TYPE_NPC or e.type_str == "npc") and lc(e.faction_tag) == "rogueagents"
end
 
function profile_name_for(e)
  if e.is_player then return "PLAYER_HUMANOID" end
  if is_rogue_npc(e) then return "NPC_HUMANOID" end
  if e.archetype ~= nil then
    if ARCHETYPE_IS_DRONE[e.archetype] then return "DRONE" end
    if ARCHETYPE_IS_TURRET[e.archetype] then return "TURRET" end
    local p = ARCHETYPE_PROFILE[e.archetype]
    if p then return p end
  end
  if e.ent_name and e.ent_name ~= "" and name_looks_like_item(e.ent_name) then return "ITEM" end
  if e.archetype ~= nil then return "NO_SKELETON" end
  return "NPC_HUMANOID"
end
 
local state
 
function get_color(e)
  if e.is_player then
    return (e.relation == "hostile") and { 255, 140, 25 } or { 51, 102, 255 }
  end
  if e.is_low_hp then return { 128, 128, 128 } end
  if e.relation == "hostile" then return { 255, 38, 38 } end
  if e.relation == "friendly" then return { 25, 230, 51 } end
  if e.relation == "neutral" then return { 255, 255, 80 } end
  return { 180, 80, 255 }
end
 
function aimbot_priority(e)
  if e.entity_type == ENTITY_TYPE_GADGET or e.entity_type_int == ENTITY_TYPE_GADGET then return 1 end
  return 3
end
 
function is_silent_target(e, allow_ignored_boneless)
  if e.is_local_player or e.is_downed then return false end
  local allow_friendly = state.silent_target_friendly and e.relation == "friendly"
  if e.is_player and not allow_friendly then return false end
  if is_rogue_npc(e) then return true end
  if e.entity_type ~= ENTITY_TYPE_NPC and e.entity_type_int ~= ENTITY_TYPE_GADGET then return false end
  if e.archetype and ARCHETYPE_WILDLIFE[e.archetype] then return false end
  if (e.relation == "friendly" and not allow_friendly) or e.relation == "neutral" then return false end
  local pname = profile_name_for(e)
  if is_boneless_profile(pname) and not allow_ignored_boneless and boneless_aim_profile_is_ignored(e) then return false end
  if e.archetype == NPC_ARCHETYPE.DestructibleProp then return true end
  if e.is_summoned and not state.silent_target_summon then return false end
  if pname ~= "TURRET" and pname ~= "BIG_DOG" and pname ~= "WARHOUND_GRENADIER"
    and pname ~= "WARHOUND_MINIGUN" and pname ~= "MINITANK" and name_is_blacklisted(e.ent_name) then
    return false
  end
  if pname == "TURRET" then return true end
  if pname == "ITEM" then return false end
  if e.is_summoned and e.relation ~= "hostile" and not allow_friendly then return false end
  if e.archetype ~= nil then
    if ARCHETYPE_WHITELIST_GLOBAL[e.archetype] then return false end
    if ARCHETYPE_COMBATANT[e.archetype] or ARCHETYPE_WHITELIST_GADGET[e.archetype] then return true end
  end
  if e.relation == "unknown" and name_looks_like_robot(e.ent_name) then return true end
  if e.relation == "unknown" and (pname == "DRONE" or pname == "BIG_DOG"
    or pname == "WARHOUND_GRENADIER" or pname == "WARHOUND_MINIGUN" or pname == "MINITANK") then
    return true
  end
  return e.relation == "hostile" or allow_friendly
end
 
-- BONE PROFILES
local BONE_PROFILES = {
  PLAYER_HUMANOID = {
    indices = { 0, 2, 4, 7, 8, 10, 15, 16, 17, 45, 46, 47, 79, 80, 84, 87, 88, 92 },
    connections = { {8,7},{7,4},{4,2},{4,15},{15,16},{16,17},{4,45},{45,46},{46,47},{2,84},{84,79},{79,80},{2,92},{92,87},{87,88} },
    aim_bone = 8, aim_bone_fallback = 7, is_humanoid = true,
  },
  NPC_HUMANOID = {
    indices = { 0, 2, 4, 6, 8, 9, 14, 15, 17, 44, 45, 47, 74, 75, 78, 79, 83, 86, 87, 91 },
    connections = { {8,6},{6,4},{4,2},{4,14},{14,15},{15,17},{4,44},{44,45},{45,47},{2,83},{83,78},{78,79},{2,91},{91,86},{86,87} },
    aim_bone = 8, aim_bone_fallback = 8, is_humanoid = true,
  },
  BIG_DOG = {
    indices = { 0, 2, 7, 8, 9, 14, 15, 16, 25, 30, 31, 32, 33, 36, 37, 38, 39 },
    connections = { {9,8},{8,7},{7,2},{16,15},{15,14},{14,2},{39,38},{38,37},{37,36},{36,2},{33,32},{32,31},{31,30},{30,2},{2,25} },
    aim_bone = 7, aim_bone_fallback = 2, is_humanoid = false,
  },
  WARHOUND_GRENADIER = {
    indices = { 0, 2, 7, 8, 9, 16, 17, 18, 27, 38, 39, 40, 41, 45, 46, 47, 48 },
    connections = { {9,8},{8,7},{7,2},{18,17},{17,16},{16,2},{41,40},{40,39},{39,38},{38,2},{48,47},{47,46},{46,45},{45,2},{2,27} },
    aim_bone = 7, aim_bone_fallback = 2, is_humanoid = false,
  },
  WARHOUND_MINIGUN = {
    indices = { 0, 2, 7, 8, 9, 16, 17, 18, 27, 34, 35, 36, 37, 40, 41, 42, 44 },
    connections = { {9,8},{8,7},{7,2},{18,17},{17,16},{16,2},{44,42},{42,41},{41,40},{40,2},{37,36},{36,35},{35,34},{34,2},{2,27} },
    aim_bone = 7, aim_bone_fallback = 2, is_humanoid = false,
  },
  MINITANK = {
    indices = { 0, 1, 7, 8, 13, 14, 15, 16, 22, 23, 28, 29, 31, 33, 35, 37 },
    connections = { {0,1},{1,7},{7,13},{1,8},{8,14},{0,16},{16,22},{22,28},{16,23},{23,29},{31,33},{33,35},{33,37},{1,31},{16,31} },
    aim_bone = 31, aim_bone_fallback = 0, is_humanoid = false,
  },
  ITEM = { indices = {}, connections = {}, aim_bone = nil, aim_bone_fallback = nil, is_humanoid = false },
  NO_SKELETON = { indices = {}, connections = {}, aim_bone = nil, aim_bone_fallback = nil, is_humanoid = false },
}
BONE_PROFILES.NPC_HUMANOID.aim_connections = {}
for _, pair in ipairs(BONE_PROFILES.NPC_HUMANOID.connections) do
  table.insert(BONE_PROFILES.NPC_HUMANOID.aim_connections, pair)
end
table.insert(BONE_PROFILES.NPC_HUMANOID.aim_connections, {74,75})
local BONE_NAMES = {
  PLAYER_HUMANOID = {head=8, chest=7, belly=4, root=2, l_knee=79, r_knee=87, l_heel=80, r_heel=88},
  NPC_HUMANOID = {head=8, chest=6, belly=4, root=2, l_knee=78, r_knee=86, l_heel=79, r_heel=87},
}
local ALL_BONE_IDS_0_90 = {}
for i = 0, 90 do ALL_BONE_IDS_0_90[#ALL_BONE_IDS_0_90 + 1] = i end
 
-- STATE
state = {
  name = "TheDivision2.exe", pid = 0, base = 0, status = "Ready", scan_info = "",
  stats_timer = 0, config_save_timer = 0, walk_skip = 0, show_ui = true, show_info_overlay = true,
  esp_enabled = false, esp_boxes = true, esp_snaplines = true,
  esp_distance = true, esp_bones = true, esp_bone_ids = false, esp_type = false, esp_name = true,
  esp_show_hostile = true, esp_show_friendly = false, esp_show_players = false,
  esp_show_wildlife = false, esp_show_neutral = false, esp_show_other = false,
  esp_show_relation = false, esp_show_faction = false, esp_desc_test = false, esp_text_size = 10,
  esp_show_silent_fov = true,
  esp_max_dist = 150, esp_loot = true, loot_text_size = 10, loot_max_dist = 150,
  loot_show_r0 = false, loot_show_r1 = false, loot_show_r2 = true, loot_show_r3 = false,
  loot_show_r4 = false, loot_show_r5 = false, loot_show_r6 = false, loot_show_r7 = true,
  loot_show_mods = true, loot_show_weapons = true,
  loot_show_gear = true, loot_show_others = true,
  loot_show_details = true, loot_show_names = false,
  loot_show_r8 = false, loot_show_r9 = true, loot_show_r11 = true, loot_show_other = true,
  target_marker_size = 3.5, crosshair_enabled = true, crosshair_size = 14, crosshair_gap = 10,
  crosshair_thick = 1.2, crosshair_dot = true, crosshair_dot_size = 1.2, crosshair_outline = true,
  silent_enabled = false, silent_target_summon = true, silent_target_friendly = false, silent_360 = false, silent_fov = 150, silent_max_dist = 150,
  silent_target_name = "", silent_last_rounds = 0, 
  silent_shots = 0, silent_armed = false, 
  aim_part = "head", dynamic_aim = true, boneless_override = true, nonskeleton_aim_offsets = {},
  boneless_aim_ignored = {}, 
  target_gadgets = false, no_recoil = false, recoil_locked = false, no_spread = false,
  spread_rva_locked = false, spread_aim_ctrl = 0, magic_bullet = false,
  instant_reload = false, rpm_enabled = false, rpm_value = 600,
  fragile_armor = false, high_headshot_dmg = false,
  rpm_live = 0.0, no_sway = false,
  extended_range = false, move_speed = false, master_enabled = true, time_mode = "normal",
  read_rva = string.format("0x%X", RVA.recoil), read_size = 16, read_result = "", preset_slot = {}, active_preset = 1,
  show_entity_counter = false, counter_collapsed = false, counter_x = 12, counter_y = 12, esp_show_caches = true,
  entities = {}, local_pos = { 0, 0, 0 }, 
  wr_timer = 0, attach_timer = 0, faction_tag_cache = {}, faction_tag_pid = 0,
  _last_arr_ptr = 0, _last_count = 0, 
  _was_attached = false, _transition_frames = 0,
  splash_text = "", splash_timer = 0, selected_target_ptr = 0,
  telem_valid = false, 
  telem_rounds = 0, 
  lp_name = "", lp_name_ptr = 0, hp = 0, hp_max = 0, armor = 0, armor_max = 0,
}
 
local function words_to_list(str)
  local t = {}
  for w in str:gmatch("%S+") do t[#t + 1] = w end
  return t
end
 
local MASTER_KEYS = words_to_list([[
  esp_enabled silent_enabled target_gadgets no_recoil no_spread magic_bullet no_sway
  move_speed extended_range instant_reload rpm_enabled fragile_armor high_headshot_dmg
]])
local MASTER_KEY_SET = {}
for _, key in ipairs(MASTER_KEYS) do MASTER_KEY_SET[key] = true end
 
local PERSIST_KEYS = words_to_list([[
  name active_preset master_enabled esp_enabled esp_boxes esp_loot loot_text_size loot_max_dist
  loot_show_details loot_show_names loot_show_mods loot_show_weapons loot_show_gear loot_show_others loot_show_r0 loot_show_r1 loot_show_r2 loot_show_r3 loot_show_r4 loot_show_r5 loot_show_r6
  loot_show_r7 loot_show_r8 loot_show_r9 loot_show_r11 loot_show_other esp_distance esp_snaplines
  esp_bones esp_bone_ids esp_type esp_name esp_show_hostile esp_show_friendly esp_show_players
  esp_show_wildlife esp_show_neutral esp_show_other esp_show_relation esp_show_faction esp_desc_test
  show_info_overlay esp_text_size esp_max_dist
  esp_show_silent_fov silent_enabled silent_target_summon silent_target_friendly silent_360 silent_fov silent_max_dist aim_part
  dynamic_aim boneless_override target_gadgets no_recoil no_spread magic_bullet no_sway
  move_speed extended_range instant_reload rpm_enabled rpm_value fragile_armor high_headshot_dmg crosshair_enabled crosshair_size
  crosshair_gap crosshair_thick crosshair_dot crosshair_dot_size crosshair_outline target_marker_size
  crosshair_r crosshair_g crosshair_b crosshair_alpha crosshair_hold_rmb
  show_entity_counter counter_collapsed counter_x counter_y esp_show_caches
]])
 
local LOOT_GROUP_FIELDS = {[1]="loot_show_mods",[2]="loot_show_weapons",[4]="loot_show_gear",[8]="loot_show_others"}
local NEW_OPTION_DEFAULTS = {
  crosshair_r = 255, crosshair_g = 255, crosshair_b = 255, crosshair_alpha = 255, crosshair_hold_rmb = false,
  silent_target_friendly = false, silent_360 = false,
  show_entity_counter = false, counter_collapsed = false, counter_x = 12, counter_y = 12, esp_show_caches = true,
  fragile_armor = false, high_headshot_dmg = false,
}
for key, value in pairs(NEW_OPTION_DEFAULTS) do state[key] = value end
local OPTION_TYPES = {}
for _, key in ipairs(PERSIST_KEYS) do OPTION_TYPES[key] = type(state[key]) end
 
function show_splash(text)
  state.splash_text = text
  state.splash_timer = 2.0
end
 
local function store_config(updates)
  local ok, err = pcall(function()
    for key, value in pairs(updates) do
      if config.set(key, value) ~= true or config.get(key, nil) ~= value then error("Config rejected " .. key) end
    end
    if config.save() ~= true then error("Config save failed") end
  end)
  state.config_error = not ok and tostring(err) or nil
  return ok, state.config_error
end
 
local function option_snapshot()
  local values = {}
  for _, key in ipairs(PERSIST_KEYS) do
    values[key] = state[key]
    if not state.master_enabled and state.master_snapshot and state.master_snapshot[key] ~= nil then
      values[key] = state.master_snapshot[key]
    end
  end
  return values
end
 
local function encode_options(values)
  local lines = {"TD2"}
  for _, key in ipairs(PERSIST_KEYS) do
    local value = values[key]
    if type(value) ~= OPTION_TYPES[key] then return nil end
    if type(value) == "boolean" then value = value and "1" or "0"
    elseif type(value) == "number" then
      if not is_finite(value) then return nil end
      value = string.format("%.17g", value)
    else value = value:gsub("([^%w _%.%-])", function(c) return string.format("%%%02X", c:byte()) end) end
    lines[#lines + 1] = key .. "=" .. value
  end
  local blob = table.concat(lines, "\n")
  return #blob <= 4096 and blob or nil
end
 
local function decode_options(blob)
  if type(blob) ~= "string" or #blob > 4096 or blob:sub(1, 4) ~= "TD2\n" then return nil end
  local values, count = {}, 0
  for line in (blob:sub(5) .. "\n"):gmatch("([^\n]*)\n") do
    local key, value = line:match("^([%w_]+)=(.*)$")
    local kind = key and OPTION_TYPES[key]
    if not kind or values[key] ~= nil then return nil end
    if kind == "boolean" then
      if value ~= "0" and value ~= "1" then return nil end
      value = value == "1"
    elseif kind == "number" then value = tonumber(value); if not is_finite(value) then return nil end
    else
      if value:gsub("%%%x%x", ""):find("%%") then return nil end
      value = value:gsub("%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end)
    end
    values[key], count = value, count + 1
  end
  for key, value in pairs(NEW_OPTION_DEFAULTS) do
    if values[key] == nil then values[key], count = value, count + 1 end
  end
  if count ~= #PERSIST_KEYS or values.active_preset % 1 ~= 0 or values.active_preset < 1 or values.active_preset > 4 then return nil end
  return values
end
 
local _last_saved_settings_blob = nil
 
function write_cfg_to_memory(force)
  local blob = encode_options(option_snapshot())
  if not blob then state.config_error = "Invalid settings or settings exceed 4096 bytes"; return false end
  if not force and _last_saved_settings_blob == blob then return true end
  local ok, err = store_config({[CFG_PREFIX .. "settings"] = blob})
  if ok then _last_saved_settings_blob = blob end
  return ok, err
end
 
function save_config_now(force) return write_cfg_to_memory(force) end
 
function read_cfg_into_state()
  local raw_blob = config.get(CFG_PREFIX .. "settings", nil)
  local values = decode_options(raw_blob)
  if values then
    for _, key in ipairs(PERSIST_KEYS) do state[key] = values[key] end
    _last_saved_settings_blob = raw_blob
  end
  if not state.master_enabled then
    state.master_snapshot = {}
    for _, key in ipairs(MASTER_KEYS) do state.master_snapshot[key], state[key] = state[key], false end
  end
end
 
function load_presets_from_file()
  for i = 1, 4 do state.preset_slot[i] = decode_options(config.get(CFG_PREFIX .. "preset_" .. i, nil)) end
end
 
function save_current_to_preset(index)
  if not state.master_enabled then show_splash("Enable Master before saving a preset"); return false end
  if type(index) ~= "number" or index % 1 ~= 0 or index < 1 or index > 4 then return false end
  local values = option_snapshot()
  local blob = encode_options(values)
  if not blob then show_splash("Preset exceeds 4096 bytes or contains invalid values"); return false end
  local saved, reason = store_config({[CFG_PREFIX .. "preset_" .. index] = blob})
  if not saved then show_splash("Preset save failed: " .. tostring(reason)); return false end
  state.preset_slot[index], state.active_preset = values, index
  show_splash(string.format("Preset %d Saved", index))
  return true
end
 
local apply_preset_changes
function load_preset_slot(index)
  if not state.master_enabled then show_splash("Enable Master before loading a preset"); return false end
  local slot = state.preset_slot[index]
  if not slot then show_splash(string.format("Preset %d Empty", index)); return false end
  local previous = option_snapshot()
  for _, key in ipairs(PERSIST_KEYS) do
    if key ~= "master_enabled" and key ~= "active_preset" then state[key] = slot[key] end
  end
  if state.pid ~= 0 and state.base ~= 0 then apply_preset_changes(previous) end
  state.active_preset = index
  show_splash(string.format("Preset %d Loaded", index))
  return true
end
 
-- HELPERS
local function to_f32(v) return string.unpack("<I4", string.pack("<f", v)) end
local function from_f32(b) return string.unpack("<f", string.pack("<I4", b)) end
 
function uint_from(bytes, off, n)
  local v = 0
  for i = off + n - 1, off, -1 do v = v * 256 + (bytes[i] or 0) end
  return v
end
 
function parse_f32_array(data, count)
  local m = {}
  for i = 1, count do m[i] = from_f32(uint_from(data, (i - 1) * 4 + 1, 4)) end
  return m
end
 
function vec_dist(a, b)
  local dx, dy, dz = a[1] - b[1], a[2] - b[2], a[3] - b[3]
  return math.sqrt(dx * dx + dy * dy + dz * dz)
end
 
function is_finite(v)
  return type(v) == "number" and v == v and v ~= math.huge and v ~= -math.huge
end
 
function is_valid_addr(addr, size)
  if not is_finite(addr) or addr % 1 ~= 0 or addr < MIN_USER_ADDR or addr > MAX_USER_ADDR then
    return false
  end
  if size ~= nil and (not is_finite(size) or size % 1 ~= 0 or size < 1 or addr + size - 1 > MAX_USER_ADDR) then
    return false
  end
  return true
end
 
function report_memory_error(op, detail)
  local frame = tonumber(state._frame_counter) or 0
  if not state._memory_error_frame or frame - state._memory_error_frame >= 120 then
    state._memory_error_frame = frame
    state.memory_error = tostring(op) .. ": " .. tostring(detail)
  end
end
 
function assert_attached()
  if state.pid == 0 or state.base == 0 then error("not attached") end
end
 
function to_byte_table(raw)
  if type(raw) == "string" then
    local n = #raw
    local t = {}
    for i = 1, n do t[i] = string.byte(raw, i) end
    return t, n
  elseif type(raw) == "table" then
    return raw, #raw
  end
  return {}, 0
end
 
function read_bytes_table(addr, n)
  if not state.pid or state.pid <= 0 or not is_valid_addr(addr, n) then
    report_memory_error("read", "invalid PID/address/size")
    return {}, 0
  end
  local ok, raw = pcall(memory.read_bytes, state.pid, addr, n)
  if not ok then
    report_memory_error("read", raw)
    return {}, 0
  end
  local t, len = to_byte_table(raw)
  if len < n then report_memory_error("read", "short read") end
  return t, len
end
 
function read_uint(addr, n)
  local raw, len = read_bytes_table(addr, n)
  if len < n then return 0, false end
  return uint_from(raw, 1, n), true
end
 
function write_uint(addr, value, n)
  if not state.pid or state.pid <= 0 or not is_valid_addr(addr, n)
    or not is_finite(value) or value < 0 or value % 1 ~= 0 or value >= 256 ^ n then
    report_memory_error("write", "invalid PID/address/value/size")
    return false
  end
  local bytes = {}
  for i = 1, n do
    bytes[i] = value % 256; value = math.floor(value / 256)
  end
  local ok, err = pcall(memory.write_bytes, state.pid, addr, bytes)
  if not ok then report_memory_error("write", err); return false end
  return true
end
 
function is_hostile_archetype(a) return not ARCHETYPE_WHITELIST_GLOBAL[a] end
 
local function read_ascii_str(raw, off, max_len)
  if not raw then return "" end
  local chars = {}
  for j = 1, max_len do
    local b = raw[off + j]
    if not b or b == 0 then break end
    if b < 0x20 or b >= 0x7F then return "" end
    chars[#chars + 1] = string.char(b)
  end
  return table.concat(chars)
end
 
function read_faction_template_tag(faction_ptr)
  local raw, len = read_bytes_table(faction_ptr + OFF.factionTag, 16)
  return len >= 16 and read_ascii_str(raw, 0, 16) or ""
end
 
local ENEMY_FACTION_TAGS = {
  ["legendary"] = { "Legendary Black Tusk", "Legendary Black Tusk" },
  ["endgame"] = { "Black Tusk", "Black Tusk" },
  ["blackbloc"] = { "Hyenas", "Hyenas" },
  ["ambushers"] = { "Wanderers", "Wanderers" },
  ["militia"] = { "True Sons", "True Sons" },
  ["rikers"] = { "Rikers", "Rikers" },
  ["cleaners"] = { "Cleaners", "Cleaners" },
  ["cultists"] = { "Outcasts", "Outcasts" },
}
 
function enemy_tag_entry(tag)
  return (tag and tag ~= "") and ENEMY_FACTION_TAGS[tag:lower()] or nil
end
 
function faction_display(fac, tag)
  local n = enemy_tag_entry(tag)
  if n then return n[1] end
  return (tag and tag ~= "") and tag or string.format("fac:0x%X", fac)
end
 
function faction_display_en(fac, tag)
  local n = enemy_tag_entry(tag)
  return n and n[2] or string.format("fac:0x%X", fac)
end
 
function match_relation(raw, off, pattern)
  for i = 1, 8 do
    if raw[off + i] ~= pattern[i] then return false end
  end
  return true
end
 
function classify_pipeline(e, ctx)
  local etype = e.entity_type_int
  if etype == ENTITY_TYPE_NPC or etype == ENTITY_TYPE_GADGET then
    if e.tier_valid and e.tier == NPC_THREAT_TIER.NonThreat then return "friendly" end
    local a = e.archetype or NPC_ARCHETYPE.Unset
    if not is_hostile_archetype(a) then return "friendly" end
  end
  if ctx.local_faction ~= 0 and e.faction ~= 0 then
    if etype == ENTITY_TYPE_GADGET and not state.target_gadgets then return "friendly" end
    local tag = ctx.tag_cache[e.faction]
    if tag == nil then
      tag = read_faction_template_tag(e.faction)
      if tag ~= "" then ctx.tag_cache[e.faction] = tag end
    end
    if tag == "PlayerServices" or tag == "Staff" then return "friendly" end
    return (e.faction ~= ctx.local_faction) and "hostile" or "friendly"
  end
  return "unknown"
end
 
function classify_entity(e, ctx)
  if ctx.local_player == 0 then return "unknown" end
  if is_rogue_npc(e) then return "hostile" end
  if enemy_tag_entry(e.faction_tag) then return "hostile" end
  local classified = classify_pipeline(e, ctx)
  if not e.is_player then
    if classified == "unknown" then return e.rel_verdict or "unknown" end
    if e.rel_verdict and classified == "hostile" and (e.rel_verdict == "friendly" or e.rel_verdict == "neutral") then
      return e.rel_verdict
    end
  end
  return classified
end
 
function batch_read_chunked(pid, stride, addrs)
  local n = #addrs
  if n == 0 then return {} end
  if not pid or pid <= 0 or not is_finite(stride) or stride % 1 ~= 0 or stride < 1 or stride > BATCH_MAX_BYTES then
    report_memory_error("batch read", "invalid PID/stride"); return {}
  end
  local per_call = math.min(BATCH_MAX_ENTRIES, math.floor(BATCH_MAX_BYTES / stride))
  if per_call < 1 then return {} end
  local out, i = {}, 1
  while i <= n do
    local last = math.min(i + per_call - 1, n)
    local sub, slots = {}, {}
    local start = #out
    for _ = 1, (last - i + 1) * stride do out[#out + 1] = 0 end
    for k = i, last do
      if is_valid_addr(addrs[k], stride) then
        sub[#sub + 1], slots[#slots + 1] = addrs[k], start + (k - i) * stride
      else report_memory_error("batch read", "invalid address") end
    end
    local expect = #sub * stride
    local ok, raw = false, nil
    if #sub > 0 then ok, raw = pcall(memory.batch_read, pid, stride, sub) end
    if #sub > 0 and not ok then report_memory_error("batch read", raw) end
    local data, dlen = to_byte_table(ok and raw or nil)
    if ok and dlen < expect then report_memory_error("batch read", "short read") end
    for k, slot in ipairs(slots) do
      if dlen >= k * stride then
        for b = 1, stride do out[slot + b] = data[(k - 1) * stride + b] end
      end
    end
    i = last + 1
  end
  return out
end
 
function read_f32(addr)
  local bits, valid = read_uint(addr, 4)
  if valid == false then error("float read failed") end
  return from_f32(bits)
end
function write_f32(addr, value) return write_uint(addr, to_f32(value), 4) end
 
function pack_f32(value)
  local bits = to_f32(value)
  local out = {}
  for i = 1, 4 do
    out[i] = bits % 256; bits = math.floor(bits / 256)
  end
  return out
end
 
function pack_vec3(v)
  local b1, b2, b3 = pack_f32(v[1]), pack_f32(v[2]), pack_f32(v[3])
  return { b1[1], b1[2], b1[3], b1[4], b2[1], b2[2], b2[3], b2[4], b3[1], b3[2], b3[3], b3[4] }
end
 
function read_sd_string(addr)
  local hdr = read_bytes_table(addr, 32)
  if #hdr < 32 then return "" end
  local size = uint_from(hdr, 17, 8)
  if size == 0 or size > 128 then return "" end
  local cap = uint_from(hdr, 25, 8)
  local bytes
  if cap <= 15 then
    bytes = hdr
  else
    local ptr = uint_from(hdr, 1, 8)
    if ptr == 0 then return "" end
    bytes = read_bytes_table(ptr, size)
  end
  local chars = {}
  for i = 1, size do
    local b = bytes[i] or 0
    if b == 0 then break end
    chars[i] = string.char(b)
  end
  return table.concat(chars)
end
 
function safe_walk(pid, base, offsets)
  if state.walk_skip > 0 then return 0 end
  local ok, res = pcall(memory.traverse_pointer_chain, pid, base, offsets)
  if not ok then
    state.walk_skip = WALK_SKIP_COOLDOWN
    state.status = "Pointer walk: " .. tostring(res) .. " (cooldown " .. WALK_SKIP_COOLDOWN .. ")"
    return 0
  end
  return res or 0
end
 
local _lp_cache, _lp_frame = 0, -1
function get_localplayer()
  local cur_frame = tonumber(state._frame_counter) or 0
  if _lp_frame == cur_frame and _lp_cache ~= 0 then return _lp_cache end
  _lp_cache = safe_walk(state.pid, state.base, {
    RVA.rlclient, OFF.pClient, OFF.pObject,
    OFF.localStage0, OFF.localStage1, OFF.localStage2,
  })
  _lp_frame = cur_frame
  return _lp_cache
end
 
function resolve_rpm_target(lp)
  if lp == 0 then return 0 end
  local w1 = read_uint(lp + OFF.weapPtr0, 8)
  if w1 == 0 then return 0 end
  local w2 = read_uint(w1 + OFF.weapPtr1, 8)
  if w2 == 0 then return 0 end
  return read_uint(w2 + OFF.weapPtr2, 8)
end
 
function read_npc_archetypes(pid, ptrs, type_raw, down_raw)
  local addrs, owners = {}, {}
  for i, ep in ipairs(ptrs) do
    if read_ascii_str(type_raw, (i - 1) * 16, 16) ~= "soldier" and uint_from(down_raw, (i - 1) * 4 + 1, 4) == 0 then
      -- Synchronized descriptor fallback logic from td2
      local desc = read_uint(ep + 0x6D0, 8) -- Fallback offset for descriptor if npcDescriptorPtr is nil
      if desc ~= 0 then
        addrs[#addrs + 1], owners[#owners + 1] = desc + OFF.npcAgentDescriptor, i
      end
    end
  end
  if #addrs == 0 then return {} end
  local raw = batch_read_chunked(pid, 8, addrs)
  local desc_addrs, desc_owners = {}, {}
  for i, owner in ipairs(owners) do
    local agent = uint_from(raw, (i - 1) * 8 + 1, 8)
    if is_valid_addr(agent, OFF.npcAgentDescriptor + 8) then
      desc_addrs[#desc_addrs + 1], desc_owners[#desc_owners + 1] = agent + OFF.npcAgentDescriptor, owner
    end
  end
  if #desc_addrs == 0 then return {} end
  raw = batch_read_chunked(pid, 8, desc_addrs)
  local fields, field_owners = {}, {}
  for i, owner in ipairs(desc_owners) do
    local desc = uint_from(raw, (i - 1) * 8 + 1, 8)
    if is_valid_addr(desc, math.max(OFF.npcArchetypeOffset, OFF.npcTierOffset) + 4) then
      fields[#fields + 1], fields[#fields + 2] = desc + OFF.npcArchetypeOffset, desc + OFF.npcTierOffset
      field_owners[#field_owners + 1] = owner
    end
  end
  if #fields == 0 then return {} end
  raw = batch_read_chunked(pid, 4, fields)
  local result = {}
  for i, owner in ipairs(field_owners) do
    result[owner] = {uint_from(raw, (i - 1) * 8 + 1, 4), uint_from(raw, (i - 1) * 8 + 5, 4)}
  end
  return result
end
 
-- SAVED FEATURE VALUES
local _frame_id = 0
local rpm_saved, rpm_last_forced, rpm_pending_weapon = {}, nil, nil
local template_saved, movement_saved = {}, {}
local armor_saved, headshot_saved = {}, {}
local restore_cached_features
 
function reset_weapon_cache()
  rpm_saved, rpm_last_forced, rpm_pending_weapon = {}, nil, nil
  template_saved, movement_saved = {}, {}
  armor_saved, headshot_saved = {}, {}
  state.silent_weapon_ptr = nil
end
 
local lock_check_elapsed = 0
local function release_owned_locks()
  for _, id in pairs(LOCK_ID) do pcall(memory.unlock, id) end
  state.silent_lock_addr = nil
  state.recoil_locked, state.spread_rva_locked = false, false
  state.spread_aim_addrs, state.spread_aim_ctrl = nil, 0
  lock_check_elapsed = 0
end
 
local function sync_feature_locks(dt)
  if not state.no_recoil and not state.no_spread then lock_check_elapsed = 0; return end
  lock_check_elapsed = lock_check_elapsed + math.max(0, tonumber(dt) or 0)
  if lock_check_elapsed < 0.5 then return end
  lock_check_elapsed = 0
  local ok, entries = pcall(memory.lock_list)
  if not ok or type(entries) ~= "table" then
    report_memory_error("lock list", ok and "invalid lock list" or entries)
    return
  end
  local by_id = {}
  for _, entry in ipairs(entries) do
    if type(entry) == "table" and type(entry.id) == "number" and is_finite(entry.id)
      and entry.pid == state.pid then by_id[entry.id] = entry end
  end
  local function present(id, address)
    local entry = by_id[id]
    return entry ~= nil and entry.address == address and entry.len == 4
  end
  if state.no_recoil then state.recoil_locked = present(LOCK_ID.recoil, state.base + RVA.recoil) end
  if state.no_spread then
    state.spread_rva_locked = present(LOCK_ID.spread_rva, state.base + RVA.spread)
    local locks = state.spread_aim_addrs
    if locks then
      locks.a1_locked = present(LOCK_ID.spread_a1, locks.a1)
      locks.a2_locked = present(LOCK_ID.spread_a2, locks.a2)
    end
  end
end
 
function clear_spread_aim_locks()
  local locks = state.spread_aim_addrs
  if locks then
    if locks.a1_locked then pcall(memory.unlock, LOCK_ID.spread_a1) end
    if locks.a2_locked then pcall(memory.unlock, LOCK_ID.spread_a2) end
  end
  state.spread_aim_addrs, state.spread_aim_ctrl = nil, 0
end
 
function ensure_spread_aim_locks(aim)
  if not aim or aim == 0 then return false end
  if state.spread_aim_ctrl ~= aim then clear_spread_aim_locks(); state.spread_aim_ctrl = aim end
  local locks = state.spread_aim_addrs
  if not locks then
    locks = {
      a1 = aim + OFF.combatAimCurrentSpread, a2 = aim + OFF.combatAimSpreadRadius,
      a1_locked = false, a2_locked = false,
    }
    state.spread_aim_addrs = locks
  end
  if not locks.a1_locked then
    local ok, res = pcall(memory.lock, LOCK_ID.spread_a1, state.pid, locks.a1, pack_f32(0.0))
    locks.a1_locked = ok and res ~= false
    if not locks.a1_locked then pcall(write_f32, locks.a1, 0.0) end
  end
  if not locks.a2_locked then
    local ok, res = pcall(memory.lock, LOCK_ID.spread_a2, state.pid, locks.a2, pack_f32(0.0))
    locks.a2_locked = ok and res ~= false
    if not locks.a2_locked then pcall(write_f32, locks.a2, 0.0) end
  end
  return locks.a1_locked and locks.a2_locked
end
 
function invalidate_on_transition(pid)
  release_owned_locks()
  if restore_cached_features then pcall(restore_cached_features) end
  _lp_cache, _lp_frame = 0, -1
  if pid and pid > 0 and state.base ~= 0 then pcall(write_uint, state.base + RVA.magicbullet, MAGIC_BULLET_OFF, 1) end
  reset_weapon_cache()
  state.silent_armed, state.silent_last_rounds, state.silent_target_ptr = false, 0, nil
  state.diag_last_write = nil
  state.telem_valid, state.telem_world_aim, state.telem_lock_target = false, nil, nil
  state.telem_delta, state.telem_rounds, state.telem_lock_addr = nil, 0, nil
  state._transition_frames, state.walk_skip = TRANSITION_FRAMES, 0
  state.entities = {}
  state.loot_items, state.loot_scan_was_enabled, state.loot_scan_elapsed = {}, false, 0
end
 
function process_is_alive(pid, expected_base)
  if not pid or pid <= 0 then return false, "invalid PID" end
  local ok, base = pcall(memory.get_process_base, pid)
  if not ok then
    local found, current = pcall(memory.get_pid, state.name)
    if found and current ~= pid then return false, "process changed or exited" end
    if not found and tostring(current):lower():find("process not found", 1, true) then return false, "process exited" end
    return nil, tostring(base)
  end
  if not is_valid_addr(base, 1) then return false, "process is no longer available" end
  if expected_base and expected_base ~= 0 and base ~= expected_base then return false, "process base changed" end
  return true
end
 
function detach_stale_process(reason)
  if state.master_enabled and not state.master_snapshot then
    state.master_snapshot = {}
    for _, key in ipairs(MASTER_KEYS) do state.master_snapshot[key] = state[key] end
  end
  release_owned_locks()
  reset_weapon_cache()
  _lp_cache, _lp_frame = 0, -1
  state.pid, state.base, state._was_attached, state.entities, state.attach_timer = 0, 0, false, {}, 0
  state.silent_armed, state.silent_target_ptr, state.silent_target_name = false, nil, ""
  state.viewproj, state.window_rect, state.local_pos = nil, nil, nil
  state.faction_tag_cache, state.faction_tag_pid = {}, 0
  state._last_arr_ptr, state._last_count, state._last_ptrs = 0, 0, nil
  state.loot_items, state.lp_name, state.lp_name_ptr = "", 0
  state.loot_scan_was_enabled, state.loot_scan_elapsed = false, 0
  for _, key in ipairs(MASTER_KEYS) do state[key] = false end
  state.master_enabled = false
  state.status = "Detached: " .. tostring(reason or "process unavailable")
  state.memory_error = nil
end
 
function chk(label, key, apply_fn)
  local v, changed = ui.checkbox(label, state[key])
  if not state.master_enabled and MASTER_KEY_SET[key] then state[key] = false; return false end
  state[key] = v
  if changed and apply_fn then pcall(apply_fn) end
  return v
end
 
function checkbox_edge(label, active)
  local a, b = ui.checkbox(label, active)
  return (b ~= nil) and (b == true) or (a ~= active)
end
 
function draw_fov_circle(cx, cy, radius, r, g, b, a)
  if radius and radius > 0 then
    draw.circle(cx, cy, radius, r, g, b, a, 0.7)
    draw.circle(cx, cy, radius + 1, 0, 0, 0, 60, 0.6)
  end
end

local function counter_counts()
  local human, nonhuman = 0, 0
  for _, e in ipairs(state.entities or {}) do
    if e and not e.is_downed and (e.relation == "hostile" or is_rogue_npc(e)) then
      if e.entity_type_int == ENTITY_TYPE_GADGET then
        nonhuman = nonhuman + 1
      else
        local profile = BONE_PROFILES[profile_name_for(e)]
        if profile and profile.is_humanoid then human = human + 1 else nonhuman = nonhuman + 1 end
      end
    end
  end
  return human, nonhuman
end

local function draw_entity_counter(w)
  if not state.show_entity_counter or not w then return end
  local human, nonhuman = counter_counts()
  local size, pad, line_h = 14, 8, 20
  local lines = { state.counter_collapsed and "> ENTITIES" or "v ENTITIES" }
  if not state.counter_collapsed then
    lines[#lines + 1] = string.format("Humans: %d", human)
    lines[#lines + 1] = string.format("Non-Humans: %d", nonhuman)
  end
  local maxw = 0
  for _, line in ipairs(lines) do
    local width = #line * 8
    if draw.get_text_width then
      local ok, measured = pcall(draw.get_text_width, line, size)
      if ok and type(measured) == "number" and measured > 0 then width = measured end
    end
    maxw = math.max(maxw, width)
  end
  local x = (w.x or 0) + (tonumber(state.counter_x) or 12)
  local y = (w.y or 0) + (tonumber(state.counter_y) or 12)
  local box_w, box_h = maxw + pad * 2, #lines * line_h + pad * 2
  pcall(draw.filled_rect, x, y, box_w, box_h, 0, 0, 0, 170)
  pcall(draw.rect, x, y, box_w, box_h, 255, 200, 0, 180, 1.0)
  for i, line in ipairs(lines) do
    local ty = y + pad + (i - 1) * line_h
    pcall(draw.text, x + pad + 1, ty + 1, line, 0, 0, 0, 220, size)
    pcall(draw.text, x + pad, ty, line, 255, 255, 255, 235, size)
  end
end
 
function draw_circle_filled(cx, cy, radius, r, g, b, a)
  if radius and radius > 0 then draw.filled_circle(cx, cy, radius, r, g, b, a) end
end
 
function draw_crosshair(w)
  if not state.crosshair_enabled or not w then return end
  if state.crosshair_hold_rmb and (not keyboard or not keyboard.is_key_down or not keyboard.is_key_down("mouse2")) then return end
  local cx, cy = w.x + w.width / 2, w.y + w.height / 2
  local size, gap, th = state.crosshair_size or 14, state.crosshair_gap or 6, state.crosshair_thick or 2
  local outline = state.crosshair_outline ~= false
  local r, g, b, a = state.crosshair_r or 255, state.crosshair_g or 255, state.crosshair_b or 255, state.crosshair_alpha or 255
  local outline_a = math.floor(220 * a / 255 + 0.5)
  local function seg(x1, y1, x2, y2)
    if outline then draw.line(x1, y1, x2, y2, 0, 0, 0, outline_a, th + 2.0) end
    draw.line(x1, y1, x2, y2, r, g, b, math.floor(235 * a / 255 + 0.5), th)
  end
  seg(cx, cy - gap, cx, cy - gap - size)
  seg(cx, cy + gap, cx, cy + gap + size)
  seg(cx - gap, cy, cx - gap - size, cy)
  seg(cx + gap, cy, cx + gap + size, cy)
  if state.crosshair_dot then
    local ds = state.crosshair_dot_size or 3
    if outline then draw_circle_filled(cx, cy, ds + 1, 0, 0, 0, outline_a) end
    draw_circle_filled(cx, cy, ds, r, g, b, a)
  end
end
 
function refresh_stats()
  assert_attached()
  local lp = get_localplayer()
  if lp == 0 then error("local player is NULL") end
  if state.lp_name_ptr ~= lp or state.lp_name == "" then
    local name = read_sd_string(lp + OFF.name)
    if name ~= "" then state.lp_name, state.lp_name_ptr = name, lp end
  end
  local hp = read_uint(lp + OFF.hpPtr, 8)
  if hp == 0 then error("hp component is NULL") end
  state.hp = read_uint(hp + OFF.health, 4)
  state.hp_max = read_uint(hp + OFF.healthMax, 4)
  state.armor = read_uint(hp + OFF.agentarmor, 4)
  state.armor_max = read_uint(hp + OFF.agentarmorMax, 4)
end
 
function apply_recoil()
  assert_attached()
  if state.no_recoil then
    local ok, result = pcall(memory.lock_rva,
      LOCK_ID.recoil, state.pid, RVA.recoil, pack_f32(0.0))
    if ok and result ~= false then
      state.recoil_locked = true
    else
      state.recoil_locked = false
      write_f32(state.base + RVA.recoil, 0.0)
    end
  else
    if state.recoil_locked then pcall(memory.unlock_rva, LOCK_ID.recoil); state.recoil_locked = false end
    write_f32(state.base + RVA.recoil, DEFAULT_RECOIL)
  end
  state.status = state.no_recoil and "No recoil ON (lock)" or "No recoil OFF"
end
 
function apply_spread()
  assert_attached()
  if state.no_spread then
    local ok, result = pcall(memory.lock_rva,
      LOCK_ID.spread_rva, state.pid, RVA.spread, pack_f32(0.0))
    if ok and result ~= false then
      state.spread_rva_locked = true
    else
      state.spread_rva_locked = false
      write_f32(state.base + RVA.spread, 0.0)
    end
    local lp = get_localplayer()
    if lp ~= 0 then
      local aim = read_uint(lp + OFF.aimCtrl, 8)
      if aim ~= 0 then ensure_spread_aim_locks(aim) end
    end
  else
    if state.spread_rva_locked then pcall(memory.unlock_rva, LOCK_ID.spread_rva); state.spread_rva_locked = false end
    write_f32(state.base + RVA.spread, DEFAULT_SPREAD)
    clear_spread_aim_locks()
    local lp = get_localplayer()
    if lp ~= 0 then
      local aim = read_uint(lp + OFF.aimCtrl, 8)
      if aim ~= 0 then
        write_f32(aim + OFF.combatAimCurrentSpread, 0.5)
        write_f32(aim + OFF.combatAimSpreadRadius, 1.0)
      end
    end
  end
  state.status = state.no_spread and "No spread ON (lock)" or "No spread OFF"
end
 
function magic_bullet_should_enable()
  if not state.magic_bullet or not state.silent_armed or not state.silent_target_ptr then return false end
  for _, e in ipairs(state.entities) do
    if e.entity_ptr == state.silent_target_ptr then return is_silent_target(e) end
  end
  return false
end
 
function apply_magic_bullet()
  assert_attached()
  local on = magic_bullet_should_enable()
  write_uint(state.base + RVA.magicbullet, on and MAGIC_BULLET_ON or MAGIC_BULLET_OFF, 1)
  state.status = state.magic_bullet and (on and "Magic bullet ON (NPC-only, locked)" or "Magic bullet ON (NPC-only, idle)") or "Magic bullet OFF"
end
 
local SWAY_PROPS = {
  { OFF.weapTemplateSwayMinH, "min_h" }, { OFF.weapTemplateSwayMaxH, "max_h" },
  { OFF.weapTemplateSwayMinV, "min_v" }, { OFF.weapTemplateSwayMaxV, "max_v" },
  { OFF.weapTemplateSwayResetDur, "reset_dur" }, { OFF.weapTemplateScopeSwaySpeed, "scope_speed" },
}
 
local function save_sway_defaults(wdata)
  local clip = read_uint(wdata + OFF.weapTemplateClipSize, 4)
  local dmg = read_uint(wdata + OFF.weapTemplateDmgMin, 4)
  local saved = template_saved[wdata]
  if not saved or saved.pid ~= state.pid or saved.clip ~= clip or saved.dmg ~= dmg then
    saved = {pid = state.pid, clip = clip, dmg = dmg, sway = {}}
    template_saved[wdata] = saved
  end
  if saved.sway.min_h ~= nil then return saved end
  local values = {}
  for _, sp in ipairs(SWAY_PROPS) do
    local v = read_f32(wdata + sp[1])
    if not is_finite(v) then error("invalid sway default") end
    values[sp[2]] = v
  end
  saved.sway = values
  return saved
end
 
local function zero_sway(wdata)
  local saved = save_sway_defaults(wdata)
  saved.sway_forced = true
  write_f32(wdata + OFF.weapTemplateSwayMinH, 0.0)
  write_f32(wdata + OFF.weapTemplateSwayMaxH, 0.0)
  write_f32(wdata + OFF.weapTemplateSwayMinV, 0.0)
  write_f32(wdata + OFF.weapTemplateSwayMaxV, 0.0)
  write_f32(wdata + OFF.weapTemplateScopeSwaySpeed, 0.0)
end
 
local function template_matches(ptr, saved)
  local clip, clip_ok = read_uint(ptr + OFF.weapTemplateClipSize, 4)
  local dmg, dmg_ok = read_uint(ptr + OFF.weapTemplateDmgMin, 4)
  return saved.pid == state.pid and clip_ok ~= false and dmg_ok ~= false and clip == saved.clip and dmg == saved.dmg
end
 
local function restore_sway_defaults()
  for ptr, saved in pairs(template_saved) do
    if saved.sway_forced then
      pcall(function()
        if not template_matches(ptr, saved) then return end
        local complete = true
        for _, sp in ipairs(SWAY_PROPS) do
          if sp[2] ~= "reset_dur" and saved.sway[sp[2]] ~= nil and read_f32(ptr + sp[1]) == 0 then
            if write_f32(ptr + sp[1], saved.sway[sp[2]]) == false then complete = false end
          end
        end
        if complete then saved.sway_forced = false; saved.sway = {} end
      end)
    end
  end
end
 
local function weapon_data_ptr(required)
  local lp = get_localplayer()
  if lp == 0 then
    if required then error("local player is NULL") end
    return 0
  end
  local aim = read_uint(lp + OFF.aimCtrl, 8)
  if aim == 0 then
    if required then error("aimCtrl is NULL") end
    return 0
  end
  local ptr = read_uint(aim + OFF.combatAimWeaponDataPtr, 8)
  if ptr == 0 and required then error("weapon data ptr is NULL") end
  return ptr
end
 
function apply_no_sway()
  assert_attached()
  if state.no_sway then
    zero_sway(weapon_data_ptr(true))
    state.status = "No sway ON"
  else
    restore_sway_defaults()
    state.status = "No sway OFF"
  end
end
 
function sway_tick()
  if not state.no_sway then return end
  local ok, err = pcall(function()
    local wdata = weapon_data_ptr(false)
    if wdata == 0 then return end
    zero_sway(wdata)
  end)
  if not ok then state.status = "NoSway: " .. tostring(err) end
end
 
local function force_extended_range(wdata)
  local saved = template_saved[wdata]
  if not saved or not template_matches(wdata, saved) then
    saved = {pid = state.pid, clip = read_uint(wdata + OFF.weapTemplateClipSize, 4),
      dmg = read_uint(wdata + OFF.weapTemplateDmgMin, 4), sway = {}}
    template_saved[wdata] = saved
  end
  if saved.range == nil then
    local raw = read_f32(wdata + OFF.weapTemplateRange)
    if not is_finite(raw) then error("invalid range default") end
    saved.range = raw
  end
  saved.range_forced = true
  if read_f32(wdata + OFF.weapTemplateRange) ~= 9999999.0 then write_f32(wdata + OFF.weapTemplateRange, 9999999.0) end
end
 
local function restore_ranges()
  for ptr, saved in pairs(template_saved) do
    if saved.range_forced then
      pcall(function()
        if not template_matches(ptr, saved) then return end
        if read_f32(ptr + OFF.weapTemplateRange) == 9999999.0 then
          if write_f32(ptr + OFF.weapTemplateRange, saved.range) == false then return end
        end
        saved.range_forced, saved.range = false, nil
      end)
    end
  end
end
 
function apply_extended_range()
  assert_attached()
  if state.extended_range then force_extended_range(weapon_data_ptr(true)) else restore_ranges() end
  state.status = state.extended_range and "Extended range ON" or "Extended range OFF"
end
 
function extended_range_tick()
  if not state.extended_range then return end
  local ok, err = pcall(function()
    local wdata = weapon_data_ptr(false)
    if wdata == 0 then return end
    force_extended_range(wdata)
  end)
  if not ok then state.status = "ExtendedRange: " .. tostring(err) end
end
 
function teleport_guard() return (state._transition_frames or 0) > 0 end
 
function apply_move_speed()
  assert_attached()
  if not state.move_speed then
    for aim, saved in pairs(movement_saved) do
      pcall(function()
        if saved.pid ~= state.pid or read_uint(saved.lp + OFF.aimCtrl, 8) ~= aim then return end
        for _, field in ipairs({{OFF.combatAimMoveSpreadAdd, "spread"}, {OFF.combatAimLerpedMoveSpeed, "speed"}}) do
          if read_f32(aim + field[1]) == 0 then write_f32(aim + field[1], saved[field[2]]) end
        end
      end)
    end
    movement_saved = {}
    state.status = "No move spread OFF"
    return
  end
  if teleport_guard() then
    state.status = "Teleport guard: move speed deferred"
    return
  end
  local lp = get_localplayer()
  if lp == 0 then error("local player is NULL") end
  local aim = read_uint(lp + OFF.aimCtrl, 8)
  if aim == 0 then error("aimCtrl is NULL") end
  local saved = movement_saved[aim]
  if not saved or saved.pid ~= state.pid or saved.lp ~= lp then
    local spread, speed = read_f32(aim + OFF.combatAimMoveSpreadAdd), read_f32(aim + OFF.combatAimLerpedMoveSpeed)
    if not is_finite(spread) or not is_finite(speed) then error("invalid movement default") end
    saved = {pid = state.pid, lp = lp, spread = spread, speed = speed}
    movement_saved[aim] = saved
  end
  write_f32(aim + OFF.combatAimMoveSpreadAdd, 0.0)
  write_f32(aim + OFF.combatAimLerpedMoveSpeed, 0.0)
  state.status = "No move spread ON"
end
 
function move_speed_tick()
  if not state.move_speed then return end
  local ok, err = pcall(apply_move_speed)
  if not ok then state.status = "MoveSpeed: " .. tostring(err) end
end

local function same_number(a, b)
  return is_finite(a) and is_finite(b) and math.abs(a - b) < 0.00001
end

local function restore_fragile_armor()
  for hp, saved in pairs(armor_saved) do
    pcall(function()
      if saved.pid ~= state.pid then return end
      if read_uint(hp + OFF.npcArmor, 4) == saved.forced then write_uint(hp + OFF.npcArmor, saved.armor, 4) end
      if read_uint(hp + OFF.npcArmorMax, 4) == saved.forced then write_uint(hp + OFF.npcArmorMax, saved.armor_max, 4) end
    end)
    armor_saved[hp] = nil
  end
end

function fragile_armor_tick()
  if not state.fragile_armor then return end
  local ok, err = pcall(function()
    for _, e in ipairs(state.entities or {}) do
      if e and not e.is_player and e.relation == "hostile" then
        local hp = read_uint(e.entity_ptr + OFF.hpPtr, 8)
        if is_valid_addr(hp, OFF.npcArmorMax + 4) then
          local saved = armor_saved[hp]
          if not saved or saved.pid ~= state.pid then
            local armor, armor_max = read_uint(hp + OFF.npcArmor, 4), read_uint(hp + OFF.npcArmorMax, 4)
            saved = {pid = state.pid, armor = armor, armor_max = armor_max, forced = 1}
            armor_saved[hp] = saved
          end
          write_uint(hp + OFF.npcArmor, saved.forced, 4)
          write_uint(hp + OFF.npcArmorMax, saved.forced, 4)
        end
      end
    end
  end)
  if not ok then state.status = "Fragile armor: " .. tostring(err) end
end

function apply_fragile_armor()
  assert_attached()
  if state.fragile_armor then fragile_armor_tick() else restore_fragile_armor() end
  state.status = state.fragile_armor and "Fragile enemy armor ON" or "Fragile enemy armor OFF"
end

local function valid_template(ptr, saved)
  return saved.pid == state.pid
    and read_uint(ptr + OFF.weapTemplateClipSize, 4) == saved.clip
    and read_uint(ptr + OFF.weapTemplateDmgMin, 4) == saved.dmg
end

local function restore_headshot_damage()
  for ptr, saved in pairs(headshot_saved) do
    pcall(function()
      if valid_template(ptr, saved) and same_number(read_f32(ptr + OFF.weapTemplateDmgMultHead), saved.forced) then
        write_f32(ptr + OFF.weapTemplateDmgMultHead, saved.base)
      end
    end)
    headshot_saved[ptr] = nil
  end
end

function headshot_damage_tick()
  if not state.high_headshot_dmg then return end
  local ok, err = pcall(function()
    local ptr = weapon_data_ptr(false)
    if ptr == 0 then return end
    local saved = headshot_saved[ptr]
    if not saved or not valid_template(ptr, saved) then
      local base = read_f32(ptr + OFF.weapTemplateDmgMultHead)
      if not is_finite(base) then error("invalid headshot multiplier") end
      saved = {pid = state.pid, clip = read_uint(ptr + OFF.weapTemplateClipSize, 4), dmg = read_uint(ptr + OFF.weapTemplateDmgMin, 4), base = base, forced = 100.0}
      headshot_saved[ptr] = saved
    end
    write_f32(ptr + OFF.weapTemplateDmgMultHead, saved.forced)
  end)
  if not ok then state.status = "Headshot damage: " .. tostring(err) end
end

function apply_headshot_damage()
  assert_attached()
  if state.high_headshot_dmg then headshot_damage_tick() else restore_headshot_damage() end
  state.status = state.high_headshot_dmg and "High headshot damage ON" or "High headshot damage OFF"
end

restore_cached_features = function()
  restore_sway_defaults()
  restore_ranges()
  local enabled = state.move_speed
  state.move_speed = false
  pcall(apply_move_speed)
  state.move_speed = enabled
  pcall(restore_rpm)
  restore_fragile_armor()
  restore_headshot_damage()
end
 
function apply_time(mode)
  if not state.master_enabled and mode ~= "normal" then state.time_mode = "normal"; return end
  assert_attached()
  state.time_mode = mode
  write_uint(state.base + RVA.setnoon, mode == "noon" and 1 or 0, 1)
  write_uint(state.base + RVA.setnight, mode == "night" and 1 or 0, 1)
  state.status = "Time: " .. mode
end
 
function sanitize_rpm_value()
  if state.rpm_value < RPM_MIN then state.rpm_value = RPM_MIN end
  if state.rpm_value > RPM_MAX then state.rpm_value = RPM_MAX end
end
 
local function rpm_context()
  local lp = get_localplayer()
  if lp == 0 then error("local player unavailable") end
  local weapon = resolve_rpm_target(lp)
  local aim = read_uint(lp + OFF.aimCtrl, 8)
  local tpl = aim ~= 0 and read_uint(aim + OFF.combatAimWeaponDataPtr, 8) or 0
  if weapon == 0 or tpl == 0 then error("weapon data unavailable") end
  return weapon, aim, tpl
end
 
local function rpm_identity(saved)
  local clip, valid = read_uint(saved.tpl + OFF.weapTemplateClipSize, 4)
  local dmg, valid_dmg = read_uint(saved.tpl + OFF.weapTemplateDmgMin, 4)
  if valid == false or valid_dmg == false then error("cannot verify weapon") end
  return saved.pid == state.pid and clip == saved.clip and dmg == saved.dmg
end
 
function restore_rpm()
  local ready, current, aim, tpl = pcall(rpm_context)
  local failure
  for weapon, saved in pairs(rpm_saved) do
    local ok, err = pcall(function()
      if not rpm_identity(saved) then return end
      if read_f32(weapon + OFF.weaponRpm) == saved.forced then
        if write_f32(weapon + OFF.weaponRpm, saved.base) == false then error("base RPM restore failed") end
        if read_f32(weapon + OFF.weaponRpm) ~= saved.base then error("base RPM restore did not stick") end
      end
      if not ready then error("waiting for active weapon to restore RPM") end
      if weapon == current and saved.tpl == tpl and saved.aim == aim then
        local rate, valid = read_uint(aim + OFF.combatAimRpm, 4)
        if valid == false then error("active RPM read failed") end
        if rate == saved.forced then
          if write_uint(aim + OFF.combatAimRpm, saved.rate, 4) == false then error("active RPM restore failed") end
          if read_uint(aim + OFF.combatAimRpm, 4) ~= saved.rate then error("active RPM restore did not stick") end
        end
      end
    end)
    if ok then rpm_saved[weapon] = nil else failure = tostring(err) end
  end
  if not next(rpm_saved) then rpm_last_forced, rpm_pending_weapon = nil, nil end
  state.rpm_error = failure
  pcall(read_rpm_once)
  if failure then state.status = "RPM restore: " .. failure end
  return failure == nil
end
 
function rpm_tick()
  if not state.rpm_enabled then return end
  sanitize_rpm_value()
  local ok, err = pcall(function()
    local weapon, aim, tpl = rpm_context()
    if not rpm_saved[weapon] and rpm_pending_weapon ~= weapon then rpm_pending_weapon = weapon; return end
    local base = read_f32(weapon + OFF.weaponRpm)
    local rate, valid = read_uint(aim + OFF.combatAimRpm, 4)
    local template_rate = read_uint(tpl + OFF.weapTemplateRpm, 4)
    if valid == false or not is_finite(base) or base <= 0 or base > 10000
      or rate < 1 or rate > 10000 or template_rate < 1 or template_rate > 10000 then error("invalid RPM data") end
    local saved = rpm_saved[weapon]
    if not saved or saved.tpl ~= tpl or not rpm_identity(saved) then
      if rate == rpm_last_forced and template_rate ~= rate then error("waiting for weapon RPM refresh") end
      saved = {pid=state.pid, tpl=tpl, aim=aim, base=template_rate,
        rate=math.floor(template_rate * rate / base + 0.5),
        clip=read_uint(tpl + OFF.weapTemplateClipSize, 4), dmg=read_uint(tpl + OFF.weapTemplateDmgMin, 4)}
      rpm_saved[weapon] = saved
    elseif saved.aim ~= aim then
      if rate ~= rpm_last_forced then saved.rate = rate end
      saved.aim = aim
    end
    local target = math.floor(state.rpm_value + 0.5)
    saved.forced, rpm_last_forced = target, target
    if base ~= target and write_f32(weapon + OFF.weaponRpm, target) == false then error("base RPM write failed") end
    if rate ~= target and write_uint(aim + OFF.combatAimRpm, target, 4) == false then error("active RPM write failed") end
    state.rpm_live, state.rpm_template_live = read_uint(aim + OFF.combatAimRpm, 4), template_rate
    if state.rpm_live ~= target then error("active RPM write did not stick") end
    state.rpm_error = nil
  end)
  if not ok then state.rpm_error = tostring(err); state.status = "RPM: " .. state.rpm_error end
end
 
function read_rpm_once()
  assert_attached()
  local _, aim, tpl = rpm_context()
  local rate, valid = read_uint(aim + OFF.combatAimRpm, 4)
  if valid == false then error("active RPM read failed") end
  state.rpm_live = rate
  state.rpm_template_live = read_uint(tpl + OFF.weapTemplateRpm, 4)
  state.status = string.format("Active RPM: %.0f", state.rpm_live)
end
 
function instant_reload_tick()
  if not state.instant_reload then return end
  local ok, err = pcall(function()
    local lp = get_localplayer()
    if lp == 0 then return end
    local aim = read_uint(lp + OFF.aimCtrl, 8)
    if aim ~= 0 then write_uint(aim + OFF.reloadField, 0, 4) end
  end)
  if not ok then state.status = "InstantReload: " .. tostring(err) end
end
 
-- MASTER CONTROL
function set_master(on)
  if on == state.master_enabled then return end
  state.master_enabled = on
  if not on then
    state.master_snapshot = {}
    for _, k in ipairs(MASTER_KEYS) do
      state.master_snapshot[k] = state[k]
      state[k] = false
    end
    if state.pid ~= 0 and state.base ~= 0 then
      pcall(apply_recoil); pcall(apply_spread); pcall(apply_magic_bullet)
      pcall(apply_no_sway); pcall(apply_extended_range); pcall(apply_move_speed)
      pcall(apply_fragile_armor); pcall(apply_headshot_damage)
      pcall(restore_rpm)
      pcall(apply_time, "normal")
    end
    if state.pid ~= 0 and state.silent_lock_addr then
      pcall(memory.unlock, LOCK_ID.silent)
      state.silent_lock_addr = nil
    end
    state.silent_armed, state.silent_target_ptr = false, nil
    state.silent_target_name, state.selected_target_ptr = "", 0
    state.entities, state.loot_items = {}, {}
    state.status = "Master OFF (F1 to re-enable)"
  else
    if state.master_snapshot then
      for _, k in ipairs(MASTER_KEYS) do state[k] = state.master_snapshot[k] end
      state.master_snapshot = nil
    end
    if state.pid ~= 0 and state.base ~= 0 then
      pcall(apply_recoil); pcall(apply_spread); pcall(apply_magic_bullet)
      if state.no_sway then pcall(apply_no_sway) end
      if state.extended_range then pcall(apply_extended_range) end
      if state.move_speed then pcall(apply_move_speed) end
      if state.fragile_armor then pcall(apply_fragile_armor) end
      if state.high_headshot_dmg then pcall(apply_headshot_damage) end
      if state.rpm_enabled then pcall(rpm_tick) end
      if state.time_mode ~= "normal" then pcall(apply_time, state.time_mode) end
    end
    state.status = "Master ON"
  end
end
 
function get_bone_ids_for_entity(e, read_all)
  if read_all then return ALL_BONE_IDS_0_90 end
  local pname = profile_name_for(e)
  if pname == "DRONE" or pname == "TURRET" or pname == "ITEM" then return {} end
  local prof = BONE_PROFILES[pname]
  return prof and prof.indices or {}
end
 
function world_to_screen(pos, m, wr)
  if not m or not wr or type(wr) ~= "table" then return nil end
  if not wr.width or not wr.height or wr.width <= 0 or wr.height <= 0 then return nil end
  local x, y, z = pos[1], pos[2], pos[3]
  local cx = m[1] * x + m[5] * y + m[9] * z + m[13]
  local cy = m[2] * x + m[6] * y + m[10] * z + m[14]
  local cw = m[4] * x + m[8] * y + m[12] * z + m[16]
  if not is_finite(cw) or cw < 0.001 then return nil end
  return wr.x + (cx / cw + 1) * wr.width / 2, wr.y + (1 - cy / cw) * wr.height / 2
end
 
function read_bones(pid, entities, read_all)
  if #entities == 0 then return {} end
  local bb_addrs = {}
  for _, e in ipairs(entities) do bb_addrs[#bb_addrs + 1] = e.entity_ptr + OFF.bonesBase end
  local bb_raw = batch_read_chunked(pid, 8, bb_addrs)
  local ba_addrs, valid = {}, {}
  for i = 1, #entities do
    local off = (i - 1) * 8
    if #bb_raw >= off + 8 then
      local bb = uint_from(bb_raw, off + 1, 8)
      if bb ~= 0 then
        ba_addrs[#ba_addrs + 1] = bb + OFF.boneArray
        valid[#valid + 1] = i
      end
    end
  end
  if #ba_addrs == 0 then return {} end
  local ba_raw = batch_read_chunked(pid, 8, ba_addrs)
  local bone_addr_list, bone_owner, bone_id_list = {}, {}, {}
  for vi = 1, #valid do
    local ei = valid[vi]
    local e = entities[ei]
    local off = (vi - 1) * 8
    if #ba_raw >= off + 8 then
      local bone_arr = uint_from(ba_raw, off + 1, 8)
      if bone_arr ~= 0 then
        for _, bid in ipairs(get_bone_ids_for_entity(e, read_all)) do
          bone_addr_list[#bone_addr_list + 1] = bone_arr + bid * BONE_STRIDE + BONE_POS_OFF
          bone_owner[#bone_owner + 1] = ei
          bone_id_list[#bone_id_list + 1] = bid
        end
      end
    end
  end
  if #bone_addr_list == 0 then return {} end
  local raw = batch_read_chunked(pid, 12, bone_addr_list)
  local bone_results, entity_bones = {}, {}
  for k = 1, #bone_addr_list do
    local boff = (k - 1) * 12
    if #raw >= boff + 12 then
      local bx = from_f32(uint_from(raw, boff + 1, 4))
      local by = from_f32(uint_from(raw, boff + 5, 4))
      local bz = from_f32(uint_from(raw, boff + 9, 4))
      if is_finite(bx) and is_finite(by) and is_finite(bz) and (bx ~= 0 or by ~= 0 or bz ~= 0) then
        local ei = bone_owner[k]
        entity_bones[ei] = entity_bones[ei] or {}
        entity_bones[ei][#entity_bones[ei] + 1] = { bid = bone_id_list[k], pos = { bx, by, bz } }
      end
    end
  end
  local MAX_BONE_DIST = 6.0
  for ei, list in pairs(entity_bones) do
    local epos, kept = entities[ei] and entities[ei].pos, {}
    local anchor = BONE_PROFILES[profile_name_for(entities[ei])]
    local anchor_id = anchor and anchor.is_humanoid and 2 or 0
    for _, entry in ipairs(list) do if entry.bid == anchor_id then epos = entry.pos; break end end
    if epos then
      for _, entry in ipairs(list) do
        local p = entry.pos
        local dx, dy, dz = p[1] - epos[1], p[2] - epos[2], p[3] - epos[3]
        if math.sqrt(dx * dx + dy * dy + dz * dz) <= MAX_BONE_DIST then kept[entry.bid] = p end
      end
    else
      for _, entry in ipairs(list) do kept[entry.bid] = entry.pos end
    end
    bone_results[ei] = kept
  end
  return bone_results
end
 
function should_show(e)
  if e.is_player then return state.esp_show_players end
  if is_rogue_npc(e) then return state.esp_show_hostile end
  if e.archetype and ARCHETYPE_WILDLIFE[e.archetype] then return state.esp_show_wildlife end
  if entity_is_cache(e) then return state.esp_show_caches end
  local pname = profile_name_for(e)
  if pname == "ITEM" then return state.esp_show_other end
  if pname ~= "TURRET" and pname ~= "BIG_DOG" and pname ~= "WARHOUND_GRENADIER"
    and pname ~= "WARHOUND_MINIGUN" and pname ~= "MINITANK" and not e.is_player then
    if name_is_blacklisted(e.ent_name) then return false end
  end
  if pname == "TURRET" then
    if e.relation == "friendly" then return state.esp_show_friendly end
    if e.relation == "neutral" then return state.esp_show_neutral end
    return state.esp_show_hostile
  end
  if e.relation == "unknown" and (pname == "DRONE" or pname == "BIG_DOG"
    or pname == "WARHOUND_GRENADIER" or pname == "WARHOUND_MINIGUN" or pname == "MINITANK") then
    return state.esp_show_hostile or state.esp_show_other
  end
  if e.relation == "hostile" then return state.esp_show_hostile end
  if e.relation == "friendly" then return state.esp_show_friendly end
  if e.relation == "neutral" then return state.esp_show_neutral end
  if e.relation == "unknown" then return state.esp_show_other end
  return false
end
 
local function calc_height_box(draw_pos, h_off, w_ratio, min_h, def_h, def_w, m, w, sy_hint)
  local _, oy = world_to_screen(draw_pos, m, w)
  local _, ty = world_to_screen({ draw_pos[1], draw_pos[2] + h_off, draw_pos[3] }, m, w)
  if oy and ty then
    local h = math.abs(oy - ty)
    if h > min_h then return h, h * w_ratio, (oy + ty) / 2 end
  end
  return def_h, def_w, sy_hint
end
 
function compute_box(e, m, w, sy_hint, draw_pos_override)
  local pname = profile_name_for(e)
  local draw_pos = draw_pos_override or e.pos
  if pname == "DRONE" then
    return calc_height_box(draw_pos, DRONE_BOX_HEIGHT, 0.8, 6, 40, 30, m, w, sy_hint)
  elseif pname == "TURRET" then
    return calc_height_box(draw_pos, TURRET_BOX_HEIGHT_OFFSET, 0.75, 6, 60, 45, m, w, sy_hint)
  elseif pname == "ITEM" then
    return calc_height_box(draw_pos, 0.3, 0.9, 3, 20, 18, m, w, sy_hint)
  elseif pname == "BIG_DOG" or pname == "WARHOUND_GRENADIER" or pname == "WARHOUND_MINIGUN" then
    return calc_height_box(draw_pos, 1.6, 0.9, 4, 40, 16, m, w, sy_hint)
  elseif pname == "MINITANK" then
    local bones = e.bones
    local rp = bones and bones[0]
    local hp = bones and (bones[37] or bones[33] or bones[31] or bones[0]) or e.pos
    if rp then
      local _, hy = world_to_screen(hp, m, w)
      local _, ry = world_to_screen(rp, m, w)
      if hy and ry and math.abs(hy - ry) > 10 then
        local h = math.abs(hy - ry)
        return h, h * 0.5, (hy + ry) / 2
      end
    end
  else
    local ht_id = (pname == "PLAYER_HUMANOID") and 10 or 9
    local bt = BONE_NAMES[pname] or BONE_NAMES.NPC_HUMANOID
    local hp = e.bones and e.bones[ht_id]
    local rp = e.bones and (e.bones[bt.l_heel] or e.bones[bt.r_heel] or e.bones[0] or e.bones[2])
    if hp and rp then
      local hx, hy = world_to_screen(hp, m, w)
      local rx, ry = world_to_screen(rp, m, w)
      if hx and rx and math.abs(hy - ry) > 10 then
        local h = math.abs(hy - ry)
        return h, h * 0.4, (hy + ry) / 2, (hx + rx) / 2
      end
    end
  end
  return 40, 16, sy_hint
end
 
function is_boneless_profile(pname)
  return pname == "DRONE" or pname == "TURRET" or pname == "ITEM" or pname == "NO_SKELETON"
end
 
local function nonskeleton_readable_key(name)
  return (tostring(name or ""):gsub("[^%w_%-]", "_"))
end
 
local DESTRUCTIBLE_PROP_PROFILE = "npc:DestructibleProp"
local BONELESS_OFFSET_DEFAULTS = {
  [DESTRUCTIBLE_PROP_PROFILE] = { x = 0.30, y = 1.30, z = -0.70 },
  ["npc:Turret"] = { x = -0.12, y = 0.68, z = 0.0 },
}
 
function nonskeleton_target_name(e)
  local kind = e and e.ent_type or "npc"
  return kind .. ":" .. tostring(e and (e.archetype_name or e.type_str or e.entity_type_int or e.ent_name) or "unnamed")
end
 
local function nonskeleton_offset_profile(e)
  local name = nonskeleton_target_name(e)
  if name ~= DESTRUCTIBLE_PROP_PROFILE then return name, false end
  local pos = e.pos
  if not pos or not is_finite(pos[1]) or not is_finite(pos[2]) or not is_finite(pos[3]) then return nil, true end
  return string.format("%s@%d,%d,%d", name, math.floor(pos[1] + 0.5),
    math.floor(pos[2] + 0.5), math.floor(pos[3] + 0.5)), true
end
 
local _pending_offsets = {}
local _pending_offset_timer = 0
 
local function flush_pending_offsets()
  if not next(_pending_offsets) then return true end
  local updates = {}
  for name, offsets in pairs(_pending_offsets) do
    local key = CFG_PREFIX .. "offset_" .. nonskeleton_readable_key(name)
    updates[key] = string.format("%.17g,%.17g,%.17g,%.17g", offsets.x, offsets.y, offsets.z, offsets.zoom or 0)
  end
  local saved, reason = store_config(updates)
  if saved then _pending_offsets, _pending_offset_timer = {}, 0
  else _pending_offset_timer = 1.0 end
  state.offset_save_error = not saved and ("Offset save failed; retrying: " .. tostring(reason)) or nil
  return saved
end
 
local function save_nonskeleton_offset(name, offsets, immediate)
  offsets.configured = true
  _pending_offsets[name] = offsets
  if immediate then return flush_pending_offsets() end
  _pending_offset_timer = 0.5
  return true
end
 
function get_nonskeleton_offset(name)
  local offsets = state.nonskeleton_aim_offsets[name]
  if not offsets then
    local defaults = BONELESS_OFFSET_DEFAULTS[name] or {}
    offsets = {x = defaults.x or 0, y = defaults.y or 0, z = defaults.z or 0, zoom = 0, configured = false}
    local raw = config.get(CFG_PREFIX .. "offset_" .. nonskeleton_readable_key(name), "")
    if type(raw) == "string" then
      local x, y, z, zoom = raw:match("^([^,]+),([^,]+),([^,]+),?([^,]*)$")
      x, y, z, zoom = tonumber(x), tonumber(y), tonumber(z), zoom == "" and 0 or tonumber(zoom)
      if is_finite(x) and is_finite(y) and is_finite(z) and is_finite(zoom)
        and math.max(math.abs(x), math.abs(y), math.abs(z), math.abs(zoom)) <= NONSKELETON_AIM_LIMIT_WORLD then
        offsets.x, offsets.y, offsets.z, offsets.zoom = x, y, z, zoom
        offsets.configured = true
      end
    end
    state.nonskeleton_aim_offsets[name] = offsets
  end
  return offsets
end
 
local function effective_boneless_offset(e)
  local name, location_scoped = nonskeleton_offset_profile(e)
  if not name or (not state.boneless_override and not location_scoped) then return nil end
  local offsets = get_nonskeleton_offset(name)
  if state.boneless_override or offsets.configured then return offsets end
end
 
function boneless_aim_profile_is_ignored_name(name)
  name = tostring(name or "")
  if name == "" then return false end
  state.boneless_aim_ignored = state.boneless_aim_ignored or {}
  local ignored = state.boneless_aim_ignored[name]
  if ignored == nil then
    ignored = false
    if config then
      local ok, value = pcall(config.get, CFG_PREFIX .. "ignore_" .. nonskeleton_readable_key(name), false)
      ignored = ok and value == true
    end
    state.boneless_aim_ignored[name] = ignored
  end
  return ignored == true
end
 
function boneless_aim_profile_is_ignored(e)
  if not e or not is_boneless_profile(profile_name_for(e)) then return false end
  local name = nonskeleton_target_name(e)
  return boneless_aim_profile_is_ignored_name(name)
end
 
local function nonskeleton_cross(a, b)
  return { a[2]*b[3]-a[3]*b[2], a[3]*b[1]-a[1]*b[3], a[1]*b[2]-a[2]*b[1] }
end
local function nonskeleton_dot(a, b)
  return a[1]*b[1]+a[2]*b[2]+a[3]*b[3]
end
function screen_delta_to_world(pos, dx, dy, m, wr, depth)
  if not m or not wr then return nil end
  local sx, sy = world_to_screen(pos, m, wr)
  if not sx or not sy then return nil end
  local rx, ry, rw = {m[1],m[5],m[9]}, {m[2],m[6],m[10]}, {m[4],m[8],m[12]}
  local cw = nonskeleton_dot(rw, pos) + m[16]
  local delta
  if depth then
    local nx = nonskeleton_dot(rx, pos) + m[13]
    local ny = nonskeleton_dot(ry, pos) + m[14]
    nx, ny = nx/cw, ny/cw
    local a, b = {}, {}
    for i=1,3 do a[i], b[i] = rx[i]-nx*rw[i], ry[i]-ny*rw[i] end
    local ray = nonskeleton_cross(a, b)
    local length = math.sqrt(nonskeleton_dot(ray, ray))
    if not is_finite(length) or length < 1e-10 then return nil end
    local forward = nonskeleton_dot(rw, ray)
    if math.abs(forward) < 1e-10 then return nil end
    local scale = depth / length * (forward > 0 and 1 or -1)
    delta = {ray[1]*scale, ray[2]*scale, ray[3]*scale}
  else
    local yz, zx = nonskeleton_cross(ry, rw), nonskeleton_cross(rw, rx)
    local det = nonskeleton_dot(rx, yz)
    if not is_finite(det) or math.abs(det) < 1e-10 then return nil end
    local tx, ty = 2*dx*cw/wr.width, -2*dy*cw/wr.height
    delta = {}
    for i=1,3 do delta[i] = (tx*yz[i]+ty*zx[i])/det end
  end
  for i=1,3 do if not is_finite(delta[i]) then return nil end end
  if cw + nonskeleton_dot(rw, delta) < 0.001 then return nil end
  return delta
end
 
function apply_nonskeleton_world_offset(pos, offsets)
  local point = {pos[1] + offsets.x, pos[2] + offsets.y, pos[3] + offsets.z}
  if (offsets.zoom or 0) ~= 0 then
    local delta = screen_delta_to_world(point, 0, 0, state.viewproj, normalize_window_rect(state.window_rect), -offsets.zoom)
    if delta then for i = 1, 3 do point[i] = point[i] + delta[i] end end
  end
  return point
end
 
function normalize_window_rect(rect)
  if type(rect) ~= "table" then return nil end
  if rect[1] and type(rect[1]) == "table" then return rect[1] end
  return (rect.x and rect.width and rect.height) and rect or nil
end
 
local function find_valid_bone(bones, ...)
  if not bones then return nil end
  local args = { ... }
  for _, b in ipairs(args) do if b and bones[b] then return b end end
  return nil
end
 
local function dynamic_aim_point(e, prof)
  local m, wr = state.viewproj, normalize_window_rect(state.window_rect)
  if not m or not wr or not wr.width or not wr.height or not e.bones then return nil end
  local cx, cy = wr.x + wr.width / 2, wr.y + wr.height / 2
  local projected = {}
  for _, id in ipairs(prof.indices or {}) do
    local p = e.bones[id]
    if p and is_finite(p[1]) and is_finite(p[2]) and is_finite(p[3]) then
      local x, y = world_to_screen(p, m, wr)
      if x and y and is_finite(x) and is_finite(y) then
        projected[id] = {x=x, y=y, w=m[4]*p[1]+m[8]*p[2]+m[12]*p[3]+m[16], p=p}
      end
    end
  end
  local best, best_dist = nil, math.huge
  for _, pair in ipairs(prof.aim_connections or prof.connections or {}) do
    local a, b = projected[pair[1]], projected[pair[2]]
    if a and b then
      local dx, dy = b.x-a.x, b.y-a.y
      local length2 = dx*dx + dy*dy
      local t = length2 > 1e-8 and math.max(0, math.min(1, ((cx-a.x)*dx+(cy-a.y)*dy)/length2)) or 0
      local ex, ey = a.x+t*dx-cx, a.y+t*dy-cy
      local distance = ex*ex + ey*ey
      if distance < best_dist then
        local u = t*a.w / ((1-t)*b.w+t*a.w)
        best = {a.p[1]+u*(b.p[1]-a.p[1]), a.p[2]+u*(b.p[2]-a.p[2]), a.p[3]+u*(b.p[3]-a.p[3])}
        best_dist = distance
      end
    end
  end
  if best then return best end
  for _, id in ipairs(prof.indices or {}) do
    local p = projected[id]
    if p then
      local distance = (p.x-cx)^2 + (p.y-cy)^2
      if distance < best_dist then best, best_dist = {p.p[1],p.p[2],p.p[3]}, distance end
    end
  end
  return best
end
 
function aim_point_for(e)
  if not e then return nil end
  local pname = profile_name_for(e)
  if is_boneless_profile(pname) then
    local offsets = effective_boneless_offset(e)
    if offsets then return apply_nonskeleton_world_offset(e.pos, offsets) end
  end
  local prof = BONE_PROFILES[pname]
  local bt = BONE_NAMES[pname] or BONE_NAMES.NPC_HUMANOID
  local target_bone, force_floor = nil, false
  if prof and (state.dynamic_aim or state.aim_part == "dynamic") then
    local continuous = dynamic_aim_point(e, prof)
    if continuous then return continuous end
  end
  if prof and prof.is_humanoid then
    local p_part = (state.dynamic_aim or state.aim_part == "dynamic") and "dynamic" or state.aim_part
    if p_part == "dynamic" then
      p_part = "head"
    end
    if p_part == "head" then target_bone = find_valid_bone(e.bones, bt.head, bt.chest)
    elseif p_part == "chest" then target_bone = find_valid_bone(e.bones, bt.chest, bt.belly)
    elseif p_part == "pelvis" then target_bone = find_valid_bone(e.bones, bt.belly, bt.root)
    elseif p_part == "legs" then
      target_bone = find_valid_bone(e.bones, bt.l_heel, bt.r_heel, bt.l_knee, bt.r_knee)
      if not target_bone then force_floor = true end
    end
  elseif prof then
    target_bone = prof.aim_bone
  end
  if force_floor or target_bone == nil then
    target_bone = (target_bone == nil and prof) and prof.aim_bone_fallback or 0
  end
  local p = e.bones and e.bones[target_bone]
  if not p then return { e.pos[1], e.pos[2], e.pos[3] } end
  return (target_bone == 0) and { p[1], p[2], p[3] + 0.15 } or p
end
 
function find_silent_target(entities, viewproj, wr, allow_ignored_boneless, boneless_only)
  if not viewproj then return nil end
  local w = normalize_window_rect(wr)
  if not w or not w.width or w.width <= 0 then return nil end
  local cx, cy = w.x + w.width / 2, w.y + w.height / 2
  local best, best_score = nil, -math.huge
  local best360, best360_score = nil, -math.huge
  local max_dist = tonumber(state.silent_max_dist) or 150
  if not is_finite(max_dist) then max_dist = 150 end
  max_dist = math.max(10, math.min(200, max_dist))
  local fov_sq = state.silent_fov * state.silent_fov
  for _, e in ipairs(entities or {}) do
    if e and not e.is_downed and e.dist <= max_dist
      and (not boneless_only or is_boneless_profile(profile_name_for(e)))
      and is_silent_target(e, allow_ignored_boneless) then
      local tp = aim_point_for(e)
      if tp then
        local score360 = aimbot_priority(e) * 10000 - e.dist
        if score360 > best360_score then best360, best360_score = e, score360 end
        local sx, sy = world_to_screen(tp, viewproj, w)
        if sx and sy then
          local dx, dy = sx - cx, sy - cy
          local dist_px_sq = dx * dx + dy * dy
          if dist_px_sq < fov_sq then
            local score = aimbot_priority(e) * 10000 - math.sqrt(dist_px_sq)
            if score > best_score then best_score, best = score, e end
          end
        end
      end
    end
  end
  return best or (state.silent_360 and best360 or nil)
end
 
function read_world_aim(aim)
  if aim == 0 then return nil end
  local raw = read_bytes_table(aim + OFF.worldAimPos, 12)
  if #raw < 12 then return nil end
  return { from_f32(uint_from(raw, 1, 4)), from_f32(uint_from(raw, 5, 4)), from_f32(uint_from(raw, 9, 4)) }
end
 
function release_silent_lock(pid)
  if state.silent_lock_addr then pcall(memory.unlock, LOCK_ID.silent); state.silent_lock_addr = nil end
  state.silent_armed, state.diag_last_write = false, nil
  state.silent_target_ptr, state.silent_target_name, state.silent_mode = nil, "", nil
  if state.pid ~= 0 and state.base ~= 0 and state.magic_bullet then
    pcall(write_uint, state.base + RVA.magicbullet, MAGIC_BULLET_OFF, 1)
  end
end
 
function silent_tick(pid, base)
  if not state.silent_enabled then
    release_silent_lock(pid)
    state.silent_last_rounds = 0
    return
  end
  local was_armed = state.silent_armed
  local ok, err = pcall(function()
    local lp = get_localplayer()
    if lp == 0 then release_silent_lock(pid); return end
    local aim = read_uint(lp + OFF.aimCtrl, 8)
    if aim == 0 then release_silent_lock(pid); return end
    local target = find_silent_target(state.entities, state.viewproj, state.window_rect)
    if target then
      if state.silent_target_ptr ~= target.entity_ptr then
        state.silent_target_ptr, state.silent_shots = target.entity_ptr, 0
      end
      local tp = aim_point_for(target)
      if tp then
        local aim_addr, aim_bytes = aim + OFF.worldAimPos, pack_vec3(tp)
        if state.silent_lock_addr and state.silent_lock_addr ~= aim_addr then
          pcall(memory.unlock, LOCK_ID.silent); state.silent_lock_addr = nil
        end
        local lock_ok, lock_result = pcall(memory.lock, LOCK_ID.silent, pid, aim_addr, aim_bytes)
        lock_ok = lock_ok and lock_result ~= false
        local wrote = lock_ok
        if lock_ok then
          state.silent_lock_addr = aim_addr
        else
          local unlocked, unlock_result = pcall(memory.unlock, LOCK_ID.silent)
          if not unlocked or unlock_result == false then release_silent_lock(pid); return end
          state.silent_lock_addr = nil
          for _ = 1, 10 do
            local write_ok, write_err = pcall(memory.write_bytes, pid, aim_addr, aim_bytes)
            if not write_ok or write_err == false then report_memory_error("silent aim write", write_err); break end
            wrote = true
          end
        end
        if not wrote then release_silent_lock(pid); return end
        state.diag_last_write = { tp[1], tp[2], tp[3] }
        state.silent_armed = true
        state.silent_mode = lock_ok and "lock" or "write"
        local aim_label = (state.dynamic_aim or state.aim_part == "dynamic") and "dynamic" or state.aim_part
        state.silent_target_name = string.format("%s %.0fm", aim_label, target.dist)
      end
    else
      release_silent_lock(pid)
      state.silent_target_name, state.silent_target_ptr = "", nil
    end
    if not was_armed then state.diag_last_write = nil end
    local weapon = resolve_rpm_target(lp)
    if weapon ~= state.silent_weapon_ptr then state.silent_weapon_ptr, state.silent_last_rounds = weapon, 0 end
    local rounds = read_uint(aim + OFF.combatAimRoundsFired, 4)
    local delta = (rounds >= state.silent_last_rounds) and (rounds - state.silent_last_rounds) or 0
    state.silent_last_rounds = rounds
    if delta > 0 then state.silent_shots = state.silent_shots + delta end
    if state.magic_bullet then
      local on = state.silent_armed and state.silent_target_ptr and target and is_silent_target(target) or false
      write_uint(base + RVA.magicbullet, on and MAGIC_BULLET_ON or MAGIC_BULLET_OFF, 1)
    end
  end)
  if not ok then release_silent_lock(pid); state.status = "Silent: " .. tostring(err) end
end
 
function dbg_refresh()
  state.telem_valid, state.telem_world_aim, state.telem_lock_target, state.telem_delta = false, nil, nil, nil
  state.telem_rounds, state.telem_lock_addr = 0, nil
  state.dbg_lp_pos, state.dbg_bone0, state.dbg_err = nil, nil, nil
  if state.pid == 0 or state.base == 0 then return end
  local lp = get_localplayer()
  if lp == 0 then return end
  local raw = read_bytes_table(lp + OFF.entityPos, 12)
  if #raw >= 12 then
    state.dbg_lp_pos = { from_f32(uint_from(raw, 1, 4)), from_f32(uint_from(raw, 5, 4)), from_f32(uint_from(raw, 9, 4)) }
  end
  local bb_ok, bb_raw = pcall(memory.batch_read, state.pid, 8, { lp + OFF.bonesBase })
  if not bb_ok then report_memory_error("debug batch read", bb_raw); bb_raw = nil end
  local bb_bytes = bb_raw and to_byte_table(bb_raw) or nil
  local bb = (bb_bytes and #bb_bytes >= 8) and uint_from(bb_bytes, 1, 8) or 0
  if bb ~= 0 then
    local ba_ok, ba_raw = pcall(memory.batch_read, state.pid, 8, { bb + OFF.boneArray })
    if not ba_ok then report_memory_error("debug batch read", ba_raw); ba_raw = nil end
    local ba_bytes = ba_raw and to_byte_table(ba_raw) or nil
    local ba = (ba_bytes and #ba_bytes >= 8) and uint_from(ba_bytes, 1, 8) or 0
    if ba ~= 0 then
      local m0 = read_bytes_table(ba + BONE_POS_OFF, 12)
      if #m0 >= 12 then
        state.dbg_bone0 = { from_f32(uint_from(m0, 1, 4)), from_f32(uint_from(m0, 5, 4)), from_f32(uint_from(m0, 9, 4)) }
      end
    end
  end
  local aimp = read_uint(lp + OFF.aimCtrl, 8)
  if aimp == 0 then return end
  state.telem_lock_addr = state.silent_lock_addr
  state.telem_rounds = read_uint(aimp + OFF.combatAimRoundsFired, 4)
  state.telem_world_aim = read_world_aim(aimp)
  if state.silent_armed and state.silent_lock_addr then state.telem_lock_target = state.diag_last_write end
  if state.telem_world_aim and state.telem_lock_target then
    local p, wd = state.telem_world_aim, state.telem_lock_target
    local dx, dy, dz = p[1] - wd[1], p[2] - wd[2], p[3] - wd[3]
    state.telem_delta = math.sqrt(dx * dx + dy * dy + dz * dz)
  end
  state.telem_valid = true
end
 
function OnStart()
  pcall(read_cfg_into_state)
  load_presets_from_file()
end
 
function OnDestroy()
  pcall(flush_pending_offsets)
  pcall(write_cfg_to_memory, true)
  local restore_sway, restore_range, restore_move = state.no_sway, state.extended_range, state.move_speed
  state.esp_enabled, state.silent_enabled, state.rpm_enabled, state.instant_reload = false, false, false, false
  state.no_sway, state.extended_range, state.move_speed = false, false, false
  state._last_arr_ptr, state._last_count, state._last_ptrs = 0, 0, nil
  state._was_attached = false
  state._transition_frames = 0
  local alive = false
  if state.pid ~= 0 and state.base ~= 0 then alive = (process_is_alive(state.pid, state.base) == true) end
  if state.pid ~= 0 then release_owned_locks() end
  if state.pid ~= 0 and alive then
    pcall(restore_rpm)
    pcall(restore_fragile_armor)
    pcall(restore_headshot_damage)
    if restore_sway then pcall(apply_no_sway) end
    if restore_range then pcall(apply_extended_range) end
    if restore_move then pcall(apply_move_speed) end
    pcall(write_f32, state.base + RVA.recoil, DEFAULT_RECOIL)
    pcall(write_f32, state.base + RVA.spread, DEFAULT_SPREAD)
    pcall(write_uint, state.base + RVA.magicbullet, MAGIC_BULLET_OFF, 1)
    pcall(apply_time, "normal")
    state.no_spread = false
    pcall(apply_spread)
  end
  reset_weapon_cache()
end
 
function check_hotkey(bind_key, state_key, apply_fn, label_name)
  if type(bind_key) == "string" and bind_key ~= "" then
    local ok, pressed = pcall(keyboard.is_key_press, bind_key)
    if ok and pressed then
      state[state_key] = not state[state_key]
      if apply_fn then pcall(apply_fn) end
      if label_name then show_splash(string.format("%s: %s", label_name, state[state_key] and "ON" or "OFF")) end
    end
  end
end
 
local function get_active_boneless_target()
  local target_ptr = state.silent_target_ptr or state.selected_target_ptr
  if target_ptr then
    for _, e in ipairs(state.entities or {}) do
      if e.entity_ptr == target_ptr and is_boneless_profile(profile_name_for(e)) then return e end
    end
  end
  local t = find_silent_target(state.entities, state.viewproj, state.window_rect)
  return (t and is_boneless_profile(profile_name_for(t))) and t or nil
end
 
local function get_boneless_offset_target()
  local target = get_active_boneless_target()
  if target then return target end
  local wr, matrix = normalize_window_rect(state.window_rect), state.viewproj
  if not matrix or not wr or not wr.width or not wr.height then return nil end
  local cx, cy = wr.x + wr.width / 2, wr.y + wr.height / 2
  local best_dist_sq = math.huge
  for _, e in ipairs(state.entities or {}) do
    if e and not e.is_player and not e.is_local_player and not e.is_downed
      and (not e.archetype or not ARCHETYPE_WILDLIFE[e.archetype]) and is_boneless_profile(profile_name_for(e)) then
      local sx, sy = world_to_screen(e.pos, matrix, wr)
      if sx and sy and sx >= wr.x and sx <= wr.x + wr.width and sy >= wr.y and sy <= wr.y + wr.height then
        local dist_sq = (sx - cx) * (sx - cx) + (sy - cy) * (sy - cy)
        if dist_sq < best_dist_sq then best_dist_sq, target = dist_sq, e end
      end
    end
  end
  return target
end
 
function toggle_boneless_aim_profile_filter()
  local target = get_active_boneless_target()
  if not target then target = find_silent_target(state.entities, state.viewproj, state.window_rect, true, true) end
  local name = target and nonskeleton_target_name(target) or state.last_boneless_aim_filter
  if not name or name == "" then
    show_splash("Aim at a boneless target first")
    return
  end
  local ignored = not boneless_aim_profile_is_ignored_name(name)
  state.boneless_aim_ignored[name] = ignored
  state.last_boneless_aim_filter = name
  if config then
    local saved, reason = store_config({[CFG_PREFIX .. "ignore_" .. nonskeleton_readable_key(name)] = ignored})
    if not saved then show_splash("Aim filter is session only: " .. tostring(reason)); return end
  end
  show_splash(string.format("Aim lock %s: %s", ignored and "OFF" or "ON", name))
end
 
local function adjust_nonskeleton_camera(dx, dy)
  local target = get_boneless_offset_target()
  if not target then show_splash("Select a bone-less target first"); return end
  if not state.boneless_override then show_splash("Enable boneless aim override first"); return end
  local name = nonskeleton_offset_profile(target)
  if not name then show_splash("Target position unavailable"); return end
  local offsets = get_nonskeleton_offset(name)
  local point = {target.pos[1] + offsets.x, target.pos[2] + offsets.y, target.pos[3] + offsets.z}
  local delta = screen_delta_to_world(point, dx, dy, state.viewproj, normalize_window_rect(state.window_rect))
  if not delta then show_splash("Cannot adjust: invalid projection"); return end
  local next_offset = {x=offsets.x+delta[1], y=offsets.y+delta[2], z=offsets.z+delta[3]}
  for _, axis in ipairs({"x", "y", "z"}) do
    if math.abs(next_offset[axis]) > NONSKELETON_AIM_LIMIT_WORLD then
      show_splash("Boneless offset limit reached"); return
    end
  end
  offsets.x, offsets.y, offsets.z = next_offset.x, next_offset.y, next_offset.z
  save_nonskeleton_offset(name, offsets)
  show_splash(string.format("World offset X %+.1f Y %+.1f Z %+.1f", offsets.x, offsets.y, offsets.z))
end
function adjust_nonskeleton_target(dx, dy)
  adjust_nonskeleton_camera(dx, dy)
end
function move_nonskeleton_depth(toward, target)
  target = target or get_boneless_offset_target()
  if not target then show_splash("Select a bone-less target first"); return end
  if not state.boneless_override then show_splash("Enable boneless aim override first"); return end
  local matrix = state.viewproj
  local window = normalize_window_rect(state.window_rect)
  if not matrix or not window then show_splash("Cannot move depth: camera unavailable"); return end
 
  local forward = {matrix[4], matrix[8], matrix[12]}
  if not is_finite(forward[1]) or not is_finite(forward[2]) or not is_finite(forward[3]) then
    show_splash("Cannot move depth: invalid camera direction"); return
  end
  local length = math.sqrt(nonskeleton_dot(forward, forward))
  if not is_finite(length) or length < 1e-10 then
    show_splash("Cannot move depth: invalid camera direction"); return
  end
 
  local name = nonskeleton_offset_profile(target)
  if not name then show_splash("Target position unavailable"); return end
  local offsets = get_nonskeleton_offset(name)
  local world_offset = {offsets.x, offsets.y, offsets.z}
  local legacy_shift
  if (offsets.zoom or 0) ~= 0 then
    local point = {target.pos[1] + offsets.x, target.pos[2] + offsets.y, target.pos[3] + offsets.z}
    legacy_shift = screen_delta_to_world(point, 0, 0, matrix, window, -offsets.zoom)
    if not legacy_shift then show_splash("Cannot resolve previous depth. Reset target offsets to start over"); return end
  end
 
  local step, point = toward / length, {}
  for i = 1, 3 do
    local value = world_offset[i] + (legacy_shift and legacy_shift[i] or 0) - forward[i] * step
    if not is_finite(value) or math.abs(value) > NONSKELETON_AIM_LIMIT_WORLD + 1e-9 then
      show_splash("World offset limit. Reset or adjust X/Y/Z"); return
    end
    world_offset[i] = math.max(-NONSKELETON_AIM_LIMIT_WORLD, math.min(NONSKELETON_AIM_LIMIT_WORLD, value))
    point[i] = target.pos[i] + world_offset[i]
  end
  if not world_to_screen(point, matrix, window) then
    show_splash("Cannot move depth: point too close or invalid projection"); return
  end
 
  offsets.x, offsets.y, offsets.z, offsets.zoom = world_offset[1], world_offset[2], world_offset[3], 0
  save_nonskeleton_offset(name, offsets)
  show_splash(string.format("World offset X %+.1f Y %+.1f Z %+.1f", offsets.x, offsets.y, offsets.z))
end
 
local function apply_silent_toggle()
  if not state.silent_enabled then release_silent_lock(state.pid) end
end
 
local FEATURE_TOGGLES = {
  {"ESP","esp_enabled"}, {"Silent aim","silent_enabled",apply_silent_toggle}, {"Target gadgets","target_gadgets"},
  {"No recoil","no_recoil",apply_recoil}, {"No spread","no_spread",apply_spread},
  {"Magic bullet (NPC-only)","magic_bullet",apply_magic_bullet}, {"No sway","no_sway",apply_no_sway},
  {"No move spread","move_speed",apply_move_speed}, {"Extended range","extended_range",apply_extended_range},
  {"Instant reload","instant_reload"},
  {"Fragile enemy armor","fragile_armor",apply_fragile_armor},
  {"High headshot damage","high_headshot_dmg",apply_headshot_damage},
  {"RPM override","rpm_enabled",function() if state.rpm_enabled then rpm_tick() else restore_rpm() end end},
}
 
apply_preset_changes = function(previous)
  for _, item in ipairs(FEATURE_TOGGLES) do
    if item[3] and previous[item[2]] ~= state[item[2]] then pcall(item[3]) end
  end
  if state.rpm_enabled and previous.rpm_enabled == state.rpm_enabled and previous.rpm_value ~= state.rpm_value then
    pcall(rpm_tick)
  end
end
 
local HOTKEY_TOGGLES = {
  {KEY.ESP, "esp_enabled", nil, "ESP"},
  {KEY.ESP_PLAYERS, "esp_show_players", nil, "ESP Players"},
  {KEY.ESP_BOX, "esp_boxes", nil, "ESP Box"},
  {KEY.ESP_LOOT, "esp_loot", nil, "Loot ESP"},
  {KEY.ESP_BONES, "esp_bones", nil, "ESP Bones"},
  {KEY.SILENT, "silent_enabled", apply_silent_toggle, "Silent Aim"},
  {KEY.MAGIC_BULLET, "magic_bullet", apply_magic_bullet, "Magic Bullet"},
  {KEY.NO_RECOIL, "no_recoil", apply_recoil, "No Recoil"},
  {KEY.NO_SPREAD, "no_spread", apply_spread, "No Spread"},
  {KEY.INSTANT_RELOAD, "instant_reload", nil, "Instant Reload"},
  {KEY.NO_SWAY, "no_sway", apply_no_sway, "No Sway"},
  {KEY.MOVE_SPEED, "move_speed", apply_move_speed, "No Movement Spread"},
  {KEY.EXTENDED_RANGE, "extended_range", apply_extended_range, "Extended Range"},
  {KEY.SHOW_FOV, "esp_show_silent_fov", nil, "Show FOV"},
  {KEY.ESP_DISTANCE, "esp_distance", nil, "Distance"},
  {KEY.ESP_SNAPLINES, "esp_snaplines", nil, "Snaplines"},
  {KEY.ESP_BONE_IDS, "esp_bone_ids", nil, "Bone IDs"},
  {KEY.ESP_TYPE, "esp_type", nil, "Type"},
  {KEY.ESP_NAME, "esp_name", nil, "Name"},
  {KEY.CROSSHAIR, "crosshair_enabled", nil, "Crosshair"},
  {KEY.COUNTER_COLLAPSE, "counter_collapsed", nil, "Counter collapsed"},
}
 
function process_hotkeys()
  if not keyboard or not keyboard.is_key_press then return end
  if keyboard.is_key_press("Insert") then state.show_ui = not state.show_ui end
  if KEY.MASTER ~= "" and keyboard.is_key_press(KEY.MASTER) then set_master(not state.master_enabled) end
  if not state.master_enabled then return end
  for _, item in ipairs(HOTKEY_TOGGLES) do check_hotkey(item[1],item[2],item[3],item[4]) end
  local preset_keys = KEY.PRESETS
  for i = 1, 4 do
    if preset_keys[i] ~= "" and keyboard.is_key_press(preset_keys[i]) then load_preset_slot(i) end
  end
  if KEY.RPM ~= "" and keyboard.is_key_press(KEY.RPM) then
    state.rpm_enabled = not state.rpm_enabled
    if not state.rpm_enabled then pcall(restore_rpm) end
    show_splash(string.format("RPM Override: %s", state.rpm_enabled and "ON" or "OFF"))
  end
  if KEY.FOV_UP ~= "" and keyboard.is_key_press(KEY.FOV_UP) then
    state.silent_fov = math.min(800, state.silent_fov + 10); show_splash(string.format("FOV: %.0f", state.silent_fov))
  end
  if KEY.FOV_DOWN ~= "" and keyboard.is_key_press(KEY.FOV_DOWN) then
    state.silent_fov = math.max(10, state.silent_fov - 10); show_splash(string.format("FOV: %.0f", state.silent_fov))
  end
  if keyboard.is_key_press(KEY.NONSKELETON_UP) then adjust_nonskeleton_target(0, -NONSKELETON_AIM_STEP_PX) end
  if keyboard.is_key_press(KEY.NONSKELETON_LEFT) then adjust_nonskeleton_target(-2 * NONSKELETON_AIM_STEP_PX, 0) end
  if keyboard.is_key_press(KEY.NONSKELETON_DOWN) then adjust_nonskeleton_target(0, NONSKELETON_AIM_STEP_PX) end
  if keyboard.is_key_press(KEY.NONSKELETON_RIGHT) then adjust_nonskeleton_target(2 * NONSKELETON_AIM_STEP_PX, 0) end
  if keyboard.is_key_press(KEY.NONSKELETON_TOWARD) then move_nonskeleton_depth(NONSKELETON_WORLD_STEP) end
  if keyboard.is_key_press(KEY.NONSKELETON_AWAY) then move_nonskeleton_depth(-NONSKELETON_WORLD_STEP) end
  if KEY.BONELESS_AIM_FILTER ~= "" and keyboard.is_key_press(KEY.BONELESS_AIM_FILTER) then
    toggle_boneless_aim_profile_filter()
  end
  if KEY.RPM_UP ~= "" and keyboard.is_key_press(KEY.RPM_UP) then
    state.rpm_value = math.min(RPM_MAX, state.rpm_value + 50); show_splash(string.format("RPM: %d", state.rpm_value))
  end
  if KEY.RPM_DOWN ~= "" and keyboard.is_key_press(KEY.RPM_DOWN) then
    state.rpm_value = math.max(RPM_MIN, state.rpm_value - 50); show_splash(string.format("RPM: %d", state.rpm_value))
  end
  if KEY.AIM_PART ~= "" and keyboard.is_key_press(KEY.AIM_PART) then
    state.aim_part = (state.aim_part == "head") and "chest" or ((state.aim_part == "chest") and "pelvis" or "head")
    state.dynamic_aim = false
    show_splash(string.format("Aim Part: %s", state.aim_part:upper()))
  end
  if KEY.AIM_DYNAMIC ~= "" and keyboard.is_key_press(KEY.AIM_DYNAMIC) then
    if state.dynamic_aim or state.aim_part == "dynamic" then
      state.dynamic_aim = false
      if state.aim_part == "dynamic" then state.aim_part = state._prev_aim_part or "head" end
      show_splash("Dynamic Aim: OFF")
    else
      if state.aim_part ~= "dynamic" then state._prev_aim_part = state.aim_part end
      state.dynamic_aim = true
      show_splash("Dynamic Aim: ON")
    end
  end
end
 
function update_connection_state(dt)
  state.process_check_timer = (state.process_check_timer or 0) + (dt or 0)
  if state.pid ~= 0 and state.base ~= 0 and state.process_check_timer >= 2.0 then
    state.process_check_timer = 0
    local alive, reason = process_is_alive(state.pid, state.base)
    if alive == false then detach_stale_process(reason)
    elseif alive == nil then report_memory_error("process check", reason) end
  end
  if state.pid == 0 then
    state.attach_timer = state.attach_timer + (dt or 0)
    if state.attach_timer >= 2.0 then
      state.attach_timer = 0
      local ok, pid = pcall(memory.get_pid, state.name)
      if ok and pid and pid > 0 then
        local bok, base = pcall(memory.get_process_base, pid)
        if bok and is_valid_addr(base, 1) then
          state.pid, state.base, state.process_check_timer, state.walk_skip = pid, base, 0, 0
          state.status = string.format("Attached PID %d 0x%X", state.pid, state.base)
        else
          report_memory_error("attach", bok and "process base unavailable" or base)
        end
      end
    end
  end
end
 
function process_hacks_and_stats(dt)
  sync_feature_locks(dt)
  if state.no_recoil then
    if not state.recoil_locked then
      pcall(apply_recoil)
    end
  end
  if state.no_spread then
    if not state.spread_rva_locked then
      pcall(apply_spread)
    end
    local ok, err = pcall(function()
      local lp = get_localplayer()
      if lp == 0 then return end
      local aim = read_uint(lp + OFF.aimCtrl, 8)
      if aim ~= 0 then ensure_spread_aim_locks(aim) end
    end)
    if not ok then state.status = "NoSpread aim lock: " .. tostring(err) end
  end
  if state.rpm_enabled then rpm_tick()
  elseif next(rpm_saved) then restore_rpm() end
  if state.instant_reload then instant_reload_tick() end
  if state.fragile_armor then fragile_armor_tick() end
  if not state.fragile_armor and next(armor_saved) then restore_fragile_armor() end
  if state.high_headshot_dmg then headshot_damage_tick() end
  if not state.high_headshot_dmg and next(headshot_saved) then restore_headshot_damage() end
  if state.no_sway then sway_tick() end
  if state.extended_range then extended_range_tick() end
  if state.move_speed and not teleport_guard() then move_speed_tick() end
  state.stats_timer = state.stats_timer + (dt or 0)
  if state.stats_timer >= 1.0 then
    state.stats_timer = 0
    pcall(refresh_stats)
    if not state.rpm_enabled then pcall(read_rpm_once) end
    if state.time_mode ~= "normal" then pcall(apply_time, state.time_mode) end
    state.selected_target_ptr = 0
    local w0 = normalize_window_rect(state.window_rect)
    local t = find_silent_target(state.entities, state.viewproj, w0)
    if t then state.selected_target_ptr = t.entity_ptr or 0 end
  end
end
 
local KEY_CLEAN_MAP = {
  Multiply = "Num *", Divide = "Num /", Decimal = "Num DEL", Add = "Num +", Subtract = "Num -",
  Numpad1 = "Num 1", Numpad2 = "Num 2", Numpad3 = "Num 3", Numpad4 = "Num 4", Numpad5 = "Num 5",
  Numpad6 = "Num 6", Numpad7 = "Num 7", Numpad8 = "Num 8", Numpad9 = "Num 9", Numpad0 = "Num 0",
  PageUp = "PgUp", PageDown = "PgDn", Insert = "Ins", Delete = "Del", Home = "Home", End = "End",
}
function clean_key_name(k)
  if not k or k == "" then return "" end
  return KEY_CLEAN_MAP[k] or k:upper()
end
 
local function int_slider(label, value, low, high, default, step)
  step = step or 1
  value = tonumber(value)
  if not is_finite(value) then value = default end
  value = math.max(low,math.min(high,math.floor(value / step + 0.5) * step))
  local edited = select(1,ui.slider_i32(label,value,low,high))
  edited = tonumber(edited)
  if not is_finite(edited) then edited = value end
  return math.max(low,math.min(high,math.floor(edited / step + 0.5) * step))
end
 
function draw_overlays(dt)
  local w0 = normalize_window_rect(state.window_rect) or { x = 0, y = 0, width = 1920, height = 1080 }
  draw_crosshair(w0)
  draw_entity_counter(w0)
  if state.splash_timer and state.splash_timer > 0 then
    state.splash_timer = state.splash_timer - (dt or 0)
    local cx, cy = w0.x + w0.width / 2, w0.y + 35
    local txt = state.splash_text or ""
    local tw = #txt * 18
    local box_w, box_h = tw + 60, 70
    local box_x, box_y = cx - box_w / 2, cy
    local tr, tg, tb = 255, 255, 100
    if txt:find("ON") then tr, tg, tb = 0, 255, 100
    elseif txt:find("OFF") then tr, tg, tb = 255, 80, 80 end
    pcall(function()
      draw.filled_rect(box_x, box_y, box_w, box_h, 0, 0, 0, 180)
      draw.text(box_x + (box_w - tw) / 2, box_y + (box_h - 32) / 2 - 6, txt, tr, tg, tb, 255, 32)
    end)
  end
  if state.show_ui then
    ui.window("TD2", function()
      if state.pid ~= 0 then ui.monospace(string.format("PID %d | Base 0x%X", state.pid, state.base))
      else ui.small("Not attached - auto-search every 2s") end
      ui.separator()
      ui.scroll_area(580, function()
        ui.collapsing_header("Config", function()
          if state.config_error then ui.small("Config: " .. state.config_error) end
          chk("Show shortcut HUD", "show_info_overlay")
          ui.separator(); ui.monospace("Presets")
          for i = 1, 4 do
            if ui.checkbox("Preset " .. i, state.active_preset == i) then state.active_preset = i end
          end
          ui.separator()
          if ui.button("Load Preset") then load_preset_slot(state.active_preset) end
          if ui.button("Save Preset") then save_current_to_preset(state.active_preset) end
        end)
        ui.collapsing_header("Toggles", function()
          local mv, mv_ch = ui.checkbox("Master (" .. clean_key_name(KEY.MASTER) .. ")", state.master_enabled)
          if mv_ch then set_master(mv) end
          ui.separator()
          for _, item in ipairs(FEATURE_TOGGLES) do chk(item[1],item[2],item[3]) end
        end)
        ui.collapsing_header("Silent Aim Settings", function()
          ui.monospace("Target part")
          if checkbox_edge("Head", not state.dynamic_aim and state.aim_part == "head") then state.aim_part = "head"; state.dynamic_aim = false end
          if checkbox_edge("Chest", not state.dynamic_aim and state.aim_part == "chest") then state.aim_part = "chest"; state.dynamic_aim = false end
          if checkbox_edge("Pelvis", not state.dynamic_aim and state.aim_part == "pelvis") then state.aim_part = "pelvis"; state.dynamic_aim = false end
          local dynamic_value, dynamic_changed = ui.checkbox(
            "Dynamic", state.dynamic_aim or state.aim_part == "dynamic")
          if dynamic_changed then
            if dynamic_value then
              if state.aim_part ~= "dynamic" then state._prev_aim_part = state.aim_part end
              state.dynamic_aim = true
            else
              state.dynamic_aim = false
              if state.aim_part == "dynamic" then
                state.aim_part = state._prev_aim_part or "head"
              end
            end
          end
          ui.small("Current: " .. ((state.dynamic_aim or state.aim_part == "dynamic") and "dynamic" or state.aim_part))
          ui.separator()
          state.target_marker_size = math.max(1,
            math.min(10, tonumber(state.target_marker_size) or 4))
          state.target_marker_size = select(1,
            ui.slider_f32("Target Marker Size", state.target_marker_size, 1, 10))
          state.target_marker_size = math.max(1,
            math.min(10, tonumber(state.target_marker_size) or 4))
          state.silent_fov = select(1, ui.slider_f32("FOV", state.silent_fov, 10, 800))
          state.silent_max_dist = select(1, ui.slider_f32("Max Distance", state.silent_max_dist, 10, 200))
          chk("Show FOV circle", "esp_show_silent_fov")
          chk("Enemy Summons", "silent_target_summon")
          chk("360 Silent Aim (no FOV fallback limit)", "silent_360")
          chk("Target Friendlies", "silent_target_friendly")
          ui.separator()
          ui.small("Target: " .. (state.silent_target_name ~= "" and state.silent_target_name or "none"))
          ui.small(state.silent_armed and (state.silent_mode == "lock" and "ARMED (kernel lock)" or "ARMED (direct write fallback)") or "idle")
          ui.small("Shots: " .. state.silent_shots)
        end)
        ui.collapsing_header("ESP settings", function()
          ui.monospace("Visuals")
          chk("Boxes", "esp_boxes"); chk("Distance", "esp_distance"); chk("Snap lines", "esp_snaplines")
          chk("Bones", "esp_bones"); chk("Bone IDs", "esp_bone_ids")
          ui.small("Bone IDs dumps all 0..90 bones (slow, debug only)")
          chk("Type", "esp_type"); chk("Name", "esp_name")
          state.esp_text_size = int_slider("ESP Text Size",state.esp_text_size,6,20,10)
          ui.separator(); ui.monospace("Filters")
          chk("Hostile", "esp_show_hostile"); chk("Players", "esp_show_players"); chk("Other", "esp_show_other")
          chk("Friendly", "esp_show_friendly"); chk("Wildlife", "esp_show_wildlife"); chk("Neutral", "esp_show_neutral")
          chk("Caches", "esp_show_caches")
          chk("Relation", "esp_show_relation"); chk("Faction", "esp_show_faction")
          chk("Entity Counter", "show_entity_counter")
          if state.show_entity_counter then
            chk("Counter collapsed", "counter_collapsed")
            state.counter_x = int_slider("Counter X", state.counter_x, 0, 1800, 12)
            state.counter_y = int_slider("Counter Y", state.counter_y, 0, 1000, 12)
          end
          chk("[TEST] Desc A/T", "esp_desc_test")
          state.esp_max_dist = select(1, ui.drag_value_u64("Max Distance", state.esp_max_dist))
          state.esp_max_dist = math.max(10, math.min(200, math.floor(tonumber(state.esp_max_dist) or 150)))
          ui.small(string.format("Entities: %d  Projection: %s", #state.entities, state.viewproj and "OK" or "none"))
          if state.scan_info ~= "" then ui.code(state.scan_info) end
        end)
        ui.collapsing_header("Loot ESP", function()
          chk("Enable loot ESP", "esp_loot")
          state.loot_text_size = int_slider("Text Size",state.loot_text_size,6,20,10)
          state.loot_max_dist = int_slider("Max Distance (m)",state.loot_max_dist,10,150,150,10)
          ui.monospace("Loot groups (all rarities)")
          state.draw_loot_group_filter("Mods", 1)
          state.draw_loot_group_filter("Weapons", 2)
          state.draw_loot_group_filter("Gear", 4)
          state.draw_loot_group_filter("Others / unidentified", 8)
          state.draw_loot_details_ui()
          ui.small("Others includes caches, keys, materials, Bounty and unidentified loot.")
          ui.separator(); ui.monospace("Rarity filters")
          chk("R0 Mixed Loot", "loot_show_r0"); chk("R1 Access Key", "loot_show_r1"); chk("R2 Bounty", "loot_show_r2")
          chk("R3 Green Material", "loot_show_r3"); chk("R4 Blue Material", "loot_show_r4"); chk("R5 Superior", "loot_show_r5")
          chk("R6 High-End", "loot_show_r6"); chk("R7 Event Key", "loot_show_r7"); chk("R8 Gear Set", "loot_show_r8")
          chk("R9 Exotic", "loot_show_r9"); chk("R11 Prototype", "loot_show_r11"); chk("Other R values", "loot_show_other")
          ui.small(string.format("Visible markers: %d", #(state.loot_items or {})))
          if state.loot_scan_error then ui.small("Loot scan: " .. state.loot_scan_error) end
        end)
        ui.collapsing_header("RPM settings", function()
          local sv, slider_changed = ui.slider_f32("RPM", state.rpm_value, RPM_MIN, RPM_MAX)
          sv = tonumber(sv)
          if slider_changed ~= false and is_finite(sv) then
            state.rpm_value = math.max(RPM_MIN, math.min(RPM_MAX, math.floor(sv + 0.5)))
          end
          local exact, exact_changed = ui.drag_value_i32("Exact Value", state.rpm_value)
          exact = tonumber(exact)
          if exact_changed ~= false and is_finite(exact) then state.rpm_value = math.floor(exact + 0.5) end
          sanitize_rpm_value()
          ui.small(string.format("live %.0f  target %d", state.rpm_live, state.rpm_value))
          if ui.button("Read RPM") then pcall(read_rpm_once) end
          if state.rpm_template_live then ui.small("Original template RPM: " .. state.rpm_template_live) end
          if state.rpm_error then ui.small("RPM: " .. state.rpm_error) end
        end)
        ui.collapsing_header("Crosshair Settings", function()
          chk("Show Crosshair", "crosshair_enabled")
          chk("Only while RMB held", "crosshair_hold_rmb")
          ui.label("Crosshair Color")
          local r, g, b, a, changed = ui.color_edit_button_srgba(state.crosshair_r, state.crosshair_g, state.crosshair_b, state.crosshair_alpha)
          if changed then state.crosshair_r, state.crosshair_g, state.crosshair_b, state.crosshair_alpha = r, g, b, a end
          chk("Circle Center Dot", "crosshair_dot")
          chk("Black Outline", "crosshair_outline")
          local v = tonumber((ui.slider_f32("Crosshair Length", state.crosshair_size, 2, 60)))
          if is_finite(v) then state.crosshair_size = math.max(2, math.min(60, v)) end
          v = tonumber((ui.slider_f32("Crosshair Gap", state.crosshair_gap, 0, 40)))
          if is_finite(v) then state.crosshair_gap = math.max(0, math.min(40, v)) end
          v = tonumber((ui.slider_f32("Crosshair Thickness", state.crosshair_thick, 1, 10)))
          if is_finite(v) then state.crosshair_thick = math.max(1, math.min(10, v)) end
          v = tonumber((ui.slider_f32("Center Dot Radius", state.crosshair_dot_size, 1, 10)))
          if is_finite(v) then state.crosshair_dot_size = math.max(1, math.min(10, v)) end
        end)
        ui.collapsing_header("Boneless Aim", function()
          if state.offset_save_error then ui.small(state.offset_save_error) end
          chk("Boneless aim override", "boneless_override")
          ui.small("Saved DestructibleProp locations also apply with Override OFF.")
          ui.small(clean_key_name(KEY.BONELESS_AIM_FILTER) .. ": toggle aim lock for current boneless target type")
          local offset_target = get_boneless_offset_target()
          local offset_name, location_scoped
          if offset_target then offset_name, location_scoped = nonskeleton_offset_profile(offset_target) end
          ui.separator(); ui.monospace("Boneless target offsets")
          if offset_name then
            ui.small("Offsets: " .. offset_name)
            if state.boneless_override then
              local offsets = get_nonskeleton_offset(offset_name)
              ui.small("Toward / Away moves the aim point in world space along the camera's forward axis.")
              local changed_any = false
              for _, axis in ipairs({ "x", "y", "z" }) do
                local shown = math.floor(offsets[axis] * 10 + 0.5) / 10
                local value, changed = ui.slider_f32("World " .. axis:upper(), shown, -NONSKELETON_AIM_LIMIT_WORLD, NONSKELETON_AIM_LIMIT_WORLD)
                if changed and is_finite(value) then
                  value = math.floor(value * 10 + 0.5) / 10
                  value = math.max(-NONSKELETON_AIM_LIMIT_WORLD, math.min(NONSKELETON_AIM_LIMIT_WORLD, value))
                  if value ~= offsets[axis] then offsets[axis] = value; changed_any = true end
                end
              end
              if changed_any then save_nonskeleton_offset(offset_name, offsets) end
              if ui.button("Toward (Num4)") then move_nonskeleton_depth(NONSKELETON_WORLD_STEP, offset_target) end
              if ui.button("Away (Num6)") then move_nonskeleton_depth(-NONSKELETON_WORLD_STEP, offset_target) end
              if location_scoped and ui.button("Use previous prop offset here") then
                local previous = get_nonskeleton_offset(DESTRUCTIBLE_PROP_PROFILE)
                offsets.x, offsets.y, offsets.z, offsets.zoom = previous.x, previous.y, previous.z, previous.zoom
                save_nonskeleton_offset(offset_name, offsets)
              end
              if ui.button("Reset target offsets") then
                local defaults = BONELESS_OFFSET_DEFAULTS[offset_name] or {}
                offsets.x, offsets.y, offsets.z, offsets.zoom = defaults.x or 0, defaults.y or 0, defaults.z or 0, 0
                save_nonskeleton_offset(offset_name, offsets)
              end
              ui.small(string.format("World offset XYZ: %.1f, %.1f, %.1f", offsets.x, offsets.y, offsets.z))
            else
              local offsets = effective_boneless_offset(offset_target)
              if offsets then
                ui.small(string.format("Location offset XYZ: %.1f, %.1f, %.1f", offsets.x, offsets.y, offsets.z))
              end
            end
            local point = aim_point_for(offset_target)
            ui.small(string.format("Aim point XYZ: %.1f, %.1f, %.1f", point[1], point[2], point[3]))
          else
            ui.small("No visible bone-less target; offset controls are ready when one appears")
          end
          ui.small("Num5/2: up/down, Num1/3: left/right, Num4/6: toward/away (0.2 m)")
        end)
        ui.collapsing_header("Player", function()
          ui.label("Name: " .. (state.lp_name ~= "" and state.lp_name or "?"))
          ui.label(string.format("HP: %d / %d", state.hp, state.hp_max))
          ui.label(string.format("Armor: %d / %d", state.armor, state.armor_max))
          ui.small("Auto-refresh: 1s")
        end)
        ui.collapsing_header("World", function()
          ui.monospace("Time of day")
          if checkbox_edge("Noon", state.time_mode == "noon") then pcall(apply_time, "noon") end
          if checkbox_edge("Night", state.time_mode == "night") then pcall(apply_time, "night") end
          if checkbox_edge("Normal", state.time_mode == "normal") then pcall(apply_time, "normal") end
          ui.small("Current: " .. state.time_mode)
        end)
        ui.collapsing_header("Debug", function()
          local ok, err = pcall(dbg_refresh)
          if not ok then state.dbg_err = tostring(err) end
          if state.memory_error then ui.small(state.memory_error) end
          ui.monospace("RVA read")
          state.read_rva = select(1, ui.text_edit(state.read_rva, false, false, false))
          state.read_size = select(1, ui.drag_value_u64("Size", state.read_size))
          if ui.button("Read") then
            local rva = tonumber(state.read_rva)
            if rva and state.pid ~= 0 then
              local okr, data = pcall(memory.read_rva, state.pid, rva, math.min(math.max(state.read_size, 1), 256))
              if okr and data then
                local bytes, n = to_byte_table(data)
                local hex = {}
                for i = 1, n do hex[i] = string.format("%02X", bytes[i]) end
                state.read_result = table.concat(hex, " ")
              else
                state.read_result = "read failed"
              end
            end
          end
          ui.code(state.read_result); ui.separator(); ui.monospace("Silent aim live")
          if state.telem_valid then
            local p, wd = state.telem_world_aim, state.telem_lock_target
            ui.small(p and string.format("worldAimPos %.2f %.2f %.2f", p[1], p[2], p[3]) or "worldAimPos -")
            ui.small(wd and string.format("lock target %.2f %.2f %.2f", wd[1], wd[2], wd[3]) or "lock target -")
            ui.small(state.telem_delta and string.format("delta %.3f  %s", state.telem_delta, state.telem_delta < SILENT_LOCK_DELTA and "LOCKED OK" or "RACE") or "delta -")
            ui.small(string.format("Lock address: %s", state.telem_lock_addr and string.format("0x%X", state.telem_lock_addr) or "none"))
            ui.small(string.format("Rounds fired: %d  Shots: %d", state.telem_rounds, state.silent_shots))
          else
            ui.small("telemetry unavailable")
          end
          ui.separator(); ui.monospace("Position Debug")
          if state.dbg_err then ui.small("Error: " .. state.dbg_err) end
          ui.small(state.dbg_lp_pos and string.format("Player Pos %.3f %.3f %.3f", state.dbg_lp_pos[1], state.dbg_lp_pos[2], state.dbg_lp_pos[3]) or "Player Pos -")
          ui.small(state.dbg_bone0 and string.format("Bone0 Pos %.3f %.3f %.3f", state.dbg_bone0[1], state.dbg_bone0[2], state.dbg_bone0[3]) or "Bone0 Pos -")
          ui.separator(); ui.monospace("Entity factions")
          local facs, fac_tags = {}, {}
          for _, ent in ipairs(state.entities) do
            local f = ent.faction
            if f and f ~= 0 then
              facs[f] = (facs[f] or 0) + 1
              if fac_tags[f] == nil then fac_tags[f] = ent.faction_tag or "" end
            end
          end
          local fkeys = {}
          for f in pairs(facs) do fkeys[#fkeys + 1] = f end
          if #fkeys == 0 then
            ui.small("none")
          else
            table.sort(fkeys, function(a, b) return (facs[a] ~= facs[b]) and (facs[a] > facs[b]) or (a < b) end)
            local parts = {}
            for i, f in ipairs(fkeys) do
              local rawtag = fac_tags[f] or ""
              parts[i] = string.format("%s(%s)×%d", faction_display_en(f, rawtag), rawtag ~= "" and rawtag or "?", facs[f])
            end
            ui.code(table.concat(parts, "  "))
          end
        end)
      end)
      ui.separator(); ui.small(state.status)
    end)
  end
  if state.show_ui and state.show_info_overlay then
    local layout = HUD_PANEL_LAYOUT
    local w0 = normalize_window_rect(state.window_rect) or { x = 0, y = 0, width = 1920, height = 1080 }
    local cols_w = layout.padding_left + layout.function_column_width + layout.status_column_width + layout.shortcut_column_width + layout.padding_right
    local box_w, box_h = math.max(layout.width, cols_w), layout.height
    local box_x, box_y = w0.x + w0.width - box_w - layout.margin_right, w0.y + layout.margin_top
    pcall(function()
      draw.filled_rect(box_x, box_y, box_w, box_h, 0, 0, 0, layout.background_alpha)
      if layout.border_enabled then draw.rect(box_x, box_y, box_w, box_h, 200, 200, 200, 220, 1.0) end
      local label_x = box_x + layout.padding_left
      local stat_x = label_x + layout.function_column_width
      local shortcut_x = stat_x + layout.status_column_width
      local ty = box_y + layout.padding_top
      draw.text(label_x, ty, "FUNCTION", 255, 220, 100, 255, layout.column_header_font)
      draw.text(stat_x, ty, "STATUS", 255, 220, 100, 255, layout.column_header_font)
      draw.text(shortcut_x, ty, "HOTKEY", 255, 220, 100, 255, layout.column_header_font)
      ty = ty + layout.column_header_height
      draw.line(label_x, ty, box_x + box_w - layout.padding_right, ty, 200, 200, 200, 150, 1.0)
      ty = ty + layout.column_header_gap
      local function draw_cat(title)
        draw.text(label_x, ty, title, 100, 200, 255, 255, layout.section_font)
        ty = ty + layout.section_height
      end
      local function draw_row(label, val_str, is_active, key_name)
        local k_str = ""
        if type(key_name) == "table" then
          local keys = {}
          for _, k in ipairs(key_name) do
            local c = clean_key_name(k); if c ~= "" then keys[#keys + 1] = c end
          end
          k_str = table.concat(keys, " / ")
        else
          k_str = clean_key_name(key_name)
        end
        draw.text(label_x, ty, label .. ":", 220, 220, 220, 255, layout.row_font)
        local r, g, b = 255, 255, 255
        if is_active == true then r, g, b, val_str = 0, 255, 100, "ON"
        elseif is_active == false then r, g, b, val_str = 255, 80, 80, "OFF"
        elseif val_str ~= nil then r, g, b = 255, 255, 100 end
        draw.text(stat_x, ty, val_str or "", r, g, b, 255, layout.row_font)
        if k_str ~= "" then draw.text(shortcut_x, ty, k_str, 0, 255, 255, 255, layout.row_font) end
        ty = ty + layout.row_height
      end
      local preset_keys = KEY.PRESETS
      draw_row("Master", nil, state.master_enabled, KEY.MASTER)
      for i = 1, 4 do
        local is_active = (state.active_preset == i)
        draw.text(label_x, ty, "Preset " .. i .. ":", is_active and 0 or 220, is_active and 255 or 220, is_active and 100 or 220, 255, layout.row_font)
        if is_active then draw.text(stat_x, ty, "Active", 0, 255, 100, 255, layout.row_font) end
        local ks = clean_key_name(preset_keys[i])
        if ks ~= "" then draw.text(shortcut_x, ty, ks, 0, 255, 255, 255, layout.row_font) end
        ty = ty + layout.row_height
      end
      draw_cat("--- FEATURES ---")
      draw_row("Silent Aim", nil, state.silent_enabled, KEY.SILENT)
      draw_row("Magic Bullet", nil, state.magic_bullet, KEY.MAGIC_BULLET)
      draw_row("RPM Override", nil, state.rpm_enabled, KEY.RPM)
      draw_row("RPM (+50 / -50)", string.format("%d / %.0f", state.rpm_value, state.rpm_live), nil, { KEY.RPM_UP, KEY.RPM_DOWN })
      draw_row("ESP", nil, state.esp_enabled, KEY.ESP)
      draw_row("No Recoil", nil, state.no_recoil, KEY.NO_RECOIL)
      draw_row("No Spread", nil, state.no_spread, KEY.NO_SPREAD)
      draw_row("Instant Reload", nil, state.instant_reload, KEY.INSTANT_RELOAD)
      draw_row("No Sway", nil, state.no_sway, KEY.NO_SWAY)
      draw_row("Crosshair", nil, state.crosshair_enabled, KEY.CROSSHAIR)
      draw_row("Time Mode", state.time_mode:upper(), nil, "")
      ty = ty + layout.section_gap
      draw_cat("--- SILENT AIM SETTINGS ---")
      local aim_lbl = (state.dynamic_aim or state.aim_part == "dynamic") and "DYNAMIC" or state.aim_part:upper()
      draw_row("Aim Part", aim_lbl, nil, KEY.AIM_PART)
      draw_row("Dynamic Aim", nil, state.dynamic_aim or state.aim_part == "dynamic", KEY.AIM_DYNAMIC)
      draw_row("Show FOV Circle", nil, state.esp_show_silent_fov, KEY.SHOW_FOV)
      draw_row("Target Marker Size", string.format("%.1f", state.target_marker_size), nil, "")
      draw_row("FOV (+10 / -10)", string.format("%.0f", state.silent_fov), nil, { KEY.FOV_UP, KEY.FOV_DOWN })
      ty = ty + layout.section_gap
      draw_cat("--- BONELESS AIM ---")
      draw_row("Boneless Override", nil, state.boneless_override, "")
      draw_row("Boneless Aim UP / DN", nil, nil, { KEY.NONSKELETON_UP, KEY.NONSKELETON_DOWN })
      draw_row("Boneless Aim L / R", nil, nil, { KEY.NONSKELETON_LEFT, KEY.NONSKELETON_RIGHT })
      draw_row("Boneless Toward / Away", nil, nil, { KEY.NONSKELETON_TOWARD, KEY.NONSKELETON_AWAY })
      local filter_state = state.last_boneless_aim_filter and state.boneless_aim_ignored[state.last_boneless_aim_filter]
      draw_row("Boneless Lock Filter", filter_state == nil and "Ready" or (filter_state and "Ignored" or "Allowed"), nil, KEY.BONELESS_AIM_FILTER)
      ty = ty + layout.section_gap
      draw_cat("--- ESP SETTINGS ---")
      draw_row("Loot ESP", nil, state.esp_enabled and state.esp_loot, KEY.ESP_LOOT)
      draw_row("ESP Box", nil, state.esp_boxes, KEY.ESP_BOX)
      draw_row("ESP Bones", nil, state.esp_bones, KEY.ESP_BONES)
      draw_row("Distance", nil, state.esp_distance, KEY.ESP_DISTANCE)
      draw_row("Snaplines", nil, state.esp_snaplines, KEY.ESP_SNAPLINES)
      draw_row("Type", nil, state.esp_type, KEY.ESP_TYPE)
      draw_row("Name", nil, state.esp_name, KEY.ESP_NAME)
      draw_row("Hostile", nil, state.esp_show_hostile, "")
      draw_row("Players", nil, state.esp_show_players, KEY.ESP_PLAYERS)
      draw_row("Other", nil, state.esp_show_other, "")
    end)
  end
end
 
-- LOOT SYSTEM
state.loot_rarity = {
  [0] = { "Mixed Loot", 245, 245, 245 }, [1] = { "Access Key", 255, 235, 145 },
  [2] = { "Bounty", 150, 150, 150 }, [3] = { "Material", 200, 245, 245 },
  [4] = { "Material", 200, 245, 245 }, [5] = { "Superior", 180, 70, 255 },
  [6] = { "High-End", 255, 220, 40 }, [7] = { "Event Key", 65, 145, 255 },
  [8] = { "Gear Set", 50, 190, 180 }, [9] = { "Exotic", 255, 85, 55 },
  [11] = { "Prototype", 220, 165, 255 },
}
 
local KNOWN_LOOT_R = { [0]=true,[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,[9]=true,[11]=true }
local LOOT_GROUP_BITS = {Mod=1, Weapon=2, Gear=4, Other=8}
state.loot_filter_enabled = function(rarity, family)
  local rarity_enabled
  if KNOWN_LOOT_R[rarity] then rarity_enabled = state["loot_show_r"..rarity] ~= false
  else rarity_enabled = state.loot_show_other ~= false end
  return rarity_enabled and state.loot_group_enabled(LOOT_GROUP_BITS[family] or 8)
end
 
state.loot_group_enabled = function(bit) return state[LOOT_GROUP_FIELDS[bit]] ~= false end
state.draw_loot_group_filter = function(label, bit)
  local field = LOOT_GROUP_FIELDS[bit]
  local value,changed = ui.checkbox(label,state[field])
  if changed then state[field] = value; save_config_now() end
end
state.classify_loot_family = function(name, internal_id)
  local id = string.lower(tostring(internal_id or "")):gsub("\\", "/"):match("([^/]+)$") or ""
  if id:match("^g_mod_") or id:match("^w_mod_") or id:match("^gear_mod_")
    or id:match("^weapon_mod_") or id:match("^player_gear_mod_") or id:match("^player_weapon_mod_")
    or id:match("^skill_mod_") or id:match("^skillmod_") or id:match("^player_skill_mod_") then
    return "Mod"
  end
  if id:match("^player_gear_") or id:match("^gear_") then return "Gear" end
  if id:match("^player_weapon_") or id:match("^weapon_") or id:match("^w_") then return "Weapon" end
  local title = string.lower(tostring(name or ""))
  if id == "" and (title:match("^offensive system:") or title:match("^offensive protocol:")) then
    return "Mod"
  end
  return "Other"
end
 
state.get_loot_details = function() return {state.loot_show_details,state.loot_show_names} end
state.set_loot_details = function(options)
  state.loot_show_details,state.loot_show_names = options[1],options[2]
  save_config_now()
end
state.draw_loot_details_ui = function()
  local current = state.get_loot_details()
  local detail,dc = ui.checkbox("Show gear slot / weapon type",current[1])
  local names,nc = ui.checkbox("Show gear / weapon names instead",current[2])
  if dc or nc then state.set_loot_details({detail,names}) end
end
state.clean_loot_name = function(value)
  if type(value) ~= "string" then return "" end
  local text = value:gsub("&lt;","<"):gsub("&gt;",">"):gsub("&quot;",'"'):gsub("&apos;", "'"):gsub("&amp;","&")
  text = text:gsub("<[^<>]*>","")
  text = text:gsub("%[([^%[%]]*)%]", function(body)
    local tag = body:lower():match("^/?([%a]+)")
    if tag == "color" or tag == "font" or tag == "size" or tag == "b" or tag == "i" or tag == "u" then return "" end
    return "["..body.."]"
  end)
  text = text:gsub("|[cC]%x%x%x%x%x%x%x%x",""):gsub("|[rR]","")
  text = text:gsub("%s+"," "):match("^%s*(.-)%s*$") or ""
  local lower = text:lower()
  if text:find("[%c<>]") or lower:find("/?color%s*[:=]") or lower:find("/color",1,true)
    or lower == "color" then return "" end
  local length = #text
  if utf8 and utf8.len then length = utf8.len(text) or 0 end
  if length < 3 or length > 128 or not text:find("[%w\128-\255]") then return "" end
  return text
end
local GEAR_SLOT_TOKENS = {
  mask="Mask",masks="Mask",chest="Chest",vest="Chest",bodyarmor="Chest",
  back="Backpack",backpack="Backpack",backpacks="Backpack",
  glove="Gloves",gloves="Gloves",holster="Holster",holsters="Holster",
  kneepads="Kneepads",kneepad="Kneepads",
}
state.loot_gear_slot = function(name,internal_id)
  local function find_slot(text)
    local found
    for token in tostring(text or ""):lower():gmatch("[%a]+") do
      local slot=GEAR_SLOT_TOKENS[token]
      if slot then
        if found and found~=slot then return nil end
        found=slot
      end
    end
    return found
  end
  local id=tostring(internal_id or ""):gsub("\\","/"):match("([^/]+)$") or ""
  return find_slot(id) or find_slot(state.clean_loot_name(name))
end
state.loot_display_label = function(name, internal_id, family)
  local options = state.get_loot_details()
  local clean_name = state.clean_loot_name(name)
  if family == "Mod" then
    local id = string.lower(tostring(internal_id or "")):gsub("\\","/"):match("([^/]+)$") or ""
    local title = clean_name:lower()
    local token_id = "_"..id:gsub("[^%w]","_").."_"
    local skill = id:match("^skill_mod_") or id:match("^skillmod_") or id:match("^player_skill_mod_")
    if skill then return "Skill Mod" end
    local gear = id:match("^g_mod_") or id:match("^gear_mod_") or id:match("^player_gear_mod_")
    local offensive = token_id:find("_offensive_",1,true) or title:match("^offensive%s")
    local defensive = token_id:find("_defensive_",1,true) or title:match("^defensive%s")
    local utility = token_id:find("_utility_",1,true) or title:match("^utility%s")
    if not options[1] then return (gear or offensive or defensive or utility) and "Gear Mod" or "Mod" end
    if offensive then return "Offensive Mod" end
    if defensive then return "Defensive Mod" end
    if utility then return "Utility Mod" end
    return gear and "Gear Mod" or "Mod"
  end
  if options[2] and clean_name ~= "" then return clean_name end
  local generic = family or "Other"
  if not options[1] then return generic end
  local id = string.lower(tostring(internal_id or "")):gsub("\\","/"):match("([^/]+)$") or ""
  if family == "Gear" then
    return state.loot_gear_slot(clean_name,id) or generic
  elseif family == "Weapon" then
    local kind = id:match("^player_weapon_([^_]+)_") or id:match("^weapon_([^_]+)_") or id:match("^w_([^_]+)_")
    local kinds = {ar="AR",smg="SMG",lmg="LMG",rifle="Rifle",mmr="MMR",shotgun="Shotgun",
      sg="Shotgun",pistol="Pistol",assaultrifle="AR",submachinegun="SMG",lightmachinegun="LMG",marksmanrifle="MMR"}
    return kinds[kind] or generic
  end
  return generic
end
state.exotic_loot_info = function(name,internal_id,family)
  local clean = state.clean_loot_name(name)
  local words = " "..(clean.." "..tostring(internal_id or "")):lower():gsub("[^%w]"," ").." "
  local cache = words:find(" cache ",1,true) or words:find(" caches ",1,true)
  local label
  if cache then family,label = "Other","Exotic Cache"
  elseif family == "Gear" then label = "Exotic Gear"
  elseif family == "Weapon" then
    label = "Exotic "..state.loot_display_label("",internal_id,"Weapon")
  elseif family == "Mod" then label = "Exotic Mod"
  else family,label = "Other","Exotic" end
  if state.get_loot_details()[2] and clean ~= "" and clean:lower() ~= label:lower() then
    label = label..": "..clean
  end
  return family,label
end
state.loot_marker_text = function(item,label)
  local count = tonumber(item.item_count) or 1
  local suffix = count > 1 and string.format(" x%d",count) or ""
  return string.format("%s%s  %.0fm",label,suffix,item.dist)
end
 
state.loot_text_is_plausible = function(text)
  return state.clean_loot_name(text) ~= ""
end
state.read_loot_sd_string = function(addr)
  if not is_valid_addr(addr,32) then return "" end
  local hdr,len = read_bytes_table(addr,32)
  if len < 32 then return "" end
  local size,cap = uint_from(hdr,17,8),uint_from(hdr,25,8)
  if size < 3 or size > 128 or cap < size or cap > 4096 then return "" end
  local bytes,read_len = hdr,len
  if cap > 15 then
    local ptr = uint_from(hdr,1,8)
    if not is_valid_addr(ptr,size) then return "" end
    bytes,read_len = read_bytes_table(ptr,size)
  end
  if read_len < size then return "" end
  local chars = {}
  for i=1,size do
    if bytes[i] == 0 then return "" end
    chars[i] = string.char(bytes[i])
  end
  local text = table.concat(chars)
  return state.loot_text_is_plausible(text) and text or ""
end
state.read_loot_cstring = function(addr, max_len)
  max_len = math.max(1, math.min(256, tonumber(max_len) or 256))
  if not is_valid_addr(addr, max_len) then return "" end
  local raw,len = read_bytes_table(addr,max_len)
  if len < 3 then return "" end
  local chars,terminated = {},false
  if raw[2] == 0 and raw[3] and raw[3] ~= 0 and raw[4] == 0 then
    for i=1,len-1,2 do
      local cp = raw[i]+raw[i+1]*256
      if cp == 0 then terminated=true; break end
      if cp < 32 or (cp>=0xD800 and cp<=0xDFFF) then return "" end
      if cp < 128 then chars[#chars+1]=string.char(cp)
      elseif utf8 and utf8.char then chars[#chars+1]=utf8.char(cp)
      else return "" end
    end
  else
    for i=1,len do
      local value=raw[i]
      if value == 0 then terminated=true; break end
      if value < 32 or value == 127 then return "" end
      chars[#chars+1]=string.char(value)
    end
  end
  if not terminated then return "" end
  local text=table.concat(chars)
  return state.loot_text_is_plausible(text) and text or ""
end
state.read_loot_text_slot = function(addr)
  if not is_valid_addr(addr,32) then return "" end
  local text=state.read_loot_sd_string(addr)
  if text ~= "" then return text end
  local ptr=read_uint(addr,8)
  if is_valid_addr(ptr,32) then
    text=state.read_loot_sd_string(ptr)
    if text ~= "" then return text end
    text=state.read_loot_cstring(ptr)
    if text ~= "" then return text end
  end
  return state.read_loot_cstring(addr)
end
 
state.classify_r0_loot = function(name, internal_id)
  local s = string.lower(tostring(name or "") .. " " .. tostring(internal_id or ""))
  if s:find("faction", 1, true) and s:find("key", 1, true) then return "Faction Key" end
  if s:find("armor", 1, true) and s:find("kit", 1, true) then return "Armor Kit" end
  if s:find("ammo", 1, true) or s:find("munition", 1, true) then return "Ammo" end
  if s:find("access", 1, true) and s:find("key", 1, true) then return "Access Key" end
  if s:find("food", 1, true) or s:find("ration", 1, true) then return "Food" end
  if s:find("water", 1, true) then return "Water" end
  if s:find("component", 1, true) then return "Components" end
  if s:find("key", 1, true) then return "Key" end
  return "R0 Item"
end
 
local BOUNTY_PATTERNS = { "bounty", "dousing the light", "scarecrow", "blinding the eye", "final girl", "binding circle", "rubber and glue" }
state.is_bounty_loot = function(name, internal_id)
  local s = string.lower(tostring(name or "") .. " " .. tostring(internal_id or ""))
  for i = 1, #BOUNTY_PATTERNS do if s:find(BOUNTY_PATTERNS[i], 1, true) then return true end end
  return false
end
 
state.scan_loot = function(pid, pobject)
  if not state.esp_enabled or not state.esp_loot or not state.local_pos then state.loot_items = {}; return end
  local loot_max_dist = tonumber(state.loot_max_dist) or 150
  if not is_finite(loot_max_dist) then loot_max_dist = 150 end
  loot_max_dist = math.max(10, math.min(150, loot_max_dist))
  local manager = read_uint(pobject + OFF.lootManager, 8)
  if not is_valid_addr(manager, 8) then state.loot_items = {}; return end
  local array = read_uint(manager + OFF.lootArray, 8)
  local count = read_uint(manager + OFF.lootCount, 4)
  if not is_valid_addr(array, 8) or count < 1 or count > 256 then state.loot_items = {}; return end
  local addrs = {}
  for i = 0, count - 1 do addrs[#addrs + 1] = array + i * 8 end
  local ptr_raw = batch_read_chunked(pid, 8, addrs)
  local loot_ptrs, pos_addrs, count_addrs, header_addrs = {}, {}, {}, {}
  for i = 1, count do
    local off = (i - 1) * 8
    if #ptr_raw >= off + 8 then
      local loot = uint_from(ptr_raw, off + 1, 8)
      if is_valid_addr(loot, 8) then
        loot_ptrs[#loot_ptrs + 1] = loot
        pos_addrs[#pos_addrs + 1] = loot + OFF.lootPos
        count_addrs[#count_addrs + 1] = loot + OFF.lootItemsCount
        header_addrs[#header_addrs + 1] = loot + OFF.lootItemsBase
      end
    end
  end
  local pos_raw = batch_read_chunked(pid, 12, pos_addrs)
  local item_count_raw = batch_read_chunked(pid, 4, count_addrs)
  local header_raw = batch_read_chunked(pid, 8, header_addrs)
  local rarity_addrs, rarity_owner = {}, {}
  for i = 1, #loot_ptrs do
    local off = (i - 1) * 8
    local poff = (i - 1) * 12
    local near = #pos_raw >= poff + 12 and vec_dist(state.local_pos, {
      from_f32(uint_from(pos_raw, poff + 1, 4)), from_f32(uint_from(pos_raw, poff + 5, 4)),
      from_f32(uint_from(pos_raw, poff + 9, 4))}) <= loot_max_dist
    if near and #header_raw >= off + 8 and #item_count_raw >= (i - 1) * 4 + 4 then
      local header = uint_from(header_raw, off + 1, 8)
      local item_count = uint_from(item_count_raw, (i - 1) * 4 + 1, 4)
      if item_count > 0 and item_count <= 256 and is_valid_addr(header, 8) then
        for item_index = 0, item_count - 1 do
          local entry = header + OFF.lootFirstEntry + item_index * OFF.lootItemStride
          local rarity_addr = entry + OFF.lootItemRarity
          if is_valid_addr(rarity_addr, 1) then
            rarity_addrs[#rarity_addrs + 1] = rarity_addr
            rarity_owner[#rarity_addrs] = {
              index = i, display_addr = entry + OFF.lootItemDisplay, defn_addr = entry + OFF.lootItemDefn,
            }
          end
        end
      end
    end
  end
  local rarity_raw = #rarity_addrs > 0 and batch_read_chunked(pid, 1, rarity_addrs) or {}
  local named_owners, display_addrs, defn_addrs = {}, {}, {}
  for ri, owner in ipairs(rarity_owner) do
    owner.rarity = rarity_raw[ri]
    if owner.rarity ~= nil then
      named_owners[#named_owners + 1] = owner
      display_addrs[#display_addrs + 1] = owner.display_addr
      defn_addrs[#defn_addrs + 1] = owner.defn_addr
    end
  end
  local display_raw = #display_addrs > 0 and batch_read_chunked(pid, 8, display_addrs) or {}
  local defn_raw = #defn_addrs > 0 and batch_read_chunked(pid, 8, defn_addrs) or {}
  local loot_labels, loot_detail_labels, loot_families = {}, {}, {}
  for i, owner in ipairs(named_owners) do
    local off = (i - 1) * 8
    local display = (#display_raw >= off + 8) and uint_from(display_raw, off + 1, 8) or 0
    local defn = (#defn_raw >= off + 8) and uint_from(defn_raw, off + 1, 8) or 0
    local name = is_valid_addr(display, OFF.lootItemObjName + 32) and state.read_loot_text_slot(display + OFF.lootItemObjName) or ""
    local internal_id = is_valid_addr(defn, OFF.lootItemDefnId + 32) and state.read_loot_text_slot(defn + OFF.lootItemDefnId) or ""
    local family = state.classify_loot_family(name, internal_id)
    if family == "Other" and owner.rarity == 8 then family = "Gear" end
    if state.is_bounty_loot(name, internal_id) then
      loot_labels[owner],family = "Bounty","Other"
    elseif owner.rarity == 9 then
      local exotic_family,exotic_label = state.exotic_loot_info(name,internal_id,family)
      family = exotic_family
      loot_labels[owner],loot_detail_labels[owner] = "Exotic",exotic_label
    elseif family ~= "Other" then
      loot_labels[owner] = family
      loot_detail_labels[owner] = state.loot_display_label(name,internal_id,family)
      if owner.rarity == 8 and loot_detail_labels[owner] == "Gear" then
        loot_detail_labels[owner] = "Gear Set"
      end
    elseif owner.rarity == 0 then
      loot_labels[owner] = state.classify_r0_loot(name,internal_id)
    else
      local r = owner.rarity
      local info = state.loot_rarity[r]
      local special = r == 1 or r == 2 or r == 3 or r == 4 or r == 7
      loot_labels[owner] = special and info and info[1] or "Other"
    end
    loot_families[owner] = family
  end
  local item_groups = {}
  for ri, owner in ipairs(rarity_owner) do
    local rarity = rarity_raw[ri]
    if rarity ~= nil then
      local groups = item_groups[owner.index]
      if not groups then groups = {}; item_groups[owner.index] = groups end
      local label = loot_labels[owner]
      if rarity == 0 and not label then label = "R0 Item" end
      local display_rarity = (label == "Bounty") and 2 or rarity
      local detail_label = loot_detail_labels[owner]
      local group_key = "R"..rarity.."|"..(label or "Other") .. (detail_label and ("|" .. detail_label) or "")
      local group = groups[group_key]
      if not group then
        group = { rarity = rarity, display_rarity = display_rarity, label = label, family = loot_families[owner] or "Other", display_label = detail_label, count = 0 }
        groups[group_key] = group
      end
      group.count = group.count + 1
    end
  end
  local items = {}
  for i, loot in ipairs(loot_ptrs) do
    local poff = (i - 1) * 12
    if #pos_raw >= poff + 12 then
      local pos = { from_f32(uint_from(pos_raw, poff + 1, 4)), from_f32(uint_from(pos_raw, poff + 5, 4)), from_f32(uint_from(pos_raw, poff + 9, 4)) }
      local dist = vec_dist(state.local_pos, pos)
      if is_finite(dist) and dist <= loot_max_dist then
        local groups = item_groups[i]
        if groups then
          local keys = {}
          for key, group in pairs(groups) do
            if group.count > 0 and state.loot_filter_enabled(group.display_rarity or group.rarity, group.family) then
              keys[#keys + 1] = key
            end
          end
          table.sort(keys)
          for row, key in ipairs(keys) do
            local group = groups[key]
            items[#items + 1] = {
              pos = pos, dist = dist, item_count = group.count,
              rarity = group.display_rarity or group.rarity, label = group.label, family = group.family, display_label = group.display_label, row = row,
            }
          end
        end
      end
    end
  end
  local stacks = {}
  for _, item in ipairs(items) do
    local stack
    for _, candidate in ipairs(stacks) do
      if vec_dist(candidate.pos, item.pos) <= 0.35 then stack = candidate; break end
    end
    if not stack then stack = { pos = item.pos, items = {} }; stacks[#stacks + 1] = stack end
    stack.items[#stack.items + 1] = item
  end
  local function marker_priority(item)
    if item.label == "Bounty" then return 1 end
    if item.rarity == 7 or item.label == "Event Key" then return 2 end
    return 3
  end
  for _, stack in ipairs(stacks) do
    table.sort(stack.items, function(a, b)
      local pa, pb = marker_priority(a), marker_priority(b)
      if pa ~= pb then return pa < pb end
      if a.rarity ~= b.rarity then return a.rarity < b.rarity end
      return tostring(a.display_label or a.label or "") < tostring(b.display_label or b.label or "")
    end)
    for row, item in ipairs(stack.items) do item.row, item.display_pos = row, stack.pos end
  end
  state.loot_items = items
end
 
local performance_sample
local function finish_performance_sample()
  local sample = performance_sample
  performance_sample = nil
  local lines = {string.format("frames=%d elapsed_ms=%.1f", sample.frames,
    (sample.clock() - sample.started) / 1000)}
  for _, name in ipairs({"frame", "entities", "bones", "loot", "esp_draw", "features", "ui"}) do
    local row = sample[name]
    if row then
      lines[#lines + 1] = string.format("%s calls=%d avg_ms=%.3f max_ms=%.3f total_ms=%.1f",
        name, row.count, row.total / row.count / 1000, row.max / 1000, row.total / 1000)
    end
  end
  local ok = pcall(function()
    assert(config.set(CFG_PREFIX .. "performance_sample", table.concat(lines, "\n")) == true)
    assert(config.save() == true)
  end)
  show_splash(ok and "Performance sample saved" or "Performance sample save failed")
end
 
local function record_performance(sample, name, elapsed)
  local row = sample[name]
  if not row then row = {count=0, total=0, max=0}; sample[name] = row end
  row.count, row.total, row.max = row.count + 1, row.total + elapsed, math.max(row.max, elapsed)
  return elapsed
end
 
function OnUpdate(dt)
  if keyboard and keyboard.is_key_press and keyboard.is_key_press("f6") then
    if performance_sample then finish_performance_sample()
    elseif engine and type(engine.time_us) == "function" then
      performance_sample = {clock=engine.time_us, started=engine.time_us(), frames=0}
      show_splash("Performance sampling: 45 seconds (F6 to finish)")
    else show_splash("Performance timer unavailable in this GUI") end
  end
  local sample = performance_sample
  local clock = sample and sample.clock
  local frame_started = clock and clock()
  _frame_id = _frame_id + 1
  state._frame_counter = _frame_id
  state.config_save_timer = (state.config_save_timer or 0) + (dt or 0)
  if state.config_save_timer >= 5.0 then state.config_save_timer = 0; save_config_now() end
  if _pending_offset_timer > 0 then
    _pending_offset_timer = _pending_offset_timer - (dt or 0)
    if _pending_offset_timer <= 0 then flush_pending_offsets() end
  end
  if state.walk_skip > 0 then state.walk_skip = state.walk_skip - 1 end
  process_hotkeys()
  if not state.master_enabled then
    for _, key in ipairs(MASTER_KEYS) do state[key] = false end
  end
  if not state.esp_enabled then state.loot_items, state.loot_scan_was_enabled = {}, false end
  update_connection_state(dt)
  if state.pid ~= 0 and state.base ~= 0 then
    state.wr_timer = (state.wr_timer or 0) + 1
    if state.wr_timer >= 5 then
      state.wr_timer = 0
      if memory and memory.get_window_rect then
        local ok, rect = pcall(memory.get_window_rect, state.pid)
        if ok then
          rect = normalize_window_rect(rect)
          if rect and is_finite(rect.x) and is_finite(rect.y) and is_finite(rect.width) and is_finite(rect.height)
            and rect.width > 0 and rect.height > 0 then state.window_rect = rect end
        else report_memory_error("window rect", rect) end
      end
    end
    if state.master_enabled and (state.esp_enabled or state.silent_enabled) then
      local pid, base = state.pid, state.base
      local scan_started = clock and clock()
      local nested_scan_us = 0
      local ok, err = pcall(function()
        local po_ptr = safe_walk(pid, base, { RVA.rlclient, OFF.pClient, OFF.pObject })
        if po_ptr == 0 then
          state.loot_items = {}
          if state._was_attached then invalidate_on_transition(pid) end
          state._was_attached, state.entities = false, {}; return
        end
        local lp = get_localplayer()
        if lp == 0 then
          if state._was_attached then invalidate_on_transition(pid) end
          state._was_attached, state.entities = false, {}; return
        end
        local lp_pos = read_bytes_table(lp + OFF.entityPos, 12)
        if #lp_pos == 12 then
          state.local_pos = parse_f32_array(lp_pos, 3)
          for _, value in ipairs(state.local_pos) do
            if not is_finite(value) then state.local_pos, state.entities = nil, {}; return end
          end
        else state.local_pos, state.entities = nil, {}; state.loot_items = {}; return end
        if not state.esp_enabled or not state.esp_loot then
          state.loot_items, state.loot_scan_was_enabled = {}, false
        else
          state.loot_scan_elapsed = (state.loot_scan_elapsed or 0) + math.max(0, dt or 0)
          local scan_due = not state.loot_scan_was_enabled or state.loot_scan_elapsed >= LOOT_SCAN_INTERVAL
          state.loot_scan_was_enabled = true
          if scan_due then
            state.loot_scan_elapsed = 0
            local loot_started = clock and clock()
            local loot_ok, loot_err = pcall(state.scan_loot, pid, po_ptr)
            if clock then nested_scan_us = record_performance(sample, "loot", clock() - loot_started) end
            if not loot_ok then state.loot_items = {}; state.loot_scan_error = tostring(loot_err)
            else state.loot_scan_error = nil end
          end
        end
        local lp_faction_raw = read_bytes_table(lp + OFF.factionCtx, 8)
        local local_faction = (#lp_faction_raw == 8) and uint_from(lp_faction_raw, 1, 8) or 0
        if state.faction_tag_pid ~= pid then state.faction_tag_cache, state.faction_tag_pid = {}, pid end
        local scan_ctx = { local_player = lp, local_faction = local_faction, tag_cache = state.faction_tag_cache }
        local meta = batch_read_chunked(pid, 8, { po_ptr + OFF.entityArray, po_ptr + OFF.entityCount })
        local arr_ptr = (#meta >= 12) and uint_from(meta, 1, 8) or 0
        local count = (#meta >= 12) and uint_from(meta, 9, 4) or 0
        local prev_arr = state._last_arr_ptr or 0
        local prev_count = state._last_count or 0
        local ptrs = {}
        if arr_ptr ~= 0 and count > 0 then
          local read_count = math.min(count, 512)
          local list_data = read_bytes_table(arr_ptr, read_count * 8)
          if #list_data >= read_count * 8 then
            for i = 0, read_count - 1 do
              local ep = uint_from(list_data, i * 8 + 1, 8)
              if ep ~= 0 and ep > 0x10000 and ep < 0x7FFFFFFFFFFF then ptrs[#ptrs + 1] = ep end
            end
          end
        end
        local transition = false
        if arr_ptr ~= 0 and prev_arr ~= 0 and arr_ptr ~= prev_arr then transition = true end
        if prev_count > 0 and count == 0 then transition = true end
        if not transition and state._last_ptrs and #ptrs >= MIN_OVERLAP_CHECK_COUNT and #state._last_ptrs >= MIN_OVERLAP_CHECK_COUNT then
          local seen, ov = {}, 0
          for _, v in ipairs(state._last_ptrs) do seen[v] = true end
          for _, v in ipairs(ptrs) do if seen[v] then ov = ov + 1 end end
          if ov < math.min(#ptrs, #state._last_ptrs) * 0.25 then transition = true end
        end
        if transition then invalidate_on_transition(pid) end
        state._last_arr_ptr, state._last_count, state._last_ptrs = arr_ptr, count, ptrs
        state._was_attached = true
        if state._transition_frames and state._transition_frames > 0 then state._transition_frames = state._transition_frames - 1 end
        state.scan_info = string.format("po=0x%X arr=0x%X cnt=%d", po_ptr, arr_ptr, count)
        if arr_ptr == 0 or count == 0 or #ptrs == 0 then state.entities = {}; return end
        local probe_ok = false
        for pi = 1, math.min(#ptrs, 4) do
          local probe = read_bytes_table(ptrs[pi] + OFF.entityType, 8)
          if #probe >= 4 then
            local printable = 0
            for i = 1, 8 do if probe[i] and probe[i] >= 0x20 and probe[i] < 0x7F then printable = printable + 1 end end
            if printable >= 4 or read_ascii_str(probe, 0, 8) == "npc" then probe_ok = true; break end
          end
        end
        if not probe_ok then state.entities = {}; return end
        local esp_max_dist = tonumber(state.esp_max_dist) or 150
        if not is_finite(esp_max_dist) then esp_max_dist = 150 end
        esp_max_dist = math.max(10, math.min(200, esp_max_dist))
        local silent_dist = tonumber(state.silent_max_dist) or 150
        if not is_finite(silent_dist) then silent_dist = 150 end
        silent_dist = math.max(10, math.min(200, silent_dist))
        local scan_max_dist = math.max(state.esp_enabled and esp_max_dist or 0, state.silent_enabled and silent_dist or 0)
        local pos_addrs = {}
        for _, ep in ipairs(ptrs) do pos_addrs[#pos_addrs + 1] = ep + OFF.entityPos end
        local raw = batch_read_chunked(pid, 12, pos_addrs)
        local nearby, near_raw = {}, {}
        for i, ep in ipairs(ptrs) do
          local off = (i - 1) * 12
          if ep ~= lp and #raw >= off + 12 then
            local pos = {from_f32(uint_from(raw, off + 1, 4)), from_f32(uint_from(raw, off + 5, 4)), from_f32(uint_from(raw, off + 9, 4))}
            local dist = vec_dist(state.local_pos, pos)
            if is_finite(dist) and dist <= scan_max_dist then
              nearby[#nearby + 1] = ep
              for b = 1, 12 do near_raw[#near_raw + 1] = raw[off + b] end
            end
          end
        end
        ptrs, raw = nearby, near_raw
        local type_addrs, name_addrs, rel_addrs, down_addrs, fac_addrs, ty_addrs = {}, {}, {}, {}, {}, {}
        for _, ep in ipairs(ptrs) do
          type_addrs[#type_addrs + 1] = ep + OFF.entityType
          name_addrs[#name_addrs + 1] = ep + OFF.entityName; rel_addrs[#rel_addrs + 1] = ep + OFF.relation
          down_addrs[#down_addrs + 1] = ep + OFF.isDowned; fac_addrs[#fac_addrs + 1] = ep + OFF.factionCtx
          ty_addrs[#ty_addrs + 1] = ep + OFF.entityTypeInt
        end
        local type_raw = batch_read_chunked(pid, 16, type_addrs)
        local name_raw = batch_read_chunked(pid, 16, name_addrs)
        local rel_raw = batch_read_chunked(pid, 8, rel_addrs)
        local down_raw = batch_read_chunked(pid, 4, down_addrs)
        local fac_raw = batch_read_chunked(pid, 8, fac_addrs)
        local ty_raw = batch_read_chunked(pid, 4, ty_addrs)
        local npc_info = read_npc_archetypes(pid, ptrs, type_raw, down_raw)
        local hp_addrs = {}
        for _, ep in ipairs(ptrs) do hp_addrs[#hp_addrs + 1] = ep + OFF.hpPtr end
        local hp_raw = batch_read_chunked(pid, 8, hp_addrs)
        local hp_valid_index, hp_data_addrs, hp_slot_count = {}, {}, 0
        for i = 1, #ptrs do
          local off = (i - 1) * 8
          if #hp_raw >= off + 8 then
            local hp = uint_from(hp_raw, off + 1, 8)
            if hp ~= 0 then
              hp_slot_count = hp_slot_count + 1; hp_valid_index[i] = hp_slot_count
              hp_data_addrs[#hp_data_addrs + 1] = hp + OFF.health
              hp_data_addrs[#hp_data_addrs + 1] = hp + OFF.healthMax
            end
          end
        end
        local hp_data_raw = #hp_data_addrs > 0 and batch_read_chunked(pid, 4, hp_data_addrs) or nil
        do
          local misses, seen = {}, {}
          for i = 1, #ptrs do
            local off = (i - 1) * 8
            if #fac_raw >= off + 8 then
              local f = uint_from(fac_raw, off + 1, 8)
              if f ~= 0 and state.faction_tag_cache[f] == nil and not seen[f] then
                seen[f] = true; misses[#misses + 1] = f
              end
            end
          end
          if #misses > 0 then
            local tag_addrs = {}
            for _, f in ipairs(misses) do tag_addrs[#tag_addrs + 1] = f + OFF.factionTag end
            local tag_raw = batch_read_chunked(pid, 16, tag_addrs)
            if #tag_raw >= #misses * 16 then
              for idx, f in ipairs(misses) do
                state.faction_tag_cache[f] = read_ascii_str(tag_raw, (idx - 1) * 16, 16)
              end
            end
          end
        end
        local function type_str_at(idx)
          return read_ascii_str(type_raw, (idx - 1) * 16, 16)
        end
        local armor_slot_by_entity, armor_addrs, armor_slot_count = {}, {}, 0
        for i = 1, #ptrs do
          local hp_off = (i - 1) * 8
          if #hp_raw >= hp_off + 8 then
            local hp_ptr = uint_from(hp_raw, hp_off + 1, 8)
            if is_valid_addr(hp_ptr, 4) then
              armor_slot_count = armor_slot_count + 1; armor_slot_by_entity[i] = armor_slot_count
              local is_player = (type_str_at(i) == "soldier")
              armor_addrs[#armor_addrs + 1] = hp_ptr + (is_player and OFF.agentarmor or OFF.npcArmor)
              armor_addrs[#armor_addrs + 1] = hp_ptr + (is_player and OFF.agentarmorMax or OFF.npcArmorMax)
            end
          end
        end
        local armor_raw = #armor_addrs > 0 and batch_read_chunked(pid, 4, armor_addrs) or nil
        local ents = {}
        if raw then
          for i = 1, #ptrs do
            local off = (i - 1) * 12
            if #raw >= off + 12 then
              local px = from_f32(uint_from(raw, off + 1, 4))
              local py = from_f32(uint_from(raw, off + 5, 4))
              local pz = from_f32(uint_from(raw, off + 9, 4))
              local pos = { px, py, pz }
              if is_finite(px) and is_finite(py) and is_finite(pz) then
                if not state.local_pos then state.entities = {}; return end
                local dist = vec_dist(state.local_pos, pos)
                local ent_name = read_ascii_str(name_raw, (i - 1) * 16, 16)
                if dist <= scan_max_dist then
                  local is_downed = down_raw and (#down_raw >= (i - 1) * 4 + 4) and (uint_from(down_raw, (i - 1) * 4 + 1, 4) ~= 0) or false
                  if not is_downed then
                    local type_str = type_str_at(i)
                    local is_player = (type_str == "soldier")
                    local archetype, tier, tier_valid = nil, NPC_THREAT_TIER.NonThreat, false
                    local archetype_raw, tier_raw = nil, nil
                    local entity_type_val = is_player and ENTITY_TYPE_PLAYER or ENTITY_TYPE_NPC
                    local entity_type_int = 0
                    if ty_raw and #ty_raw >= (i - 1) * 4 + 4 then
                      entity_type_int = uint_from(ty_raw, (i - 1) * 4 + 1, 4)
                      if entity_type_int >= 0x80000000 then entity_type_int = entity_type_int - 0x100000000 end
                    end
                    if not is_player then
                      local info = npc_info[i]
                      if info then
                        archetype_raw, tier_raw = info[1], info[2]
                        if archetype_raw < 80 then archetype = archetype_raw end
                        if tier_raw < 5 then tier, tier_valid = tier_raw, true end
                      end
                    end
                    local relation_raw, rel_verdict, faction = 0, nil, 0
                    if rel_raw and #rel_raw >= (i - 1) * 8 + 8 then
                      local roff = (i - 1) * 8
                      relation_raw = uint_from(rel_raw, roff + 1, 8)
                      if not is_player then
                        if match_relation(rel_raw, roff, RELATION_HOSTILE) then rel_verdict = "hostile"
                        elseif match_relation(rel_raw, roff, RELATION_FRIENDLY) then rel_verdict = "friendly"
                        elseif match_relation(rel_raw, roff, RELATION_NEUTRAL) then rel_verdict = "neutral" end
                      end
                    end
                    if fac_raw and #fac_raw >= (i - 1) * 8 + 8 then faction = uint_from(fac_raw, (i - 1) * 8 + 1, 8) end
                    local faction_tag = state.faction_tag_cache[faction] or ""
                    local hp_val, hp_max = 0, 0
                    local vi = hp_valid_index[i]
                    if vi and hp_data_raw and #hp_data_raw >= (vi - 1) * 8 + 8 then
                      hp_val = uint_from(hp_data_raw, (vi - 1) * 8 + 1, 4)
                      hp_max = uint_from(hp_data_raw, (vi - 1) * 8 + 5, 4)
                    end
                    local armor_val, armor_max_val = 0, 0
                    local armor_slot = armor_slot_by_entity[i]
                    if armor_slot and armor_raw and #armor_raw >= (armor_slot - 1) * 8 + 8 then
                      armor_val = uint_from(armor_raw, (armor_slot - 1) * 8 + 1, 4)
                      armor_max_val = uint_from(armor_raw, (armor_slot - 1) * 8 + 5, 4)
                    end
                    local is_low_hp = hp_max > 0 and (hp_val / hp_max) < 0.1
                    local classified = classify_entity({
                      is_player = is_player, type_str = type_str, faction = faction, faction_tag = faction_tag,
                      archetype = archetype, tier = tier, tier_valid = tier_valid,
                      entity_ptr = ptrs[i], entity_type_int = entity_type_int, rel_verdict = rel_verdict,
                    }, scan_ctx)
                    if classified == "unknown" and archetype ~= nil and archetype ~= NPC_ARCHETYPE.Unset then
                      classified = "hostile"
                    end
                    local relation = is_player and ((classified == "hostile") and "hostile" or "player") or classified
                    local summon_kind = nil
                    if not is_player and archetype ~= nil then
                      if ARCHETYPE_IS_DRONE[archetype] then summon_kind = "drone"
                      elseif ARCHETYPE_IS_DOG[archetype] then summon_kind = "dog"
                      elseif archetype == NPC_ARCHETYPE.MiniTank then summon_kind = "tank"
                      elseif ARCHETYPE_IS_TURRET[archetype] then summon_kind = "turret"
                      elseif ARCHETYPE_IS_GADGET[archetype] then summon_kind = "gadget" end
                    end
                    ents[#ents + 1] = {
                      pos = pos, dist = dist, entity_ptr = ptrs[i],
                      is_local_player = (ptrs[i] == scan_ctx.local_player),
                      ent_type = is_player and "player" or "npc", entity_type = entity_type_val,
                      entity_type_int = entity_type_int, is_player = is_player,
                      is_summoned = (summon_kind ~= nil), summon_kind = summon_kind,
                      ent_name = ent_name, type_str = type_str, relation = relation,
                      relation_raw = relation_raw, faction = faction, faction_tag = faction_tag,
                      is_downed = is_downed, hp = hp_val, hp_max = hp_max, is_low_hp = is_low_hp,
                      armor = armor_val, armor_max = armor_max_val,
                      archetype = archetype, archetype_name = (archetype ~= nil) and ARCHETYPE_NAME_BY_ID[archetype] or nil,
                      tier = tier, tier_valid = tier_valid, archetype_raw = archetype_raw, tier_raw = tier_raw,
                    }
                  end
                end
              end
            end
          end
        end
        if (state.esp_boxes or state.esp_bones or state.silent_enabled) and #ents > 0 then
          local bone_ents = {}
          for _, e in ipairs(ents) do
            local visible = state.esp_enabled and e.dist <= esp_max_dist and should_show(e)
            local target = state.silent_enabled and e.dist <= silent_dist and is_silent_target(e)
            if (visible or target) and #get_bone_ids_for_entity(e, state.esp_bone_ids) > 0 then bone_ents[#bone_ents + 1] = e end
          end
          local bones_started = clock and clock()
          local bone_data = read_bones(pid, bone_ents, state.esp_enabled and state.esp_bones and state.esp_bone_ids)
          if clock then nested_scan_us = nested_scan_us + record_performance(sample, "bones", clock() - bones_started) end
          for i, e in ipairs(bone_ents) do e.bones = bone_data[i] end
        end
        state.entities = ents
      end)
      if clock then record_performance(sample, "entities", clock() - scan_started - nested_scan_us) end
      if not ok then state.entities, state.loot_items = {}, {}; state.status = "Scan: " .. tostring(err) end
      local vm = read_bytes_table(base + RVA.viewmatrix + OFF.viewProj, 64)
      if #vm == 64 then state.viewproj = parse_f32_array(vm, 16)
      else state.viewproj, state.entities = nil, {}; release_silent_lock(pid) end
      silent_tick(pid, base)
      local esp_started = clock and clock()
      local wr = normalize_window_rect(state.window_rect) or { x = 0, y = 0, width = 1920, height = 1080 }
      local w, m = wr, state.viewproj
      local esp_text_size = tonumber(state.esp_text_size) or 10
      if not is_finite(esp_text_size) then esp_text_size = 10 end
      esp_text_size = math.max(6, math.min(20, math.floor(esp_text_size + 0.5)))
      local esp_text_line = esp_text_size + 2
      if m and #m >= 16 and w and w.width and w.width > 0 then
        local cx, cy = w.x + w.width / 2, w.y + w.height
        if state.silent_enabled and state.esp_show_silent_fov then
          local cr, cg, cb = 255, 200, 0
          if state.silent_armed then cr, cg, cb = 0, 255, 100 end
          draw_fov_circle(w.x + w.width / 2, w.y + w.height / 2, state.silent_fov, cr, cg, cb, 65)
        end
        if state.esp_enabled then
          for _, e in ipairs(state.entities) do
            pcall(function()
              if e.is_local_player or (e.entity_ptr and e.entity_ptr == get_localplayer()) then return end
              if e.dist <= (tonumber(state.esp_max_dist) or 150) and should_show(e) then
                local pname = profile_name_for(e)
                local offsets = is_boneless_profile(pname) and effective_boneless_offset(e)
                local draw_pos = offsets and apply_nonskeleton_world_offset(e.pos, offsets) or e.pos
                local sx, sy = world_to_screen(draw_pos, m, w)
                if sx and sy then
                  if offsets or (state.silent_armed and state.silent_target_ptr == e.entity_ptr) then
                    local tp = offsets and draw_pos or aim_point_for(e)
                    if tp and state.viewproj and state.window_rect then
                      local tsx, tsy = world_to_screen(tp, state.viewproj, w)
                      if tsx and tsy then
                        local sz = state.target_marker_size or 3
                        draw_circle_filled(tsx, tsy, sz * 1.2, 255, 235, 150, 30)
                        draw_circle_filled(tsx, tsy, sz * 0.7, 255, 240, 180, 75)
                        draw_circle_filled(tsx, tsy, math.max(2, sz * 0.3), 255, 250, 210, 160)
                      end
                    end
                  end
                  local cr = get_color(e)
                  local prof = BONE_PROFILES[pname]
                  local is_summon_box = pname == "DRONE" or pname == "TURRET" or pname == "ITEM" or pname == "NO_SKELETON" or pname == "MINITANK" or pname == "BIG_DOG" or pname == "WARHOUND_GRENADIER" or pname == "WARHOUND_MINIGUN"
                  local draw_box = state.esp_boxes and (is_summon_box or not state.esp_bones or (e.bones ~= nil and next(e.bones) ~= nil))
                  local box_h, box_w, box_cy, box_cx = compute_box(e, m, w, sy, draw_pos)
                  sx = box_cx or sx
                  if state.esp_snaplines then
                    draw.line(cx, cy, sx, is_summon_box and sy or box_cy, 100, 100, 255, 75, 0.75)
                  end
                  if draw_box then
                    draw.rect(sx - box_w / 2, box_cy - box_h / 2, box_w, box_h, cr[1], cr[2], cr[3], 135, 0.8)
                    if e.hp_max > 0 and e.hp > 0 then
                      local ratio = math.min(e.hp / e.hp_max, 1.0)
                      local bar_x, bar_top = sx - box_w / 2 - 3, box_cy - box_h / 2
                      local green_h = box_h * ratio
                      local red_h = box_h - green_h
                      if red_h > 0 then draw.filled_rect(bar_x, bar_top, 2, red_h, 200, 0, 0, 200) end
                      if green_h > 0 then draw.filled_rect(bar_x, bar_top + red_h, 2, green_h, 0, 200, 0, 200) end
                    end
                    if e.armor_max > 0 and e.armor > 0 then
                      local bar_x, bar_top = sx + box_w / 2 + 1, box_cy - box_h / 2
                      local armor_ratio = math.max(0, math.min(e.armor / e.armor_max, 1.0))
                      local armor_h = box_h * armor_ratio
                      draw.filled_rect(bar_x, bar_top, 2, box_h, 25, 35, 45, 190)
                      if armor_h > 0 then
                        draw.filled_rect(bar_x, bar_top + box_h - armor_h, 2, armor_h, 70, 190, 255, 230)
                      end
                    end
                  end
                  if state.esp_bones and e.bones and prof and prof.connections then
                    for _, seg in ipairs(prof.connections) do
                      local p1, p2 = e.bones[seg[1]], e.bones[seg[2]]
                      if p1 and p2 then
                        local x1, y1 = world_to_screen(p1, m, w)
                        local x2, y2 = world_to_screen(p2, m, w)
                        if x1 and x2 then draw.line(x1, y1, x2, y2, cr[1], cr[2], cr[3], 200, 1.5) end
                      end
                    end
                  end
                  if state.esp_bone_ids and state.esp_bones and e.bones then
                    for bid, bp in pairs(e.bones) do
                      local bx, by = world_to_screen(bp, m, w)
                      if bx and by then
                        draw.text(bx + 1, by + 1, tostring(bid), 0, 0, 0, 200, esp_text_size)
                        draw.text(bx, by, tostring(bid), 255, 255, 0, 250, esp_text_size)
                      end
                    end
                  end
                  if state.esp_distance then
                    local txt = string.format("%.0fm", e.dist)
                    draw.text(sx - #txt * esp_text_size * 0.30, box_cy + box_h / 2 + 2, txt, 120, 180, 120, 200, esp_text_size)
                  end
                  if state.esp_name and e.ent_name and e.ent_name ~= "" then
                    draw.text(sx - #e.ent_name * esp_text_size * 0.30, box_cy - box_h / 2 - esp_text_line, e.ent_name, 255, 255, 255, 220, esp_text_size)
                  end
                  if state.esp_type and e.ent_type then
                    local tlabel = e.ent_type
                    if e.archetype_name then tlabel = tlabel .. ":" .. e.archetype_name end
                    draw.text(sx - #tlabel * esp_text_size * 0.30, box_cy - box_h / 2 - esp_text_line * (state.esp_name and 2 or 1), tlabel, cr[1], cr[2], cr[3], 200, esp_text_size)
                  end
                  if state.esp_show_relation and e.relation_raw then
                    local rtxt = string.format("0x%X", e.relation_raw)
                    local yoff = -esp_text_line + (state.esp_name and -esp_text_line or 0) + (state.esp_type and -esp_text_line or 0)
                    draw.text(sx - #rtxt * esp_text_size * 0.30, box_cy - box_h / 2 + yoff, rtxt, 200, 200, 200, 180, esp_text_size)
                  end
                  if state.esp_show_faction and e.faction then
                    local ftxt = faction_display(e.faction, e.faction_tag)
                    local yoff = -esp_text_line + (state.esp_name and -esp_text_line or 0) + (state.esp_type and -esp_text_line or 0) + (state.esp_show_relation and -esp_text_line or 0)
                    draw.text(sx - #ftxt * esp_text_size * 0.30, box_cy - box_h / 2 + yoff, ftxt, 180, 180, 255, 180, esp_text_size)
                  end
                  if state.esp_desc_test then
                    local atxt = string.format("A%s T%s Ty%d", tostring(e.archetype_raw or "-"), tostring(e.tier_raw or "-"), e.entity_type_int or 0)
                    local yoff = -esp_text_line + (state.esp_name and -esp_text_line or 0) + (state.esp_type and -esp_text_line or 0)
                      + (state.esp_show_relation and -esp_text_line or 0) + (state.esp_show_faction and -esp_text_line or 0)
                    draw.text(sx - #atxt * esp_text_size * 0.30, box_cy - box_h / 2 + yoff, atxt, 255, 200, 80, 200, esp_text_size)
                  end
                end
              end
            end)
          end
        end
        if state.esp_enabled and state.esp_loot then
          local loot_text_size = tonumber(state.loot_text_size) or 10
          loot_text_size = math.max(6, math.min(20, math.floor((is_finite(loot_text_size) and loot_text_size or 10) + 0.5)))
          local loot_line_step = math.max(11, loot_text_size + 1)
          for _, item in ipairs(state.loot_items or {}) do
            pcall(function()
              local lx, ly = world_to_screen(item.display_pos or item.pos, m, w)
              if lx and ly then
                local info = state.loot_rarity[item.rarity]
                local label = item.display_label or item.label or (info and info[1]) or "Other Loot"
                label = label:gsub("^High%-End ", "")
                local rr, gg, bb = info and info[2] or 220, info and info[3] or 220, info and info[4] or 220
                local flash = math.floor(_frame_id / 20) % 2 == 0
                if item.label == "Bounty" then
                  rr, gg, bb = flash and 245 or 115, flash and 245 or 115, flash and 245 or 115
                elseif item.rarity == 7 then
                  rr, gg, bb = flash and 245 or 65, flash and 245 or 145, 255
                elseif item.rarity == 9 then
                  rr, gg, bb = 255, flash and 235 or 85, flash and 235 or 55
                elseif item.rarity == 11 then
                  rr, gg, bb = flash and 255 or 220, flash and 245 or 165, 255
                end
                label = state.loot_marker_text(item,label)
                if (item.row or 1) == 1 then draw_circle_filled(lx, ly, 4, rr, gg, bb, 220) end
                draw.text(lx + 7, ly - 7 + ((item.row or 1) - 1) * loot_line_step, label, rr, gg, bb, 240, loot_text_size)
              end
            end)
          end
        end
      end
      if clock then record_performance(sample, "esp_draw", clock() - esp_started) end
    end
    if state.master_enabled then
      local features_started = clock and clock()
      process_hacks_and_stats(dt)
      if clock then record_performance(sample, "features", clock() - features_started) end
    end
  end
  local ui_started = clock and clock()
  draw_overlays(dt)
  if clock then
    record_performance(sample, "ui", clock() - ui_started)
    record_performance(sample, "frame", clock() - frame_started)
    sample.frames = sample.frames + 1
    if clock() - sample.started >= 45000000 then finish_performance_sample() end
  end
end
]====]
 
local startup_error
 
local function bootstrap(dt)
  if pending_source then
    local source = pending_source
    pending_source = nil
    local ok, failure = pcall(function()
      local compile = loadstring or load
      assert(type(compile) == "function", "This GUI does not provide a Lua source loader")
      local chunk, compile_error = compile(source, "@td2.lua")
      assert(chunk, compile_error)
      chunk()
      assert(type(OnUpdate) == "function" and OnUpdate ~= bootstrap, "TD2 update callback was not loaded")
      if OnStart then OnStart() end
    end)
    if ok then return OnUpdate(dt) end
 
    startup_error = tostring(failure)
    OnUpdate, OnStart, OnDestroy = bootstrap, nil, nil
  end
 
  if startup_error and ui and ui.window then
    ui.window("TD2 startup error", function()
      ui.label("TD2 could not start. Share the error below.")
      if ui.code then ui.code(startup_error) else ui.label(startup_error) end
    end)
  end
end
 
OnUpdate = bootstrap