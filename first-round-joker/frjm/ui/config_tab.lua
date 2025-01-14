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
                            colour = G.C.GREY,
                            r = 0.1,
                        },
                        nodes = {
                            create_toggle({ -- option toggle
                                label = localize('frj_save_joker'),
                                label_scale = 0.4,
                                info = { localize("frj_save_joker_d") },
                                ref_table = mconfig,
                                ref_value = 'save_joker',
                                callback = function () FRJM:save_config() end
                            }),
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            padding = 0.1,
                            colour = G.C.GREY,
                            r = 0.1,
                        },
                        nodes = {
                            create_toggle({ -- option toggle
                                label = localize('frj_base_price'),
                                label_scale = 0.4,
                                info = { localize("frj_base_price_d") },
                                ref_table = mconfig,
                                ref_value = 'base_price',
                                callback = function () FRJM:save_config() end
                            }),
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            padding = 0.1,
                            colour = G.C.GREY,
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
                                        label = localize('frj_user_keybind'),
                                        label_scale = 0.4,
                                        info = { localize("frj_user_keybind_d") },
                                        ref_table = mconfig,
                                        ref_value = 'use_user_keybind',
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
                                                text_scale = 0.4,
                                                max_length = 1,
                                                all_caps = true,
                                                prompt_text = mconfig.user_keybind,
                                                ref_table = mconfig,
                                                ref_value = 'user_keybind',
                                                keyboard_offset = 1,
                                                callback = function () FRJM:save_config() end
                                            }),
                                        }
                                    },
                                },
                            },
                        }
                    }
                }
            }
        }
    }
end
