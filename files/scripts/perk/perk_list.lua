local to_insert =
{
    -- Revenge intermission
    {
        id = "COPIS_QSTNBL_PERKS_REVENGE_INTERMISSION",
        author = "Copi",
        ui_name = "$perk_name_copis_qstnbl_perks_revenge_intermission",
        ui_description = "$perk_desc_copis_qstnbl_perks_revenge_intermission",
        ui_icon = "mods/copis_questionable_perks/files/ui_gfx/perk_icons/revenge_intermission.png",
        perk_icon = "mods/copis_questionable_perks/files/items_gfx/perks/revenge_intermission.png",
        stackable = true,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local vscs = EntityGetComponent(entity_who_picked, "VariableStorageComponent", "perk_component") or {}
            local vsc = nil
            for i = 1, #vscs do
                if ComponentGetValue2(vscs[i], "name") == "revenge_intermission" then
                    vsc = vscs[i]
                    break
                end
            end
            if vsc then
                ComponentSetValue2(vsc, "value_int", ComponentGetValue2(vsc, "value_int") + 1.0)
            else
                EntityAddComponent2(entity_who_picked, "LuaComponent", {
                    _tags = "perk_component",
                    script_damage_received =
                    "mods/copis_questionable_perks/files/scripts/perk/damage_received/revenge_intermission.lua"
                })
                EntityAddComponent2(entity_who_picked, "VariableStorageComponent", {
                    _tags = "perk_component",
                    name = "revenge_intermission",
                    value_int = 1.0
                })
            end
        end,
    },
    -- Monster Wands
    {
        id = "COPIS_QSTNBL_PERKS_MONSTER_WANDS",
        author = "Copi",
        ui_name = "$perk_name_copis_qstnbl_perks_monster_wands",
        ui_description = "$perk_desc_copis_qstnbl_perks_monster_wands",
        ui_icon = "mods/copis_questionable_perks/files/ui_gfx/perk_icons/monster_wands.png",
        perk_icon = "mods/copis_questionable_perks/files/items_gfx/perks/monster_wands.png",
        stackable = false,
        func = function(entity_perk_item, entity_who_picked, item_name)
            GameAddFlagRun("copis_qstnbl_perks_monster_wands")
            local enemies = EntityGetWithTag("enemy")
            for i = 1, #enemies do
                local victim = enemies[i]
                local picker = EntityGetFirstComponentIncludingDisabled(victim, "ItemPickUpperComponent")
                if picker ~= nil then
                    local has_wand = false
                    local invs = EntityGetAllChildren(victim) or {}
                    for j = 1, #invs do
                        if EntityGetName(invs[j]) == "inventory_quick" then
                            local items = EntityGetAllChildren(invs[j]) or {}
                            for k = 1, #items do
                                if EntityHasTag(items[k], "wand") then
                                    has_wand = true
                                    break
                                end
                            end
                            break
                        end
                    end

                    if not has_wand then
                        local x, y = EntityGetTransform(victim)
                        local file = table.concat {
                            "data/scripts/streaming_integration/entities/wand_level_0",
                            tostring(math.random(1, 3)),
                            ".xml"
                        }
                        local wand = EntityLoad(file, x, y)
                        GamePickUpInventoryItem(victim, wand, false)
                        -- Set 50% drop chance
                        local drop = false
                        if math.random(0, 1) == 1 then
                            drop = true
                        end
                        ComponentSetValue2(picker, "drop_items_on_death", drop)
                    end
                end
            end
        end,
        func_remove = function(entity_who_picked)
            GameRemoveFlagRun("copis_qstnbl_perks_monster_wands")
            local enemies = EntityGetWithTag("enemy")
            for i = 1, #enemies do
            local victim = enemies[i]
                local picker = EntityGetFirstComponentIncludingDisabled(victim, "ItemPickUpperComponent")
                if picker ~= nil then
                    local has_wand = false
                    local invs = EntityGetAllChildren(victim) or {}
                    for j = 1, #invs do
                        if EntityGetName(invs[j]) == "inventory_quick" then
                            local items = EntityGetAllChildren(invs[j]) or {}
                            for k = 1, #items do
                                if EntityHasTag(items[k], "wand") then
                                    EntityKill(items[k])
                                    break
                                end
                            end
                            break
                        end
                    end
                end
            end
        end,
    },
    --[[
    -- Limb Lengthening
    {
        id = "COPIS_QSTNBL_PERKS_LIMB_LENGTHENING",
        author = "Copi",
        ui_name = "$perk_name_copis_qstnbl_perks_limb_lengthening",
        ui_description = "$perk_desc_copis_qstnbl_perks_limb_lengthening",
        ui_icon = "mods/copis_questionable_perks/files/ui_gfx/perk_icons/limb_lengthening.png",
        perk_icon = "mods/copis_questionable_perks/files/items_gfx/perks/limb_lengthening.png",
        stackable = false,
        func = function(entity_perk_item, entity_who_picked, item_name)
            -- Make player taller, slow down player, add script to randomly hurt them when they move
        end,
        func_remove = function(entity_who_picked)

        end,
    },]]
    -- Perk
    {
        id = "COPIS_QSTNBL_PERKS_BLANK",
        author = "Copi",
        ui_name = "$perk_name_copis_qstnbl_perks_blank",
        ui_description = "$perk_desc_copis_qstnbl_perks_blank",
        ui_icon = "mods/copis_questionable_perks/files/ui_gfx/perk_icons/blank.png",
        perk_icon = "mods/copis_questionable_perks/files/items_gfx/perks/blank.png",
        stackable = false,
        func = function(entity_perk_item, entity_who_picked, item_name)
            -- Do nothing lol
        end
    },
    --[[
    -- Revenge Supernova
    {
        id = "COPIS_QSTNBL_PERKS_REVENGE_SUPERNOVA",
        author = "Copi",
        ui_name = "$perk_name_copis_qstnbl_perks_revenge_supernova",
        ui_description = "$perk_desc_copis_qstnbl_perks_revenge_supernova",
        ui_icon = "mods/copis_questionable_perks/files/ui_gfx/perk_icons/supernova.png",
        perk_icon = "mods/copis_questionable_perks/files/items_gfx/perks/supernova.png",
        stackable = false,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            EntityAddComponent2(entity_who_picked, "LuaComponent", {
                _tags = "perk_component",
                script_damage_received =
                "mods/copis_questionable_perks/files/scripts/perk/damage_received/supernova.lua"
            })
        end,
    },]]
    --[[
    -- LOIC
    {
        id = "COPIS_QSTNBL_PERKS_REVENGE_SUPERNOVA",
        author = "Copi",
        ui_name = "$perk_name_copis_qstnbl_perks_revenge_supernova",
        ui_description = "$perk_desc_copis_qstnbl_perks_revenge_supernova",
        ui_icon = "mods/copis_questionable_perks/files/ui_gfx/perk_icons/supernova.png",
        perk_icon = "mods/copis_questionable_perks/files/items_gfx/perks/supernova.png",
        stackable = false,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            EntityAddComponent2(entity_who_picked, "LuaComponent", {
                _tags = "perk_component",
                script_damage_received =
                "mods/copis_questionable_perks/files/scripts/perk/damage_received/supernova.lua"
            })
        end,
    },]]
    --[[
    -- Slippery
    {
        id = "COPIS_QSTNBL_PERKS_REVENGE_SUPERNOVA",
        author = "Copi",
        ui_name = "$perk_name_copis_qstnbl_perks_revenge_supernova",
        ui_description = "$perk_desc_copis_qstnbl_perks_revenge_supernova",
        ui_icon = "mods/copis_questionable_perks/files/ui_gfx/perk_icons/supernova.png",
        perk_icon = "mods/copis_questionable_perks/files/items_gfx/perks/supernova.png",
        stackable = false,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            EntityAddComponent2(entity_who_picked, "LuaComponent", {
                _tags = "perk_component",
                script_damage_received =
                "mods/copis_questionable_perks/files/scripts/perk/damage_received/supernova.lua"
            })
        end,
    },]]
    -- Tinkle With Wands Everywhere
    {
        id = "COPIS_QSTNBL_PERKS_PISS_WAND",
        author = "Copi",
        ui_name = "$perk_name_copis_qstnbl_perks_piss_wand",
        ui_description = "$perk_desc_copis_qstnbl_perks_piss_wand",
        ui_icon = "mods/copis_questionable_perks/files/ui_gfx/perk_icons/piss_wand.png",
        perk_icon = "mods/copis_questionable_perks/files/items_gfx/perks/piss_wand.png",
        stackable = false,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            -- Every 30s, piss a little, if holding a wand.
            EntityAddComponent2(entity_who_picked, "LuaComponent", {
                _tags = "perk_component",
                script_source_file =
                "mods/copis_questionable_perks/files/scripts/perk/piss_wand.lua",
                execute_every_n_frame = 1800,
            })
        end,
    },
        -- Monster Wands
        {
            id = "COPIS_QSTNBL_PERKS_ITEM_REPEL",
            author = "Copi",
            ui_name = "$perk_name_copis_qstnbl_perks_item_repel",
            ui_description = "$perk_desc_copis_qstnbl_perks_item_repel",
            ui_icon = "mods/copis_questionable_perks/files/ui_gfx/perk_icons/item_repel.png",
            perk_icon = "mods/copis_questionable_perks/files/items_gfx/perks/item_repel.png",
            stackable = false,
            func = function(entity_perk_item, entity_who_picked, item_name)
                EntityAddComponent2(entity_who_picked, "LuaComponent", {
                    _tags = "perk_component",
                    script_source_file =
                    "mods/copis_questionable_perks/files/scripts/perk/item_repel.lua",
                    execute_every_n_frames = 1
                })
            end,
        },
}

for i = 1, #to_insert do
    to_insert[i].author = "Copi"
    to_insert[i].mod = "Copi's Questionable Perks"
    perk_list[#perk_list + 1] = to_insert[i]
end
