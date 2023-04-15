--[[
function OnModPreInit() end
function OnModInit() end
function OnModPostInit() end
function OnPlayerSpawned(player_entity) end
function OnPlayerDied(player_entity) end
function OnWorldInitialized() end
function OnWorldPreUpdate() end
function OnWorldPostUpdate() end
function OnBiomeConfigLoaded() end
function OnMagicNumbersAndWorldSeedInitialized() end
function OnPausedChanged(is_paused, is_inventory_pause) end
function OnModSettingsChanged() end
function OnPausePreUpdate() end
]]

-- Translations
local translations = ModTextFileGetContent("data/translations/common.csv");
if translations ~= nil then
    while translations:find("\r\n\r\n") do
        translations = translations:gsub("\r\n\r\n", "\r\n");
    end
    local files = { "perks" }
    for i=1, #files do
        local new_translations = ModTextFileGetContent(table.concat({ "mods/copis_questionable_perks/files/translations/", files[i], ".csv" }));
        translations = translations .. new_translations;
    end
    ModTextFileSetContent("data/translations/common.csv", translations);
end

-- Add perks
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/copis_questionable_perks/files/scripts/perk/perk_list.lua")


--- ### Adds a component to an entity file.
--- ***
--- @param file_path string The path to the file you wish to add a component to.
--- @param comp string The component you wish to add.
function ModEntityFileAddComponent(file_path, comp)
    local file_contents = ModTextFileGetContent(file_path)
    local contents = file_contents:gsub("</Entity>$", function() return comp .. "</Entity>" end)
    ModTextFileSetContent(file_path, contents)
end


-- Humanoid crap
ModEntityFileAddComponent(
    "data/entities/base_humanoid.xml",
[[
<LuaComponent
    execute_on_added="1"
    remove_after_executed="1"
    script_source_file="mods/copis_questionable_perks/files/scripts/perk/monster_wands.lua"
/>
]]
)

-- Fake Icon crap, thanks conga!!!
ModEntityFileAddComponent(
    "data/entities/items/pickup/perk.xml",
[[
<LuaComponent
    execute_every_n_frame="1"
    remove_after_executed="1"
    script_source_file="mods/copis_questionable_perks/files/scripts/piss_wand_initer.lua"
/>
]]
)
