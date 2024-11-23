-- 5s, 1m, 10m, 1h, 10h, 50h, 250h, 1000h, All
-- Items, Fluids, Buildings, Pollution, Kills

-- First I define three simple functions, one for reading startup settings
-- and one for creating paths to the .png files for each prototype.

-- Everytime I need a "name=" I put a prefix before it, so that
-- Other mods with similar names do not interfere with mine and vice versa.
-- I use "er:" because my name is eradicator, but that's kinda long.
-- The prefix can be any string you like. I use a second prefix "hcg-"
-- because I have more than one mod, and this makes it easier to see what
-- belongs where.

-- This allows me to read settings values without repeating my prefix
-- all the time.
local function config(name)
    return settings.startup['iat-ss-' .. name].value
end

local function branded_name(name)
    return 'iat-ss-' .. name
end

--And these two make defining common file paths much shorter.
local function sprite(name)
    return '__statistics-signals__/graphics/entity/' .. name
end

local function icon(name)
    return '__statistics-signals__/graphics/icon/' .. name
end

-- local function sound(name)
--     return '__statistics-signals__/sounds/' .. name
-- end


local function generate_iat_constant_combinator(combinator, filename)
    combinator.sprites =
        make_4way_animation_from_spritesheet({
            layers =
            {
                {
                    scale = 0.5,
                    filename = filename,
                    width = 114,
                    height = 102,
                    shift = util.by_pixel(0, 5)
                },
                {
                    scale = 0.5,
                    filename = "__base__/graphics/entity/combinator/constant-combinator-shadow.png",
                    width = 98,
                    height = 66,
                    shift = util.by_pixel(8.5, 5.5),
                    draw_as_shadow = true
                }
            }
        })
    combinator.activity_led_sprites =
    {
        north = util.draw_as_glow
            {
                scale = 0.5,
                filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-N.png",
                width = 14,
                height = 12,
                shift = util.by_pixel(9, -11.5)
            },
        east = util.draw_as_glow
            {
                scale = 0.5,
                filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-E.png",
                width = 14,
                height = 14,
                shift = util.by_pixel(7.5, -0.5)
            },
        south = util.draw_as_glow
            {
                scale = 0.5,
                filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-S.png",
                width = 14,
                height = 16,
                shift = util.by_pixel(-9, 2.5)
            },
        west = util.draw_as_glow
            {
                scale = 0.5,
                filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-W.png",
                width = 14,
                height = 16,
                shift = util.by_pixel(-7, -15)
            }
    }
    combinator.circuit_wire_connection_points =
    {
        {
            shadow =
            {
                red = util.by_pixel(7, -6),
                green = util.by_pixel(23, -6)
            },
            wire =
            {
                red = util.by_pixel(-8.5, -17.5),
                green = util.by_pixel(7, -17.5)
            }
        },
        {
            shadow =
            {
                red = util.by_pixel(32, -5),
                green = util.by_pixel(32, 8)
            },
            wire =
            {
                red = util.by_pixel(16, -16.5),
                green = util.by_pixel(16, -3.5)
            }
        },
        {
            shadow =
            {
                red = util.by_pixel(25, 20),
                green = util.by_pixel(9, 20)
            },
            wire =
            {
                red = util.by_pixel(9, 7.5),
                green = util.by_pixel(-6.5, 7.5)
            }
        },
        {
            shadow =
            {
                red = util.by_pixel(1, 11),
                green = util.by_pixel(1, -2)
            },
            wire =
            {
                red = util.by_pixel(-15, -0.5),
                green = util.by_pixel(-15, -13.5)
            }
        }
    }
    return combinator
end

-- defines.input_action.wire_dragging
-- defines.wire_connector_id.circuit_red
-- defines.wire_connector_id.circuit_green
-- defines.wire_connector_id.combinator_input_red
-- defines.wire_connector_id.combinator_input_green
-- defines.wire_connector_id.combinator_output_red
-- defines.wire_connector_id.combinator_output_green
-- change_logistic_point_group
-- delete_logistic_group
-- defines.target_type.logistic_section



-- Vanilla imports
require("__base__.prototypes.entity.combinator-pictures")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

-- Entity
data:extend
{
    generate_iat_constant_combinator
    ({
        type = "constant-combinator",
        name = branded_name 'production-combinator',
        icon = icon 'constant-combinator-prod-5s.png',
        flags = { "placeable-neutral", "player-creation" },
        minable = { mining_time = 0.1, result = branded_name 'production-combinator' },
        max_health = 120,
        corpse = "constant-combinator-remnants",
        dying_explosion = "constant-combinator-explosion",
        collision_box = { { -0.35, -0.35 }, { 0.35, 0.35 } },
        selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
        damaged_trigger_effect = hit_effects.entity(),
        fast_replaceable_group = branded_name 'production-combinator',
        open_sound = sounds.combinator_open,
        close_sound = sounds.combinator_close,
        icon_draw_specification = { scale = 0.7 },
        activity_led_light =
        {
            intensity = 0,
            size = 1,
            color = { r = 1.0, g = 1.0, b = 1.0 }
        },

        activity_led_light_offsets =
        {
            { 0.296875,  -0.40625 },
            { 0.25,      -0.03125 },
            { -0.296875, -0.078125 },
            { -0.21875,  -0.46875 }
        },

        circuit_wire_max_distance = 9
    }, sprite 'combinator/constant-combinator-prod-5s.png')
}


-- Item
data:extend({
    -- This is the item that is used to place the entity on the map.
    {
        type         = 'item',
        name         = branded_name 'production-combinator',

        -- In lua any function that is called with exactly one argument
        -- can be written without () brackets if the argument is a string or table.

        -- here we call icon() which will return the full path
        -- '__statistics-signals__/graphics/icons/constant-combinator-prod-5s.png'

        icon         = icon 'constant-combinator-prod-5s.png',
        icon_size    = 64,
        subgroup     = 'circuit-network',
        order        = 'z',

        -- This is the name of the entity to be placed.
        -- For convenience the item, recipe and entity
        -- often have the same name, but this is not required.
        -- For demonstration purposes I will use explicit
        -- names here.
        place_result = 'iat-ss-production-combinator',
        stack_size   = 50,
    },
})

-- data:extend({
--     {
--         type= "item-subgroup",
--         name = "virtual-signal-iat-production",
--         group = "signals",
--         order = "z_iat[1]"
--     },
--     {
--         type= "item-subgroup",
--         name = "virtual-signal-iat-consumption",
--         group = "signals",
--         order = "z_iat[2]"
--     }
-- })

-- data:extend({
--     {
--         type = "virtual-signal",
--         name = "signal-iat-production",
--         icon = "__statistics-signals__/graphics/icons/signal/signal_production_5s.png",
--         subgroup = "virtual-signal-iat-production",
--         order = "z[production]-[000]"
--     },
--     {
--         type = "virtual-signal",
--         name = "signal-iat-consumption",
--         icon = "__statistics-signals__/graphics/icons/signal/signal_consumption_5s.png",
--         subgroup = "virtual-signal-iat-consumption",
--         order = "z[consumption]-[000]"
--     }
-- })
-- data:extend{signal5s}
