dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
SetRandomSeed(pos_x, pos_y)
if Random() > 0.1 then return end
local hittables = EntityGetInRadiusWithTag(pos_x, pos_y, 128, "mortal") or {}
if #hittables > 0 then
	local target = hittables[math.random(1, #hittables)]
	local t_x, t_y = EntityGetTransform( target )
	EntityLoad( "mods/copis_questionable_perks/files/entities/loic.xml", t_x+math.random(-3,3), t_y+math.random(2,8) )
end