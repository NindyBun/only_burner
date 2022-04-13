for _, list in pairs(data.raw) do
    for key, entity in pairs(list) do
        if entity.type == "inserter" then
            entity.energy_per_movement = settings.startup["burner-inserter-conversion-multiplier"].value * util.parse_energy(entity.energy_per_movement) .. "J"
            entity.energy_per_rotation = settings.startup["burner-inserter-conversion-multiplier"].value * util.parse_energy(entity.energy_per_rotation) .. "J"
            entity.energy_source.type = "burner"
            entity.energy_source.fuel_inventory_size = 1
            entity.allow_burner_leech = settings.startup["burner-leech"].value
            if entity.name == "inserter" then
                data.raw["recipe"]["inserter"].ingredients = {{"electronic-circuit", 1}, {"burner-inserter", 1}}
            end
        elseif entity.type == "lamp" or entity.type == "decider-combinator" or entity.type == "arithmetic-combinator" then
            entity.energy_source.type = "void"
        elseif 
            entity.energy_usage and 
            entity.energy_source and 
            entity.energy_source.type and 
            entity.energy_source.type == "electric" and
            entity.type ~= "electric-energy-interface" and            
            entity.type ~= "roboport" and
            entity.type ~= "beacon" then
                if not entity.energy_source.emissions_per_minute then
                    entity.energy_source.emissions_per_minute = 0
                end
                if entity.name == "electric-mining-drill" then
                    data.raw["recipe"]["electric-mining-drill"].ingredients = {{"electronic-circuit", 3}, {"burner-mining-drill", 2}}
                end
                entity.name = entity.name.gsub("Electric", "Upgraded Burner")
                entity.energy_source.emissions_per_minute = entity.energy_source.emissions_per_minute * settings.startup["burner-conversion-pollution-factor"].value            
                entity.energy_usage = settings.startup["burner-non-inserter-conversion-multiplier"].value * util.parse_energy(entity.energy_usage) .. "J"
                entity.energy_source.type = "burner"
                entity.energy_source.fuel_inventory_size = 1
                entity.energy_source.light_flicker =
                    {
                        color = {0,0,0},
                        minimum_intensity = 0.6,
                        maximum_intensity = 0.95
                    }
                entity.energy_source.smoke =
                    {
                        {
                            name = "smoke",
                            frequency = 10,
                            position = {0.7, -1.2},
                            starting_vertical_speed = 0.08,
                            starting_frame_deviation = 60
                        }
                    }
        end
    end
end