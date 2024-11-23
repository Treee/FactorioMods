-- script.on_event(defines.events.on_player_changed_position,
--   function(event)
--     local player = game.get_player(event.player_index) -- get the player that moved
--     -- if they're currently controlling the character
--     if player.controller_type == defines.controllers.character then
--       -- and wearing our armor
--       if player.get_inventory(defines.inventory.character_armor).get_item_count("fire-armor") >= 1 then
--         -- create the fire where they're standing
--         player.surface.create_entity{name="fire-flame", position=player.position, force="neutral"}
--       end
--     end
--   end
-- )


-- defines.input_action.set_signal
-- defines.prototypes['virtual-signal']['virtual-signal']




script.on_event(defines.input_action.wire_dragging, function(event)
	local entity = event.entity
	game.print(string.format("ID: %d Name: %s", entity.unit_number, entity.prototype.name))
	if entity and entity.unit_number and entity.prototype.name == "iat-ss-production-combinator" then
		local player = game.players[1]
		player.create_local_flying_text {
			text = { event },
			position = { 1, 0.5 },
			color = nil,
			time_to_live = 90,
			speed = 1.0,
		}
	end
end)

script.on_event(defines.input_action.set_signal, function(event)
	local entity = event.entity
	game.print(string.format("ID: %d Name: %s", entity.unit_number, entity.prototype.name))
	if entity and entity.unit_number and entity.prototype.name == "iat-ss-production-combinator" then
		local player = game.players[1]
		player.create_local_flying_text {
			text = { event },
			position = { 1, 0.5 },
			color = nil,
			time_to_live = 90,
			speed = 1.0,
		}
	end
end)

script.on_event(defines.input_action.switch_constant_combinator_state, function(event)
	local entity = event.entity
	game.print(string.format("ID: %d Name: %s", entity.unit_number, entity.prototype.name))
	if entity and entity.unit_number and entity.prototype.name == "iat-ss-production-combinator" then
		local player = game.players[1]
		player.create_local_flying_text {
			text = { event },
			position = { 1, 0.5 },
			color = nil,
			time_to_live = 90,
			speed = 1.0,
		}
	end
end)
-- defines.input_action.wire_dragging
