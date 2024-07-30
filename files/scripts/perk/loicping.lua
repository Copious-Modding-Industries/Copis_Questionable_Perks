dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local hittables = EntityGetInRadiusWithTag(pos_x, pos_y, 128, "mortal") or {}
for i=1, #hittables do
	local t_x, t_y = EntityGetTransform( hittables[i] )
	for k=1, 20 do
		GameCreateSpriteForXFrames("mods/copis_questionable_perks/files/particles/loic_ping.png", t_x, t_y, true, 0, 0, k)
		GameCreateSpriteForXFrames("mods/copis_questionable_perks/files/particles/loic_ping.png", t_x, t_y, true, 0, 0, k)
	end
end