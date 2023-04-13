if GameHasFlagRun("copis_qstnbl_perks_monster_wands") then
    local victim = GetUpdatedEntityID()
    local x, y = EntityGetTransform( victim )
    local file = table.concat{
        "data/scripts/streaming_integration/entities/wand_level_0",
        tostring(math.random( 1, 3 )),
        ".xml"
    }
    local wand = EntityLoad( file, x, y )
    GamePickUpInventoryItem(victim, wand, false)

    -- Set 50% drop chance
end
