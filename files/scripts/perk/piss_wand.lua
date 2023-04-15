local eid = GetUpdatedEntityID()
local px, py = EntityGetTransform(eid)
local controls = EntityGetFirstComponentIncludingDisabled(eid, "ControlsComponent")
if controls then
    local vx, vy = ComponentGetValueVector2(controls, "mAimingVectorNormalized")
    GameCreateParticle("urine", px, py-2, math.random(50, 100), vx * 12, vy * 12, false, true)
end
