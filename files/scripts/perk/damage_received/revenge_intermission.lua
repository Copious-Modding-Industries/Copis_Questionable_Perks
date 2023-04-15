---@diagnostic disable-next-line: lowercase-global
function damage_received(damage, message, entity_thats_responsible, is_fatal)
    local victim = GetUpdatedEntityID()
    local vscs = EntityGetComponent(victim, "VariableStorageComponent", "perk_component") or {}
    local duration = nil
    for i = 1, #vscs do
        if ComponentGetValue2(vscs[i], "name") == "revenge_intermission" then
            duration = ComponentGetValue2(vscs[i], "value_int")
            local damagemodels = EntityGetComponentIncludingDisabled(victim, "DamageModelComponent") or {}
            local max_hp_sum = 0
            for j = 1, #damagemodels do
                max_hp_sum = max_hp_sum + ComponentGetValue2(damagemodels[j], "max_hp")
            end
            max_hp_sum = max_hp_sum / #damagemodels
            if damage >= (max_hp_sum / 16) then
                local t = GameGetRealWorldTimeSinceStarted()
                local quit = false
                while not quit do
                    if GameGetRealWorldTimeSinceStarted() - t > duration then
                        quit = true
                    else
                        local shit = "CONCATS " .. "ARE " .. "FUCKING " .. "SLOW."
                        GlobalsSetValue("fucking_lag", shit)
                    end
                end
            end
            break
        end
    end
end
