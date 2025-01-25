--- Create a new configuration option box.
---@param content UIDef[]
---@return UIDef
function LNXFCA.UIDEF.config_create_option_box(content)
    return {
        n = G.UIT.R,
        config = {
            align = "cm",
            colour = G.C.L_BLACK,
            r = 0.1,
            padding = 0.1,
        },
        nodes = content
    }
end


--- Create a toggle widget
function LNXFCA.UIDEF.config_create_option_toggle(args)
    local toggle_args = args or {}
    toggle_args.inactive_colour = args.inactive_colour or G.C.WHITE
    toggle_args.active_colour = args.active_colour or G.C.BLUE
    toggle_args.info = type(args.info) == 'string' and { args.info } or args.info

    local toggle = create_toggle(toggle_args)

    -- Create info text rows
    if args.info then
        local info = {}
        for _, v in ipairs(args.info --[=[@as string[]]=]) do
            table.insert(info, { n = G.UIT.R, config = { align = "cm", minh = 0.005, }, nodes = {{
                n = G.UIT.T,
                config = { text = v, scale = 0.3, colour = HEX("b8c7d4"), },
            }}})
        end

        -- Replace info with ours
        if info then
            info = { n = G.UIT.R, config = { align = "cm" }, nodes = info }
            toggle.nodes[2] = info
        end
    end

    return toggle
end

