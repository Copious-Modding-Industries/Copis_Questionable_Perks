


dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/lib/coroutines.lua")

async(function ()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

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

	GameCutThroughWorldVertical( pos_x, -2147483647, pos_y, 40, 40 )
	EntitySetComponentsWithTagEnabled( entity_id, "enabled_in_world", true )
	GamePlaySound( "data/audio/Desktop/misc.bank", "misc/beam_from_sky_hit", pos_x, pos_y )
	GameScreenshake( 200 )
    EntityLoad( "data/entities/particles/poof_green_huge.xml", pos_x, pos_y-5 )

    local pec = EntityGetFirstComponent( entity_id, "ParticleEmitterComponent")
    if pec then
        ComponentSetValue2(pec, "count_min", 21000)
        ComponentSetValue2(pec, "count_max", 21000)
        ComponentSetValue2(pec, "cosmetic_force_create", true)
    end
end)