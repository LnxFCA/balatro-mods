FRJM.mod.config_tab = function ()
    local mconfig = FRJM.mod.config

    ---@type UIDef
    return {
        n = G.UIT.ROOT,
        config = {
            r = 0.1,
            minw = 6,
            align = "cm",
            padding = 0.1,
            colour = G.C.BLACK,
        },
        nodes = {
            {
                n = G.UIT.C,
                config = {
                    align = "cm",
                    r = 0.1,
                    padding = 0.1,
                },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            padding = 0.1,
                            colour = G.C.L_BLACK,
                            r = 0.1,
                        },
                        nodes = {
                            create_toggle({ -- option toggle
                                label = localize('frj_save_joker'),
                                info = localize("frj_save_joker_d"),
                                active_colour = G.C.BLUE,
                                inactive_colour = G.C.WHITE,
                                ref_table = mconfig,
                                ref_value = 'save_joker',
                                callback = function () FRJM:save_config() end
                            }),
                        },
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            padding = 0.1,
                            colour = G.C.L_BLACK,
                            r = 0.1,
                        },
                        nodes = {
                            create_toggle({ -- option toggle
                                label = localize('frj_base_price'),
                                info = localize("frj_base_price_d"),
                                active_colour = G.C.BLUE,
                                inactive_colour = G.C.BLUE,
                                ref_table = mconfig,
                                ref_value = 'base_price',
                                callback = function () FRJM:save_config() end
                            }),
                        },
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            padding = 0.1,
                            colour = G.C.L_BLACK,
                            minh = 1.8,
                            r = 0.1,
                        },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = {
                                    align = "cm",
                                },
                                nodes = {
                                    create_toggle({ -- option toggle
                                        label = localize('frj_use_custom_keybind'),
                                        info = localize("frj_use_custom_keybind_d"),
                                        active_colour = G.C.BLUE,
                                        inactive_colour = G.C.WHITE,
                                        ref_table = mconfig,
                                        ref_value = 'use_custom_keybind',
                                        callback = function () FRJM:save_config() end
                                    }),
                                    {
                                        n = G.UIT.R,
                                        config = {
                                            align = "cm",
                                            padding = 0.2,
                                        },
                                        nodes = {
                                            create_text_input({
                                                colour = G.C.GREEN,
                                                w = 1,
                                                max_length = 1,
                                                all_caps = true,
                                                prompt_text = mconfig.custom_keybind,
                                                ref_table = mconfig,
                                                ref_value = 'custom_keybind',
                                                keyboard_offset = 1,
                                                callback = function () FRJM:save_config() end
                                            }),
                                        },
                                    },
                                },
                            },
                        },
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                        },
                        nodes = {
                            {
                                n = G.UIT.B,
                                config = {
                                    h = 0.05,
                                    w = 0,
                                }
                            }
                        },
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            align = "bm",
                            padding = 0.1,
                        },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = {
                                    align = "cm",
                                    maxw = 3.5,
                                    maxh = 2.5,
                                    colour = G.C.RED,
                                    padding = 0.2,
                                    r = 0.1,
                                    hover = true,
                                    shadow = true,
                                    button = 'frjm_restart_game',
                                },
                                nodes = {
                                    {
                                        n = G.UIT.T,
                                        config = {
                                            text = localize('frj_game_restart_btn'),
                                            colour = G.C.UI.TEXT_LIGHT,
                                            scale = 0.35,
                                        }
                                    },
                                },
                            }
                        },
                    },
                },
            },
        },
    }
end
