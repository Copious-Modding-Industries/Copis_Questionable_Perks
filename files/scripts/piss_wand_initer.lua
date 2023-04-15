local perk = GetUpdatedEntityID()
local comp = EntityGetFirstComponent(perk, "SpriteComponent")
if comp then
    if ComponentGetValue2(comp, "image_file") == "mods/copis_questionable_perks/files/items_gfx/perks/piss_wand.png" then
        ComponentSetValue2(comp, "image_file", "mods/copis_questionable_perks/files/items_gfx/perks/piss_wand_fake.png")
    end
end