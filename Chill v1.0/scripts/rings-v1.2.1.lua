--[[
Ring Meters by londonali1010 (2009), modified with vertical bar graph and text functionality. You can add vertical bars by writing them in the settings table

This script draws percentage meters as rings, vertical bars, or text. It is fully customizable.

To call this script in Conky, use the following:
	lua_load ~/scripts/rings-bars.lua
	lua_draw_hook_pre ring_stats
]]

settings_table = {
    -- Ring example (CPU)
    {
        type = 'ring', -- Type of meter (ring or bar)
        name = 'cpu',
        arg = 'cpu0',
        max = 100,
        bg_colour = 0x4C363E,
        bg_alpha = 1,
        fg_colour = 0xf2e8bb,
        fg_alpha = 1,
        x = 46, y = 218.3,
        radius = 10,
        thickness = 9,
        start_angle = 0,
        end_angle = 360
    },
        {
        type = 'ring', -- Type of meter (ring or bar)
        name = 'memperc',
        arg = '/',
        max = 100,
        bg_colour = 0x4C363E,
        bg_alpha = 1,
        fg_colour = 0xf2e8bb,
        fg_alpha = 1,
        x = 99, y = 218.3,
        radius = 10,
        thickness = 9,
        start_angle = 0,
        end_angle = 360
    },
     {
        type = 'ring', -- Type of meter (ring or bar)
        name = 'fs_used_perc',
        arg = '/',
        max = 100,
        bg_colour = 0x4C363E,
        bg_alpha = 1,
        fg_colour = 0xf2e8bb,
        fg_alpha = 1,
        x = 152, y = 218.3,
        radius = 10,
        thickness = 9,
        start_angle = 0,
        end_angle = 360
    },
    -- Ring example (Memory Percentage)
    {
        type = 'ring',
        name = 'fs_used_perc',
        arg = '/home',
        max = 100,
        bg_colour = 0x4C363E,
        bg_alpha = 1,
        fg_colour = 0xf2e8bb,
        fg_alpha = 1,
        x = 205, y = 218.3,
        radius = 10,
        thickness = 9,
        start_angle = 0,
        end_angle = 360
    },
            {
        type = 'text', -- Type is 'text'
        text = 'CPU', -- Dynamic text using Conky variables
        x = 32.25, y = 175, -- Position of the text
        font = 'Bungee', -- Font
        font_size = 15, -- Font size
        fg_colour = 0x4C363E, -- Text color
        fg_alpha = 1, -- Text opacity
    },
    {
        type = 'text', -- Type is 'text'
        text = '${cpu cpu0}%', -- Dynamic text using Conky variables
        x = 32.25, y = 189, -- Position of the text
        font = 'Bungee', -- Font
        font_size = 15, -- Font size
        fg_colour = 0xE99403, -- Text color
        fg_alpha = 1, -- Text opacity
    },
--        {
--       type = 'text', -- Type is 'text'
--        text = '${hwmon 1 temp 1}°C',
--       x = 61, y = 235, -- Position of the text
--       font = 'Bungee', -- Font
--        font_size = 15, -- Font size
--       fg_colour = 0xf2e8bb, -- Text color
--       fg_alpha = 1, -- Text opacity
--   },
   
                {
        type = 'text', -- Type is 'text'
        text = 'RAM', -- Dynamic text using Conky variables
        x = 85.25, y = 175, -- Position of the text
        font = 'Bungee', -- Font
        font_size = 15, -- Font size
        fg_colour = 0x4C363E, -- Text color
        fg_alpha = 1, -- Text opacity
    },
                    {
        type = 'text', -- Type is 'text'
        text = '${memperc}%', 
        x = 85.25, y = 189, -- Position of the text
        font = 'Bungee', -- Font
        font_size = 15, -- Font size
        fg_colour = 0xE99403, -- Text color
        fg_alpha = 1, -- Text opacity
    },
                        {
--        type = 'text', -- Type is 'text'
 --       text = '(${memperc}%)', -- Dynamic text using Conky variables
--        x = 138.25, y = 235, -- Position of the text
 --       font = 'Bungee', -- Font
 ------       font_size = 15, -- Font size
  --      fg_colour = 0xf2e8bb, -- Text color
  --      fg_alpha = 1, -- Text opacity
    },
    {
        type = 'text', -- Type is 'text'
        text = 'SSD1', -- Dynamic text using Conky variables
        x = 138.25, y = 175, -- Position of the text
        font = 'Bungee', -- Font
        font_size = 15, -- Font size
        fg_colour = 0x4C363E, -- Text color
        fg_alpha = 1, -- Text opacity
    },
        {
        type = 'text', -- Type is 'text'
        text = '${fs_used_perc /}%', -- Dynamic text using Conky variables
        x = 138.25, y = 189, -- Position of the text
        font = 'Bungee', -- Font
        font_size = 15, -- Font size
        fg_colour = 0xE99403, -- Text color
        fg_alpha = 1, -- Text opacity
    },
            {
        type = 'text', -- Type is 'text'
        text = '${fs_used_perc /home}%', -- Dynamic text using Conky variables
        x = 191.25, y = 189, -- Position of the text
        font = 'Bungee', -- Font
        font_size = 15, -- Font size
        fg_colour = 0xE99403, -- Text color
        fg_alpha = 1, -- Text opacity
    },
        {
        type = 'text', -- Type is 'text'
        text = 'SSD2', -- Dynamic text using Conky variables
        x = 191.25, y = 175, -- Position of the text
        font = 'Bungee', -- Font
        font_size = 15, -- Font size
        fg_colour = 0x4C363E, -- Text color
        fg_alpha = 1, -- Text opacity
    },
}

require 'cairo'

-- Convert RGB to RGBA
function rgb_to_r_g_b(colour, alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

-- Function to draw a ring meter
function draw_ring(cr, t, pt)
    local xc, yc, ring_r, ring_w, sa, ea = pt['x'], pt['y'], pt['radius'], pt['thickness'], pt['start_angle'], pt['end_angle']
    local bgc, bga, fgc, fga = pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

    local angle_0 = sa * (2 * math.pi / 360) - math.pi / 2
    local angle_f = ea * (2 * math.pi / 360) - math.pi / 2
    local t_arc = t * (angle_f - angle_0)

    -- Draw background ring
    cairo_arc(cr, xc, yc, ring_r, angle_0, angle_f)
    cairo_set_source_rgba(cr, rgb_to_r_g_b(bgc, bga))
    cairo_set_line_width(cr, ring_w)
    cairo_stroke(cr)

    -- Draw indicator ring
    cairo_arc(cr, xc, yc, ring_r, angle_0, angle_0 + t_arc)
    cairo_set_source_rgba(cr, rgb_to_r_g_b(fgc, fga))
    cairo_stroke(cr)
end

-- Function to display text
function draw_text(cr, pt, text)
    local x, y = pt['x'], pt['y']
    local font = pt['font'] or "Sans"
    local font_size = pt['font_size'] or 12
    local fg_colour = pt['fg_colour']
    local fg_alpha = pt['fg_alpha']
    

    -- Set font and size
    cairo_select_font_face(cr, font, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL)
    cairo_set_font_size(cr, font_size)

  -- Set the color for the text explicitly
    cairo_set_source_rgba(cr, rgb_to_r_g_b(fg_colour, fg_alpha))
    
    -- Save the current transformation matrix
    cairo_save(cr)

    -- Move to position and rotate the text
    cairo_translate(cr, x, y)  -- Translate to the text position

    -- Draw the text at the new position
    cairo_move_to(cr, 0, 0)  -- After rotation, the origin will be at (0, 0)
    cairo_show_text(cr, text)

    -- Restore the original transformation matrix
    cairo_restore(cr)

    -- Stroke the text to apply the changes
    cairo_stroke(cr)
end

-- Function to draw a vertical bar
-- Function to draw a horizontal bar
function draw_bar(cr, t, pt)
    local x, y, bar_w, bar_h = pt['x'], pt['y'], pt['bar_width'], pt['bar_height']
    local bgc, bga, fgc, fga = pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

    -- Draw background bar
    cairo_set_source_rgba(cr, rgb_to_r_g_b(bgc, bga))
    cairo_rectangle(cr, x, y, bar_w, bar_h)
    cairo_fill(cr)

    -- Draw filled bar (the indicator)
    local filled_w = bar_w * t
    cairo_set_source_rgba(cr, rgb_to_r_g_b(fgc, fga))
    cairo_rectangle(cr, x, y, filled_w, bar_h)
    cairo_fill(cr)
end

-- Main function to draw rings, bars, or text
function conky_ring_stats()
    local function setup_rings_bars(cr, pt)
        local str = ''
        local value = 0
        
        if pt['type'] == 'ring' or pt['type'] == 'bar' then
            str = string.format('${%s %s}', pt['name'], pt['arg'])
            str = conky_parse(str)
            value = tonumber(str)
            if value == nil then value = 0 end
            local pct = value / pt['max']

            if pt['type'] == 'ring' then
                draw_ring(cr, pct, pt)
            elseif pt['type'] == 'bar' then
                draw_bar(cr, pct, pt)
            end
        elseif pt['type'] == 'text' then
            str = conky_parse(pt['text'])
            draw_text(cr, pt, str)
        end
    end

    if conky_window == nil then return end
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    local cr = cairo_create(cs)

    local updates = conky_parse('${updates}')
    update_num = tonumber(updates)

    if update_num > 5 then
        for i in pairs(settings_table) do
            setup_rings_bars(cr, settings_table[i])
        end
    end
    cairo_surface_destroy(cs)
    cairo_destroy(cr)
end

