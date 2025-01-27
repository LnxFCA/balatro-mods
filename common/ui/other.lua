function LNXFCA.UIDEF.create_spacing_box(args)
    ---@type UIDef
    return {
        n = args.col or G.UIT.R, config = { padding = args.padding or 0, colour = args.colour },
        nodes = {{ n = G.UIT.B, config = { h = args.h or 0.1, w = args.w or 0.1, }}}
    }
end


function LNXFCA.UIDEF.create_open_button(args)
    if not G.FUNCS.lnxfca_open_button then
        -- Define the button handling function
        G.FUNCS.lnxfca_open_button = function (e)
            if e.config.callback then e.config.callback(e) end

            -- ref_value holds the link to open
            LNXFCA.utils.open_link(e.config.ref_value)
        end
    end

    ---@type UIDef
    return {
        n = args.col or G.UIT.C,
        config = {
            align = "cm", padding = args.padding or 0.1, r = args.r or 0.1, minw = args.minw,
            minh = args.minw, colour = args.bg_colour or G.C.BLACK, callback = args.callback,
            ref_value = args.link, hover = true, shadow = true, button = 'lnxfca_open_button',
        },
        nodes = {{ n = G.UIT.T, config = { text = args.label, scale = args.scale or 0.4, colour = args.fg_colour or G.C.UI.TEXT_LIGHT, }}},
    }
end


function LNXFCA.UIDEF.create_open_button_grid(rows, args, spacing)
    local buttons = {} -- UIDef[]
    local parent = { n = G.UIT.R, config = { align = "cm", padding = 0.1, }, nodes  = {}}
    for i, link in ipairs(args) do
        if i % (rows + 1) == 0 then  -- Check for rows
            -- Store parent and create a new container
            table.insert(buttons, parent)
            parent = { n = G.UIT.R, config = { align = "cm", padding = 0.1, }, nodes = {}}
        end

        local button = LNXFCA.UIDEF.create_open_button({
            label = link.label, link = link.link, padding = 0.25, bg_colour = link.bg_colour or G.C.UI.TRANSPARENT_DARK,
            fg_colour = link.fg_colour,
        })

        -- Insert button into the grid
        table.insert(parent.nodes, button)

        -- Add button spacing
        if i % rows ~= 0 and #args > i and spacing then
            table.insert(parent.nodes, LNXFCA.UIDEF.create_spacing_box({ col = G.UIT.C, w = spacing }))
        end
    end
    table.insert(buttons, parent)

    return buttons
end
