dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/lib/coroutines.lua")

async(function ()
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	GameEntityPlaySound( entity_id, "beam_from_sky_start" )

	for i=13, 1, -1 do
		GameScreenshake( 13-i )
		wait( i*2 )
		for k=1, 50 do
			GameCreateSpriteForXFrames("mods/copis_questionable_perks/files/particles/loic2.png", x, y-5, true, 0, 0, math.floor(((i*2)/50)*k))
		end
	end
	GameCutThroughWorldVertical( x, -2147483647, y, 40, 60 )
	EntitySetComponentsWithTagEnabled( entity_id, "enabled_in_world", true )
	GamePlaySound( "data/audio/Desktop/misc.bank", "misc/beam_from_sky_hit", x, y )
	GameScreenshake( 20 )
	for k=1, 60 do
		GameCreateSpriteForXFrames("mods/copis_questionable_perks/files/particles/loic2.png", x, y-5, true, 0, 0, k)
	end
    EntityLoad( "mods/copis_questionable_perks/files/entities/loic_poof.xml", x, y-5 )

	local pec = EntityGetFirstComponent( entity_id, "ParticleEmitterComponent")
	if pec then
		ComponentSetValue2(pec, "count_min", 21000)
		ComponentSetValue2(pec, "count_max", 21000)
		ComponentSetValue2(pec, "cosmetic_force_create", true)
	end
end)