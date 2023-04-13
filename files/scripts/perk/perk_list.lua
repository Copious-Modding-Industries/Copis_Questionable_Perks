local to_insert =
{
    --  Revenge intermission
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
    --  Monster Wands
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
        end,
        func_remove = function(entity_who_picked)
            GameRemoveFlagRun("copis_qstnbl_perks_monster_wands")
        end,
    },
    --  Limb Lengthening 
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
            GameRemoveFlagRun("copis_qstnbl_perks_monster_wands")
        end,
    },
}

for i = 1, #to_insert do
    to_insert[i].author = "Copi"
    to_insert[i].mod = "Copi's Questionable Perks"
    perk_list[#perk_list + 1] = to_insert[i]
end
