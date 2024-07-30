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
        stackable = true,
        func = function(entity_perk_item, entity_who_picked, item_name)

            local surgery = {
                bones_fucked_up = tonumber(GlobalsGetValue("cqp_leg_surgery")),
                hitbox_min = tonumber(GlobalsGetValue("cqp_hitbox_min_x")),
                hitbox_max = tonumber(GlobalsGetValue("cqp_hitbox_max_x")),
            }

            -- Make player taller, slow down player, add script to randomly hurt them when they move
            local hitboxcomp = EntityGetFirstComponent(entity_who_picked, "HitboxComponent")
            local chardatcomp = EntityGetFirstComponent(entity_who_picked, "CharacterDataComponent")




            if hitboxcomp and chardatcomp then
                -- Save original heights
                if not GameHasFlagRun("copis_questionable_perks_original_scale") then
                    GlobalsSetValue("cqp_hitbox_min_x", tostring(ComponentGetValue(hitboxcomp, "aabb_min_y")))
                    GlobalsSetValue("cqp_hitbox_max_x", tostring(ComponentGetValue(hitboxcomp, "aabb_max_y")))
                    GameAddFlagRun("copis_questionable_perks_original_scale")
                end
            end


            if enemy_values.has_character_data == "true" then
                local character_data_component = EntityGetFirstComponentIncludingDisabled(enemy_id, "CharacterDataComponent")
                ComponentSetValue2(character_data_component, "buoyancy_check_offset_y", enemy_values.buoyancy_check_offset_y * scale)
                ComponentSetValue2(character_data_component, "climb_over_y",  math.max(2, enemy_values.climb_over_y * scale))
                ComponentSetValue2(character_data_component, "check_collision_max_size_x", math.max(3, enemy_values.check_collision_max_size_x * scale))
                ComponentSetValue2(character_data_component, "check_collision_max_size_y", math.max(3, enemy_values.check_collision_max_size_y * scale))
                ComponentSetValue2(character_data_component, "collision_aabb_min_x",  math.min(-0.5, enemy_values.collision_aabb_min_x * scale))
                ComponentSetValue2(character_data_component, "collision_aabb_max_x",  math.max(0.5, enemy_values.collision_aabb_max_x * scale))
                ComponentSetValue2(character_data_component, "collision_aabb_min_y", math.min(-0.5, enemy_values.collision_aabb_min_y * scale))
                ComponentSetValue2(character_data_component, "collision_aabb_max_y", math.max(0.5, enemy_values.collision_aabb_max_y * scale))
            end

            ComponentSetValue2(hitboxcomp, "aabb_min_y", surgery.hitbox_min * surgery.bones_fucked_up)
            ComponentSetValue2(hitboxcomp, "aabb_max_y", surgery.hitbox_min * surgery.bones_fucked_up)








            --character data
            local cdc = EntityGetFirstComponentIncludingDisabled(entity_who_picked, "CharacterDataComponent")
            if cdc then

                if not GameHasFlagRun("copis_questionable_perks_original_scale") then
                    GlobalsSetValue("cqp_hitbox_min_x", tostring(ComponentGetValue(hitboxcomp, "aabb_min_y")))
                    GlobalsSetValue("cqp_hitbox_max_x", tostring(ComponentGetValue(hitboxcomp, "aabb_max_y")))



                    local scaled_buoyancy_check_offset_y = original_values.buoyancy_check_offset_y * scale
                    local scaled_climb_over_y = math.max(2, original_values.climb_over_y * scale)
                    local scaled_check_collision_max_size_x = math.max(3, original_values.check_collision_max_size_x * scale)
                    local scaled_check_collision_max_size_y = math.max(3, original_values.check_collision_max_size_y * scale)
                    local scaled_collision_aabb_min_x = math.min(-0.5, original_values.collision_aabb_min_x * scale)
                    local scaled_collision_aabb_max_x = math.max(0.5, original_values.collision_aabb_max_x * scale)
                    collision_aabb_min_y * scale
                    original_values.collision_aabb_max_y * scale
                    original_values.eff_hg_size_x * scale
                    original_values.eff_hg_size_y * scale
                    original_values.eff_hg_damage_min * scale
                    original_values.eff_hg_damage_max * scale
                    original_values.destroy_ground * scale * 10




















                    GameAddFlagRun("copis_questionable_perks_original_scale")
                end


















                local scaled_buoyancy_check_offset_y = original_values.buoyancy_check_offset_y * scale
                local scaled_climb_over_y = math.max(2, original_values.climb_over_y * scale)
                local scaled_check_collision_max_size_x = math.max(3, original_values.check_collision_max_size_x * scale)
                local scaled_check_collision_max_size_y = math.max(3, original_values.check_collision_max_size_y * scale)
                local scaled_collision_aabb_min_x = math.min(-0.5, original_values.collision_aabb_min_x * scale)
                local scaled_collision_aabb_max_x = math.max(0.5, original_values.collision_aabb_max_x * scale)
                local scaled_collision_aabb_min_y = math.min(-0.5, original_values.collision_aabb_min_y * scale)
                local scaled_collision_aabb_max_y = math.max(0.5, original_values.collision_aabb_max_y * scale)
                local scaled_eff_hg_size_x = original_values.eff_hg_size_x * scale
                local scaled_eff_hg_size_y = original_values.eff_hg_size_y * scale
                local scaled_eff_hg_damage_min = original_values.eff_hg_damage_min * scale
                local scaled_eff_hg_damage_max = original_values.eff_hg_damage_max * scale
                local scaled_destroy_ground = original_values.destroy_ground * scale * 10
                ComponentSetValue2(cdc, "buoyancy_check_offset_y", scaled_buoyancy_check_offset_y)
                ComponentSetValue2(cdc, "climb_over_y", scaled_climb_over_y)
                ComponentSetValue2(cdc, "check_collision_max_size_x", scaled_check_collision_max_size_x)
                ComponentSetValue2(cdc, "check_collision_max_size_y", scaled_check_collision_max_size_y)
                ComponentSetValue2(cdc, "collision_aabb_min_x", scaled_collision_aabb_min_x)
                ComponentSetValue2(cdc, "collision_aabb_max_x", scaled_collision_aabb_max_x)
                ComponentSetValue2(cdc, "collision_aabb_min_y", scaled_collision_aabb_min_y)
                ComponentSetValue2(cdc, "collision_aabb_max_y", scaled_collision_aabb_max_y)
                ComponentSetValue2(cdc, "eff_hg_size_x", scaled_eff_hg_size_x)
                ComponentSetValue2(cdc, "eff_hg_size_y", scaled_eff_hg_size_y)
                ComponentSetValue2(cdc, "eff_hg_damage_min", scaled_eff_hg_damage_min)
                ComponentSetValue2(cdc, "eff_hg_damage_max", scaled_eff_hg_damage_max)
                ComponentSetValue2(cdc, "destroy_ground", scaled_destroy_ground)
            end






















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
    --[[]]
    -- LOIC
    {
        id = "COPIS_QSTNBL_PERKS_LOIC",
        author = "Copi",
        ui_name = "$perk_name_copis_qstnbl_perks_loic",
        ui_description = "$perk_desc_copis_qstnbl_perks_loic",
        ui_icon = "mods/copis_questionable_perks/files/ui_gfx/perk_icons/loic.png",
        perk_icon = "mods/copis_questionable_perks/files/items_gfx/perks/loic.png",
        stackable = false,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            EntityAddComponent2(entity_who_picked, "LuaComponent", {
                _tags = "perk_component",
                execute_every_n_frame = 30,
				script_source_file = "mods/copis_questionable_perks/files/scripts/perk/loicloader.lua"
            })
            EntityAddComponent2(entity_who_picked, "LuaComponent", {
                _tags = "perk_component",
                execute_every_n_frame = 20,
				script_source_file = "mods/copis_questionable_perks/files/scripts/perk/loicping.lua"
            })
        end,
    },
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
    -- Greed Repulsion Field
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
                execute_every_n_frame = 1
            })
        end,
    },
}

for i = 1, #to_insert do
    to_insert[i].author = "Copi"
    to_insert[i].mod = "Copi's Questionable Perks"
    perk_list[#perk_list + 1] = to_insert[i]
end
