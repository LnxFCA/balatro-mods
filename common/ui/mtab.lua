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


--- Create mod about tab
function LNXFCA.UIDEF.create_about_tab(info)
    local lnxfca_common = localize('lnxfca_common')

    info.developed_by = info.developed_by or lnxfca_common.developed_by_fmt:format(table.concat(info.author, ','))

    ---@type UIDef
    return {
        n = G.UIT.ROOT, config = { align = "cm", minw = 8, colour = G.C.BLACK, r = 0.1, padding = 0.2, },
        nodes = {{
            n = G.UIT.C, config = { align = "cl", minw = 8, },
            nodes = {
                {  -- Title
                    n = G.UIT.R, config = { align = "cm", padding = 0.1, minw = 8 },
                    nodes = {
                        { n = G.UIT.T, config = { text = info.title, colour = G.C.UI.TEXT_LIGHT, scale = 0.55, }},
                        LNXFCA.UIDEF.create_coloured_text(("[v%s]"):format(info.version), { colour = HEX("5684c4"), })
                    },
                },
                {  -- Devloper
                    n = G.UIT.R, config = { align = "cm", padding = 0.05, minw = 8 },
                    nodes = {{ n = G.UIT.T, config = { text = info.developed_by, scale = 0.35, colour = HEX("bedfed") }}},
                },

                LNXFCA.UIDEF.create_spacing_box({ padding = 0.1, }),

                {  -- Description
                    n = G.UIT.R, config = { align = "cl", padding = 0.1, },
                    nodes = LNXFCA.UIDEF.create_multiline_text(info.description, { align = "cl", scale = 0.4, colour = HEX("b0babf"), }),
                },
                LNXFCA.UIDEF.create_spacing_box({ padding = 0.1, }),
                { -- Usage
                    n = G.UIT.R, config = { align = "cl", padding = 0.1, },
                    nodes = {
                        LNXFCA.UIDEF.create_spacing_box({ col = G.UIT.C, w = 0.3, }),
                        { n = G.UIT.T, config = { text = lnxfca_common.usage_h_text, scale = 0.45, colour = G.C.UI.TEXT_LIGHT, }},
                    },
                },
                {
                    n = G.UIT.R, config = { align = "cm", padding = 0.2, },
                    nodes = {{ n = G.UIT.C, config = { align = "cm", }, nodes = LNXFCA.UIDEF.create_open_button_grid(2, info.documentation) }},
                },
                {  -- External links
                    n = G.UIT.R, config = { align = "cl", padding = 0.1, },
                    nodes = {
                        LNXFCA.UIDEF.create_spacing_box({ col = G.UIT.C, w = 0.3, }),
                        { n = G.UIT.T, config = { text = lnxfca_common.links_h_text, scale = 0.45, colour = G.C.UI.TEXT_LIGHT, }},
                    },
                },
                {
                    n = G.UIT.R, config = { align = "cm", padding = 0.2, },
                    nodes = {{ n = G.UIT.C, config = { align = "cm", }, nodes = LNXFCA.UIDEF.create_open_button_grid(3, info.links, 0.5)}}
                },
                {  -- Updates
                    n = G.UIT.R, config = { align = "cm", padding = 0.1, },
                    nodes = {{ n = G.UIT.C, config = { align = "cm", }, nodes = {
                        LNXFCA.UIDEF.create_open_button({
                            label = lnxfca_common.update_fmt, link = info.updates, padding = 0.2,
                            bg_colour = G.C.UI.TRANSPARENT_DARK, fg_colour = HEX("5684c4"),
                        }),
                    }}},
                },
                {  -- Copyright
                    n = G.UIT.R, config = { align = "cl", padding = 0.1, },
                    nodes = {LNXFCA.UIDEF.create_coloured_text(
                        info.copyright or lnxfca_common.copyright_fmt:format(os.date('%Y'), info.author[1]),
                        { col = G.UIT.C, padding = 0.1, align = "cm", scale = 0.35, colour = HEX("8a9da1") }
                    )},
                },
            },
        }},
    }
end
