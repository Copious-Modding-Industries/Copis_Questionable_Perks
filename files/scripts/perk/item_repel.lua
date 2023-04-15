local function repel(id, x, y)
    local physicscomponents = EntityGetComponent(id, "PhysicsBodyComponent")
    if (physicscomponents ~= nil) then

        local px, py = EntityGetTransform(id)
        local ox = x - px
        local oy = y - py
        local len = (((ox ^ 2) + (oy ^ 2))^0.5)^0.5 * -1
        PhysicsApplyForce(id, (ox / len), (oy / len))

    end
end

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local items = EntityGetInRadiusWithTag(pos_x, pos_y, 128, "item_pickup") or {}
local nuggets = EntityGetInRadiusWithTag(pos_x, pos_y, 128, "gold_nugget") or {}

for i = 1, #nuggets do
    repel(nuggets[i], pos_x, pos_y)
end
for i = 1, #items do
    -- Potion shattering was *too* evil
    if not EntityHasTag(items[i], "potion") then
        repel(items[i], pos_x, pos_y)
    end
end
