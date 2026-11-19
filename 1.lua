-- HOTKEY CONFIGURATION

HOTKEY_SILENT = "Numpad7"
HOTKEY_MAGIC_BULLET = "Numpad8"
HOTKEY_RPM = "Numpad9"
HOTKEY_RPM_UP = "Add"
HOTKEY_RPM_DOWN = "Subtract"
HOTKEY_ESP = ""
HOTKEY_ESP_PLAYERS = "Delete"
HOTKEY_NO_RECOIL = ""
HOTKEY_NO_SPREAD = ""
HOTKEY_INSTANT_RELOAD = ""
HOTKEY_NO_SWAY = ""
HOTKEY_CROSSHAIR = "Decimal"
HOTKEY_AIM_PART = "Home"
HOTKEY_AIM_DYNAMIC = "End"
HOTKEY_SHOW_FOV = "Numpad0"
HOTKEY_COUNTER_COLLAPSE = "F8"  -- collapse/expand the entity counter box
HOTKEY_FOV_UP = ""  -- FOV is slider-adjustable
HOTKEY_TAP_LOOT = "PageUp"  -- single tap-to-loot sweep
HOTKEY_FOV_DOWN = ""  -- FOV is slider-adjustable
HOTKEY_AUTO_LOOT = "PageDown"  -- toggles Auto-Loot All Items
HOTKEY_NONSKELETON_UP = "Numpad5"
HOTKEY_NONSKELETON_LEFT = "Numpad1"
HOTKEY_NONSKELETON_DOWN = "Numpad2"
HOTKEY_NONSKELETON_RIGHT = "Numpad3"
HOTKEY_NONSKELETON_FAR = "Numpad4"
HOTKEY_NONSKELETON_NEAR = "Numpad6"
HOTKEY_ESP_BOX = "Multiply"
HOTKEY_ESP_LOOT = ""
HOTKEY_ESP_BONES = "Divide"
HOTKEY_ESP_DISTANCE = ""
HOTKEY_ESP_SNAPLINES = ""
HOTKEY_ESP_TYPE = ""
HOTKEY_ESP_NAME = ""
HOTKEY_MOVE_SPEED = ""
HOTKEY_EXTENDED_RANGE = ""
HOTKEY_ESP_BONE_IDS = ""

-- MASTER / PRESETS

HOTKEY_MASTER = "F1"  -- hotkey names are uppercase; the API is case-sensitive
HOTKEY_PRESET_1 = "F9"
HOTKEY_PRESET_2 = "F10"
HOTKEY_PRESET_3 = "F11"
HOTKEY_PRESET_4 = "F12"

-- HUD PANEL LAYOUT

HUD_PANEL_LAYOUT = {
    width = 340,
    height = 880,
    margin_right = 20,
    margin_top = 50,
    padding_left = 12,
    padding_right = 12,
    padding_top = 12,
    function_column_width = 140,
    status_column_width = 80,
    shortcut_column_width = 80,
    column_header_height = 20,
    column_header_gap = 10,
    row_height = 19,
    section_height = 19,
    section_gap = 4,
    column_header_font = 13,
    section_font = 13,
    row_font = 12,
    background_alpha = 150,
    border_enabled = true,
}

-- SHARED RVA / OFF

RVA = {
    rlclient = 0x6F683F8,  -- client base pointer
    viewmatrix = 0x6F68880,  -- view matrix (read at base + RVA + viewProj offset)
    recoil = 0x660A724,  -- recoil value, default 30.0
    spread = 0x660A720,  -- spread value, default 4.0
    setnoon = 0x7109F06,  -- force noon
    setnight = 0x7109F07,  -- force night
    magicbullet = 0x6602001,  -- magic bullet, default 0x98
}
OFF = {
    pClient = 0x130,
    pObject = 0x28,
    entityArray = 0x550,  -- entity array offset
    entityCount = 0x558,  -- entity count offset
    entityPos = 0x80,
    localStage0 = 0x380,  -- local player pointer chain, stage 0
    localStage1 = 0x10,
    localStage2 = 0x30,
    viewProj = 0x450,
    bonesBase = 0x220,
    boneArray = 0x170,
    entityType = 0x228,
    entityName = 0x438,
    relation = 0x250,
    isDowned = 0x3B8,
    hpPtr = 0x7D0,
    health = 0x5C,
    healthMax = 0x60,
    factionCtx = 0x3E0,
    entityTypeInt = 0xC00,
    factionTag = 0x18,
    aimCtrl = 0x848,
    worldAimPos = 0x3AA8,
    npcDescriptorPtr = nil,  -- nil: archetype/tier reads return nil
    npcAgentDescriptor = 0x20,
    npcArchetypeOffset = 0x180,  -- archetype offset
    npcTierOffset = 0x184,
    name = 0x438,
    agentarmor = 0x254,
    agentarmorMax = 0x258,
    agentarmorOverflow = 0x248,
    npcArmor = 0x1C4,
    npcArmorMax = 0x1C8,
    weapPtr0 = 0x718,
    weapPtr1 = 0x38,
    weapPtr2 = 0x10,
    rpmFinal = 0x270,  -- RPM final value offset
    reloadField = 0x3B18,  -- reload state offset (0 = not reloading)
    combatAimClipSizeCached = 0x3ADC,
    combatAimRoundsFired = 0x3AE8,
    combatAimCurrentSpread = 0x3B3C,
    combatAimWeaponDataPtr = 0x3A78,
    combatAimSpreadRadius = 0x424C,
    combatAimAccuracyLocked = 0x3C38,
    combatAimFireInterval = 0x3BC8,
    combatAimFiredGate = 0x3A9C,  -- fired gate offset
    combatAimFiredGateCap = 0x3AA0,  -- fired gate cap offset
    combatAimInfiniteAmmo = 0x3C3A,  -- infinite ammo flag offset
    combatAimMoveSpreadAdd = 0x3840,
    combatAimLerpedMoveSpeed = 0x3844,
    weapTemplateDmgMin = 0x18,
    weapTemplateDmgMax = 0x44,
    weapTemplateRpm = 0x304,
    weapTemplateClipSize = 0x318,
    weapTemplateUnlimitedAmmo = 0x320,  -- template unlimited-ammo flag offset
    weapTemplateSwayMoveSpeed = 0x2B4,
    weapTemplateSwayMinH = 0x2B8,
    weapTemplateSwayMaxH = 0x2BC,
    weapTemplateSwayMinV = 0x2C0,
    weapTemplateSwayMaxV = 0x2C4,
    weapTemplateSwayResetDur = 0x2C8,
    weapTemplateSwayInCoverMod = 0x2CC,
    weapTemplateScopeSwaySpeed = 0x2D0,
    weapTemplateDmgMultHead = 0xA0,
    weapTemplateDmgMultBody = 0xA4,
    weapTemplateDmgMultArms = 0xA8,
    weapTemplateDmgMultLegs = 0xAC,
    weapTemplateRange = 0x4C,
    lootManager = 0x80,
    lootCount = 0x30,
    lootArray = 0x28,
    lootPos = 0x38,
    lootItemsCount = 0x20,
    lootItemsBase = 0x18,
    lootFirstEntry = 0x18,
    lootItemStride = 0xE8,
    lootItemDisplay = 0xB0,
    lootItemDefn = 0xA8,
    lootItemRarity = 0xC0,
    lootItemObjName = 0x98,  -- loot item object name offset
    lootItemDefnId = 0x10,
}
BONE_STRIDE = 0x40
BONE_POS_OFF = 0x30
ENTITY_TYPE_GADGET = -1
ENTITY_TYPE_NPC = 5
ENTITY_TYPE_PLAYER = 6
NPC_ARCHETYPE = {
    Unset = 0,
    Assault = 1,
    Rusher = 2,
    Thrower = 3,
    Sniper = 4,
    Controller = 5,
    HeavyWeapons = 6,
    Tank = 7,
    Support = 8,
    Medic = 9,
    Engineer = 10,
    Turret = 11,
    StaticTurret = 12,
    RPG = 13,
    Immobilizer = 14,
    Bomber = 15,
    Flamer = 16,
    Disruptor = 17,
    Shield = 18,
    DroneSuicide = 19,
    DroneTaser = 20,
    DroneRevive = 21,
    MiniTank = 22,
    BigDog = 23,
    BigDogConvoy = 24,
    DroneHelicopter = 25,
    Hunter = 26,
    LootGoblin = 27,
    Bodyguard = 28,
    Leader = 29,
    ChemicalDrone = 30,
    Special = 31,
    Civilian = 32,
    Dog = 33,
    Raven = 34,
    Rat = 35,
    Pigeon = 36,
    Seagull = 37,
    SeekerMine = 38,
    SupportStation = 39,
    Crow = 40,
    Raccoon = 41,
    Squirrel = 42,
    Fox = 43,
    Rabbit = 44,
    Eagle = 45,
    Vulture = 46,
    DestructibleProp = 47,
    Cat = 48,
    RCCar = 49,
    RCBlade = 50,
    Firefly = 51,
    FemaleDeer = 52,
    MaleDeer = 53,
    Monkey = 54,
    Flamingo = 55,
    Crocodile = 56,
    Parrot = 57,
    CatLoco = 58,
    RatLoco = 59,
    JumperCar = 60,
    DroneBomb = 61,
    MGStationary = 62,
    RogueAgent = 63,
    DroneOperator = 64,
    BigDogGrenadier = 65,
    BigDogMinigun = 66,
    SeagullLoco = 67,
    SquirrelLoco = 68,
    SkillDeploymentBox = 69,
    Trap = 70,
    Hive = 71,
    Decoy = 72,
    TurretCleaners = 73,
    AssaultDrone = 74,
    BigDogFlamer = 75,
    DogCompanion = 76,
    SmartCover = 77,
    BigDogMortar = 78,
    BigDogSmall = 79,
}
NPC_THREAT_TIER = { Boss = 0, Heavy = 1, Standard = 2, Skill = 3, NonThreat = 4 }
ARCHETYPE_NAME_BY_ID = {}
for k, v in pairs(NPC_ARCHETYPE) do ARCHETYPE_NAME_BY_ID[v] = k end
ARCHETYPE_WHITELIST_GLOBAL = {}
for _, k in ipairs({
    "Unset", "DestructibleProp", "Civilian",
    "Dog", "Raven", "Rat", "Pigeon", "Seagull", "Crow", "Raccoon", "Squirrel",
    "Fox", "Rabbit", "Eagle", "Vulture", "Cat",
    "FemaleDeer", "MaleDeer", "Monkey", "Flamingo", "Crocodile", "Parrot",
    "CatLoco", "RatLoco", "SeagullLoco", "SquirrelLoco",
}) do ARCHETYPE_WHITELIST_GLOBAL[NPC_ARCHETYPE[k]] = true end
ARCHETYPE_WILDLIFE = {}
for _, k in ipairs({
    "Dog", "Raven", "Rat", "Pigeon", "Seagull", "Crow", "Raccoon", "Squirrel",
    "Fox", "Rabbit", "Eagle", "Vulture", "Cat", "FemaleDeer", "MaleDeer",
    "Monkey", "Flamingo", "Crocodile", "Parrot", "CatLoco", "RatLoco",
    "SeagullLoco", "SquirrelLoco",
}) do ARCHETYPE_WILDLIFE[NPC_ARCHETYPE[k]] = true end
ARCHETYPE_WHITELIST_GADGET = {}
for _, k in ipairs({
    "Turret", "StaticTurret", "MGStationary", "TurretCleaners",
    "ChemicalDrone", "DroneSuicide", "DroneTaser", "DroneRevive",
    "DroneBomb", "AssaultDrone", "SeekerMine", "Trap", "Hive",
    "SupportStation", "SkillDeploymentBox", "RCCar", "RCBlade", "Firefly",
    "JumperCar", "Decoy", "SmartCover", "DogCompanion",
}) do ARCHETYPE_WHITELIST_GADGET[NPC_ARCHETYPE[k]] = true end
ARCHETYPE_COMBATANT = {}
for _, k in ipairs({
    "Assault", "Rusher", "Thrower", "Sniper", "Controller", "HeavyWeapons",
    "Tank", "Support", "Medic", "Engineer", "RPG", "Immobilizer", "Bomber",
    "Flamer", "Disruptor", "Shield", "Hunter", "LootGoblin", "Bodyguard",
    "Leader", "Special", "RogueAgent", "DroneOperator",
    "BigDog", "BigDogConvoy", "BigDogGrenadier", "BigDogMinigun",
    "BigDogFlamer", "BigDogMortar", "BigDogSmall", "MiniTank",
    "DroneSuicide", "DroneTaser", "DroneRevive", "DroneBomb", "AssaultDrone",
    "SeekerMine", "ChemicalDrone", "Turret", "StaticTurret", "MGStationary",
    "TurretCleaners",
}) do ARCHETYPE_COMBATANT[NPC_ARCHETYPE[k]] = true end

function lc(s)
    return (s:gsub("%u", function(c) return c:lower() end))
end
NON_COMBATANT_NAME_PARTS = {}
for _, n in ipairs({
    "box", "crate", "canister", "barrel", "container", "loot", "supply",
    "yellow box", "resource", "cache", "stash", "drop", "package", "briefcase",
    "helicopter", "chopper", "drone carrier", "extraction", "balloon",
    "destructible", "prop", "barrier", "cover", "sandbag", "barricade",
    "generator", "antenna", "terminal", "console", "vending",
}) do NON_COMBATANT_NAME_PARTS[#NON_COMBATANT_NAME_PARTS + 1] = n end

function name_is_blacklisted(name)
    if not name or name == "" then return false end
    local ln = lc(name)
    for _, pat in ipairs(NON_COMBATANT_NAME_PARTS) do
        if ln:find(pat, 1, true) then return true end
    end
    return false
end

CACHE_NAME_PARTS = {}
for _, n in ipairs({
    "cache", "stash", "container", "resource", "ceramic", "component", "material",
    "yellow box", "supply", "drop", "package", "briefcase", "crate", "box", "loot",
}) do CACHE_NAME_PARTS[#CACHE_NAME_PARTS + 1] = n end

function name_is_cache(name)
    if not name or name == "" then return false end
    local ln = lc(name)
    for _, pat in ipairs(CACHE_NAME_PARTS) do
        if ln:find(pat, 1, true) then return true end
    end
    return false
end

-- Caches are identified by name or type string; archetype is unavailable (nil).
function entity_is_cache(e)
    if not e or e.is_player then return false end
    if name_is_cache(e.ent_name) then return true end
    if name_is_cache(e.type_str) then return true end
    return false
end

function count_cache_entities()
    local count = 0
    local nearest, nearest_dist = nil, nil
    for _, e in ipairs(state.entities or {}) do
        if entity_is_cache(e) then
            count = count + 1
            local d = tonumber(e.dist) or 1e9
            if nearest_dist == nil or d < nearest_dist then
                nearest_dist = d
                nearest = e
            end
        end
    end
    return count, nearest, nearest_dist
end

-- BONE PROFILES

BONE_PROFILES = {
    PLAYER_HUMANOID = {
        indices = { 0, 2, 4, 7, 8, 10, 15, 16, 17, 45, 46, 47, 79, 80, 84, 87, 88, 92 },
        connections = {
            { 8, 7 }, { 7, 4 }, { 4, 2 },
            { 4, 15 }, { 15, 16 }, { 16, 17 },
            { 4, 45 }, { 45, 46 }, { 46, 47 },
            { 2, 84 }, { 84, 79 }, { 79, 80 },
            { 2, 92 }, { 92, 87 }, { 87, 88 },
        },
        aim_bone = 8,
        aim_bone_fallback = 7,
        expected = 104,
        is_humanoid = true,
    },
    NPC_HUMANOID = {
        indices = { 0, 2, 4, 6, 8, 9, 14, 15, 17, 44, 45, 47, 78, 79, 83, 86, 87, 91 },
        connections = {
            { 8, 6 }, { 6, 4 }, { 4, 2 },
            { 4, 14 }, { 14, 15 }, { 15, 17 },
            { 4, 44 }, { 44, 45 }, { 45, 47 },
            { 2, 83 }, { 83, 78 }, { 78, 79 },
            { 2, 91 }, { 91, 86 }, { 86, 87 },
        },
        aim_bone = 8,
        aim_bone_fallback = 8,
        expected = 104,
        is_humanoid = true,
    },
    BIG_DOG = {
        indices = { 0, 2, 7, 8, 9, 14, 15, 16, 25, 30, 31, 32, 33, 36, 37, 38, 39 },
        connections = {
            { 9, 8 }, { 8, 7 }, { 7, 2 },
            { 16, 15 }, { 15, 14 }, { 14, 2 },
            { 39, 38 }, { 38, 37 }, { 37, 36 }, { 36, 2 },
            { 33, 32 }, { 32, 31 }, { 31, 30 }, { 30, 2 },
            { 2, 25 },
        },
        aim_bone = 7,
        aim_bone_fallback = 2,
        expected = 0,
        is_humanoid = false,
    },
    WARHOUND_GRENADIER = {
        indices = { 0, 2, 7, 8, 9, 16, 17, 18, 27, 38, 39, 40, 41, 45, 46, 47, 48 },
        connections = {
            { 9, 8 }, { 8, 7 }, { 7, 2 },
            { 18, 17 }, { 17, 16 }, { 16, 2 },
            { 41, 40 }, { 40, 39 }, { 39, 38 }, { 38, 2 },
            { 48, 47 }, { 47, 46 }, { 46, 45 }, { 45, 2 },
            { 2, 27 },
        },
        aim_bone = 7,
        aim_bone_fallback = 2,
        expected = 0,
        is_humanoid = false,
    },
    WARHOUND_MINIGUN = {
        indices = { 0, 2, 7, 8, 9, 16, 17, 18, 27, 34, 35, 36, 37, 40, 41, 42, 44 },
        connections = {
            { 9, 8 }, { 8, 7 }, { 7, 2 },
            { 18, 17 }, { 17, 16 }, { 16, 2 },
            { 44, 42 }, { 42, 41 }, { 41, 40 }, { 40, 2 },
            { 37, 36 }, { 36, 35 }, { 35, 34 }, { 34, 2 },
            { 2, 27 },
        },
        aim_bone = 7,
        aim_bone_fallback = 2,
        expected = 0,
        is_humanoid = false,
    },
    MINITANK = {
        indices = { 0, 1, 7, 8, 13, 14, 15, 16, 22, 23, 28, 29, 31, 33, 35, 37 },
        connections = {
            { 0, 1 }, { 1, 7 }, { 7, 13 }, { 1, 8 }, { 8, 14 },
            { 0, 16 }, { 16, 22 }, { 22, 28 }, { 16, 23 }, { 23, 29 },
            { 31, 33 }, { 33, 35 }, { 33, 37 },
            { 1, 31 }, { 16, 31 },
        },
        aim_bone = 31,
        aim_bone_fallback = 0,
        expected = 40,
        is_humanoid = false,
    },
    DRONE = {
        indices = {},
        connections = {},
        aim_bone = nil,
        aim_bone_fallback = nil,
        expected = 0,
        is_humanoid = false,
    },
    TURRET = {
        indices = {},
        connections = {},
        aim_bone = nil,
        aim_bone_fallback = nil,
        expected = 0,
        is_humanoid = false,
    },
    ITEM = {
        indices = {},
        connections = {},
        aim_bone = nil,
        aim_bone_fallback = nil,
        expected = 0,
        is_humanoid = false,
    },
    NO_SKELETON = {
        indices = {},
        connections = {},
        aim_bone = nil,
        aim_bone_fallback = nil,
        expected = 0,
        is_humanoid = false,
    },
}
ARCHETYPE_PROFILE = {}
for _, k in ipairs({
    "Assault", "Rusher", "Thrower", "Sniper", "Controller", "HeavyWeapons",
    "Tank", "Support", "Medic", "Engineer", "RPG", "Immobilizer", "Bomber",
    "Flamer", "Disruptor", "Shield", "Hunter", "LootGoblin", "Bodyguard",
    "Leader", "Special", "Civilian", "RogueAgent", "DroneOperator",
}) do ARCHETYPE_PROFILE[NPC_ARCHETYPE[k]] = "NPC_HUMANOID" end
for _, k in ipairs({
    "BigDog", "BigDogConvoy", "BigDogFlamer", "BigDogMortar", "BigDogSmall",
    "DogCompanion",
}) do ARCHETYPE_PROFILE[NPC_ARCHETYPE[k]] = "BIG_DOG" end
ARCHETYPE_PROFILE[NPC_ARCHETYPE.BigDogGrenadier] = "WARHOUND_GRENADIER"
ARCHETYPE_PROFILE[NPC_ARCHETYPE.BigDogMinigun] = "WARHOUND_MINIGUN"
ARCHETYPE_PROFILE[NPC_ARCHETYPE.MiniTank] = "MINITANK"
LEGACY_BONE_NAMES = {
    PLAYER_HUMANOID = {
        head = 8,
        chest = 7,
        belly = 4,
        root = 2,
        l_shoulder = 15,
        r_shoulder = 45,
        l_arm = 16,
        r_arm = 46,
        l_hand = 17,
        r_hand = 47,
        l_knee = 79,
        r_knee = 87,
        l_heel = 80,
        r_heel = 88,
        l_toe = 84,
        r_toe = 92
    },
    NPC_HUMANOID = {
        head = 8,
        chest = 6,
        belly = 4,
        root = 2,
        l_shoulder = 14,
        r_shoulder = 44,
        l_arm = 15,
        r_arm = 45,
        l_hand = 17,
        r_hand = 47,
        l_knee = 78,
        r_knee = 86,
        l_heel = 79,
        r_heel = 87,
        l_toe = 83,
        r_toe = 91
    },
    BIG_DOG = { root = 0, pelvis = 2, chest = 7, head = 9, top = 9 },
    WARHOUND_GRENADIER = { root = 0, pelvis = 2, chest = 7, head = 9, top = 9 },
    WARHOUND_MINIGUN = { root = 0, pelvis = 2, chest = 7, head = 9, top = 9 },
    MINITANK = {
        head = 31,
        chest = 33,
        belly = 33,
        root = 0,
        l_top = 31,
        r_top = 35,
        l_front = 1,
        r_front = 16,
        middle = 33,
        top = 37
    },
    DRONE = { root = 0 },
    TURRET = { root = 0 },
    ITEM = { root = 0 },
}
ALL_BONE_IDS_SPARSE = {
    0, 1, 2, 4, 6, 7, 8, 9, 13, 14, 15, 16, 17, 18,
    22, 23, 25, 27, 28, 29, 30, 31, 32, 33, 34, 35,
    36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 47, 48,
    78, 79, 80, 83, 84, 86, 87, 88, 91, 92,
}
ALL_BONE_IDS_0_90 = {}
for i = 0, 90 do ALL_BONE_IDS_0_90[#ALL_BONE_IDS_0_90 + 1] = i end
DEFAULT_RECOIL = 30.0
DEFAULT_SPREAD = 4.0
MAGIC_BULLET_OFF = 0x98
MAGIC_BULLET_ON = 0xFF
RPM_MIN = 60
RPM_MAX = 3000
BATCH_MAX_ENTRIES = 256
BATCH_MAX_BYTES = 4096
TRANSITION_FRAMES = 120
MIN_OVERLAP_CHECK_COUNT = 4
SILENT_LOCK_DELTA = 2.0
LOCK_ID = {
    silent = 10001,
    recoil = 10002,
    spread_rva = 10003,
    spread_a1 = 10004,
    spread_a2 = 10005,
}
ESP_PREDICT_STRENGTH = 0.7
TURRET_BOX_HEIGHT_OFFSET = 1.3
DRONE_BOX_HEIGHT = 0.8
NONSKELETON_AIM_STEP_PX = 2
NONSKELETON_AIM_LIMIT_WORLD = 2.0
NONSKELETON_WORLD_STEP = 0.1
DEFAULT_EXTENDED_RANGE = 100.0
ROBOT_NAME_PROFILE = {
    { "minitank", "MINITANK" },
    { "mini tank", "MINITANK" },
    { "warhound minigun", "WARHOUND_MINIGUN" },
    { "warhound grenadier", "WARHOUND_GRENADIER" },
    { "warhound", "WARHOUND_GRENADIER" },
    { "war hound", "WARHOUND_GRENADIER" },
    { "bigdog", "BIG_DOG" },
    { "big dog", "BIG_DOG" },
    { "canine", "BIG_DOG" },
    { "war dog", "BIG_DOG" },
}
ITEM_NAME_PATTERNS = {
    "battery", "power cell", "powercell", "fuel cell", "fuelcell",
    "energy cell", "capacitor", "reactor", "core",
    "keycard", "key card", "access card", "id card", "badge",
    "intel", "document", "datapad", "hard drive", "harddrive",
    "usb", "disk", "tape", "recording",
    "medkit", "med kit", "first aid", "bandage", "antiviral", "vaccine",
    "ration", "ammo box", "ammo crate",
    "shd tech", "shd cache", "shd node", "satellite", "relay",
    "beacon", "transmitter", "receiver", "uplink",
    "objective", "marker", "waypoint", "checkpoint",
    "supply drop", "airdrop", "cache drop",
}

function name_looks_like_item(name)
    if not name or name == "" then return false end
    local ln = lc(name)
    for _, pat in ipairs(ITEM_NAME_PATTERNS) do
        if ln:find(pat, 1, true) then return true end
    end
    return false
end
ARCHETYPE_IS_DRONE = {}
for _, k in ipairs({
    "DroneSuicide", "DroneTaser", "DroneRevive", "DroneBomb", "AssaultDrone",
    "ChemicalDrone", "DroneHelicopter", "SeekerMine",
}) do ARCHETYPE_IS_DRONE[NPC_ARCHETYPE[k]] = true end
ARCHETYPE_IS_DOG = {}
for _, k in ipairs({
    "BigDog", "BigDogConvoy", "BigDogFlamer", "BigDogMortar", "BigDogSmall",
    "BigDogGrenadier", "BigDogMinigun", "DogCompanion",
}) do ARCHETYPE_IS_DOG[NPC_ARCHETYPE[k]] = true end
ARCHETYPE_IS_TURRET = {}
for _, k in ipairs({
    "Turret", "StaticTurret", "MGStationary", "TurretCleaners",
    "SupportStation", "SkillDeploymentBox",
}) do ARCHETYPE_IS_TURRET[NPC_ARCHETYPE[k]] = true end
ARCHETYPE_IS_GADGET = {}
for _, k in ipairs({
    "RCCar", "RCBlade", "Firefly", "JumperCar",
    "Trap", "Hive", "Decoy", "SmartCover",
}) do ARCHETYPE_IS_GADGET[NPC_ARCHETYPE[k]] = true end

function name_looks_like_robot(name)
    if not name or name == "" then return false end
    local ln = lc(name)
    for _, pair in ipairs(ROBOT_NAME_PROFILE) do
        if ln:find(pair[1], 1, true) then return true end
    end
    return false
end

function profile_name_for(e)
    if e.is_player then return "PLAYER_HUMANOID" end
    if e.archetype ~= nil then
        if ARCHETYPE_IS_DRONE[e.archetype] then return "DRONE" end
        if ARCHETYPE_IS_TURRET[e.archetype] then return "TURRET" end
        local p = ARCHETYPE_PROFILE[e.archetype]
        if p then return p end
    end
    if e.ent_name and e.ent_name ~= "" and name_looks_like_item(e.ent_name) then
        return "ITEM"
    end
    if e.archetype ~= nil then return "NO_SKELETON" end
    return "NPC_HUMANOID"
end
state = nil

function get_color(e)
    if e.is_player then
        if e.relation == "hostile" then return { 255, 140, 25 } end
        return { 51, 102, 255 }
    end
    if e.is_low_hp then return { 128, 128, 128 } end
    if e.relation == "hostile" then return { 255, 38, 38 } end
    if e.relation == "friendly" then return { 25, 230, 51 } end
    if e.relation == "neutral" then return { 255, 255, 80 } end
    return { 180, 80, 255 }
end

function aimbot_priority(e)
    if e.entity_type == ENTITY_TYPE_GADGET then return 1 end
    return 3
end

function is_silent_target(e)
    -- Rogue agents are hostile player-type entities, so they are valid targets; friendly/neutral players are still rejected.
    -- Nameless hostiles (empty name and type) still pass: an empty name is neither an item nor blacklisted.
    -- 'Target Friendlies' (default off): also locks onto friendly entities, including teammates in group play.
    local allow_friendly = state.silent_target_friendly and e.relation == "friendly"
    if e.is_player and e.relation ~= "hostile" and not allow_friendly then return false end
    if e.is_player and not state.silent_target_rogues and not allow_friendly then return false end
    if e.is_downed then return false end
    -- 'Ignore Gadgets': when on, silent aim ignores every gadget (shield generators, drones, stations).
    if state.ignore_gadgets and e.entity_type_int == ENTITY_TYPE_GADGET then return false end
    if e.entity_type ~= ENTITY_TYPE_NPC and not (e.is_player and (e.relation == "hostile" or allow_friendly)) then return false end
    if e.archetype and ARCHETYPE_WILDLIFE[e.archetype] then return false end
    if e.relation == "neutral" then return false end
    if e.relation == "friendly" and not allow_friendly then return false end
    if e.archetype == NPC_ARCHETYPE.DestructibleProp then return true end
    if e.is_summoned and not state.silent_target_summon then return false end
    local pname = profile_name_for(e)
    if pname ~= "TURRET" and pname ~= "BIG_DOG"
        and pname ~= "WARHOUND_GRENADIER" and pname ~= "WARHOUND_MINIGUN"
        and pname ~= "MINITANK"
        and name_is_blacklisted(e.ent_name) then
        return false
    end
    if pname == "TURRET" then return true end
    if pname == "ITEM" then return false end
    if e.is_summoned and e.relation ~= "hostile" then return false end
    if e.archetype ~= nil then
        if ARCHETYPE_WHITELIST_GLOBAL[e.archetype] then return false end
        if ARCHETYPE_COMBATANT[e.archetype] then return true end
        if ARCHETYPE_WHITELIST_GADGET[e.archetype] then return true end
    end
    if e.relation == "unknown" and name_looks_like_robot(e.ent_name) then
        return true
    end
    if e.relation == "unknown"
        and (pname == "DRONE" or pname == "TURRET"
            or pname == "BIG_DOG" or pname == "WARHOUND_GRENADIER"
            or pname == "WARHOUND_MINIGUN" or pname == "MINITANK") then
        return true
    end
    return e.relation == "hostile"
end

-- STATE

state = {
    name = "TheDivision2.exe",
    pid = 0,
    base = 0,
    status = "Ready",
    scan_info = "",
    stats_timer = 0,
    config_save_timer = 0,
    walk_skip = 0,
    show_ui = true,
    show_info_overlay = true,
    toggle_cooldown = 0,
    _key_prev = {},
    esp_enabled = false,
    esp_boxes = true,
    esp_snaplines = false,
    esp_distance = true,
    esp_bones = true,
    esp_bone_ids = false,
    esp_type = false,
    esp_name = true,
    esp_show_hostile = true,
    esp_show_friendly = false,
    esp_show_players = false,
    esp_show_wildlife = false,
    esp_show_neutral = false,
    esp_show_other = false,
    esp_show_caches = true,  -- ESP-mark component caches / containers (default on)
    esp_show_relation = false,
    esp_show_faction = false,
    esp_show_silent_fov = true,
    esp_max_dist = 150,
    esp_armor = true,
    esp_loot = true,
    loot_text_size = 10,
    loot_max_dist = 150,
    loot_show_boxes = false,
    loot_show_r0 = true,
    loot_show_r1 = true,
    loot_show_r2 = true,
    loot_show_r3 = true,
    loot_show_r4 = true,
    loot_show_r5 = true,
    loot_show_r6 = true,
    loot_show_r7 = true,
    loot_show_r8 = true,
    loot_show_r9 = true,
    loot_show_r11 = true,
    loot_show_other = true,
    target_marker_size = 3,
    crosshair_enabled = true,
    crosshair_size = 14,
    crosshair_gap = 10,
    crosshair_thick = 1.2,
    crosshair_dot = true,
    crosshair_dot_size = 1.2,
    crosshair_outline = true,
    silent_enabled = false,
    silent_target_summon = true,
    silent_target_rogues = true,
    silent_target_friendly = false,  -- 'Target Friendlies' toggle, default off
    silent_fov = 150,
    silent_360 = false,  -- 360-degree silent aim, no FOV limit (default off)
    show_entity_counter = false,  -- on-screen entity counter (default off)
    counter_x = 12,  -- counter position X (slider, persisted)
    counter_y = 12,  -- counter position Y (slider, persisted)
    counter_collapsed = false,  -- counter box collapsed (F8 / checkbox, persisted)
    silent_max_dist = 150,
    silent_target_name = "",
    silent_last_rounds = 0,
    silent_fired = false,
    silent_lock_addr = nil,
    silent_shots = 0,
    silent_armed = false,
    silent_seen_gen = 0,
    silent_target_ptr = nil,
    aim_part = "head",
    dynamic_aim = true,
    boneless_override = true,
    nonskeleton_aim_offsets = {},
    target_gadgets = false,
    ignore_gadgets = false,  -- Ignore Gadgets toggle (default off, not persisted)
    no_recoil = false,
    recoil_locked = false,
    no_spread = false,
    spread_rva_locked = false,
    spread_aim_addrs = nil,
    magic_bullet = false,
    fragile_armor = false,  -- Fragile Enemy Armor (default off; enable in Toggles after F1)
    infinite_ammo = false,  -- infinite ammo (default off)
    auto_loot_all = false,  -- Auto-Loot All Items master (PgDn, default off)
    loot_auto_r0 = true, loot_auto_r1 = true, loot_auto_r2 = true, loot_auto_r3 = true,
    loot_auto_r4 = true, loot_auto_r5 = true, loot_auto_r6 = true, loot_auto_r7 = true,
    loot_auto_r8 = true, loot_auto_r9 = true, loot_auto_r11 = true, loot_auto_other = true,
    high_headshot_dmg = false,  -- high headshot damage (default off)
    fast_fire = false,  -- fast fire interval (default off)
    instant_reload = false,
    rpm_enabled = false,
    rpm_value = 600,
    rpm_original = nil,
    rpm_live = 0.0,
    rpm_template_live = 0.0,
    rpm_template_original = nil,
    rpm_seen_gen = 0,
    no_sway = false,
    sway_saved = {
        min_h = nil, max_h = nil, min_v = nil, max_v = nil, reset_dur = nil, scope_speed = nil,
    },
    no_sway_live = 0.0,
    sway_seen_gen = 0,
    extended_range = false,
    extended_range_live = nil,
    ext_seen_gen = 0,
    move_speed = false,
    move_speed_live = nil,
    move_spread_add_live = nil,
    move_seen_gen = 0,
    master_enabled = true,
    master_snapshot = nil,
    time_mode = "normal",
    read_rva = "0x6426638",
    read_size = 16,
    read_result = "",
    preset_slot = {},
    active_preset = 1,
    entities = {},
    local_pos = { 0, 0, 0 },
    viewproj = nil,
    window_rect = nil,
    wr_timer = 0,
    attach_timer = 0,
    faction_tag_cache = {},
    faction_tag_pid = 0,
    _last_arr_ptr = 0,
    _last_count = 0,
    _last_ptrs = nil,
    _prev_pos_by_ptr = nil,
    _was_attached = false,
    _stable_frames = 0,
    _transition_frames = 0,
    _weapon_ptr = 0,
    _weapon_gen = 0,
    _weapon_cached_frame = -1,
    _weapon_fingerprint = nil,
    diag_last_write = nil,
    splash_text = "",
    splash_timer = 0,
    selected_target_ptr = 0,
    telem_valid = false,
    telem_world_aim = nil,
    telem_lock_target = nil,
    telem_delta = nil,
    telem_rounds = 0,
    telem_lock_addr = nil,
    dbg_lp_pos = nil,
    dbg_bone0 = nil,
    dbg_err = nil,
    lp_name = "",
    lp_name_ptr = 0,
    hp = 0,
    hp_max = 0,
    armor = 0,
    armor_max = 0,
}
MASTER_KEYS = {
    "esp_enabled", "esp_loot", "crosshair_enabled", "silent_enabled",
    "target_gadgets", "silent_target_rogues", "silent_target_friendly", "silent_360", "dynamic_aim", "boneless_override",
    "no_recoil", "no_spread", "magic_bullet", "fragile_armor", "no_sway", "move_speed",
    "extended_range", "instant_reload", "rpm_enabled",
    "auto_loot_all", "high_headshot_dmg", "fast_fire",
    "esp_boxes", "esp_snaplines", "esp_distance", "esp_bones", "esp_bone_ids",
    "esp_type", "esp_name", "esp_show_hostile", "esp_show_friendly",
    "esp_show_players", "esp_show_wildlife", "esp_show_neutral", "esp_show_other", "esp_show_caches",
    "esp_show_relation", "esp_show_faction", "esp_show_silent_fov",
    "loot_show_r0", "loot_show_r1", "loot_show_r2", "loot_show_r3",
    "loot_show_r4", "loot_show_r5", "loot_show_r6", "loot_show_r7", "loot_show_r8",
    "loot_show_r9", "loot_show_r11", "loot_show_other", "loot_show_boxes",
    "loot_auto_r0", "loot_auto_r1", "loot_auto_r2", "loot_auto_r3",
    "loot_auto_r4", "loot_auto_r5", "loot_auto_r6", "loot_auto_r7", "loot_auto_r8",
    "loot_auto_r9", "loot_auto_r11", "loot_auto_other",
    "crosshair_dot", "crosshair_outline",
}

function show_splash(text)
    state.splash_text = text
    state.splash_timer = 2.0
end
CFG_PREFIX = "td2."
PERSIST_KEYS = {
    "name",
    "master_enabled",
    "time_mode",
    "esp_enabled",
    "esp_boxes",
    "esp_armor",
    "esp_loot",
    "loot_text_size",
    "loot_max_dist",
    "loot_show_boxes",
    "loot_show_r0",
    "loot_show_r1",
    "loot_show_r2",
    "loot_show_r3",
    "loot_show_r4",
    "loot_show_r5",
    "loot_show_r6",
    "loot_show_r7",
    "loot_show_r8",
    "loot_show_r9",
    "loot_show_r11",
    "loot_show_other",
    "loot_auto_r0",
    "loot_auto_r1",
    "loot_auto_r2",
    "loot_auto_r3",
    "loot_auto_r4",
    "loot_auto_r5",
    "loot_auto_r6",
    "loot_auto_r7",
    "loot_auto_r8",
    "loot_auto_r9",
    "loot_auto_r11",
    "loot_auto_other",
    "esp_distance",
    "esp_snaplines",
    "esp_bones",
    "esp_bone_ids",
    "esp_type",
    "esp_name",
    "esp_show_hostile",
    "esp_show_friendly",
    "esp_show_players",
    "esp_show_wildlife",
    "esp_show_neutral",
    "esp_show_other",
    "esp_show_caches",
    "esp_show_relation",
    "esp_show_faction",
    "esp_max_dist",
    "esp_show_silent_fov",
    "silent_enabled",
    "silent_target_summon",
    "silent_target_rogues", "silent_target_friendly", "silent_360", "show_entity_counter", "counter_x", "counter_y", "counter_collapsed",
    "silent_fov",
    "silent_max_dist",
    "aim_part",
    "dynamic_aim",
    "boneless_override",
    "target_gadgets",
    "no_recoil",
    "no_spread",
    "magic_bullet",
    "fragile_armor",
    "auto_loot_all",
    "high_headshot_dmg",
    "fast_fire",
    "no_sway",
    "move_speed",
    "extended_range",
    "instant_reload",
    "rpm_enabled",
    "rpm_value",
    "crosshair_enabled",
    "crosshair_size",
    "crosshair_gap",
    "crosshair_thick",
    "crosshair_dot",
    "crosshair_dot_size",
    "crosshair_outline",
    "target_marker_size"
}

function write_cfg_to_memory()
    if not config then return false, "Config API unavailable" end
    for _, k in ipairs(PERSIST_KEYS) do
        local v = state[k]
        if not state.master_enabled and state.master_snapshot then
            if state.master_snapshot[k] ~= nil then
                v = state.master_snapshot[k]
            elseif k == "time_mode" and state.master_snapshot.time_mode ~= nil then
                v = state.master_snapshot.time_mode
            elseif k == "aim_part" and state.master_snapshot.aim_part ~= nil then
                v = state.master_snapshot.aim_part
            end
        end
        if type(v) == "boolean" or type(v) == "number" or type(v) == "string" then
            pcall(config.set, CFG_PREFIX .. k, v)
        end
    end
    return true
end

function save_config_now()
    if not config then return false end
    pcall(write_cfg_to_memory)
    if not config.save then return false end
    local ok = pcall(config.save)
    return ok
end

function read_cfg_into_state()
    if not config then return false, "Config API unavailable" end
    for _, k in ipairs(PERSIST_KEYS) do
        local ok, v = pcall(config.get, CFG_PREFIX .. k, nil)
        if ok and v ~= nil then state[k] = v end
    end
    if not state.master_enabled then
        state.master_snapshot = {}
        for _, k in ipairs(MASTER_KEYS) do
            state.master_snapshot[k] = state[k]
            state[k] = false
        end
        state.master_snapshot.time_mode = state.time_mode
        state.master_snapshot.aim_part = state.aim_part
        state.time_mode = "normal"
        if state.aim_part == "dynamic" then state.aim_part = "head" end
    end
    return true
end

function serialize_table(val)
    local t = type(val)
    if t == "table" then
        local sb = { "{" }
        for k, v in pairs(val) do
            local ks = type(k) == "string" and string.format("[%q]", k) or string.format("[%d]", k)
            table.insert(sb, ks .. "=" .. serialize_table(v) .. ",")
        end
        table.insert(sb, "}")
        return table.concat(sb)
    elseif t == "string" then
        return string.format("%q", val)
    elseif t == "number" or t == "boolean" then
        return tostring(val)
    else
        return "nil"
    end
end

function save_presets_to_file()
    if not config then return end
    for i = 1, 4 do
        local slot = state.preset_slot[i]
        if slot then
            for k, v in pairs(slot) do
                if type(v) == "boolean" or type(v) == "number" or type(v) == "string" then
                    pcall(config.set, string.format("td2.preset_%d_%s", i, k), v)
                end
            end
        end
    end
    pcall(config.set, "td2.active_preset", state.active_preset)
    if config.save then pcall(config.save) end
    state.status = "Presets saved to config"
end

function load_presets_from_file()
    if not config then return end
    local ok, ap = pcall(config.get, "td2.active_preset", 1)
    if ok and ap ~= nil then state.active_preset = ap end
    for i = 1, 4 do
        local slot = {}
        local loaded_any = false
        for _, k in ipairs(PERSIST_KEYS) do
            local ok_v, val = pcall(config.get, string.format("td2.preset_%d_%s", i, k), nil)
            if ok_v and val ~= nil then
                slot[k] = val
                loaded_any = true
            end
        end
        if loaded_any then
            state.preset_slot[i] = slot
        end
    end
    state.status = "Presets loaded from config"
end

function save_current_to_preset(index)
    if not state.master_enabled then
        show_splash("Enable Master before saving a preset")
        return
    end
    local slot = {}
    for _, k in ipairs(PERSIST_KEYS) do
        if k ~= "master_enabled" then slot[k] = state[k] end
    end
    state.preset_slot[index] = slot
    state.active_preset = index
    save_presets_to_file()
    show_splash(string.format("Preset %d Saved", index))
end

function load_preset_slot(index)
    if not state.master_enabled then
        show_splash("Enable Master before loading a preset")
        return
    end
    local slot = state.preset_slot[index]
    if not slot then
        show_splash(string.format("Preset %d Empty", index))
        return
    end
    for _, k in ipairs(PERSIST_KEYS) do
        if k ~= "master_enabled" and slot[k] ~= nil then
            state[k] = slot[k]
        end
    end
    state.active_preset = index
    save_presets_to_file()
    show_splash(string.format("Preset %d Loaded", index))
end

-- HELPERS

to_f32, from_f32 = nil, nil
if string.pack and string.unpack then
    to_f32 = function(v) return string.unpack("<I4", string.pack("<f", v)) end
    from_f32 = function(b) return string.unpack("<f", string.pack("<I4", b)) end
else
    to_f32 = function(value)
        if value == 0 then return 0 end
        local sign = 0
        if value < 0 then
            sign = 0x80000000; value = -value
        end
        local mantissa, exponent = math.frexp(value)
        local biased = exponent + 126
        if biased <= 0 then return sign end
        if biased >= 255 then return sign + 0x7F800000 end
        return sign + biased * 0x800000 + math.floor((mantissa * 2 - 1) * 0x800000 + 0.5)
    end
    from_f32 = function(bits)
        if bits >= 0x80000000 then return -from_f32(bits - 0x80000000) end
        local exponent = math.floor(bits / 0x800000)
        local mantissa = bits % 0x800000
        if exponent == 255 then return 0 end
        if exponent == 0 then return math.ldexp(mantissa / 0x800000, -126) end
        return math.ldexp(1 + mantissa / 0x800000, exponent - 127)
    end
end

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
MIN_USER_ADDR = 0x10000
MAX_USER_ADDR = 0x7FFFFFFFFFFF

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

function pad_to(t, n)
    for i = #t + 1, n do t[i] = 0 end
    return t
end

function read_bytes_table(addr, n)
    if not state.pid or state.pid <= 0 or not is_valid_addr(addr, n) then
        report_memory_error("read", "invalid PID/address/size")
        return pad_to({}, n), 0
    end
    local ok, raw = pcall(memory.read_bytes, state.pid, addr, n)
    if not ok then
        report_memory_error("read", raw)
        return pad_to({}, n), 0
    end
    local t, len = to_byte_table(raw)
    if len < n then pad_to(t, n) end
    return t, len
end

function read_uint(addr, n)
    local data = read_bytes_table(addr, n)
    return uint_from(data, 1, n)
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

function is_hostile_archetype(a)
    if ARCHETYPE_WHITELIST_GLOBAL[a] then return false end
    return true
end

function read_faction_template_tag(faction_ptr)
    local raw, len = read_bytes_table(faction_ptr + OFF.factionTag, 16)
    if len < 16 then return "" end
    local chars = {}
    for i = 1, 16 do
        local b = raw[i]
        if b == 0 then break end
        if b < 0x20 or b >= 0x7F then return "" end
        chars[#chars + 1] = string.char(b)
    end
    return table.concat(chars)
end
ENEMY_FACTION_TAGS = {
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
    if not tag or tag == "" then return nil end
    return ENEMY_FACTION_TAGS[string.lower(tag)]
end

function faction_display(fac, tag)
    local n = enemy_tag_entry(tag)
    if n then return n[1] end
    if tag and tag ~= "" then return tag end
    return string.format("fac:0x%X", fac)
end

function faction_display_en(fac, tag)
    local n = enemy_tag_entry(tag)
    if n then return n[2] end
    return string.format("fac:0x%X", fac)
end
RELATION_HOSTILE = { 0xBF, 0x06, 0x3D, 0x2C, 0x0F, 0xC0, 0x16, 0x0C }
RELATION_FRIENDLY = { 0x0D, 0x56, 0x38, 0xF4, 0x20, 0x76, 0x01, 0x00 }
RELATION_NEUTRAL = { 0xA4, 0x46, 0x88, 0x82, 0x54, 0xF0, 0x03, 0x00 }

function match_relation(raw, off, pattern)
    for i = 1, 8 do
        if raw[off + i] ~= pattern[i] then return false end
    end
    return true
end

function classify_pipeline(e, ctx)
    local etype = e.entity_type_int
    if etype == ENTITY_TYPE_NPC or etype == ENTITY_TYPE_GADGET then
        if e.tier_valid and e.tier == NPC_THREAT_TIER.NonThreat then
            return "friendly"
        end
        local a = e.archetype
        if a == nil then a = NPC_ARCHETYPE.Unset end
        if not is_hostile_archetype(a) then return "friendly" end
    end
    if ctx.local_faction ~= 0 and e.faction ~= 0 then
        if etype == ENTITY_TYPE_GADGET and not state.target_gadgets then
            return "friendly"
        end
        local tag = ctx.tag_cache[e.faction]
        if tag == nil then
            tag = read_faction_template_tag(e.faction)
            if tag ~= "" then
                ctx.tag_cache[e.faction] = tag
            end
        end
        if tag == "PlayerServices" or tag == "Staff" then return "friendly" end
        if e.faction ~= ctx.local_faction then return "hostile" end
        return "friendly"
    end
    return "unknown"
end

function classify_entity(e, ctx)
    if ctx.local_player == 0 then return "unknown" end
    if enemy_tag_entry(e.faction_tag) then return "hostile" end
    local classified = classify_pipeline(e, ctx)
    if not e.is_player then
        -- The direct relation bytes are authoritative: all entities share one faction pointer, so the faction comparison alone cannot distinguish hostile from friendly.
        if e.rel_verdict then return e.rel_verdict end
        return classified
    end
    -- For player-type entities the relation bytes are authoritative: a hostile player-type entity is a Rogue, a friendly/neutral one is a teammate.
    if e.rel_verdict then return e.rel_verdict end
    return classified
end

function batch_read_chunked(pid, stride, addrs)
    local n = #addrs
    if n == 0 then return {} end
    local per_call = math.min(BATCH_MAX_ENTRIES, math.floor(BATCH_MAX_BYTES / stride))
    if per_call < 1 then return {} end
    local out = {}
    local i = 1
    while i <= n do
        local last = math.min(i + per_call - 1, n)
        local sub = {}
        for k = i, last do sub[#sub + 1] = addrs[k] end
        local expect = #sub * stride
        local valid = pid and pid > 0 and is_finite(stride) and stride % 1 == 0 and stride > 0
        if valid then
            for _, addr in ipairs(sub) do
                if not is_valid_addr(addr, stride) then valid = false; break end
            end
        end
        local ok, raw = false, nil
        if valid then ok, raw = pcall(memory.batch_read, pid, stride, sub) end
        if not ok then report_memory_error("batch read", raw or "invalid PID/address/stride") end
        local data, dlen = to_byte_table(ok and raw or nil)
        if dlen == 0 then
            for _ = 1, expect do out[#out + 1] = 0 end
        else
            if dlen < expect then pad_to(data, expect) end
            for b = 1, expect do out[#out + 1] = data[b] end
        end
        i = last + 1
    end
    return out
end

function read_f32(addr) return from_f32(read_uint(addr, 4)) end

function write_f32(addr, value) write_uint(addr, to_f32(value), 4) end

function pack_f32(value)
    local bits = to_f32(value)
    local out = {}
    for i = 1, 4 do
        out[i] = bits % 256; bits = math.floor(bits / 256)
    end
    return out
end

function read_sd_string(addr)
    local hdr = read_bytes_table(addr, 32)
    if #hdr < 32 then return "" end
    local size = uint_from(hdr, 17, 8)
    if size == 0 or size > 128 then return "" end
    local bytes
    local cap = uint_from(hdr, 25, 8)
    if cap <= 15 then
        bytes = {}
        for i = 1, size do bytes[i] = hdr[i] end
    else
        local ptr = uint_from(hdr, 1, 8)
        if ptr == 0 then return "" end
        bytes = read_bytes_table(ptr, size)
    end
    local chars = {}
    for i = 1, size do chars[i] = string.char(bytes[i] or 0) end
    return table.concat(chars)
end
WALK_SKIP_COOLDOWN = 120

function safe_walk(pid, base, offsets)
    if state.walk_skip > 0 then return 0 end
    local ok, res = pcall(memory.traverse_pointer_chain, pid, base, offsets)
    if not ok then
        state.walk_skip = WALK_SKIP_COOLDOWN
        state.status = "Pointer walk: " .. tostring(res) ..
            " (cooldown " .. WALK_SKIP_COOLDOWN .. ")"
        return 0
    end
    return res or 0
end

function get_localplayer()
    return safe_walk(state.pid, state.base, {
        RVA.rlclient, OFF.pClient, OFF.pObject,
        OFF.localStage0, OFF.localStage1, OFF.localStage2,
    })
end

function resolve_rpm_target(lp)
    if lp == 0 then return 0 end
    local w1 = read_uint(lp + OFF.weapPtr0, 8)
    if w1 == 0 then return 0 end
    local w2 = read_uint(w1 + OFF.weapPtr1, 8)
    if w2 == 0 then return 0 end
    return read_uint(w2 + OFF.weapPtr2, 8)
end

function read_npc_archetype_and_tier(ent)
    if not OFF.npcDescriptorPtr then return nil, nil end
    local agent = read_uint(ent + OFF.npcDescriptorPtr, 8)
    if agent == 0 then return nil, nil end
    local desc = read_uint(agent + OFF.npcAgentDescriptor, 8)
    if desc == 0 then return nil, nil end
    local a_raw = read_uint(desc + OFF.npcArchetypeOffset, 4)
    local t_raw = read_uint(desc + OFF.npcTierOffset, 4)
    local archetype = (a_raw < 80) and a_raw or nil
    local tier = (t_raw < 5) and t_raw or nil
    return archetype, tier
end

-- WEAPON CACHE

_frame_id = 0

function refresh_weapon_cache(force)
    if not force and state._weapon_cached_frame == _frame_id then
        return
    end
    state._weapon_cached_frame = _frame_id
    local lp = get_localplayer()
    if lp == 0 then
        if state._weapon_ptr ~= 0 then
            state._weapon_ptr = 0
            state._weapon_gen = state._weapon_gen + 1
        end
        state._weapon_fingerprint = nil
        return
    end
    local w3 = resolve_rpm_target(lp)
    if w3 == 0 then
        if state._weapon_ptr ~= 0 then
            state._weapon_ptr = 0
            state._weapon_gen = state._weapon_gen + 1
        end
        state._weapon_fingerprint = nil
        return
    end
    local clip = read_uint(w3 + OFF.weapTemplateClipSize, 4)
    local dmg = read_uint(w3 + OFF.weapTemplateDmgMin, 4)
    if clip == 0 or dmg == 0 then
        return
    end
    local fingerprint = clip * 0x100000000 + dmg
    if w3 ~= state._weapon_ptr then
        state._weapon_ptr = w3
        state._weapon_gen = state._weapon_gen + 1
        state._weapon_fingerprint = fingerprint
    elseif state._weapon_fingerprint ~= nil
        and state._weapon_fingerprint ~= fingerprint then
        state._weapon_gen = state._weapon_gen + 1
        state._weapon_fingerprint = fingerprint
    else
        state._weapon_fingerprint = fingerprint
    end
end

function weapon_gen()
    refresh_weapon_cache(false)
    return state._weapon_gen
end

function reset_weapon_cache()
    state.rpm_original = nil
    state.rpm_template_original = nil
    state.extended_range_live = nil
    state.move_speed_live = nil
    state.move_spread_add_live = nil
    state.no_sway_live = 0
    state.sway_saved = {
        min_h = nil,
        max_h = nil,
        min_v = nil,
        max_v = nil,
        reset_dur = nil,
        scope_speed = nil,
    }
    state._weapon_ptr = 0
    state._weapon_fingerprint = nil
    state._weapon_cached_frame = -1
    state._weapon_gen = state._weapon_gen + 1
    state.rpm_seen_gen = state._weapon_gen
    state.sway_seen_gen = state._weapon_gen
    state.ext_seen_gen = state._weapon_gen
    state.move_seen_gen = state._weapon_gen
    state.silent_seen_gen = state._weapon_gen
end

function invalidate_on_transition(pid)
    if state.silent_lock_addr then
        pcall(memory.unlock, LOCK_ID.silent)
        state.silent_lock_addr = nil
    end
    if state.spread_aim_addrs then
        pcall(memory.unlock, LOCK_ID.spread_a1)
        pcall(memory.unlock, LOCK_ID.spread_a2)
        state.spread_aim_addrs = nil
    end
    state.recoil_locked = false
    state.spread_rva_locked = false
    reset_weapon_cache()
    state.silent_armed = false
    state.silent_last_rounds = 0
    state.silent_target_ptr = nil
    state.diag_last_write = nil
    state.telem_valid = false
    state.telem_world_aim = nil
    state.telem_lock_target = nil
    state.telem_delta = nil
    state.telem_rounds = 0
    state.telem_lock_addr = nil
    state._transition_frames = TRANSITION_FRAMES
    state._stable_frames = 0
    state.walk_skip = 0
    state._prev_pos_by_ptr = nil
    state.entities = {}
end

function process_is_alive(pid, expected_base)
    if not pid or pid <= 0 then return false, "invalid PID" end
    if not memory or not memory.get_process_base then return nil, "memory API unavailable" end
    local ok, base = pcall(memory.get_process_base, pid)
    if not ok then return nil, tostring(base) end
    if not is_valid_addr(base, 1) then return false, "process is no longer available" end
    if expected_base and expected_base ~= 0 and base ~= expected_base then
        return false, "process base changed"
    end
    return true
end

function detach_stale_process(reason)
    local old_pid = state.pid
    if state.master_enabled and not state.master_snapshot then
        state.master_snapshot = {}
        for _, key in ipairs(MASTER_KEYS) do
            state.master_snapshot[key] = state[key]
        end
        state.master_snapshot.time_mode = state.time_mode
        state.master_snapshot.aim_part = state.aim_part
    end
    if old_pid and old_pid > 0 and memory.unlock_all then
        pcall(memory.unlock_all, old_pid)
    end
    invalidate_on_transition(old_pid)
    state.pid, state.base = 0, 0
    state._was_attached = false
    state.entities = {}
    state.attach_timer = 0
    for _, key in ipairs({ "no_recoil", "no_spread", "rpm_enabled", "instant_reload",
        "no_sway", "extended_range", "move_speed", "silent_enabled", "magic_bullet", "fragile_armor",
        "auto_loot_all", "high_headshot_dmg", "fast_fire",
        "no_flash", "no_smoke", "no_suppression", "time_enabled" }) do
        if state[key] ~= nil then state[key] = false end
    end
    state.master_enabled = false
    state.status = "Detached: " .. tostring(reason or "process unavailable")
    state.memory_error = nil
end

function chk(label, key, apply_fn)
    local v, changed = ui.checkbox(label, state[key])
    if not state.master_enabled then
        state[key] = false
        return false
    end
    state[key] = v
    if changed and apply_fn then pcall(apply_fn) end
    return v
end

function checkbox_edge(label, active)
    local a, b = ui.checkbox(label, active)
    if b ~= nil then return b == true end
    return a ~= active
end

function draw_fov_circle(cx, cy, radius, r, g, b, a)
    r, g, b, a = r or 255, g or 255, b or 255, a or 160
    if not radius or radius <= 0 then return end
    if draw.circle then
        local ok = pcall(draw.circle, cx, cy, radius, r, g, b, a, 1.0)
        if ok then
            pcall(draw.circle, cx, cy, radius + 1, 0, 0, 0, 90, 1.0)
            return
        end
    end
    local segs = 64
    for i = 0, segs - 1 do
        local a1 = (i / segs) * math.pi * 2
        local a2 = ((i + 1) / segs) * math.pi * 2
        draw.line(
            cx + math.cos(a1) * radius, cy + math.sin(a1) * radius,
            cx + math.cos(a2) * radius, cy + math.sin(a2) * radius,
            r, g, b, a, 1.0
        )
    end
end

-- Count alive hostiles as Humans and Non-Humans (bots and gadgets).
function counter_counts()
    local human, nonhuman = 0, 0
    local local_faction = 0
    for _, e in ipairs(state.entities or {}) do
        if e and e.is_local_player and e.faction and e.faction ~= 0 then
            local_faction = e.faction
            break
        end
    end
    for _, e in ipairs(state.entities or {}) do
        if e and not e.is_downed then
            if e.entity_type_int == ENTITY_TYPE_GADGET then
                local enemy = false
                if e.faction and e.faction ~= 0 and local_faction ~= 0 and e.faction ~= local_faction then
                    enemy = true
                elseif e.relation == "hostile" then
                    enemy = true
                end
                if enemy then nonhuman = nonhuman + 1 end
            elseif e.relation == "hostile" then
                local pname = profile_name_for(e)
                local prof = pname and BONE_PROFILES[pname] or nil
                local is_human = true
                if prof ~= nil then is_human = prof.is_humanoid == true end
                if is_human then human = human + 1 else nonhuman = nonhuman + 1 end
            end
        end
    end
    return human, nonhuman
end

-- On-screen entity counter as a collapsible drawn box (F8 or the checkbox toggles it; position from the Counter X/Y sliders).
function draw_entity_counter(w)
    if not state.show_entity_counter or not w then return end
    local human, nonhuman = counter_counts()
    local size = 14
    local pad = 8
    local line_h = 20
    local header = state.counter_collapsed and "> ENTITIES" or "v ENTITIES"
    local lines = { header }
    if not state.counter_collapsed then
        lines[2] = string.format("Humans: %d", human)
        lines[3] = string.format("Non-Humans: %d", nonhuman)
    end
    local maxw = 0
    for _, ln in ipairs(lines) do
        local tw = 0
        if draw.get_text_width then
            local ok, v = pcall(draw.get_text_width, ln, size)
            if ok and type(v) == "number" then tw = v end
        end
        if tw <= 0 then tw = #ln * 8 end
        if tw > maxw then maxw = tw end
    end
    local x = (w.x or 0) + (tonumber(state.counter_x) or 12)
    local y = (w.y or 0) + (tonumber(state.counter_y) or 12)
    local box_w = maxw + pad * 2
    local box_h = #lines * line_h + pad * 2
    pcall(draw.filled_rect, x, y, box_w, box_h, 0, 0, 0, 170)
    pcall(draw.rect, x, y, box_w, box_h, 255, 200, 0, 180, 1.0)
    for i, ln in ipairs(lines) do
        local ty = y + pad + (i - 1) * line_h
        pcall(draw.text, x + pad + 1, ty + 1, ln, 0, 0, 0, 220, size)
        pcall(draw.text, x + pad, ty, ln, 255, 255, 255, 235, size)
    end
end

function draw_circle_filled(cx, cy, radius, r, g, b, a)
    if not radius or radius <= 0 then return end
    r, g, b, a = r or 255, g or 255, b or 255, a or 255
    if draw.filled_circle then
        local ok = pcall(draw.filled_circle, cx, cy, radius, r, g, b, a)
        if ok then return end
    end
    local ir = math.floor(radius + 0.5)
    if ir < 1 then ir = 1 end
    if draw.circle then
        for i = ir, 1, -1 do pcall(draw.circle, cx, cy, i, r, g, b, a, 1.0) end
    else
        draw.filled_rect(cx - radius, cy - radius, radius * 2, radius * 2, r, g, b, a)
    end
end

function draw_crosshair(w)
    if not state.crosshair_enabled or not w then return end
    local cx = w.x + w.width / 2
    local cy = w.y + w.height / 2
    local size = state.crosshair_size or 14
    local gap = state.crosshair_gap or 6
    local th = state.crosshair_thick or 2
    local outline = state.crosshair_outline ~= false
    local function seg(x1, y1, x2, y2)
        if outline then draw.line(x1, y1, x2, y2, 0, 0, 0, 220, th + 2.0) end
        draw.line(x1, y1, x2, y2, 255, 255, 255, 235, th)
    end
    seg(cx, cy - gap, cx, cy - gap - size)
    seg(cx, cy + gap, cx, cy + gap + size)
    seg(cx - gap, cy, cx - gap - size, cy)
    seg(cx + gap, cy, cx + gap + size, cy)
    if state.crosshair_dot then
        local ds = state.crosshair_dot_size or 3
        if outline then draw_circle_filled(cx, cy, ds + 1, 0, 0, 0, 220) end
        draw_circle_filled(cx, cy, ds, 255, 255, 255, 255)
    end
end

-- PLAYER STATS

function refresh_stats()
    assert_attached()
    local lp = get_localplayer()
    if lp == 0 then error("local player is NULL") end
    if state.lp_name_ptr ~= lp or state.lp_name == "" then
        local name = read_sd_string(lp + OFF.name)
        if name ~= "" then
            state.lp_name = name; state.lp_name_ptr = lp
        end
    end
    local hp = read_uint(lp + OFF.hpPtr, 8)
    if hp == 0 then error("hp component is NULL") end
    state.hp = read_uint(hp + OFF.health, 4)
    state.hp_max = read_uint(hp + OFF.healthMax, 4)
    state.armor = read_uint(hp + OFF.agentarmor, 4)
    state.armor_max = read_uint(hp + OFF.agentarmorMax, 4)
end

-- GAMEPLAY

function apply_recoil()
    assert_attached()
    if state.no_recoil then
        if pcall(memory.lock_rva, LOCK_ID.recoil, state.pid, RVA.recoil, pack_f32(0.0)) then
            state.recoil_locked = true
        else
            state.recoil_locked = false
            write_f32(state.base + RVA.recoil, 0.0)
        end
    else
        if state.recoil_locked then
            pcall(memory.unlock_rva, LOCK_ID.recoil)
            state.recoil_locked = false
        end
        write_f32(state.base + RVA.recoil, DEFAULT_RECOIL)
    end
    state.status = state.no_recoil and "No recoil ON (lock)" or "No recoil OFF"
end

function apply_spread()
    assert_attached()
    if state.no_spread then
        if pcall(memory.lock_rva, LOCK_ID.spread_rva, state.pid, RVA.spread, pack_f32(0.0)) then
            state.spread_rva_locked = true
        else
            state.spread_rva_locked = false
            write_f32(state.base + RVA.spread, 0.0)
        end
        local lp = get_localplayer()
        if lp ~= 0 then
            local aim = read_uint(lp + OFF.aimCtrl, 8)
            if aim ~= 0 then
                local a1 = aim + OFF.combatAimCurrentSpread
                local a2 = aim + OFF.combatAimSpreadRadius
                local ok1 = pcall(memory.lock, LOCK_ID.spread_a1, state.pid, a1, pack_f32(0.0))
                local ok2 = pcall(memory.lock, LOCK_ID.spread_a2, state.pid, a2, pack_f32(0.0))
                if ok1 and ok2 then
                    state.spread_aim_addrs = { a1, a2 }
                else
                    write_f32(a1, 0.0)
                    write_f32(a2, 0.0)
                end
            end
        end
    else
        if state.spread_rva_locked then
            pcall(memory.unlock_rva, LOCK_ID.spread_rva)
            state.spread_rva_locked = false
        end
        write_f32(state.base + RVA.spread, DEFAULT_SPREAD)
        if state.spread_aim_addrs then
            pcall(memory.unlock, LOCK_ID.spread_a1)
            pcall(memory.unlock, LOCK_ID.spread_a2)
            state.spread_aim_addrs = nil
        end
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
    if not state.magic_bullet then return false end
    if not state.silent_armed then return false end
    if not state.silent_target_ptr then return false end
    for _, e in ipairs(state.entities) do
        if e.entity_ptr == state.silent_target_ptr then
            return is_silent_target(e)
        end
    end
    return false
end

function apply_magic_bullet()
    assert_attached()
    local on = magic_bullet_should_enable()
    write_uint(state.base + RVA.magicbullet,
        on and MAGIC_BULLET_ON or MAGIC_BULLET_OFF, 1)
    if state.magic_bullet then
        state.status = on and "Magic bullet ON (NPC-only, locked)"
            or "Magic bullet ON (NPC-only, idle)"
    else
        state.status = "Magic bullet OFF"
    end
end

function apply_no_sway()
    assert_attached()
    local lp = get_localplayer()
    if lp == 0 then error("local player is NULL") end
    local aim = read_uint(lp + OFF.aimCtrl, 8)
    if aim == 0 then error("aimCtrl is NULL") end
    local wdata = read_uint(aim + OFF.combatAimWeaponDataPtr, 8)
    if wdata == 0 then error("weapon data ptr is NULL") end
    if state.no_sway then
        if state.sway_saved.min_h == nil then
            state.sway_saved.min_h = from_f32(read_uint(wdata + OFF.weapTemplateSwayMinH, 4))
            state.sway_saved.max_h = from_f32(read_uint(wdata + OFF.weapTemplateSwayMaxH, 4))
            state.sway_saved.min_v = from_f32(read_uint(wdata + OFF.weapTemplateSwayMinV, 4))
            state.sway_saved.max_v = from_f32(read_uint(wdata + OFF.weapTemplateSwayMaxV, 4))
            state.sway_saved.reset_dur = from_f32(read_uint(wdata + OFF.weapTemplateSwayResetDur, 4))
            state.sway_saved.scope_speed = from_f32(read_uint(wdata + OFF.weapTemplateScopeSwaySpeed, 4))
        end
        write_f32(wdata + OFF.weapTemplateSwayMinH, 0.0)
        write_f32(wdata + OFF.weapTemplateSwayMaxH, 0.0)
        write_f32(wdata + OFF.weapTemplateSwayMinV, 0.0)
        write_f32(wdata + OFF.weapTemplateSwayMaxV, 0.0)
        write_f32(wdata + OFF.weapTemplateScopeSwaySpeed, 0.0)
        state.status = "No sway ON"
    else
        if state.sway_saved.min_h ~= nil then
            write_f32(wdata + OFF.weapTemplateSwayMinH, state.sway_saved.min_h)
            write_f32(wdata + OFF.weapTemplateSwayMaxH, state.sway_saved.max_h)
            write_f32(wdata + OFF.weapTemplateSwayMinV, state.sway_saved.min_v)
            write_f32(wdata + OFF.weapTemplateSwayMaxV, state.sway_saved.max_v)
            if state.sway_saved.reset_dur ~= nil then
                write_f32(wdata + OFF.weapTemplateSwayResetDur, state.sway_saved.reset_dur)
            end
            if state.sway_saved.scope_speed ~= nil then
                write_f32(wdata + OFF.weapTemplateScopeSwaySpeed, state.sway_saved.scope_speed)
            end
        end
        state.status = "No sway OFF"
    end
end

function sway_tick()
    if not state.no_sway then return end
    local ok, err = pcall(function()
        local lp = get_localplayer()
        if lp == 0 then return end
        local aim = read_uint(lp + OFF.aimCtrl, 8)
        if aim == 0 then return end
        local wdata = read_uint(aim + OFF.combatAimWeaponDataPtr, 8)
        if wdata == 0 then return end
        local gen = weapon_gen()
        if gen ~= state.sway_seen_gen then
            state.sway_seen_gen = gen
            state.sway_saved = {
                min_h = nil,
                max_h = nil,
                min_v = nil,
                max_v = nil,
                reset_dur = nil,
                scope_speed = nil,
            }
        end
        if state.sway_saved.min_h == nil then
            state.sway_saved.min_h = from_f32(read_uint(wdata + OFF.weapTemplateSwayMinH, 4))
            state.sway_saved.max_h = from_f32(read_uint(wdata + OFF.weapTemplateSwayMaxH, 4))
            state.sway_saved.min_v = from_f32(read_uint(wdata + OFF.weapTemplateSwayMinV, 4))
            state.sway_saved.max_v = from_f32(read_uint(wdata + OFF.weapTemplateSwayMaxV, 4))
            state.sway_saved.reset_dur = from_f32(read_uint(wdata + OFF.weapTemplateSwayResetDur, 4))
            state.sway_saved.scope_speed = from_f32(read_uint(wdata + OFF.weapTemplateScopeSwaySpeed, 4))
        end
        write_f32(wdata + OFF.weapTemplateSwayMinH, 0.0)
        write_f32(wdata + OFF.weapTemplateSwayMaxH, 0.0)
        write_f32(wdata + OFF.weapTemplateSwayMinV, 0.0)
        write_f32(wdata + OFF.weapTemplateSwayMaxV, 0.0)
        write_f32(wdata + OFF.weapTemplateScopeSwaySpeed, 0.0)
        state.no_sway_live = from_f32(read_uint(wdata + OFF.weapTemplateSwayResetDur, 4))
    end)
    if not ok then state.status = "NoSway: " .. tostring(err) end
end

function apply_extended_range()
    assert_attached()
    local lp = get_localplayer()
    if lp == 0 then error("local player is NULL") end
    local aim = read_uint(lp + OFF.aimCtrl, 8)
    if aim == 0 then error("aimCtrl is NULL") end
    local wdata = read_uint(aim + OFF.combatAimWeaponDataPtr, 8)
    if wdata == 0 then error("weapon data ptr is NULL") end
    if state.extended_range then
        if state.extended_range_live == nil then
            local raw = from_f32(read_uint(wdata + OFF.weapTemplateRange, 4))
            if raw == 0 then raw = DEFAULT_EXTENDED_RANGE end
            state.extended_range_live = raw
        end
        write_f32(wdata + OFF.weapTemplateRange, 9999999.0)
        state.status = "Extended range ON"
    else
        if state.extended_range_live ~= nil then
            write_f32(wdata + OFF.weapTemplateRange, state.extended_range_live)
        end
        state.status = "Extended range OFF"
    end
end

function extended_range_tick()
    if not state.extended_range then return end
    local ok, err = pcall(function()
        local lp = get_localplayer()
        if lp == 0 then return end
        local aim = read_uint(lp + OFF.aimCtrl, 8)
        if aim == 0 then return end
        local wdata = read_uint(aim + OFF.combatAimWeaponDataPtr, 8)
        if wdata == 0 then return end
        local gen = weapon_gen()
        if gen ~= state.ext_seen_gen then
            state.ext_seen_gen = gen
            state.extended_range_live = nil
        end
        if state.extended_range_live == nil then
            local raw = from_f32(read_uint(wdata + OFF.weapTemplateRange, 4))
            if raw == 0 then raw = DEFAULT_EXTENDED_RANGE end
            state.extended_range_live = raw
        end
        local cur = from_f32(read_uint(wdata + OFF.weapTemplateRange, 4))
        if cur ~= 9999999.0 then
            write_f32(wdata + OFF.weapTemplateRange, 9999999.0)
        end
    end)
    if not ok then state.status = "ExtendedRange: " .. tostring(err) end
end

function teleport_guard()
    return (state._transition_frames or 0) > 0
end

function apply_move_speed()
    assert_attached()
    if teleport_guard() then
        state.move_speed_live = nil
        state.move_spread_add_live = nil
        state.status = "Teleport guard: move speed deferred"
        return
    end
    local lp = get_localplayer()
    if lp == 0 then error("local player is NULL") end
    local aim = read_uint(lp + OFF.aimCtrl, 8)
    if aim == 0 then error("aimCtrl is NULL") end
    if state.move_speed then
        if state.move_spread_add_live == nil then
            state.move_spread_add_live = from_f32(read_uint(aim + OFF.combatAimMoveSpreadAdd, 4))
        end
        if state.move_speed_live == nil then
            state.move_speed_live = from_f32(read_uint(aim + OFF.combatAimLerpedMoveSpeed, 4))
        end
        write_f32(aim + OFF.combatAimMoveSpreadAdd, 0.0)
        write_f32(aim + OFF.combatAimLerpedMoveSpeed, 0.0)
        state.status = "No move spread ON"
    else
        if state.move_spread_add_live ~= nil then
            write_f32(aim + OFF.combatAimMoveSpreadAdd, state.move_spread_add_live)
        end
        if state.move_speed_live ~= nil then
            write_f32(aim + OFF.combatAimLerpedMoveSpeed, state.move_speed_live)
        end
        state.status = "No move spread OFF"
    end
end

function move_speed_tick()
    if not state.move_speed then return end
    local ok, err = pcall(function()
        local lp = get_localplayer()
        if lp == 0 then return end
        local aim = read_uint(lp + OFF.aimCtrl, 8)
        if aim == 0 then return end
        if state.move_spread_add_live == nil and state.move_speed_live == nil then
            apply_move_speed()
            return
        end
        local gen = weapon_gen()
        if gen ~= state.move_seen_gen then
            state.move_seen_gen = gen
            state.move_spread_add_live = nil
            state.move_speed_live = nil
        end
        write_f32(aim + OFF.combatAimMoveSpreadAdd, 0.0)
    end)
    if not ok then state.status = "MoveSpeed: " .. tostring(err) end
end

function apply_time(mode)
    if not state.master_enabled and mode ~= "normal" then
        state.time_mode = "normal"
        return
    end
    assert_attached()
    state.time_mode = mode
    local noon = mode == "noon" and 1 or 0
    local night = mode == "night" and 1 or 0
    write_uint(state.base + RVA.setnoon, noon, 1)
    write_uint(state.base + RVA.setnight, night, 1)
    state.status = "Time: " .. mode
end

-- RPM

function sanitize_rpm_value()
    if state.rpm_value < RPM_MIN then state.rpm_value = RPM_MIN end
    if state.rpm_value > RPM_MAX then state.rpm_value = RPM_MAX end
end

function restore_rpm()
    local lp = get_localplayer()
    if lp == 0 then return end
    if state.rpm_original ~= nil then
        local w3 = resolve_rpm_target(lp)
        if w3 ~= 0 then write_f32(w3 + OFF.rpmFinal, state.rpm_original) end
        state.rpm_original = nil
    end
    -- Template RPM is never written, so there is nothing to restore here.
    state.rpm_template_original = nil
end

function rpm_tick()
    if not state.rpm_enabled then return end
    sanitize_rpm_value()
    local ok, err = pcall(function()
        local lp = get_localplayer()
        if lp == 0 then return end
        local w3 = resolve_rpm_target(lp)
        if w3 ~= 0 then
            local gen = weapon_gen()
            if gen ~= state.rpm_seen_gen then
                state.rpm_seen_gen = gen
                state.rpm_original = nil
                state.rpm_template_original = nil
            end
            state.rpm_live = read_f32(w3 + OFF.rpmFinal)
            if state.rpm_original == nil then
                state.rpm_original = state.rpm_live
            end
            if state.rpm_live ~= state.rpm_value then
                write_f32(w3 + OFF.rpmFinal, state.rpm_value)
            end
        end
        local aim = read_uint(lp + OFF.aimCtrl, 8)
        if aim ~= 0 then
            local wdata = read_uint(aim + OFF.combatAimWeaponDataPtr, 8)
            if wdata ~= 0 then
                -- Template RPM is read-only; it is never written.
                state.rpm_template_live = read_f32(wdata + OFF.weapTemplateRpm)
            end
            -- The fire interval is a per-shot countdown, so it is never written here; RPM uses rpmFinal only.
        end
    end)
    if not ok then state.status = "RPM: " .. tostring(err) end
end

function read_rpm_once()
    assert_attached()
    local lp = get_localplayer()
    if lp == 0 then error("local player is NULL") end
    local w3 = resolve_rpm_target(lp)
    if w3 == 0 then error("weapon chain broken") end
    state.rpm_live = read_f32(w3 + OFF.rpmFinal)
    state.rpm_template_live = 0.0
    local aim = read_uint(lp + OFF.aimCtrl, 8)
    if aim ~= 0 then
        local wdata = read_uint(aim + OFF.combatAimWeaponDataPtr, 8)
        if wdata ~= 0 then state.rpm_template_live = read_f32(wdata + OFF.weapTemplateRpm) end
    end
    state.status = string.format("RPM final: %.0f  template: %.0f", state.rpm_live, state.rpm_template_live)
end

function instant_reload_tick()
    if not state.instant_reload then return end
    local ok, err = pcall(function()
        local lp = get_localplayer()
        if lp == 0 then return end
        local aim = read_uint(lp + OFF.aimCtrl, 8)
        if aim == 0 then return end
        write_uint(aim + OFF.reloadField, 0, 4)
    end)
    if not ok then state.status = "InstantReload: " .. tostring(err) end
end

-- Fragile Enemy Armor: strip NPC armor so damage hits health directly.
function fragile_armor_tick()
    if not state.fragile_armor then return end
    local ok, err = pcall(function()
        for _, e in ipairs(state.entities) do
            if not e.is_player and e.relation == "hostile" then
                -- Resolve the health-component pointer here (the entity table does not carry it).
                local hp_ptr = read_uint(e.entity_ptr + OFF.hpPtr, 8)
                if hp_ptr ~= 0 then
                    write_uint(hp_ptr + OFF.npcArmor, 1, 4)
                    write_uint(hp_ptr + OFF.npcArmorMax, 1, 4)
                end
            end
        end
    end)
    if not ok then state.status = "FragileArmor: " .. tostring(err) end
end

-- Infinite ammo is removed; this function is a no-op kept so existing call sites do not error.
function apply_infinite_ammo()
end

function infinite_ammo_tick()
    -- Removed; no-op. See apply_infinite_ammo.
end

-- Auto-loot: teleport only bags holding a checked item type to the player.
local function loot_auto_enabled(rarity)
    local keys = {
        [0] = "loot_auto_r0", [1] = "loot_auto_r1", [2] = "loot_auto_r2", [3] = "loot_auto_r3",
        [4] = "loot_auto_r4", [5] = "loot_auto_r5", [6] = "loot_auto_r6", [7] = "loot_auto_r7",
        [8] = "loot_auto_r8", [9] = "loot_auto_r9", [11] = "loot_auto_r11",
    }
    local key = keys[rarity]
    if key then return state[key] ~= false end
    return state.loot_auto_other ~= false
end

function auto_loot_all_tick(force)
    if not force and not state.auto_loot_all then return end
    if not force then
        state._autoloot_frame = (state._autoloot_frame or 0) + 1
        if state._autoloot_frame < 5 then return end
        state._autoloot_frame = 0
    end
    local ok, err = pcall(function()
        local po_ptr = safe_walk(state.pid, state.base, { RVA.rlclient, OFF.pClient, OFF.pObject })
        if po_ptr == 0 then return end
        local loot_mgr = read_uint(po_ptr + OFF.lootManager, 8)
        if loot_mgr == 0 then return end
        local loot_count = read_uint(loot_mgr + OFF.lootCount, 4)
        local loot_arr = read_uint(loot_mgr + OFF.lootArray, 8)
        if loot_arr == 0 or loot_count == 0 or loot_count > 256 then return end
        local lp = get_localplayer()
        if lp == 0 then return end
        local lp_pos_bytes = read_bytes_table(lp + OFF.entityPos, 12)
        if #lp_pos_bytes < 12 then return end
        local lp_pos = parse_f32_array(lp_pos_bytes, 3)
        local ptr_addrs = {}
        for i = 0, loot_count - 1 do ptr_addrs[#ptr_addrs + 1] = loot_arr + i * 8 end
        local ptr_raw = batch_read_chunked(state.pid, 8, ptr_addrs)
        local bags, count_addrs, header_addrs = {}, {}, {}
        for i = 1, loot_count do
            local off = (i - 1) * 8
            if #ptr_raw >= off + 8 then
                local bag = uint_from(ptr_raw, off + 1, 8)
                if is_valid_addr(bag, 8) then
                    bags[#bags + 1] = bag
                    count_addrs[#count_addrs + 1] = bag + OFF.lootItemsCount
                    header_addrs[#header_addrs + 1] = bag + OFF.lootItemsBase
                end
            end
        end
        if #bags == 0 then return end
        local count_raw = batch_read_chunked(state.pid, 4, count_addrs)
        local header_raw = batch_read_chunked(state.pid, 8, header_addrs)
        local rarity_addrs, rarity_bag = {}, {}
        for i = 1, #bags do
            local hoff = (i - 1) * 8
            local coff = (i - 1) * 4
            if #header_raw >= hoff + 8 and #count_raw >= coff + 4 then
                local header = uint_from(header_raw, hoff + 1, 8)
                local item_count = uint_from(count_raw, coff + 1, 4)
                if item_count > 0 and item_count <= 256 and is_valid_addr(header, 8) then
                    for item_index = 0, item_count - 1 do
                        local entry = header + OFF.lootFirstEntry + item_index * OFF.lootItemStride
                        local rarity_addr = entry + OFF.lootItemRarity
                        if is_valid_addr(rarity_addr, 1) then
                            rarity_addrs[#rarity_addrs + 1] = rarity_addr
                            rarity_bag[#rarity_bag + 1] = bags[i]
                        end
                    end
                end
            end
        end
        if #rarity_addrs == 0 then return end
        local rarity_raw = batch_read_chunked(state.pid, 1, rarity_addrs)
        if #rarity_raw < #rarity_addrs then return end
        local wanted = {}
        for ri = 1, #rarity_addrs do
            if loot_auto_enabled(rarity_raw[ri]) then wanted[rarity_bag[ri]] = true end
        end
        -- Spread bags in a small circle around the player (golden angle) instead of stacking them on one point.
        local bag_i = 0
        for bag, _ in pairs(wanted) do
            bag_i = bag_i + 1
            local ang = (bag_i * 2.39996) % 6.28318
            local ox = math.cos(ang) * 1.0
            local oz = math.sin(ang) * 1.0
            write_f32(bag + OFF.lootPos + 0, lp_pos[1] + ox)
            write_f32(bag + OFF.lootPos + 4, lp_pos[2])
            write_f32(bag + OFF.lootPos + 8, lp_pos[3] + oz)
        end
    end)
    if not ok then state.status = "AutoLoot: " .. tostring(err) end
end

-- High headshot damage: template headshot multiplier to 100x.
function headshot_dmg_tick()
    if not state.high_headshot_dmg then return end
    pcall(function()
        local lp = get_localplayer()
        if lp == 0 then return end
        local aim = read_uint(lp + OFF.aimCtrl, 8)
        if aim == 0 then return end
        local wdata = read_uint(aim + OFF.combatAimWeaponDataPtr, 8)
        if wdata == 0 then return end
        write_f32(wdata + OFF.weapTemplateDmgMultHead, 100.0)
    end)
end

-- Fast fire: fire interval to 0.0 (no delay).
function fire_interval_tick()
    if not state.fast_fire then return end
    pcall(function()
        local lp = get_localplayer()
        if lp == 0 then return end
        local aim = read_uint(lp + OFF.aimCtrl, 8)
        if aim == 0 then return end
        write_f32(aim + OFF.combatAimFireInterval, 0.0)
    end)
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
        state.master_snapshot.time_mode = state.time_mode
        state.master_snapshot.aim_part = state.aim_part
        state.time_mode = "normal"
        if state.aim_part == "dynamic" then state.aim_part = "head" end
        if state.pid ~= 0 and state.base ~= 0 then
            pcall(apply_recoil)
            pcall(apply_spread)
            pcall(apply_magic_bullet)
            pcall(apply_no_sway)
            pcall(apply_extended_range)
            pcall(apply_move_speed)
            pcall(restore_rpm)
            pcall(apply_time, "normal")
        end
        if state.pid ~= 0 and state.silent_lock_addr then
            pcall(memory.unlock, LOCK_ID.silent)
            state.silent_lock_addr = nil
        end
        state.silent_armed = false
        state.silent_fired = false
        state.silent_target_ptr = nil
        state.silent_target_name = ""
        state.selected_target_ptr = 0
        state.entities = {}
        state.loot_items = {}
        state.status = "Master OFF (F1 to re-enable)"
    else
        if state.master_snapshot then
            for _, k in ipairs(MASTER_KEYS) do
                state[k] = state.master_snapshot[k]
            end
            state.time_mode = state.master_snapshot.time_mode or "normal"
            state.aim_part = state.master_snapshot.aim_part or state.aim_part
            state.master_snapshot = nil
        end
        if state.pid ~= 0 and state.base ~= 0 then
            pcall(apply_recoil)
            pcall(apply_spread)
            pcall(apply_magic_bullet)
            if state.no_sway then pcall(apply_no_sway) end
            if state.extended_range then pcall(apply_extended_range) end
            if state.move_speed then pcall(apply_move_speed) end
            if state.rpm_enabled then pcall(rpm_tick) end
            if state.time_mode ~= "normal" then pcall(apply_time, state.time_mode) end
        end
        state.status = "Master ON"
    end
end

function get_bone_ids_for_entity(e, read_all)
    if read_all then
        return ALL_BONE_IDS_0_90
    end
    local pname = profile_name_for(e)
    if pname == "DRONE" then return {} end
    if pname == "TURRET" then return {} end
    if pname == "ITEM" then return {} end
    local prof = BONE_PROFILES[pname]
    if not prof then
        return ALL_BONE_IDS_SPARSE
    end
    return prof.indices
end

function world_to_screen(pos, m, wr)
    if not m or not wr then return nil end
    if type(wr) ~= "table" then return nil end
    if not wr.width or not wr.height or wr.width <= 0 or wr.height <= 0 then return nil end
    local x, y, z = pos[1], pos[2], pos[3]
    local cx = m[1] * x + m[5] * y + m[9] * z + m[13]
    local cy = m[2] * x + m[6] * y + m[10] * z + m[14]
    local cw = m[4] * x + m[8] * y + m[12] * z + m[16]
    if not is_finite(cw) or cw < 0.001 then return nil end
    local nx = cx / cw
    local ny = cy / cw
    return wr.x + (nx + 1) * wr.width / 2, wr.y + (1 - ny) * wr.height / 2
end

function read_bones(pid, entities, read_all)
    if #entities == 0 then return {} end
    local bb_addrs = {}
    for _, e in ipairs(entities) do
        bb_addrs[#bb_addrs + 1] = e.entity_ptr + OFF.bonesBase
    end
    local bb_raw = batch_read_chunked(pid, 8, bb_addrs)
    local ba_addrs = {}
    local valid = {}
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
    local bone_addr_list = {}
    local bone_owner = {}
    local bone_id_list = {}
    for vi = 1, #valid do
        local ei = valid[vi]
        local e = entities[ei]
        local off = (vi - 1) * 8
        if #ba_raw >= off + 8 then
            local bone_arr = uint_from(ba_raw, off + 1, 8)
            if bone_arr ~= 0 then
                local bone_ids = get_bone_ids_for_entity(e, read_all)
                for _, bid in ipairs(bone_ids) do
                    bone_addr_list[#bone_addr_list + 1] = bone_arr + bid * BONE_STRIDE + BONE_POS_OFF
                    bone_owner[#bone_owner + 1] = ei
                    bone_id_list[#bone_id_list + 1] = bid
                end
            end
        end
    end
    if #bone_addr_list == 0 then return {} end
    local raw = batch_read_chunked(pid, 12, bone_addr_list)
    local bone_results = {}
    local entity_bones = {}
    for k = 1, #bone_addr_list do
        local boff = (k - 1) * 12
        if #raw >= boff + 12 then
            local bx = from_f32(uint_from(raw, boff + 1, 4))
            local by = from_f32(uint_from(raw, boff + 5, 4))
            local bz = from_f32(uint_from(raw, boff + 9, 4))
            if is_finite(bx) and is_finite(by) and is_finite(bz) then
                if bx ~= 0 or by ~= 0 or bz ~= 0 then
                    local ei = bone_owner[k]
                    local bid = bone_id_list[k]
                    entity_bones[ei] = entity_bones[ei] or {}
                    entity_bones[ei][#entity_bones[ei] + 1] = { bid = bid, pos = { bx, by, bz } }
                end
            end
        end
    end
    local MAX_BONE_DIST_FROM_ENTITY = 6.0
    for ei, list in pairs(entity_bones) do
        local epos = entities[ei] and entities[ei].pos
        local kept = {}
        if epos then
            for _, entry in ipairs(list) do
                local p = entry.pos
                local dx, dy, dz = p[1] - epos[1], p[2] - epos[2], p[3] - epos[3]
                local d = math.sqrt(dx * dx + dy * dy + dz * dz)
                if d <= MAX_BONE_DIST_FROM_ENTITY then
                    kept[entry.bid] = p
                end
            end
        else
            for _, entry in ipairs(list) do
                kept[entry.bid] = entry.pos
            end
        end
        bone_results[ei] = kept
    end
    return bone_results
end

function should_show(e)
    -- Rogue agents (hostile player-type entities) show under the Hostile toggle, so they stay visible when teammates are hidden.
    if e.is_player then
        if e.relation == "hostile" then return state.esp_show_hostile end
        return state.esp_show_players
    end
    if e.archetype and ARCHETYPE_WILDLIFE[e.archetype] then
        return state.esp_show_wildlife
    end
    local pname = profile_name_for(e)
    -- Caches are ESP markers only; they never become silent-aim targets.
    if entity_is_cache(e) then return state.esp_show_caches end
    if pname == "ITEM" then
        return state.esp_show_other
    end
    if pname ~= "TURRET"
        and pname ~= "BIG_DOG"
        and pname ~= "WARHOUND_GRENADIER"
        and pname ~= "WARHOUND_MINIGUN"
        and pname ~= "MINITANK"
        and not e.is_player then
        if name_is_blacklisted(e.ent_name) then return false end
    end
    if pname == "TURRET" then
        if e.relation == "friendly" then return state.esp_show_friendly end
        if e.relation == "neutral" then return state.esp_show_neutral end
        return state.esp_show_hostile
    end
    if e.relation == "unknown"
        and (pname == "DRONE" or pname == "TURRET"
            or pname == "BIG_DOG" or pname == "WARHOUND_GRENADIER"
            or pname == "WARHOUND_MINIGUN" or pname == "MINITANK") then
        return state.esp_show_hostile or state.esp_show_other
    end
    if e.relation == "hostile" then return state.esp_show_hostile end
    if e.relation == "friendly" then return state.esp_show_friendly end
    if e.relation == "neutral" then return state.esp_show_neutral end
    if e.relation == "unknown" then return state.esp_show_other end
    return false
end

function compute_box(e, m, w, sy_hint, draw_pos_override)
    local box_h = 0
    local box_w = 0
    local box_cy = sy_hint
    local pname = profile_name_for(e)
    local prof = BONE_PROFILES[pname]
    local b = LEGACY_BONE_NAMES[pname] or LEGACY_BONE_NAMES.NPC_HUMANOID
    local draw_pos = draw_pos_override or ((pname == "DRONE") and e.pos or e.pred_pos or e.pos)
    if pname == "DRONE" then
        local _, oy = world_to_screen(draw_pos, m, w)
        local top = { draw_pos[1], draw_pos[2] + DRONE_BOX_HEIGHT, draw_pos[3] }
        local _, ty = world_to_screen(top, m, w)
        if oy and ty then
            local h = math.abs(oy - ty)
            if h > 6 then
                return h, h * 0.8, (oy + ty) / 2
            end
        end
        return 40, 30, sy_hint
    end
    if pname == "TURRET" then
        local base = draw_pos
        local top = { draw_pos[1], draw_pos[2] + TURRET_BOX_HEIGHT_OFFSET, draw_pos[3] }
        local _, by = world_to_screen(base, m, w)
        local _, ty = world_to_screen(top, m, w)
        if by and ty then
            local h = math.abs(by - ty)
            if h > 6 then
                return h, h * 0.75, (by + ty) / 2
            end
        end
        return 60, 45, sy_hint
    end
    if pname == "ITEM" then
        local base = draw_pos
        local top = { draw_pos[1], draw_pos[2] + 0.3, draw_pos[3] }
        local _, by = world_to_screen(base, m, w)
        local _, ty = world_to_screen(top, m, w)
        if by and ty then
            local h = math.abs(by - ty)
            if h > 3 then
                return h, h * 0.9, (by + ty) / 2
            end
        end
        return 20, 18, sy_hint
    end
    if pname == "BIG_DOG"
        or pname == "WARHOUND_GRENADIER"
        or pname == "WARHOUND_MINIGUN" then
        local _, by = world_to_screen(draw_pos, m, w)
        local top = { draw_pos[1], draw_pos[2] + 1.6, draw_pos[3] }
        local _, ty = world_to_screen(top, m, w)
        if by and ty then
            local h = math.abs(by - ty)
            if h > 4 then
                box_h = h
                box_w = h * 0.9
                box_cy = (by + ty) / 2
            end
        end
    elseif pname == "MINITANK" then
        local bones = e.bones
        local rp = bones and bones[0]
        local hp = nil
        if bones then
            for _, bid in ipairs({ 37, 33, 31, 0 }) do
                if bones[bid] then
                    hp = bones[bid]; break
                end
            end
        end
        if not hp then hp = e.pos end
        if rp then
            local _, hy = world_to_screen(hp, m, w)
            local _, ry = world_to_screen(rp, m, w)
            if hy and ry then
                local h = math.abs(hy - ry)
                if h > 10 then
                    box_h = h
                    box_w = h * 0.5
                    box_cy = (hy + ry) / 2
                end
            end
        else
            local _, hy = world_to_screen(hp, m, w)
            if hy then box_cy = hy end
        end
    else
        local ht_id = (pname == "PLAYER_HUMANOID") and 10 or 9
        local bones = e.bones
        local hp = bones and bones[ht_id]
        local rp = bones and bones[0]
        if hp and rp then
            local _, hy = world_to_screen(hp, m, w)
            local _, ry = world_to_screen(rp, m, w)
            if hy and ry then
                local h = math.abs(hy - ry)
                if h > 10 then
                    box_h = h
                    box_w = h * 0.4
                    box_cy = (hy + ry) / 2
                end
            end
        end
    end
    if box_h <= 0 then
        box_h = 40
        box_w = 16
    end
    return box_h, box_w, box_cy
end

function is_boneless_profile(pname)
    return pname == "DRONE" or pname == "TURRET" or pname == "ITEM" or pname == "NO_SKELETON"
end

function nonskeleton_offset_key(name)
    local bytes = {}
    for i = 1, #name do bytes[#bytes + 1] = string.format("%02x", string.byte(name, i)) end
    return table.concat(bytes)
end

function nonskeleton_target_name(e)
    local name = e and tostring(e.ent_name or "") or ""
    local legacy_name = name ~= "" and name or "(unnamed)"
    local kind = e and tostring(e.ent_type or "npc") or "npc"
    if e and e.archetype_name then
        return kind .. ":" .. tostring(e.archetype_name), legacy_name
    end
    if e and e.type_str and e.type_str ~= "" then
        return kind .. ":" .. tostring(e.type_str), legacy_name
    end
    if e and e.entity_type_int ~= nil then
        return kind .. ":" .. tostring(e.entity_type_int), legacy_name
    end
    return legacy_name, legacy_name
end

function get_nonskeleton_offset(name, legacy_name)
    name = tostring(name or "")
    if name == "" then name = "(unnamed)" end
    state.nonskeleton_aim_offsets = state.nonskeleton_aim_offsets or {}
    local offsets = state.nonskeleton_aim_offsets[name]
    if not offsets then
        offsets = { x = 0, y = 0, z = 0 }
        if config then
            local key = nonskeleton_offset_key(name)
            local ok_x, x = pcall(config.get, "td2.nonskel_" .. key .. "_wx", nil)
            local ok_y, y = pcall(config.get, "td2.nonskel_" .. key .. "_wy", nil)
            local ok_z, z = pcall(config.get, "td2.nonskel_" .. key .. "_wz", nil)
            if ok_x and tonumber(x) then offsets.x = tonumber(x) end
            if ok_y and tonumber(y) then offsets.y = tonumber(y) end
            if ok_z and tonumber(z) then offsets.z = tonumber(z) end
            if legacy_name and legacy_name ~= name and ok_x and ok_y and ok_z
                and x == nil and y == nil and z == nil then
                local old_key = "td2.nonskel_" .. nonskeleton_offset_key(legacy_name)
                local old_ok_x, old_x = pcall(config.get, old_key .. "_wx", nil)
                local old_ok_y, old_y = pcall(config.get, old_key .. "_wy", nil)
                local old_ok_z, old_z = pcall(config.get, old_key .. "_wz", nil)
                if old_ok_x and tonumber(old_x) then offsets.x = tonumber(old_x) end
                if old_ok_y and tonumber(old_y) then offsets.y = tonumber(old_y) end
                if old_ok_z and tonumber(old_z) then offsets.z = tonumber(old_z) end
                if (old_ok_x and tonumber(old_x)) or (old_ok_y and tonumber(old_y)) or (old_ok_z and tonumber(old_z)) then
                    pcall(config.set, "td2.nonskel_" .. key .. "_wx", offsets.x)
                    pcall(config.set, "td2.nonskel_" .. key .. "_wy", offsets.y)
                    pcall(config.set, "td2.nonskel_" .. key .. "_wz", offsets.z)
                    save_config_now()
                end
            end
        end
        state.nonskeleton_aim_offsets[name] = offsets
    end
    return offsets
end

function screen_delta_to_world(pos, dx, dy, vp, wr)
    if not vp or not wr then return nil end
    local sx, sy = world_to_screen(pos, vp, wr)
    if not sx or not sy then return nil end
    local eps = 0.01
    local gx, gy = {}, {}
    for axis = 1, 3 do
        local sample = { pos[1], pos[2], pos[3] }
        sample[axis] = sample[axis] + eps
        local px, py = world_to_screen(sample, vp, wr)
        if not px or not py then return nil end
        gx[axis], gy[axis] = (px - sx) / eps, (py - sy) / eps
    end
    local a, b, c = 0, 0, 0
    for axis = 1, 3 do
        a = a + gx[axis] * gx[axis]
        b = b + gx[axis] * gy[axis]
        c = c + gy[axis] * gy[axis]
    end
    local det = a * c - b * b
    if math.abs(det) < 1e-8 then return nil end
    local lx = (dx * c - dy * b) / det
    local ly = (dy * a - dx * b) / det
    return {
        gx[1] * lx + gy[1] * ly,
        gx[2] * lx + gy[2] * ly,
        gx[3] * lx + gy[3] * ly,
    }
end

function apply_nonskeleton_world_offset(pos, offsets)
    return {
        pos[1] + offsets.x,
        pos[2] + offsets.y,
        pos[3] + offsets.z,
    }
end

function aim_point_for(e)
    if not e then return nil end
    local pname = profile_name_for(e)
    local point
    if pname == "DRONE" then
        point = { e.pos[1], e.pos[2], e.pos[3] }
    elseif pname == "TURRET" or pname == "ITEM" or pname == "NO_SKELETON" then
        point = { e.pos[1], e.pos[2], e.pos[3] }
    end
    if point and is_boneless_profile(pname) and state.boneless_override then
        local stable_name, legacy_name = nonskeleton_target_name(e)
        local offsets = get_nonskeleton_offset(stable_name, legacy_name)
        return apply_nonskeleton_world_offset(point, offsets)
    end
    local prof = BONE_PROFILES[pname]
    local bt = LEGACY_BONE_NAMES[pname] or LEGACY_BONE_NAMES.NPC_HUMANOID
    local target_bone = nil
    local force_floor = false
    local function find_valid_bone(...)
        if not e.bones then return nil end
        local args = {...}
        for _, b in ipairs(args) do
            if b and e.bones[b] then return b end
        end
        return nil
    end
    if prof and prof.is_humanoid then
        local p_part = (state.dynamic_aim or state.aim_part == "dynamic") and "dynamic" or state.aim_part
        if p_part == "dynamic" and state.viewproj and state.window_rect then
            local wr = state.window_rect[1] or state.window_rect
            if wr and wr.width and wr.height > 0 then
                local screen_cx = wr.x + wr.width / 2
                local cy = wr.y + wr.height / 2
                local draw_pos = e.pred_pos or e.pos
                local sx, sy = world_to_screen(draw_pos, state.viewproj, wr)
                if sx and sy then
                    local box_h, box_w, box_cy = compute_box(e, state.viewproj, wr, cy)
                    local box_top = box_cy - box_h / 2
                    local box_left = sx - box_w / 2
                    local rel_y = (box_h > 0) and ((cy - box_top) / box_h) or 0.0
                    local rel_x = (box_w > 0) and ((screen_cx - box_left) / box_w) or 0.5
                    if cy >= sy - (box_h * 0.10) then
                        rel_y = math.max(rel_y, 0.90)
                    end
                    local is_left = rel_x < 0.5
                    if rel_y < 0.20 then
                        target_bone = find_valid_bone(bt.head, bt.chest)
                    elseif rel_y >= 0.20 and rel_y < 0.45 then
                        if rel_x < 0.35 then target_bone = find_valid_bone(bt.r_arm, bt.r_shoulder, bt.chest, bt.belly)
                        elseif rel_x > 0.65 then target_bone = find_valid_bone(bt.l_arm, bt.l_shoulder, bt.chest, bt.belly)
                        else target_bone = find_valid_bone(bt.chest, bt.belly) end
                    elseif rel_y >= 0.45 and rel_y < 0.70 then
                        target_bone = find_valid_bone(bt.belly, bt.root)
                    elseif rel_y >= 0.70 and rel_y < 0.88 then
                        if is_left then target_bone = find_valid_bone(bt.r_knee, bt.r_heel, bt.l_knee)
                        else target_bone = find_valid_bone(bt.l_knee, bt.l_heel, bt.r_knee) end
                        if not target_bone then force_floor = true end
                    else
                        if is_left then target_bone = find_valid_bone(bt.r_heel, bt.r_knee, bt.l_heel, bt.l_knee)
                        else target_bone = find_valid_bone(bt.l_heel, bt.l_knee, bt.r_heel, bt.r_knee) end
                        if not target_bone then force_floor = true end
                    end
                else
                    target_bone = find_valid_bone(bt.head)
                end
            else
                target_bone = find_valid_bone(bt.head)
            end
        else
            if p_part == "head" then target_bone = find_valid_bone(bt.head, bt.chest) end
            if p_part == "chest" then target_bone = find_valid_bone(bt.chest, bt.belly) end
            if p_part == "pelvis" then target_bone = find_valid_bone(bt.belly, bt.root) end
            if p_part == "legs" then
                target_bone = find_valid_bone(bt.l_heel, bt.r_heel, bt.l_knee, bt.r_knee)
                if not target_bone then force_floor = true end
            end
        end
    elseif prof then
        target_bone = prof.aim_bone
    end
    if force_floor then
        target_bone = 0
    end
    if target_bone == nil and prof then
        target_bone = prof.aim_bone_fallback
    end
    if target_bone == nil then
        target_bone = 0
    end
    local p = e.bones and e.bones[target_bone]
    if not p then
        -- Humanoid profiles with no bone position aim at chest height (position + 1.2m); other profiles keep the raw position.
        if prof and prof.is_humanoid then
            return { e.pos[1], e.pos[2] + 1.2, e.pos[3] }
        end
        return { e.pos[1], e.pos[2], e.pos[3] }
    end
    if target_bone == 0 then
        return { p[1], p[2], p[3] + 0.15 }
    end
    return p
end

function find_silent_target(entities, viewproj, wr)
    if not viewproj or not wr then return nil end
    local w = wr[1]
    if not w or not w.width or w.width <= 0 then return nil end
    local cx, cy = w.x + w.width / 2, w.y + w.height / 2
    local best, best_score = nil, -math.huge
    local best360, best360_score = nil, -math.huge
    local max_dist = state.silent_max_dist
    local fov_sq = state.silent_fov * state.silent_fov
    for _, e in ipairs(entities) do
        if e and not e.is_downed and e.dist <= max_dist then
            local valid = is_silent_target(e)
            if valid then
                local tp = aim_point_for(e)
                if tp then
                    -- Track the closest hostile in any direction as the 360 fallback, and separately the best target near the reticle.
                    local prio = aimbot_priority(e)
                    local score360 = prio * 10000 - e.dist
                    if score360 > best360_score then
                        best360_score = score360
                        best360 = e
                    end
                    local sx, sy = world_to_screen(tp, viewproj, w)
                    if sx and sy then
                        local dx, dy = sx - cx, sy - cy
                        local dist_px_sq = dx * dx + dy * dy
                        if dist_px_sq < fov_sq then
                            local dist_px = math.sqrt(dist_px_sq)
                            local score = prio * 10000 - dist_px
                            if score > best_score then
                                best_score = score
                                best = e
                            end
                        end
                    end
                end
            end
        end
    end
    -- Reticle first: if anything is near the reticle it wins, even in 360 mode; otherwise fall back to the closest hostile in any direction.
    if best then return best end
    if state.silent_360 then return best360 end
    return nil
end

function pack_vec3(v)
    local out = {}
    for i = 1, 3 do
        local bits = 0
        local x = v[i]
        if x < 0 then
            bits = 0x80000000; x = -x
        end
        if x ~= 0 and is_finite(x) then
            local m, e = math.frexp(x)
            local b = e + 126
            if b >= 255 then
                bits = bits + 0x7F800000
            elseif b > 0 then
                bits = bits + b * 0x800000 + math.floor((m * 2 - 1) * 0x800000 + 0.5)
            end
        end
        for j = 1, 4 do
            out[(i - 1) * 4 + j] = bits % 256
            bits = math.floor(bits / 256)
        end
    end
    return out
end

function read_world_aim(aim)
    if aim == 0 then return nil end
    local raw = read_bytes_table(aim + OFF.worldAimPos, 12)
    if #raw < 12 then return nil end
    return {
        from_f32(uint_from(raw, 1, 4)),
        from_f32(uint_from(raw, 5, 4)),
        from_f32(uint_from(raw, 9, 4)),
    }
end

function release_silent_lock(pid)
    if state.silent_lock_addr then
        pcall(memory.unlock, LOCK_ID.silent)
        state.silent_lock_addr = nil
    end
    state.silent_armed = false
    state.diag_last_write = nil
end

function silent_tick(pid, base)
    if (state._transition_frames or 0) > 0 then
        release_silent_lock(pid)
        state.silent_target_ptr = nil
        state.silent_target_name = ""
        return
    end
    if not state.silent_enabled then
        release_silent_lock(pid)
        state.silent_last_rounds = 0
        state.silent_target_name = ""
        state.silent_target_ptr = nil
        if state.magic_bullet then
            pcall(write_uint, base + RVA.magicbullet, MAGIC_BULLET_OFF, 1)
        end
        return
    end
    local was_armed = state.silent_armed
    local ok, err = pcall(function()
        local lp = get_localplayer()
        if lp == 0 then
            release_silent_lock(pid)
            return
        end
        local aim = read_uint(lp + OFF.aimCtrl, 8)
        if aim == 0 then
            release_silent_lock(pid)
            return
        end
        local target = find_silent_target(state.entities, state.viewproj, state.window_rect)
        if target then
            if state.silent_target_ptr ~= target.entity_ptr then
                state.silent_target_ptr = target.entity_ptr
                state.silent_shots = 0
            end
            local tp = aim_point_for(target)
            if tp then
                local aim_addr = aim + OFF.worldAimPos
                local aim_bytes = pack_vec3(tp)
                if state.silent_lock_addr and state.silent_lock_addr ~= aim_addr then
                    pcall(memory.unlock, LOCK_ID.silent)
                    state.silent_lock_addr = nil
                end
                local lock_ok = pcall(memory.lock, LOCK_ID.silent, pid, aim_addr, aim_bytes)
                if lock_ok then
                    state.silent_lock_addr = aim_addr
                else
                    local wrote = true
                    for _ = 1, 10 do
                        local write_ok, write_err = pcall(memory.write_bytes, pid, aim_addr, aim_bytes)
                        if not write_ok then
                            report_memory_error("silent aim write", write_err)
                            wrote = false
                            break
                        end
                    end
                    if wrote then state.silent_lock_addr = aim_addr end
                end
                state.diag_last_write = { tp[1], tp[2], tp[3] }
                state.silent_armed = true
                local aim_label = (state.dynamic_aim or state.aim_part == "dynamic") and "dynamic" or state.aim_part
                state.silent_target_name = string.format("%s %.0fm", aim_label, target.dist)
            end
        else
            release_silent_lock(pid)
            state.silent_target_name = ""
            state.silent_target_ptr = nil
        end
        if not was_armed then
            state.diag_last_write = nil
        end
        local gen = weapon_gen()
        if gen ~= state.silent_seen_gen then
            state.silent_seen_gen = gen
            state.silent_last_rounds = 0
        end
        local rounds = read_uint(aim + OFF.combatAimRoundsFired, 4)
        local delta
        if rounds >= state.silent_last_rounds then
            delta = rounds - state.silent_last_rounds
        else
            delta = 0
        end
        state.silent_last_rounds = rounds
        if delta > 0 then
            state.silent_fired = true
            state.silent_shots = state.silent_shots + delta
        else
            state.silent_fired = false
        end
        if state.magic_bullet then
            local on = false
            if state.silent_armed and state.silent_target_ptr and target then
                on = is_silent_target(target)
            end
            write_uint(base + RVA.magicbullet,
                on and MAGIC_BULLET_ON or MAGIC_BULLET_OFF, 1)
        end
    end)
    if not ok then state.status = "Silent: " .. tostring(err) end
end

-- DEBUG REFRESH

function dbg_refresh()
    state.dbg_lp_pos = nil
    state.dbg_bone0 = nil
    state.dbg_err = nil
    if state.pid == 0 or state.base == 0 then return end
    local lp = get_localplayer()
    if lp == 0 then return end
    local raw = read_bytes_table(lp + OFF.entityPos, 12)
    if #raw >= 12 then
        state.dbg_lp_pos = {
            from_f32(uint_from(raw, 1, 4)),
            from_f32(uint_from(raw, 5, 4)),
            from_f32(uint_from(raw, 9, 4)),
        }
    end
    local bb_ok, bb_raw = pcall(memory.batch_read, state.pid, 8, { lp + OFF.bonesBase })
    if not bb_ok then report_memory_error("debug batch read", bb_raw); bb_raw = nil end
    local bb = (bb_raw and #bb_raw >= 8) and uint_from(bb_raw, 1, 8) or 0
    if bb ~= 0 then
        local ba_ok, ba_raw = pcall(memory.batch_read, state.pid, 8, { bb + OFF.boneArray })
        if not ba_ok then report_memory_error("debug batch read", ba_raw); ba_raw = nil end
        local ba = (ba_raw and #ba_raw >= 8) and uint_from(ba_raw, 1, 8) or 0
        if ba ~= 0 then
            local m0 = read_bytes_table(ba + BONE_POS_OFF, 12)
            if #m0 >= 12 then
                state.dbg_bone0 = {
                    from_f32(uint_from(m0, 1, 4)),
                    from_f32(uint_from(m0, 5, 4)),
                    from_f32(uint_from(m0, 9, 4)),
                }
            end
        end
    end
end

-- LIFECYCLE: OnStart — Runs once when the script starts.

function OnStart_impl()
    pcall(read_cfg_into_state)
    state.toggle_cooldown = 0
    load_presets_from_file()
end

-- LIFECYCLE: OnDestroy — Runs once when the script shuts down.

function OnDestroy_impl()
    pcall(write_cfg_to_memory)
    if config and config.save then pcall(config.save) end
    state.esp_enabled = false
    state.silent_enabled = false
    state.rpm_enabled = false
    state.instant_reload = false
    state.fragile_armor = false
    state.infinite_ammo = false
    state.auto_loot_all = false
    state.high_headshot_dmg = false
    state.fast_fire = false
    state._last_arr_ptr = 0
    state._last_count = 0
    state._last_ptrs = nil
    state._prev_pos_by_ptr = nil
    state._was_attached = false
    state._stable_frames = 0
    state._transition_frames = 0
    reset_weapon_cache()
    local alive = false
    if state.pid ~= 0 and state.base ~= 0 then
        local alive_result = process_is_alive(state.pid, state.base)
        alive = alive_result == true
    end
    if state.pid ~= 0 and state.silent_lock_addr then
        pcall(memory.unlock, LOCK_ID.silent)
        state.silent_lock_addr = nil
    end
    if state.pid ~= 0 then
        if state.recoil_locked then
            pcall(memory.unlock_rva, LOCK_ID.recoil)
            state.recoil_locked = false
        end
        if state.spread_rva_locked then
            pcall(memory.unlock_rva, LOCK_ID.spread_rva)
            state.spread_rva_locked = false
        end
        if state.spread_aim_addrs then
            pcall(memory.unlock, LOCK_ID.spread_a1)
            pcall(memory.unlock, LOCK_ID.spread_a2)
            state.spread_aim_addrs = nil
        end
        if alive then
            pcall(restore_rpm)
            state.no_sway = false; pcall(apply_no_sway)
            state.extended_range = false; pcall(apply_extended_range)
            state.move_speed = false; pcall(apply_move_speed)
            state.magic_bullet = false; pcall(apply_magic_bullet)
            if state.time_mode ~= "normal" then pcall(apply_time, "normal") end
            pcall(write_f32, state.base + RVA.recoil, DEFAULT_RECOIL)
            pcall(write_f32, state.base + RVA.spread, DEFAULT_SPREAD)
        end
        if memory.unlock_all then
            pcall(memory.unlock_all, state.pid)
        end
    end
end

-- Rising-edge only: holding a key must not toggle every frame.
function key_edge(key)  -- global on purpose: the main chunk is at Lua's 200-local limit
    if not key or key == "" then return false end
    if not keyboard or not keyboard.is_key_press then return false end
    local ok, now = pcall(keyboard.is_key_press, key)
    if not ok then return false end
    state._key_prev = state._key_prev or {}
    local prev = state._key_prev[key]
    state._key_prev[key] = now
    return now and not prev
end

function check_hotkey(bind_key, state_key, apply_fn, label_name)
    if type(bind_key) == "string" and bind_key ~= "" then
        local pressed = key_edge(bind_key)
        if pressed then
            state[state_key] = not state[state_key]
            if apply_fn then pcall(apply_fn) end
            if label_name then
                local status_str = state[state_key] and "ON" or "OFF"
                show_splash(string.format("%s: %s", label_name, status_str))
            end
        end
    end
end

function adjust_nonskeleton_target(dx, dy)
    local target_ptr = state.silent_target_ptr or state.selected_target_ptr
    local target = nil
    if target_ptr then
        for _, e in ipairs(state.entities or {}) do
            if e.entity_ptr == target_ptr then target = e; break end
        end
    end
    if not target then target = find_silent_target(state.entities, state.viewproj, state.window_rect) end
    if not target or not is_boneless_profile(profile_name_for(target)) then
        show_splash("Select a bone-less target first")
        return
    end
    local name, legacy_name = nonskeleton_target_name(target)
    local offsets = get_nonskeleton_offset(name, legacy_name)
    local base_point = { target.pos[1], target.pos[2], target.pos[3] }
    local wr = state.window_rect and (state.window_rect[1] or state.window_rect)
    local world_delta = screen_delta_to_world(base_point, dx, dy, state.viewproj, wr)
    if not world_delta then
        show_splash("Cannot adjust: target is not projectable")
        return
    end
    local nx = offsets.x + world_delta[1]
    local ny = offsets.y + world_delta[2]
    local nz = offsets.z + world_delta[3]
    local magnitude = math.sqrt(nx * nx + ny * ny + nz * nz)
    if magnitude > NONSKELETON_AIM_LIMIT_WORLD then
        local scale = NONSKELETON_AIM_LIMIT_WORLD / magnitude
        nx, ny, nz = nx * scale, ny * scale, nz * scale
    end
    offsets.x, offsets.y, offsets.z = nx, ny, nz
    if config then
        local key = "td2.nonskel_" .. nonskeleton_offset_key(name)
        pcall(config.set, key .. "_wx", offsets.x)
        pcall(config.set, key .. "_wy", offsets.y)
        pcall(config.set, key .. "_wz", offsets.z)
        pcall(config.set, key .. "_ready", true)
        save_config_now()
    end
    show_splash(string.format("%s world offset: X %+.3f Y %+.3f Z %+.3f", name, offsets.x, offsets.y, offsets.z))
end

function adjust_nonskeleton_z(delta)
    local target_ptr = state.silent_target_ptr or state.selected_target_ptr
    local target = nil
    if target_ptr then
        for _, e in ipairs(state.entities or {}) do
            if e.entity_ptr == target_ptr then target = e; break end
        end
    end
    if not target then target = find_silent_target(state.entities, state.viewproj, state.window_rect) end
    if not target or not is_boneless_profile(profile_name_for(target)) then
        show_splash("Select a bone-less target first")
        return
    end
    local name, legacy_name = nonskeleton_target_name(target)
    local offsets = get_nonskeleton_offset(name, legacy_name)
    offsets.z = math.max(-NONSKELETON_AIM_LIMIT_WORLD,
        math.min(NONSKELETON_AIM_LIMIT_WORLD, (offsets.z or 0) + delta))
    if config then
        local key = "td2.nonskel_" .. nonskeleton_offset_key(name)
        pcall(config.set, key .. "_wx", offsets.x)
        pcall(config.set, key .. "_wy", offsets.y)
        pcall(config.set, key .. "_wz", offsets.z)
        pcall(config.set, key .. "_ready", true)
        save_config_now()
    end
    show_splash(string.format("%s Z offset: %+.2f", name, offsets.z))
end

function process_hotkeys()
    if not keyboard or not keyboard.is_key_press then return end
    if key_edge("Insert") then
        state.show_ui = not state.show_ui
    end
    if HOTKEY_MASTER ~= "" and key_edge(HOTKEY_MASTER) then
        set_master(not state.master_enabled)
    end
    if not state.master_enabled then return end
    check_hotkey(HOTKEY_ESP, "esp_enabled", nil, "ESP")
    check_hotkey(HOTKEY_ESP_PLAYERS, "esp_show_players", nil, "ESP Players")
    check_hotkey(HOTKEY_ESP_BOX, "esp_boxes", nil, "ESP Box")
    check_hotkey(HOTKEY_ESP_LOOT, "esp_loot", nil, "Loot ESP")
    check_hotkey(HOTKEY_ESP_BONES, "esp_bones", nil, "ESP Bones")
    check_hotkey(HOTKEY_SILENT, "silent_enabled", nil, "Silent Aim")
    check_hotkey(HOTKEY_MAGIC_BULLET, "magic_bullet", apply_magic_bullet, "Magic Bullet")
    check_hotkey(HOTKEY_NO_RECOIL, "no_recoil", apply_recoil, "No Recoil")
    check_hotkey(HOTKEY_NO_SPREAD, "no_spread", apply_spread, "No Spread")
    check_hotkey(HOTKEY_INSTANT_RELOAD, "instant_reload", nil, "Instant Reload")
    check_hotkey(HOTKEY_NO_SWAY, "no_sway", apply_no_sway, "No Sway")
    check_hotkey(HOTKEY_MOVE_SPEED, "move_speed", apply_move_speed, "No Movement Spread")
    check_hotkey(HOTKEY_EXTENDED_RANGE, "extended_range", apply_extended_range, "Extended Range")
    check_hotkey(HOTKEY_AUTO_LOOT, "auto_loot_all", nil, "Auto-Loot All")
    check_hotkey(HOTKEY_SHOW_FOV, "esp_show_silent_fov", nil, "Show FOV")
    if HOTKEY_COUNTER_COLLAPSE ~= "" and key_edge(HOTKEY_COUNTER_COLLAPSE) then
        state.counter_collapsed = not state.counter_collapsed
        show_splash(state.counter_collapsed and "Counter: collapsed" or "Counter: expanded")
    end
    check_hotkey(HOTKEY_ESP_DISTANCE, "esp_distance", nil, "Distance")
    check_hotkey(HOTKEY_ESP_SNAPLINES, "esp_snaplines", nil, "Snaplines")
    check_hotkey(HOTKEY_ESP_BONE_IDS, "esp_bone_ids", nil, "Bone IDs")
    check_hotkey(HOTKEY_ESP_TYPE, "esp_type", nil, "Type")
    check_hotkey(HOTKEY_ESP_NAME, "esp_name", nil, "Name")
    check_hotkey(HOTKEY_CROSSHAIR, "crosshair_enabled", nil, "Crosshair")
    if HOTKEY_TAP_LOOT ~= "" and key_edge(HOTKEY_TAP_LOOT) then
        auto_loot_all_tick(true)
        show_splash("Tap Loot")
    end
    if HOTKEY_PRESET_1 ~= "" and key_edge(HOTKEY_PRESET_1) then load_preset_slot(1) end
    if HOTKEY_PRESET_2 ~= "" and key_edge(HOTKEY_PRESET_2) then load_preset_slot(2) end
    if HOTKEY_PRESET_3 ~= "" and key_edge(HOTKEY_PRESET_3) then load_preset_slot(3) end
    if HOTKEY_PRESET_4 ~= "" and key_edge(HOTKEY_PRESET_4) then load_preset_slot(4) end
    if HOTKEY_RPM ~= "" and key_edge(HOTKEY_RPM) then
        state.rpm_enabled = not state.rpm_enabled
        if not state.rpm_enabled then pcall(restore_rpm) end
        local status_str = state.rpm_enabled and "ON" or "OFF"
        show_splash(string.format("RPM Override: %s", status_str))
    end
    if HOTKEY_FOV_UP ~= "" and key_edge(HOTKEY_FOV_UP) then
        state.silent_fov = math.min(800, state.silent_fov + 10)
        show_splash(string.format("FOV: %.0f", state.silent_fov))
    end
    if HOTKEY_FOV_DOWN ~= "" and key_edge(HOTKEY_FOV_DOWN) then
        state.silent_fov = math.max(10, state.silent_fov - 10)
        show_splash(string.format("FOV: %.0f", state.silent_fov))
    end
    if keyboard.is_key_press(HOTKEY_NONSKELETON_UP) then
        adjust_nonskeleton_target(0, -NONSKELETON_AIM_STEP_PX)
    end
    if keyboard.is_key_press(HOTKEY_NONSKELETON_LEFT) then
        adjust_nonskeleton_target(-NONSKELETON_AIM_STEP_PX, 0)
    end
    if keyboard.is_key_press(HOTKEY_NONSKELETON_DOWN) then
        adjust_nonskeleton_target(0, NONSKELETON_AIM_STEP_PX)
    end
    if keyboard.is_key_press(HOTKEY_NONSKELETON_RIGHT) then
        adjust_nonskeleton_target(NONSKELETON_AIM_STEP_PX, 0)
    end
    if keyboard.is_key_press(HOTKEY_NONSKELETON_FAR) then
        adjust_nonskeleton_z(-NONSKELETON_WORLD_STEP)
    end
    if keyboard.is_key_press(HOTKEY_NONSKELETON_NEAR) then
        adjust_nonskeleton_z(NONSKELETON_WORLD_STEP)
    end
    if HOTKEY_RPM_UP ~= "" and key_edge(HOTKEY_RPM_UP) then
        state.rpm_value = math.min(RPM_MAX, state.rpm_value + 50)
        show_splash(string.format("RPM: %d", state.rpm_value))
    end
    if HOTKEY_RPM_DOWN ~= "" and key_edge(HOTKEY_RPM_DOWN) then
        state.rpm_value = math.max(RPM_MIN, state.rpm_value - 50)
        show_splash(string.format("RPM: %d", state.rpm_value))
    end
    if HOTKEY_AIM_PART ~= "" and key_edge(HOTKEY_AIM_PART) then
        if state.aim_part == "head" then
            state.aim_part = "chest"
        elseif state.aim_part == "chest" then
            state.aim_part = "pelvis"
        else
            state.aim_part = "head"
        end
        state.dynamic_aim = false
        show_splash(string.format("Aim Part: %s", (state.aim_part or "head"):upper()))
    end
    if HOTKEY_AIM_DYNAMIC ~= "" and key_edge(HOTKEY_AIM_DYNAMIC) then
        if state.dynamic_aim or state.aim_part == "dynamic" then
            state.dynamic_aim = false
            if state.aim_part == "dynamic" then
                state.aim_part = state._prev_aim_part or "head"
            end
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
        if alive == false then
            detach_stale_process(reason)
        elseif alive == nil then
            report_memory_error("process check", reason)
        end
    end
    if state.pid ~= 0 and state.base ~= 0 then
        local dok, derr = pcall(dbg_refresh)
        if not dok then state.dbg_err = tostring(derr) end
    end
    if state.pid == 0 then
        state.attach_timer = state.attach_timer + (dt or 0)
        if state.attach_timer >= 2.0 then
            state.attach_timer = 0
            local ok, pid = false, nil
            if memory and memory.get_pid then ok, pid = pcall(memory.get_pid, state.name) end
            if ok and pid and pid > 0 then
                local bok, base = false, nil
                if memory and memory.get_process_base then bok, base = pcall(memory.get_process_base, pid) end
                if bok and is_valid_addr(base, 1) then
                    state.pid = pid
                    state.base = base
                    state.process_check_timer = 0
                    state.walk_skip = 0
                    state.status = string.format("Attached PID %d 0x%X", state.pid, state.base)
                else
                    report_memory_error("attach", bok and "process base unavailable" or base)
                end
            end
        end
    end
    if state.pid ~= 0 and state.base ~= 0 then
        refresh_weapon_cache(true)
    end
end

function process_hacks_and_stats(dt)
    local in_transition = (state._transition_frames or 0) > 0 or not state._was_attached
    if not in_transition and state.no_recoil then
        if not state.recoil_locked then
            pcall(apply_recoil)
        else
            local ok = pcall(memory.lock_rva, LOCK_ID.recoil, state.pid, RVA.recoil, pack_f32(0.0))
            if not ok then
                state.recoil_locked = false
                pcall(apply_recoil)
            end
        end
    end
    if not in_transition and state.no_spread then
        if not state.spread_rva_locked then
            pcall(apply_spread)
        else
            local ok = pcall(memory.lock_rva, LOCK_ID.spread_rva, state.pid, RVA.spread, pack_f32(0.0))
            if not ok then
                state.spread_rva_locked = false
                pcall(apply_spread)
            end
        end
    end
    if not in_transition and state.rpm_enabled then rpm_tick() end
    if not in_transition and state.instant_reload then instant_reload_tick() end
    if not in_transition and state.fragile_armor then fragile_armor_tick() end
    if not in_transition and state.auto_loot_all then auto_loot_all_tick() end
    if not in_transition and state.high_headshot_dmg then headshot_dmg_tick() end
    if not in_transition and state.fast_fire then fire_interval_tick() end
    if not in_transition and state.no_sway then sway_tick() end
    if not in_transition and state.extended_range then extended_range_tick() end
    if state.move_speed and not teleport_guard() then move_speed_tick() end
    state.stats_timer = state.stats_timer + (dt or 0)
    if state.stats_timer >= 1.0 then
        state.stats_timer = 0
        pcall(refresh_stats)
        if state.time_mode ~= "normal" then
            pcall(apply_time, state.time_mode)
        end
        state.selected_target_ptr = 0
        local t = find_silent_target(state.entities, state.viewproj, state.window_rect)
        if t then
            state.selected_target_ptr = t.entity_ptr or 0
        end
    end
end

function clean_key_name(k)
    if not k or k == "" then return "" end
    local map = {
        Multiply = "Num *", Divide = "Num /", Decimal = "Num DEL", Add = "Num +", Subtract = "Num -",
        Numpad1 = "Num 1", Numpad2 = "Num 2", Numpad3 = "Num 3", Numpad4 = "Num 4", Numpad5 = "Num 5",
        Numpad6 = "Num 6", Numpad7 = "Num 7", Numpad8 = "Num 8", Numpad9 = "Num 9", Numpad0 = "Num 0",
        PageUp = "PgUp", PageDown = "PgDn", Insert = "Ins", Delete = "Del", Home = "Home", End = "End",
    }
    return map[k] or k:upper()
end

function draw_overlays(dt)
    if state.splash_timer and state.splash_timer > 0 then
        state.splash_timer = state.splash_timer - (dt or 0)
        local w0 = state.window_rect
        if w0 and #w0 > 0 then w0 = w0[1] end
        if not w0 then w0 = { x = 0, y = 0, width = 1920, height = 1080 } end
        local cx = w0.x + w0.width / 2
        local cy = w0.y + 35
        local txt = state.splash_text or ""
        local tw = 0
        if draw.get_text_width then
            tw = draw.get_text_width(txt, 32)
        elseif render and render.get_text_size then
            _, tw = render.get_text_size(txt)
        else
            tw = #txt * 18
        end
        local box_padding_x = 30
        local box_w = tw + (box_padding_x * 2)
        local box_h = 70
        local box_x = cx - (box_w / 2)
        local box_y = cy
        local tr, tg, tb = 255, 255, 255
        if txt:find("ON") then tr, tg, tb = 0, 255, 100
        elseif txt:find("OFF") then tr, tg, tb = 255, 80, 80
        else tr, tg, tb = 255, 255, 100 end
        pcall(function()
            draw.filled_rect(box_x, box_y, box_w, box_h, 0, 0, 0, 180)
            local text_x = box_x + (box_w - tw) / 2
            local text_y = box_y + (box_h - 32) / 2 - 6
            draw.text(text_x, text_y, txt, tr, tg, tb, 255, 32)
        end)
    end
    if state.show_ui then
        local title = state.pid ~= 0 and string.format("TD2 [PID %d]", state.pid) or "TD2"
        ui.window(title, function()
            if state.pid ~= 0 then
                ui.monospace(string.format("Base 0x%X", state.base))
            else
                ui.small("Not attached - auto-search every 2s")
            end
            ui.separator()
            ui.scroll_area(580, function()
                ui.collapsing_header("Config", function()
                    local mv, mv_ch = ui.checkbox("Master (" .. clean_key_name(HOTKEY_MASTER) .. ")", state.master_enabled)
                    if mv_ch then set_master(mv) end
                    ui.separator()
                    ui.monospace("Presets")
                    for i = 1, 4 do
                        if ui.checkbox("Preset " .. i, state.active_preset == i) then state.active_preset = i end
                    end
                    ui.separator()
                    if ui.button("Load Preset") then load_preset_slot(state.active_preset) end
                    if ui.button("Save Preset") then save_current_to_preset(state.active_preset) end
                end)
                ui.collapsing_header("Toggles", function()
                    chk("ESP", "esp_enabled")
                    chk("Silent aim", "silent_enabled")
                    chk("Target gadgets", "target_gadgets")
                    chk("Ignore Gadgets", "ignore_gadgets")
                    chk("No recoil", "no_recoil", apply_recoil)
                    chk("No spread", "no_spread", apply_spread)
                    chk("Magic bullet (NPC-only)", "magic_bullet", apply_magic_bullet)
                    chk("No sway", "no_sway", apply_no_sway)
                    chk("No move spread", "move_speed", apply_move_speed)
                    chk("Extended range", "extended_range", apply_extended_range)
                    chk("Instant reload", "instant_reload")
                    chk("Fragile Enemy Armor", "fragile_armor")
                    chk("Auto-Loot All Items (PgDn)", "auto_loot_all")
                    chk("High Headshot Dmg", "high_headshot_dmg")
                    chk("Fast Fire Interval", "fast_fire")
                    chk("RPM override", "rpm_enabled", function()
                        if not state.rpm_enabled then pcall(restore_rpm) end
                    end)
					ui.separator()
                    ui.monospace("Crosshair")
                    chk("Show Crosshair", "crosshair_enabled")
                    chk("Circle Center Dot", "crosshair_dot")
                    chk("Black Outline", "crosshair_outline")
                    state.crosshair_size = select(1, ui.slider_f32("Crosshair Length", state.crosshair_size, 2, 60))
                    state.crosshair_gap = select(1, ui.slider_f32("Crosshair Gap", state.crosshair_gap, 0, 40))
                    state.crosshair_thick = select(1, ui.slider_f32("Crosshair Thickness", state.crosshair_thick, 1, 10))
                    state.crosshair_dot_size = select(1, ui.slider_f32("Center Dot Radius", state.crosshair_dot_size, 1, 10))
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
                    state.silent_max_dist = select(1, ui.slider_f32("Max Distance", state.silent_max_dist, 10, 800))
                    chk("Show FOV circle", "esp_show_silent_fov")
                    chk("Enemy Summons", "silent_target_summon")
                    chk("Rogue Agents", "silent_target_rogues")
                    chk("Target Friendlies", "silent_target_friendly")
                    chk("360 Silent Aim (no FOV limit)", "silent_360")
                    chk("Entity Counter (on-screen)", "show_entity_counter")
                    state.counter_x = select(1, ui.slider_f32("Counter X", state.counter_x, 0, 1920))
                    state.counter_y = select(1, ui.slider_f32("Counter Y", state.counter_y, 0, 1080))
                    chk("Counter collapsed (F8)", "counter_collapsed")
                    do  -- count nameless hostiles
                        local nameless_hostile = 0
                        for _, e in ipairs(state.entities or {}) do
                            if e and (e.ent_name == nil or e.ent_name == "") and e.relation == "hostile" then
                                nameless_hostile = nameless_hostile + 1
                            end
                        end
                        ui.small("Nameless hostiles (Rogues?): " .. nameless_hostile)
                    end
                    ui.separator()
                    ui.small("Target: " .. (state.silent_target_name ~= "" and state.silent_target_name or "none"))
                    ui.small(state.silent_armed and "ARMED (kernel lock ~10ms)" or "idle")
                    ui.small("Shots: " .. state.silent_shots)
                end)
                ui.collapsing_header("Boneless Aim (test)", function()
                    chk("Boneless aim override", "boneless_override")
                    local offset_target = nil
                    local offset_ptr = state.silent_target_ptr or state.selected_target_ptr
                    if offset_ptr then
                        for _, e in ipairs(state.entities or {}) do
                            if e.entity_ptr == offset_ptr
                                and (not e.archetype or not ARCHETYPE_WILDLIFE[e.archetype])
                                and is_boneless_profile(profile_name_for(e)) then
                                offset_target = e
                                break
                            end
                        end
                    end
                    if not offset_target then
                        local wr = state.window_rect and (state.window_rect[1] or state.window_rect)
                        if state.viewproj and wr and wr.width and wr.height then
                            local cx, cy = wr.x + wr.width / 2, wr.y + wr.height / 2
                            local best_dist_sq = math.huge
                            for _, e in ipairs(state.entities or {}) do
                                if e and not e.is_player and not e.is_local_player
                                    and (not e.archetype or not ARCHETYPE_WILDLIFE[e.archetype])
                                    and is_boneless_profile(profile_name_for(e)) then
                                    local sx, sy = world_to_screen(e.pos, state.viewproj, wr)
                                    if sx and sy and sx >= wr.x and sx <= wr.x + wr.width
                                        and sy >= wr.y and sy <= wr.y + wr.height then
                                        local dx, dy = sx - cx, sy - cy
                                        local dist_sq = dx * dx + dy * dy
                                        if dist_sq < best_dist_sq then
                                            best_dist_sq, offset_target = dist_sq, e
                                        end
                                    end
                                end
                            end
                        end
                    end
                    ui.separator()
                    ui.monospace("Boneless target offsets")
                    if offset_target and is_boneless_profile(profile_name_for(offset_target)) then
                        local offset_name = nonskeleton_target_name(offset_target)
                        local offsets = get_nonskeleton_offset(offset_name)
                        ui.small("Offsets: " .. offset_name)
                        local changed_any = false
                        for _, axis in ipairs({ "x", "y", "z" }) do
                            local label = axis:upper()
                            local value = select(1, ui.slider_f32(label, offsets[axis] or 0, -NONSKELETON_AIM_LIMIT_WORLD, NONSKELETON_AIM_LIMIT_WORLD))
                            value = math.max(-NONSKELETON_AIM_LIMIT_WORLD,
                                math.min(NONSKELETON_AIM_LIMIT_WORLD, tonumber(value) or 0))
                            if value >= 0 then
                                value = math.floor(value * 10 + 0.5) / 10
                            else
                                value = math.ceil(value * 10 - 0.5) / 10
                            end
                            if value ~= offsets[axis] then
                                offsets[axis] = value
                                changed_any = true
                            end
                        end
                        if changed_any and config then
                            local key = "td2.nonskel_" .. nonskeleton_offset_key(offset_name)
                            pcall(config.set, key .. "_wx", offsets.x)
                            pcall(config.set, key .. "_wy", offsets.y)
                            pcall(config.set, key .. "_wz", offsets.z)
                            pcall(config.set, key .. "_ready", true)
                            save_config_now()
                        end
                    else
                        ui.small("No visible bone-less target; offset controls are ready when one appears")
                    end
                    ui.small("Num5/2: up/down, Num1/3: left/right, Num4/6: Z -/+")
                end)
                ui.collapsing_header("ESP settings", function()
                    ui.monospace("Visuals")
                    chk("Boxes", "esp_boxes")
                    chk("Distance", "esp_distance")
                    chk("Snap lines", "esp_snaplines")
                    chk("Bones", "esp_bones")
                    chk("Bone IDs", "esp_bone_ids")
                    ui.small("Bone IDs dumps all 0..90 bones (slow, debug only)")
                    chk("Type", "esp_type")
                    chk("Name", "esp_name")
                    ui.separator()
                    ui.monospace("Filters")
                    chk("Hostile", "esp_show_hostile")
                    chk("Players", "esp_show_players")
                    chk("Other", "esp_show_other")
                    chk("Caches", "esp_show_caches")
                    local cache_count, cache_near, cache_dist = count_cache_entities()
                    local cache_note = string.format("Cache markers: %d", cache_count)
                    if cache_near then
                        local nm = (cache_near.ent_name ~= "" and cache_near.ent_name or cache_near.type_str or "?")
                        cache_note = cache_note .. string.format("  nearest: %s (%.0fm)", nm, cache_dist or 0)
                    end
                    ui.small(cache_note)
                    local seen_types, type_list = {}, {}
                    for _, e in ipairs(state.entities or {}) do
                        local t = e.type_str or ""
                        if t ~= "" and not seen_types[t] then
                            seen_types[t] = true
                            type_list[#type_list + 1] = t
                            if #type_list >= 8 then break end
                        end
                    end
                    if #type_list > 0 then ui.small("Entity types: " .. table.concat(type_list, ", ")) end
                    local near_list = {}
                    for _, e in ipairs(state.entities or {}) do
                        if not e.is_player then near_list[#near_list + 1] = e end
                    end
                    table.sort(near_list, function(a, b) return (tonumber(a.dist) or 1e9) < (tonumber(b.dist) or 1e9) end)
                    if #near_list == 0 then
                        ui.small("Nearby entities: none")
                    else
                        ui.small("Nearby entities:")
                        for i = 1, math.min(5, #near_list) do
                            local e = near_list[i]
                            local nm = (e.ent_name ~= "" and e.ent_name or "?")
                            local tp = (e.type_str ~= "" and e.type_str or "?")
                            ui.small(string.format("  %s | %s | %.0fm", nm, tp, tonumber(e.dist) or 0))
                        end
                    end
                    chk("Friendly", "esp_show_friendly")
                    chk("Wildlife", "esp_show_wildlife")
                    chk("Neutral", "esp_show_neutral")
                    chk("Relation", "esp_show_relation")
                    chk("Faction", "esp_show_faction")
                    state.esp_max_dist = select(1, ui.drag_value_u64("Max Distance", state.esp_max_dist))
                    ui.small(string.format("Entities: %d  Projection: %s", #state.entities, state.viewproj and "OK" or "none"))
                    if state.scan_info ~= "" then ui.code(state.scan_info) end
                end)
                ui.collapsing_header("Loot Markers", function()
                    chk("Show loot markers", "esp_loot")
                    local saved_size = tonumber(state.loot_text_size) or 10
                    if not is_finite(saved_size) then saved_size = 10 end
                    state.loot_text_size = math.max(6,
                        math.min(16, math.floor(saved_size + 0.5)))
                    local loot_size = select(1,
                        ui.slider_i32("Text Size", state.loot_text_size, 6, 16))
                    loot_size = tonumber(loot_size) or 10
                    if not is_finite(loot_size) then loot_size = 10 end
                    state.loot_text_size = math.max(6,
                        math.min(16, math.floor(loot_size + 0.5)))
                    local loot_dist = tonumber(state.loot_max_dist) or 150
                    if not is_finite(loot_dist) then loot_dist = 150 end
                    loot_dist = math.max(10, math.min(200, math.floor(loot_dist / 10 + 0.5) * 10))
                    local loot_distance = select(1,
                        ui.slider_i32("Max Distance (m)", loot_dist, 10, 200))
                    loot_distance = tonumber(loot_distance) or 150
                    if not is_finite(loot_distance) then loot_distance = 150 end
                    state.loot_max_dist = math.max(10,
                        math.min(200, math.floor(loot_distance / 10 + 0.5) * 10))
                    ui.monospace("Loot types")
                    chk("R0 Mixed Loot", "loot_show_r0")
                    chk("R1 Access Key", "loot_show_r1")
                    chk("R2 Bounty", "loot_show_r2")
                    chk("R3 Material", "loot_show_r3")
                    chk("R4 Material", "loot_show_r4")
                    chk("R5 Superior", "loot_show_r5")
                    chk("R6 High-End", "loot_show_r6")
                    chk("R7 Event Key", "loot_show_r7")
                    chk("R8 Gear Set", "loot_show_r8")
                    chk("R9 Exotic", "loot_show_r9")
                    chk("R11 Prototype", "loot_show_r11")
                    chk("Other R values", "loot_show_other")
                    ui.small(string.format("Visible markers: %d", #(state.loot_items or {})))
                    ui.small(string.format("Loot bags in manager: %d", tonumber(state.loot_mgr_total) or 0))
                    chk("Loot Boxes (empty containers)", "loot_show_boxes")
                    if state.loot_scan_error then ui.small("Loot scan: " .. state.loot_scan_error) end
                end)
                ui.collapsing_header("Auto-Loot Items", function()
                    ui.small("PgDn toggles Auto-Loot All; PgUp does one tap-loot sweep. Only bags with a checked type are moved to you.")
                    chk("R0 Mixed Loot", "loot_auto_r0")
                    chk("R1 Access Key", "loot_auto_r1")
                    chk("R2 Bounty", "loot_auto_r2")
                    chk("R3 Material", "loot_auto_r3")
                    chk("R4 Material", "loot_auto_r4")
                    chk("R5 Superior", "loot_auto_r5")
                    chk("R6 High-End", "loot_auto_r6")
                    chk("R7 Event Key", "loot_auto_r7")
                    chk("R8 Gear Set", "loot_auto_r8")
                    chk("R9 Exotic", "loot_auto_r9")
                    chk("R11 Prototype", "loot_auto_r11")
                    chk("Other R values", "loot_auto_other")
                end)
                ui.collapsing_header("RPM settings", function()
                    local sv = select(1, ui.slider_f32("RPM", state.rpm_value, RPM_MIN, RPM_MAX))
                    state.rpm_value = math.floor(sv + 0.5)
                    state.rpm_value = select(1, ui.drag_value_i32("Exact Value", state.rpm_value))
                    sanitize_rpm_value()
                    ui.small(string.format("live %.0f  template %.0f  target %d", state.rpm_live, state.rpm_template_live, state.rpm_value))
                    if ui.button("Read RPM") then pcall(read_rpm_once) end
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
                    ui.code(state.read_result)
                    ui.separator()
                    ui.monospace("Silent aim live")
                    if state.telem_valid then
                        local p = state.telem_world_aim
                        local wd = state.telem_lock_target
                        if p then ui.small(string.format("worldAimPos %.2f %.2f %.2f", p[1], p[2], p[3])) else ui.small("worldAimPos -") end
                        if wd then ui.small(string.format("lock target %.2f %.2f %.2f", wd[1], wd[2], wd[3])) else ui.small("lock target -") end
                        if state.telem_delta then
                            ui.small(string.format("delta %.3f  %s", state.telem_delta, state.telem_delta < SILENT_LOCK_DELTA and "LOCKED OK" or "RACE"))
                        else
                            ui.small("delta -")
                        end
                        ui.small(string.format("Lock address: %s", state.telem_lock_addr and string.format("0x%X", state.telem_lock_addr) or "none"))
                        ui.small(string.format("Rounds fired: %d  Shots: %d", state.telem_rounds, state.silent_shots))
                    else
                        ui.small("telemetry unavailable")
                    end
                    ui.separator()
                    ui.monospace("Position Debug")
                    if state.dbg_err then ui.small("Error: " .. state.dbg_err) end
                    ui.small(state.dbg_lp_pos and string.format("Player Pos %.3f %.3f %.3f", state.dbg_lp_pos[1], state.dbg_lp_pos[2], state.dbg_lp_pos[3]) or "Player Pos -")
                    ui.small(state.dbg_bone0 and string.format("Bone0 Pos %.3f %.3f %.3f", state.dbg_bone0[1], state.dbg_bone0[2], state.dbg_bone0[3]) or "Bone0 Pos -")
                    ui.separator()
                    ui.monospace("Entity factions")
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
                        table.sort(fkeys, function(a, b)
                            if facs[a] ~= facs[b] then return facs[a] > facs[b] end
                            return a < b
                        end)
                        local parts = {}
                        for i, f in ipairs(fkeys) do
                            local rawtag = fac_tags[f] or ""
                            local shown = rawtag ~= "" and rawtag or "?"
                            parts[i] = string.format("%s(%s)×%d", faction_display_en(f, rawtag), shown, facs[f])
                        end
                        ui.code(table.concat(parts, "  "))
                    end
                end)
            end)
            ui.separator()
            ui.small(state.status)
        end)
    end
    if state.show_info_overlay then
        local layout = HUD_PANEL_LAYOUT
        local w0 = state.window_rect
        if w0 and #w0 > 0 then w0 = w0[1] end
        if not w0 then w0 = { x = 0, y = 0, width = 1920, height = 1080 } end
        local columns_width = layout.padding_left + layout.function_column_width
            + layout.status_column_width + layout.shortcut_column_width
            + layout.padding_right
        local box_w = math.max(layout.width, columns_width)
        local box_h = layout.height
        local box_x = w0.x + w0.width - box_w - layout.margin_right
        local box_y = w0.y + layout.margin_top
        pcall(function()
            draw.filled_rect(box_x, box_y, box_w, box_h,
                0, 0, 0, layout.background_alpha)
            if layout.border_enabled then
                draw.rect(box_x, box_y, box_w, box_h,
                    200, 200, 200, 220, 1.0)
            end
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
            local function draw_category_header(title)
                draw.text(label_x, ty, title, 100, 200, 255, 255, layout.section_font)
                ty = ty + layout.section_height
            end
            local function draw_row(label, val_str, is_active, key_name)
                local k_str = ""
                if type(key_name) == "table" then
                    local keys = {}
                    for _, key in ipairs(key_name) do
                        local clean = clean_key_name(key)
                        if clean ~= "" then keys[#keys + 1] = clean end
                    end
                    k_str = table.concat(keys, " / ")
                else
                    k_str = clean_key_name(key_name)
                end
                draw.text(label_x, ty, label .. ":", 220, 220, 220, 255, layout.row_font)
                local r, g, b = 255, 255, 255
                if is_active == true then
                    r, g, b, val_str = 0, 255, 100, "ON"
                elseif is_active == false then
                    r, g, b, val_str = 255, 80, 80, "OFF"
                elseif val_str ~= nil then
                    r, g, b = 255, 255, 100
                end
                draw.text(stat_x, ty, val_str or "", r, g, b, 255, layout.row_font)
                if k_str ~= "" then
                    draw.text(shortcut_x, ty, k_str, 0, 255, 255, 255, layout.row_font)
                end
                ty = ty + layout.row_height
            end
            local preset_keys = { HOTKEY_PRESET_1, HOTKEY_PRESET_2, HOTKEY_PRESET_3, HOTKEY_PRESET_4 }
            draw_row("Master", nil, state.master_enabled, HOTKEY_MASTER)
            for i = 1, 4 do
                local is_active = (state.active_preset == i)
                local lr, lg, lb = is_active and 0 or 220, is_active and 255 or 220, is_active and 100 or 220
                draw.text(label_x, ty, "Preset " .. i .. ":", lr, lg, lb, 255, layout.row_font)
                if is_active then draw.text(stat_x, ty, "Active", 0, 255, 100, 255, layout.row_font) end
                local k_str = clean_key_name(preset_keys[i])
                if k_str ~= "" then
                    draw.text(shortcut_x, ty, k_str, 0, 255, 255, 255, layout.row_font)
                end
                ty = ty + layout.row_height
            end
            draw_category_header("--- FEATURES ---")
            draw_row("Silent Aim", nil, state.silent_enabled, HOTKEY_SILENT)
            draw_row("Magic Bullet", nil, state.magic_bullet, HOTKEY_MAGIC_BULLET)
            draw_row("RPM Override", nil, state.rpm_enabled, HOTKEY_RPM)
            local rpm_str = string.format("%d / %.0f", state.rpm_value, state.rpm_live)
            draw_row("RPM (+50 / -50)", rpm_str, nil, { HOTKEY_RPM_UP, HOTKEY_RPM_DOWN })
            draw_row("ESP", nil, state.esp_enabled, HOTKEY_ESP)
            draw_row("No Recoil", nil, state.no_recoil, HOTKEY_NO_RECOIL)
            draw_row("No Spread", nil, state.no_spread, HOTKEY_NO_SPREAD)
            draw_row("Instant Reload", nil, state.instant_reload, HOTKEY_INSTANT_RELOAD)
            draw_row("Auto-Loot All", nil, state.auto_loot_all, HOTKEY_AUTO_LOOT)
            draw_row("Tap Loot", nil, nil, HOTKEY_TAP_LOOT)
            draw_row("No Sway", nil, state.no_sway, HOTKEY_NO_SWAY)
            draw_row("Crosshair", nil, state.crosshair_enabled, HOTKEY_CROSSHAIR)
            draw_row("Time Mode", (state.time_mode or "normal"):upper(), nil, "")
            ty = ty + layout.section_gap
            draw_category_header("--- SILENT AIM SETTINGS ---")
            local aim_label = (state.dynamic_aim or state.aim_part == "dynamic") and "DYNAMIC" or (state.aim_part or "head"):upper()
            draw_row("Aim Part", aim_label, nil, HOTKEY_AIM_PART)
            local is_dynamic = state.dynamic_aim or (state.aim_part == "dynamic")
            draw_row("Dynamic Aim", nil, is_dynamic, HOTKEY_AIM_DYNAMIC)
            draw_row("Show FOV Circle", nil, state.esp_show_silent_fov, HOTKEY_SHOW_FOV)
            draw_row("Target Marker Size", string.format("%.0f", state.target_marker_size), nil, "")
            draw_row("FOV (+10 / -10)", string.format("%.0f", state.silent_fov), nil, { HOTKEY_FOV_UP, HOTKEY_FOV_DOWN })
            ty = ty + layout.section_gap
            draw_category_header("--- BONELESS AIM (TEST) ---")
            draw_row("Boneless Override", nil, state.boneless_override, "")
            draw_row("Boneless Aim UP / DN", nil, nil, { HOTKEY_NONSKELETON_UP, HOTKEY_NONSKELETON_DOWN })
            draw_row("Boneless Aim L / R", nil, nil, { HOTKEY_NONSKELETON_LEFT, HOTKEY_NONSKELETON_RIGHT })
            draw_row("Boneless Aim Z", nil, nil, { HOTKEY_NONSKELETON_FAR, HOTKEY_NONSKELETON_NEAR })
            ty = ty + layout.section_gap
            draw_category_header("--- ESP SETTINGS ---")
            draw_row("Loot ESP", nil, state.esp_loot, HOTKEY_ESP_LOOT)
            draw_row("ESP Box", nil, state.esp_boxes, HOTKEY_ESP_BOX)
            draw_row("ESP Bones", nil, state.esp_bones, HOTKEY_ESP_BONES)
            draw_row("Distance", nil, state.esp_distance, HOTKEY_ESP_DISTANCE)
            draw_row("Snaplines", nil, state.esp_snaplines, HOTKEY_ESP_SNAPLINES)
            draw_row("Type", nil, state.esp_type, HOTKEY_ESP_TYPE)
            draw_row("Name", nil, state.esp_name, HOTKEY_ESP_NAME)
            draw_row("Hostile", nil, state.esp_show_hostile, "")
            draw_row("Players", nil, state.esp_show_players, HOTKEY_ESP_PLAYERS)
            draw_row("Other", nil, state.esp_show_other, "")
            draw_row("Caches", nil, state.esp_show_caches, "")
        end)
    end
end
state.loot_rarity = {
    [0] = { "Mixed Loot", 245, 245, 245 },
    [1] = { "Access Key", 255, 235, 145 },
    [2] = { "Bounty", 150, 150, 150 },
    [3] = { "Material", 95, 220, 115 },
    [4] = { "Material", 55, 155, 255 },
    [5] = { "Superior", 180, 70, 255 },
    [6] = { "High-End", 255, 220, 40 },
    [7] = { "Event Key", 65, 145, 255 },
    [8] = { "Gear Set", 50, 190, 180 },
    [9] = { "Exotic", 255, 85, 55 },
    [11] = { "Prototype", 220, 165, 255 },
}
state.loot_filter_enabled = function(rarity)
    local keys = {
        [0] = "loot_show_r0", [1] = "loot_show_r1", [2] = "loot_show_r2", [3] = "loot_show_r3",
        [4] = "loot_show_r4",
        [5] = "loot_show_r5",
        [6] = "loot_show_r6", [7] = "loot_show_r7", [8] = "loot_show_r8",
        [9] = "loot_show_r9", [11] = "loot_show_r11",
    }
    local key = keys[rarity]
    if key then return state[key] ~= false end
    return state.loot_show_other ~= false
end
state.read_loot_cstring = function(addr, max_len)
    max_len = math.max(1, math.min(128, tonumber(max_len) or 96))
    if not is_valid_addr(addr, max_len) then return "" end
    local raw, len = read_bytes_table(addr, max_len)
    if len < 1 then return "" end
    local chars = {}
    for i = 1, math.min(len, max_len) do
        local b = raw[i] or 0
        if b == 0 then break end
        if b < 32 or b == 127 then return "" end
        chars[#chars + 1] = string.char(b)
    end
    return table.concat(chars)
end
state.read_loot_text_slot = function(addr)
    if not is_valid_addr(addr, 32) then return "" end
    local ptr = read_uint(addr, 8)
    if is_valid_addr(ptr, 32) then
        local pointed = read_sd_string(ptr)
        if pointed ~= "" then return pointed end
        pointed = state.read_loot_cstring(ptr)
        if pointed ~= "" then return pointed end
    end
    local inline = read_sd_string(addr)
    if inline ~= "" then return inline end
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
    if s:find("component", 1, true) or s:find("ceramic", 1, true) or s:find("steel", 1, true)
        or s:find("polycarbonate", 1, true) or s:find("titanium", 1, true)
        or s:find("carbon fiber", 1, true) or s:find("carbon fibre", 1, true)
        or s:find("electronics", 1, true) or s:find("protective fabric", 1, true)
        or s:find("material", 1, true) then return "Components" end
    if s:find("key", 1, true) then return "Key" end
    return "R0 Item"
end
state.is_bounty_loot = function(name, internal_id)
    local s = string.lower(tostring(name or "") .. " " .. tostring(internal_id or ""))
    return s:find("bounty", 1, true) ~= nil
        or s:find("dousing the light", 1, true) ~= nil
        or s:find("scarecrow", 1, true) ~= nil
        or s:find("blinding the eye", 1, true) ~= nil
        or s:find("final girl", 1, true) ~= nil
        or s:find("binding circle", 1, true) ~= nil
        or s:find("rubber and glue", 1, true) ~= nil
end
state.scan_loot = function(pid, pobject)
    if not state.esp_loot or not state.local_pos then state.loot_items = {}; state.loot_boxes = {}; return end
    local manager = read_uint(pobject + OFF.lootManager, 8)
    if not is_valid_addr(manager, 8) then state.loot_items = {}; state.loot_boxes = {}; return end
    local array = read_uint(manager + OFF.lootArray, 8)
    local count = read_uint(manager + OFF.lootCount, 4)
    state.loot_mgr_total = count
    if not is_valid_addr(array, 8) or count < 1 or count > 256 then state.loot_items = {}; state.loot_boxes = {}; return end
    local ptr_raw = batch_read_chunked(pid, 8, (function()
        local addrs = {}
        for i = 0, count - 1 do addrs[#addrs + 1] = array + i * 8 end
        return addrs
    end)())
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
        if #header_raw >= off + 8 and #item_count_raw >= (i - 1) * 4 + 4 then
            local header = uint_from(header_raw, off + 1, 8)
            local item_count = uint_from(item_count_raw, (i - 1) * 4 + 1, 4)
            if item_count > 0 and item_count <= 256 and is_valid_addr(header, 8) then
                for item_index = 0, item_count - 1 do
                    local entry = header + OFF.lootFirstEntry + item_index * OFF.lootItemStride
                    local rarity_addr = entry + OFF.lootItemRarity
                    if is_valid_addr(rarity_addr, 1) then
                        rarity_addrs[#rarity_addrs + 1] = rarity_addr
                        rarity_owner[#rarity_addrs] = {
                            index = i,
                            display_addr = entry + OFF.lootItemDisplay,
                            defn_addr = entry + OFF.lootItemDefn,
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
        if owner.rarity == 0 or owner.rarity == 6 then
            named_owners[#named_owners + 1] = owner
            display_addrs[#display_addrs + 1] = owner.display_addr
            defn_addrs[#defn_addrs + 1] = owner.defn_addr
        end
    end
    local display_raw = #display_addrs > 0 and batch_read_chunked(pid, 8, display_addrs) or {}
    local defn_raw = #defn_addrs > 0 and batch_read_chunked(pid, 8, defn_addrs) or {}
    local loot_labels = {}
    for i, owner in ipairs(named_owners) do
        local off = (i - 1) * 8
        local display = #display_raw >= off + 8 and uint_from(display_raw, off + 1, 8) or 0
        local defn = #defn_raw >= off + 8 and uint_from(defn_raw, off + 1, 8) or 0
        local name = is_valid_addr(display, OFF.lootItemObjName + 32)
            and state.read_loot_text_slot(display + OFF.lootItemObjName) or ""
        local internal_id = is_valid_addr(defn, OFF.lootItemDefnId + 32)
            and state.read_loot_text_slot(defn + OFF.lootItemDefnId) or ""
        if owner.rarity == 0 then
            loot_labels[owner] = state.classify_r0_loot(name, internal_id)
        elseif state.is_bounty_loot(name, internal_id) then
            loot_labels[owner] = "Bounty"
        end
    end
    local item_groups = {}
    for ri, owner in ipairs(rarity_owner) do
        local rarity = rarity_raw[ri]
        if rarity ~= nil then
            local groups = item_groups[owner.index]
            if not groups then groups = {}; item_groups[owner.index] = groups end
            local label = loot_labels[owner]
            if rarity == 0 and not label then label = "R0 Item" end
            local display_rarity = label == "Bounty" and 2 or rarity
            local group_key = label or ("R" .. tostring(rarity))
            local group = groups[group_key]
            if not group then
                group = { rarity = rarity, display_rarity = display_rarity, label = label, count = 0 }
                groups[group_key] = group
            end
            group.count = group.count + 1
        end
    end
    local items = {}
    local boxes = {}
    for i, loot in ipairs(loot_ptrs) do
        local poff = (i - 1) * 12
        if #pos_raw >= poff + 12 then
            local pos = {
                from_f32(uint_from(pos_raw, poff + 1, 4)),
                from_f32(uint_from(pos_raw, poff + 5, 4)),
                from_f32(uint_from(pos_raw, poff + 9, 4)),
            }
            local dist = vec_dist(state.local_pos, pos)
            if is_finite(dist) and dist <= (tonumber(state.loot_max_dist) or 150) then
                local groups = item_groups[i]
                if groups then
                    local keys = {}
                    for key, group in pairs(groups) do
                        if group.count > 0 and state.loot_filter_enabled(group.display_rarity or group.rarity) then
                            keys[#keys + 1] = key
                        end
                    end
                    table.sort(keys)
                    for row, key in ipairs(keys) do
                        local group = groups[key]
                        items[#items + 1] = {
                            pos = pos, dist = dist, item_count = group.count, rarity = group.display_rarity or group.rarity,
                            label = group.label, row = row,
                        }
                    end
                end
                if not groups then
                    boxes[#boxes + 1] = { pos = pos, dist = dist }
                end
            end
        end
    end
    local stacks = {}
    for _, item in ipairs(items) do
        local stack
        for _, candidate in ipairs(stacks) do
            if vec_dist(candidate.pos, item.pos) <= 0.35 then
                stack = candidate
                break
            end
        end
        if not stack then
            stack = { pos = item.pos, items = {} }
            stacks[#stacks + 1] = stack
        end
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
            return tostring(a.label or "") < tostring(b.label or "")
        end)
        for row, item in ipairs(stack.items) do
            item.row = row
            item.display_pos = stack.pos
        end
    end
    state.loot_boxes = boxes
    state.loot_items = items
end

function OnUpdate_impl(dt)
    _frame_id = _frame_id + 1
    state._frame_counter = _frame_id
    state.show_info_overlay = state.show_ui
    state.config_save_timer = (state.config_save_timer or 0) + (dt or 0)
    if state.config_save_timer >= 5.0 then
        state.config_save_timer = 0
        save_config_now()
    end
    if state.walk_skip > 0 then state.walk_skip = state.walk_skip - 1 end
    if state.toggle_cooldown > 0 then state.toggle_cooldown = state.toggle_cooldown - 1 end
    process_hotkeys()
    if not state.master_enabled then
        for _, key in ipairs(MASTER_KEYS) do state[key] = false end
        if state.time_mode ~= "normal" then
            state.time_mode = "normal"
            if state.pid ~= 0 and state.base ~= 0 then pcall(apply_time, "normal") end
        end
    end
    update_connection_state(dt)
    if state.pid ~= 0 and state.base ~= 0 then
        if state.master_enabled and (state.esp_enabled or state.silent_enabled or state.esp_loot) then
            local pid, base = state.pid, state.base
            local ok, err = pcall(function()
                local vm = read_bytes_table(base + RVA.viewmatrix + OFF.viewProj, 64)
                if #vm == 64 then state.viewproj = parse_f32_array(vm, 16) end
                state.wr_timer = state.wr_timer + 1
                if state.wr_timer >= 5 then
                    state.wr_timer = 0
                    if memory and memory.get_window_rect then state.window_rect = memory.get_window_rect(pid) end
                end
                local po_ptr = safe_walk(pid, base, { RVA.rlclient, OFF.pClient, OFF.pObject })
                if po_ptr == 0 then
                    state.loot_items = {}
                    if state._was_attached then invalidate_on_transition(pid) end
                    state._was_attached = false; state.entities = {}; return
                end
                local lp = get_localplayer()
                if lp == 0 then
                    if state._was_attached then invalidate_on_transition(pid) end
                    state._was_attached = false; state.entities = {}; return
                end
                local lp_pos = read_bytes_table(lp + OFF.entityPos, 12)
                if #lp_pos == 12 then state.local_pos = parse_f32_array(lp_pos, 3) end
                if not state.esp_loot then
                    state.loot_items = {}
                    state.loot_scan_was_enabled = false
                else
                    local scan_due = not state.loot_scan_was_enabled
                        or (_frame_id - (state.loot_scan_last_frame or 0) >= 15)
                    state.loot_scan_was_enabled = true
                    if scan_due then
                        state.loot_scan_last_frame = _frame_id
                        local loot_ok, loot_err = pcall(state.scan_loot, pid, po_ptr)
                        if not loot_ok then
                            state.loot_items = {}
                            state.loot_scan_error = tostring(loot_err)
                        else
                            state.loot_scan_error = nil
                        end
                    end
                end
                local lp_faction_raw = read_bytes_table(lp + OFF.factionCtx, 8)
                local local_faction = #lp_faction_raw == 8 and uint_from(lp_faction_raw, 1, 8) or 0
                if state.faction_tag_pid ~= pid then
                    state.faction_tag_cache = {}
                    state.faction_tag_pid = pid
                end
                local scan_ctx = {
                    local_player = lp,
                    local_faction = local_faction,
                    tag_cache = state.faction_tag_cache,
                }
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
                if #ptrs > 200 then
                    local trimmed = {}
                    for i = 1, 200 do trimmed[i] = ptrs[i] end
                    ptrs = trimmed
                end
                local transition = false
                if arr_ptr ~= 0 and prev_arr ~= 0 and arr_ptr ~= prev_arr then transition = true end
                if prev_count > 0 and count == 0 then transition = true end
                if not transition and state._last_ptrs and #ptrs >= MIN_OVERLAP_CHECK_COUNT and #state._last_ptrs >= MIN_OVERLAP_CHECK_COUNT then
                    local seen, ov = {}, 0
                    for _, v in ipairs(state._last_ptrs) do seen[v] = true end
                    for _, v in ipairs(ptrs) do if seen[v] then ov = ov + 1 end end
                    local denom = math.min(#ptrs, #state._last_ptrs)
                    if ov < denom * 0.25 then transition = true end
                end
                if transition then invalidate_on_transition(pid) end
                state._last_arr_ptr = arr_ptr
                state._last_count = count
                state._last_ptrs = ptrs
                state._was_attached = true
                if arr_ptr ~= 0 and arr_ptr == prev_arr and count == prev_count and count > 0 then
                    state._stable_frames = (state._stable_frames or 0) + 1
                else
                    state._stable_frames = 0
                end
                if state._transition_frames and state._transition_frames > 0 then
                    state._transition_frames = state._transition_frames - 1
                end
                state.scan_info = string.format("po=0x%X arr=0x%X cnt=%d", po_ptr, arr_ptr, count)
                if arr_ptr == 0 or count == 0 or #ptrs == 0 then
                    state.entities = {}; return
                end
                local probe_ok = false
                for pi = 1, math.min(#ptrs, 16) do
                    local probe = read_bytes_table(ptrs[pi] + OFF.entityType, 8)
                    if #probe >= 4 then
                        local printable = 0
                        for i = 1, 8 do
                            local b = probe[i]
                            if b and b >= 0x20 and b < 0x7F then printable = printable + 1 end
                        end
                        if printable >= 4 then probe_ok = true; break end
                    end
                end
                if not probe_ok then state.entities = {}; return end
                local pos_addrs, type_addrs, name_addrs, rel_addrs, down_addrs, fac_addrs, ty_addrs = {}, {}, {}, {}, {}, {}, {}
                for _, ep in ipairs(ptrs) do
                    pos_addrs[#pos_addrs + 1] = ep + OFF.entityPos
                    type_addrs[#type_addrs + 1] = ep + OFF.entityType
                    name_addrs[#name_addrs + 1] = ep + OFF.entityName
                    rel_addrs[#rel_addrs + 1] = ep + OFF.relation
                    down_addrs[#down_addrs + 1] = ep + OFF.isDowned
                    fac_addrs[#fac_addrs + 1] = ep + OFF.factionCtx
                    ty_addrs[#ty_addrs + 1] = ep + OFF.entityTypeInt
                end
                local raw = batch_read_chunked(pid, 12, pos_addrs)
                local type_raw = batch_read_chunked(pid, 16, type_addrs)
                local name_raw = batch_read_chunked(pid, 16, name_addrs)
                local rel_raw = batch_read_chunked(pid, 8, rel_addrs)
                local down_raw = batch_read_chunked(pid, 4, down_addrs)
                local fac_raw = batch_read_chunked(pid, 8, fac_addrs)
                local ty_raw = batch_read_chunked(pid, 4, ty_addrs)
                local hp_addrs = {}
                for _, ep in ipairs(ptrs) do hp_addrs[#hp_addrs + 1] = ep + OFF.hpPtr end
                local hp_raw = batch_read_chunked(pid, 8, hp_addrs)
                local hp_valid_index, hp_data_addrs, hp_slot_count = {}, {}, 0
                for i = 1, #ptrs do
                    local off = (i - 1) * 8
                    if #hp_raw >= off + 8 then
                        local hp = uint_from(hp_raw, off + 1, 8)
                        if hp ~= 0 then
                            hp_slot_count = hp_slot_count + 1
                            hp_valid_index[i] = hp_slot_count
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
                                local toff, chars, ok = (idx - 1) * 16, {}, true
                                for j = 1, 16 do
                                    local b = tag_raw[toff + j]
                                    if b == 0 then break end
                                    if b < 0x20 or b >= 0x7F then ok = false; break end
                                    chars[#chars + 1] = string.char(b)
                                end
                                state.faction_tag_cache[f] = ok and table.concat(chars) or ""
                            end
                        end
                    end
                end
                local function type_str_at(idx)
                    if not type_raw then return "" end
                    local toff = (idx - 1) * 16
                    if #type_raw < toff + 4 then return "" end
                    local chars = {}
                    for j = 0, 15 do
                        local b = type_raw[toff + j + 1]
                        if b == nil or b == 0 then break end
                        if b >= 0x20 and b < 0x7F then chars[#chars + 1] = string.char(b) else break end
                    end
                    return table.concat(chars)
                end
                local armor_slot_by_entity, armor_addrs, armor_slot_count = {}, {}, 0
                for i = 1, #ptrs do
                    local hp_off = (i - 1) * 8
                    if #hp_raw >= hp_off + 8 then
                        local hp_ptr = uint_from(hp_raw, hp_off + 1, 8)
                        if is_valid_addr(hp_ptr, 4) then
                            armor_slot_count = armor_slot_count + 1
                            armor_slot_by_entity[i] = armor_slot_count
                            local is_player = type_str_at(i) == "soldier"
                            local armor_off = is_player and OFF.agentarmor or OFF.npcArmor
                            local max_off = is_player and OFF.agentarmorMax or OFF.npcArmorMax
                            armor_addrs[#armor_addrs + 1] = hp_ptr + armor_off
                            armor_addrs[#armor_addrs + 1] = hp_ptr + max_off
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
                                local dist = vec_dist(state.local_pos, pos)
                                local ent_name = ""
                                if name_raw then
                                    local noff = (i - 1) * 16
                                    if #name_raw >= noff + 16 then
                                        local chars = {}
                                        for j = 0, 15 do
                                            local b = name_raw[noff + j + 1]
                                            if b == 0 then break end
                                            if b >= 0x20 and b < 0x7F then chars[#chars + 1] = string.char(b) end
                                        end
                                        ent_name = table.concat(chars)
                                    end
                                end
                                if dist < state.esp_max_dist then
                                    local is_downed = false
                                    if down_raw then
                                        local doff = (i - 1) * 4
                                        if #down_raw >= doff + 4 then
                                            is_downed = (uint_from(down_raw, doff + 1, 4) ~= 0)
                                        end
                                    end
                                    if not is_downed then
                                        local type_str = type_str_at(i)
                                        local is_player = (type_str == "soldier")
                                        local archetype, tier, tier_valid = nil, NPC_THREAT_TIER.NonThreat, false
                                        local entity_type_val = is_player and ENTITY_TYPE_PLAYER or ENTITY_TYPE_NPC
                                        local entity_type_int = 0
                                        if ty_raw then
                                            local tyoff = (i - 1) * 4
                                            if #ty_raw >= tyoff + 4 then
                                                entity_type_int = uint_from(ty_raw, tyoff + 1, 4)
                                                if entity_type_int >= 0x80000000 then entity_type_int = entity_type_int - 0x100000000 end
                                            end
                                        end
                                        if not is_player then
                                            local a_raw, t_raw = read_npc_archetype_and_tier(ptrs[i])
                                            if a_raw ~= nil then archetype = a_raw end
                                            if t_raw ~= nil then tier, tier_valid = t_raw, true end
                                        end
                                        local relation, relation_raw, rel_verdict, faction = "unknown", 0, nil, 0
                                        if rel_raw then
                                            local roff = (i - 1) * 8
                                            if #rel_raw >= roff + 8 then
                                                relation_raw = uint_from(rel_raw, roff + 1, 8)
                                                -- Compute the relation-bytes verdict for players too; it is the authoritative hostile/friendly signal.
                                                if match_relation(rel_raw, roff, RELATION_HOSTILE) then rel_verdict = "hostile"
                                                elseif match_relation(rel_raw, roff, RELATION_FRIENDLY) then rel_verdict = "friendly"
                                                elseif match_relation(rel_raw, roff, RELATION_NEUTRAL) then rel_verdict = "neutral" end
                                            end
                                        end
                                        if fac_raw then
                                            local foff = (i - 1) * 8
                                            if #fac_raw >= foff + 8 then faction = uint_from(fac_raw, foff + 1, 8) end
                                        end
                                        local faction_tag = state.faction_tag_cache[faction] or ""
                                        local hp_val, hp_max = 0, 0
                                        local vi = hp_valid_index[i]
                                        if vi and hp_data_raw then
                                            local doff = (vi - 1) * 8
                                            if #hp_data_raw >= doff + 8 then
                                                hp_val = uint_from(hp_data_raw, doff + 1, 4)
                                                hp_max = uint_from(hp_data_raw, doff + 5, 4)
                                            end
                                        end
                                        local armor_val, armor_max_val, armor_overflow = 0, 0, 0
                                        local armor_slot = armor_slot_by_entity[i]
                                        if armor_slot and armor_raw then
                                            local aoff = (armor_slot - 1) * 8
                                            if #armor_raw >= aoff + 8 then
                                                armor_val = uint_from(armor_raw, aoff + 1, 4)
                                                armor_max_val = uint_from(armor_raw, aoff + 5, 4)
                                            end
                                        end
                                        local is_low_hp = hp_max > 0 and (hp_val / hp_max) < 0.1
                                        local classified = classify_entity({
                                            is_player = is_player, faction = faction, faction_tag = faction_tag,
                                            archetype = archetype, tier = tier, tier_valid = tier_valid,
                                            entity_ptr = ptrs[i], entity_type_int = entity_type_int, rel_verdict = rel_verdict,
                                        }, scan_ctx)
                                        if classified == "unknown" and archetype ~= nil and archetype ~= NPC_ARCHETYPE.Unset then
                                            classified = "hostile"
                                        end
                                        relation = is_player and ((classified == "hostile") and "hostile" or "player") or classified
                                        local summon_kind = nil
                                        if not is_player and archetype ~= nil then
                                            if ARCHETYPE_IS_DRONE[archetype] then summon_kind = "drone"
                                            elseif ARCHETYPE_IS_DOG[archetype] then summon_kind = "dog"
                                            elseif archetype == NPC_ARCHETYPE.MiniTank then summon_kind = "tank"
                                            elseif ARCHETYPE_IS_TURRET[archetype] then summon_kind = "turret"
                                            elseif ARCHETYPE_IS_GADGET[archetype] then summon_kind = "gadget" end
                                        end
                                        local prev = state._prev_pos_by_ptr and state._prev_pos_by_ptr[ptrs[i]] or nil
                                        local pred_pos = { pos[1], pos[2], pos[3] }
                                        if prev then
                                            pred_pos[1] = pos[1] + (pos[1] - prev[1]) * ESP_PREDICT_STRENGTH
                                            pred_pos[2] = pos[2] + (pos[2] - prev[2]) * ESP_PREDICT_STRENGTH
                                            pred_pos[3] = pos[3] + (pos[3] - prev[3]) * ESP_PREDICT_STRENGTH
                                        end
                                        ents[#ents + 1] = {
                                            pos = pos, pred_pos = pred_pos, dist = dist, entity_ptr = ptrs[i],
                                            is_local_player = (ptrs[i] == scan_ctx.local_player),
                                            ent_type = is_player and "player" or "npc", entity_type = entity_type_val,
                                            entity_type_int = entity_type_int, is_player = is_player,
                                            is_summoned = (summon_kind ~= nil), summon_kind = summon_kind,
                                            ent_name = ent_name, type_str = type_str, relation = relation,
                                            relation_raw = relation_raw, faction = faction, faction_tag = faction_tag,
                                            is_downed = is_downed, hp = hp_val, hp_max = hp_max, is_low_hp = is_low_hp,
                                            armor = armor_val, armor_max = armor_max_val, armor_overflow = armor_overflow,
                                            archetype = archetype, archetype_name = (archetype ~= nil) and ARCHETYPE_NAME_BY_ID[archetype] or nil,
                                            tier = tier, tier_valid = tier_valid,
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
                        if should_show(e) or state.silent_enabled then bone_ents[#bone_ents + 1] = e end
                    end
                    local bone_data = read_bones(pid, bone_ents, state.esp_bone_ids)
                    local bi = 1
                    for _, e in ipairs(ents) do
                        if should_show(e) or state.silent_enabled then
                            e.bones = bone_data[bi]; bi = bi + 1
                        end
                    end
                end
                local prev_map = {}
                for _, e in ipairs(ents) do prev_map[e.entity_ptr] = e.pos end
                state._prev_pos_by_ptr = prev_map
                state.entities = ents
            end)
            if not ok then state.status = "Scan: " .. tostring(err) end
            silent_tick(pid, base)
            state.telem_valid, state.telem_world_aim, state.telem_lock_target, state.telem_delta = false, nil, nil, nil
            state.telem_rounds, state.telem_lock_addr = 0, nil
            pcall(function()
                local lp = get_localplayer()
                if lp == 0 then return end
                local aimp = read_uint(lp + OFF.aimCtrl, 8)
                if aimp == 0 then return end
                state.telem_lock_addr = state.silent_lock_addr
                state.telem_rounds = read_uint(aimp + OFF.combatAimRoundsFired, 4)
                state.telem_world_aim = read_world_aim(aimp)
                if state.silent_armed and state.silent_lock_addr then
                    state.telem_lock_target = state.diag_last_write
                end
                if state.telem_world_aim and state.telem_lock_target then
                    local p, wd = state.telem_world_aim, state.telem_lock_target
                    local dx, dy, dz = p[1] - wd[1], p[2] - wd[2], p[3] - wd[3]
                    state.telem_delta = math.sqrt(dx * dx + dy * dy + dz * dz)
                end
                state.telem_valid = true
            end)
            local wr = state.window_rect
            if not wr or #wr == 0 then wr = { { x = 0, y = 0, width = 1920, height = 1080 } } end
            local w, m = wr[1], state.viewproj
            if m and #m >= 16 and w and w.width and w.width > 0 then
                local cx, cy = w.x + w.width / 2, w.y + w.height
                if state.silent_enabled and state.esp_show_silent_fov and not state.silent_360 then
                    local cross_x, cross_y = w.x + w.width / 2, w.y + w.height / 2
                    local cr, cg, cb = 255, 200, 0
                    if state.silent_armed then cr, cg, cb = 0, 255, 100 end
                    draw_fov_circle(cross_x, cross_y, state.silent_fov, cr, cg, cb, 140)
                end
                draw_crosshair(w)
                draw_entity_counter(w)
                if state.esp_enabled then
                    for _, e in ipairs(state.entities) do
                        pcall(function()
                            if e.is_local_player or (e.entity_ptr and e.entity_ptr == get_localplayer()) then return end
                            if should_show(e) then
                                local pname = profile_name_for(e)
                                local draw_pos = (pname == "DRONE") and e.pos or e.pred_pos or e.pos
                                if state.boneless_override and is_boneless_profile(pname) then
                                    local stable_name, legacy_name = nonskeleton_target_name(e)
                                    draw_pos = apply_nonskeleton_world_offset(
                                        draw_pos, get_nonskeleton_offset(stable_name, legacy_name), m)
                                end
                                local sx, sy = world_to_screen(draw_pos, m, w)
                                if sx and sy then
                                    if state.silent_armed and state.silent_target_ptr == e.entity_ptr then
                                        local tp = aim_point_for(e)
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
                                    local box_h, box_w, box_cy = compute_box(e, m, w, sy, draw_pos)
                                    if state.esp_snaplines then
                                        local snap_y = is_summon_box and sy or box_cy
                                        draw.line(cx, cy, sx, snap_y, 100, 100, 255, 120, 1.0)
                                    end
                                    if draw_box then
                                        draw.rect(sx - box_w / 2, box_cy - box_h / 2, box_w, box_h, cr[1], cr[2], cr[3], 180, 1.0)
                                        if e.hp_max > 0 and e.hp > 0 then
                                            local ratio = math.min(e.hp / e.hp_max, 1.0)
                                            local bar_x, bar_top = sx - box_w / 2 - 4, box_cy - box_h / 2
                                            local green_h = box_h * ratio
                                            local red_h = box_h - green_h
                                            if red_h > 0 then draw.filled_rect(bar_x, bar_top, 3, red_h, 200, 0, 0, 200) end
                                            if green_h > 0 then draw.filled_rect(bar_x, bar_top + red_h, 3, green_h, 0, 200, 0, 200) end
                                        end
                                        if e.armor_max > 0 and e.armor > 0 then
                                            local bar_x, bar_top = sx + box_w / 2 + 1, box_cy - box_h / 2
                                            local armor_ratio = math.max(0, math.min(e.armor / e.armor_max, 1.0))
                                            local armor_h = box_h * armor_ratio
                                            draw.filled_rect(bar_x, bar_top, 3, box_h, 25, 35, 45, 190)
                                            if armor_h > 0 then
                                                draw.filled_rect(bar_x, bar_top + box_h - armor_h, 3, armor_h, 70, 190, 255, 230)
                                            end
                                        end
                                    end
                                    if state.esp_bones and e.bones and prof then
                                        local cr1, cr2, cr3 = cr[1], cr[2], cr[3]
                                        if prof.connections then
                                            for _, seg in ipairs(prof.connections) do
                                                local p1, p2 = e.bones[seg[1]], e.bones[seg[2]]
                                                if p1 and p2 then
                                                    local x1, y1 = world_to_screen(p1, m, w)
                                                    local x2, y2 = world_to_screen(p2, m, w)
                                                    if x1 and x2 then draw.line(x1, y1, x2, y2, cr1, cr2, cr3, 200, 1.5) end
                                                end
                                            end
                                        end
                                    end
                                    if state.esp_bone_ids and state.esp_bones and e.bones then
                                        for bid, bp in pairs(e.bones) do
                                            local bx, by = world_to_screen(bp, m, w)
                                            if bx and by then
                                                draw.text(bx + 1, by + 1, tostring(bid), 0, 0, 0, 200, 10)
                                                draw.text(bx, by, tostring(bid), 255, 255, 0, 250, 10)
                                            end
                                        end
                                    end
                                    if state.esp_distance then
                                        local txt = string.format("%.0fm", e.dist)
                                        draw.text(sx - #txt * 3, box_cy + box_h / 2 + 2, txt, 120, 180, 120, 200, 10)
                                    end
                                    if state.esp_name and e.ent_name and e.ent_name ~= "" then
                                        draw.text(sx - #e.ent_name * 3, box_cy - box_h / 2 - 12, e.ent_name, 255, 255, 255, 220, 10)
                                    end
                                    if state.esp_type and e.ent_type then
                                        local tlabel = e.ent_type
                                        if e.archetype_name then tlabel = tlabel .. ":" .. e.archetype_name end
                                        local yoff = state.esp_name and -24 or -12
                                        draw.text(sx - #tlabel * 3, box_cy - box_h / 2 + yoff, tlabel, cr[1], cr[2], cr[3], 200, 10)
                                    end
                                    if state.esp_show_relation and e.relation_raw then
                                        local rtxt = string.format("0x%X", e.relation_raw)
                                        local yoff = -12
                                        if state.esp_name then yoff = yoff - 12 end
                                        if state.esp_type then yoff = yoff - 12 end
                                        draw.text(sx - #rtxt * 3, box_cy - box_h / 2 + yoff, rtxt, 200, 200, 200, 180, 10)
                                    end
                                    if state.esp_show_faction and e.faction then
                                        local ftxt = faction_display(e.faction, e.faction_tag)
                                        local yoff = -12
                                        if state.esp_name then yoff = yoff - 12 end
                                        if state.esp_type then yoff = yoff - 12 end
                                        if state.esp_show_relation then yoff = yoff - 12 end
                                        draw.text(sx - #ftxt * 3, box_cy - box_h / 2 + yoff, ftxt, 180, 180, 255, 180, 10)
                                    end
                                end
                            end
                        end)
                    end
                end
                if state.esp_loot then
                    for _, item in ipairs(state.loot_items or {}) do
                        pcall(function()
                            local lx, ly = world_to_screen(item.display_pos or item.pos, m, w)
                            if lx and ly then
                                local info = state.loot_rarity[item.rarity]
                                local label = item.label or (info and info[1]) or "Other Loot"
                                local rr, gg, bb = info and info[2] or 220, info and info[3] or 220, info and info[4] or 220
                                if item.label == "Bounty" then
                                    local flash = math.floor(_frame_id / 20) % 2 == 0
                                    if flash then rr, gg, bb = 245, 245, 245
                                    else rr, gg, bb = 115, 115, 115 end
                                elseif item.rarity == 7 then
                                    local flash = math.floor(_frame_id / 20) % 2 == 0
                                    if flash then rr, gg, bb = 245, 245, 245
                                    else rr, gg, bb = 65, 145, 255 end
                                end
                                label = string.format("%s x%d  %.0fm", label, item.item_count or 0, item.dist)
                                if (item.row or 1) == 1 then draw_circle_filled(lx, ly, 4, rr, gg, bb, 220) end
                                local text_size = tonumber(state.loot_text_size) or 10
                                if not is_finite(text_size) then text_size = 10 end
                                text_size = math.max(6, math.min(16, math.floor(text_size + 0.5)))
                                local row_spacing = math.max(11, text_size + 1)
                                draw.text(lx + 7,
                                    ly - 7 + ((item.row or 1) - 1) * row_spacing,
                                    label, rr, gg, bb, 240, text_size)
                            end
                        end)
                    end
                    if state.loot_show_boxes then
                        for _, box in ipairs(state.loot_boxes or {}) do
                            pcall(function()
                                local bx, by = world_to_screen(box.pos, m, w)
                                if bx and by then
                                    draw_circle_filled(bx, by, 4, 255, 255, 0, 220)
                                    local bsize = math.max(6, math.min(16, math.floor((tonumber(state.loot_text_size) or 10) + 0.5)))
                                    draw.text(bx + 7, by - 7, string.format("Loot Box  %.0fm", box.dist), 255, 255, 0, 240, bsize)
                                end
                            end)
                        end
                    end
                end
            end
        end
        if state.master_enabled then process_hacks_and_stats(dt) end
    end
    draw_overlays(dt)
end

-- Lifecycle wrappers never throw: errors are caught, reported in state.status, and retried next frame.
function OnStart()
    state.pid, state.base = 0, 0
    state.entities, state.loot_items = {}, {}
    state.master_snapshot = nil
    state.silent_lock_addr = nil
    state.recoil_locked, state.spread_rva_locked, state.spread_aim_addrs = false, false, nil
    state._key_prev = state._key_prev or {}
    if state.loot_show_r5 == nil then state.loot_show_r5 = true end
    if state.time_mode == nil then state.time_mode = "normal" end
    if state.aim_part == nil then state.aim_part = "head" end
    local ok, err = pcall(OnStart_impl)
    if not ok then state.status = "Init: " .. tostring(err) end
    -- Launch-safe: never start with memory writes enabled. F1 restores saved toggles.
    if state.master_enabled then pcall(set_master, false) end
    state.status = "Launch-safe: Master OFF - press F1 after main menu to enable"
end

function OnUpdate(dt)
    local ok, err = pcall(OnUpdate_impl, dt)
    if not ok then state.status = "Update: " .. tostring(err) end
end

function OnDestroy()
    local ok, err = pcall(OnDestroy_impl)
    if not ok then
        if memory and memory.unlock_all and state.pid and state.pid ~= 0 then pcall(memory.unlock_all, state.pid) end
    end
end