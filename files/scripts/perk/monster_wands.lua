if GameHasFlagRun("copis_qstnbl_perks_monster_wands") then
    local victim = GetUpdatedEntityID()
    local picker = EntityGetFirstComponentIncludingDisabled( victim, "ItemPickUpperComponent" )
    if picker ~= nil then
        local x, y = EntityGetTransform( victim )
        local file = table.concat{
            "data/scripts/streaming_integration/entities/wand_level_0",
            tostring(math.random( 1, 3 )),
            ".xml"
        }
        local wand = EntityLoad( file, x, y )
        GamePickUpInventoryItem(victim, wand, false)

        -- Set 50% drop chance
        local drop = false
        if math.random(0, 1) == 1 then
            drop = true
        end
        ComponentSetValue2(picker, "drop_items_on_death", drop)
    end
end
