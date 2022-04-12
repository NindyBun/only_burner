for _, list in pairs(data.raw) do
    for key, entity in pairs(list) do
        if entity.type == "inserter" and entity.name ~= "burner-inserter" then
            entity.energy_per_movement = settings.startup["burner-inserter-conversion-multiplier"].value * util.parse_energy(entity.energy_per_movement) .. "J"
            entity.energy_per_rotation = settings.startup["burner-inserter-conversion-multiplier"].value * util.parse_energy(entity.energy_per_rotation) .. "J"
            entity.energy_source = {
                type = "burner",
                fuel_inventory_size = 1,
                render_no_power_icon = false
            }
            entity.allow_burner_leech = settings.startup["burner-leech"].value
        end
    end
end