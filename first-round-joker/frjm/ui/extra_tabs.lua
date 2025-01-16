---@type fun(text: string | string[], args: table | nil): UIDef
FRJM.UI.create_multiline_text = function(text, args)
    local rtext = (type(text) == 'table' and text) or { text }
    args = args or {}

    ---@type UIDef[]
    local lines = {}
    for _, v in ipairs(rtext) do
        table.insert(lines, {
            n = G.UIT.R,
            config = {
                align = args.align or "cm",
                minh = 0.05,
            },
            nodes = {
                {
                    n = G.UIT.T,
                    config = {
                        text = v,
                        colour = args.colour or G.C.TEXT_LIGHT,
                        scale = args.scale or 0.4,
                    },
                },
            },
        })
    end

    return lines
end


FRJM.UI.create_about_tab_ui = function()
    ---@type UIDef
    return {
        n = G.UIT.ROOT,
        config = {
            align = "cm",
            minw = 8.8,
            minh = 6,
            colour = G.C.BLACK,
            r = 0.2,
        },
        nodes = {
            {
                n = G.UIT.C,
                config = {
                    align = "cm",
                    padding = 0.2,
                    r = 0.1,
                },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            padding = 0.2,
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = FRJM.mod.name,
                                    colour = G.C.TEXT_LIGHT,
                                    scale = 0.5,
                                },
                            },
                        },
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                        },
                        nodes = FRJM.UI.create_multiline_text(localize('frj_description'), { align = "cl" })
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                        },
                        nodes = {{
                            n = G.UIT.B,
                            config = { h = 0.2, w = 1 }
                        }},
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = localize('frj_developed_by') .. table.concat(FRJM.mod.author, ', '),
                                    colour = G.C.BLUE,
                                    scale = 0.4,
                                }
                            },
                        },
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                        },
                        nodes = FRJM.UI.create_multiline_text(localize('frj_credits'), { colour = G.C.GREEN }),
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            padding = 0.2,
                        },
                        nodes = FRJM.UI.create_multiline_text(localize('frj_project_page'))
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                        },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = {
                                    align = "cm",
                                    padding = 0.2,
                                    shadow = true,
                                    hover = true,
                                    button = 'frjm_open_project_page',
                                    colour = G.C.WHITE,
                                    r = 0.1,
                                    ref_table = FRJM.project_page,
                                    ref_value = 'github'
                                },
                                nodes = {{
                                    n = G.UIT.T,
                                    config = {
                                        text = "GitHub",
                                        scale = 0.4,
                                        colour = G.C.BLACK,
                                    },
                                }},
                            },
                            {
                                n = G.UIT.C,
                                config = {
                                    align = "cm",
                                },
                                nodes = {{
                                    n = G.UIT.B,
                                    config = { w = 0.2, h = 0.1 },
                                }},
                            },
                            {
                                n = G.UIT.C,
                                config = {
                                    align = "cm",
                                    padding = 0.2,
                                    shadow = true,
                                    hover = true,
                                    button = 'frjm_open_project_page',
                                    colour = G.C.ORANGE,
                                    r = 0.1,
                                    ref_table = FRJM.project_page,
                                    ref_value = 'nexusmods'
                                },
                                nodes = {{
                                    n = G.UIT.T,
                                    config = {
                                        text = "NexusMods",
                                        scale = 0.4,
                                        colour = G.C.TEXT_LIGHT,
                                    },
                                }},
                            },
                        },
                    },
                },
            },
        },
    }
end


FRJM.mod.extra_tabs = function ()
    return {
        {
            label = 'About',
            tab_definition_function = FRJM.UI.create_about_tab_ui,
        }
    }
end
