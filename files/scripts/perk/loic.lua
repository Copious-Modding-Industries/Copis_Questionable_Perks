


dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/lib/coroutines.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local hittables = EntityGetInRadiusWithTag(pos_x, pos_y, 128, "hittable") or {}
if #hittables > 0 then
    local target = hittables[math.random(1, #hittables)]
	local t_x, t_y = EntityGetTransform( target )

    GameCreateSpriteForXFrames("mods/copis_questionable_perks/files/particles/loic.png", t_x, t_y, true, 0, 0, 180)
	GameEntityPlaySound( entity_id, "beam_from_sky_start" )
	wait( 60 )

    for i = 1, 3 do
        GameScreenshake( i * 10 )
        wait( 20 )
    end


	GameScreenshake( 40 )
	wait( 20 )
	GameScreenshake( 60 )
	wait( 20 )
	GameScreenshake( 100 )
	wait( 20 )

	GameCutThroughWorldVertical( t_x, -2147483647, t_y, 40, 40 )
	EntitySetComponentsWithTagEnabled( entity_id, "enabled_in_world", true )
	GamePlaySound( "data/audio/Desktop/misc.bank", "misc/beam_from_sky_hit", t_x, t_y )
	GameScreenshake( 200 )
    EntityLoad( "mods/copis_questionable_perks/entities/particles/loic.xml", t_x, t_y-5 )

    local pec = EntityGetFirstComponent( entity_id, "ParticleEmitterComponent")
    if pec then
        ComponentSetValue2(pec, "count_min", 21000)
        ComponentSetValue2(pec, "count_max", 21000)
        ComponentSetValue2(pec, "cosmetic_force_create", true)
    end
end