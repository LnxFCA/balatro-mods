FRJM.UI.config_tab = function ()
    return {
        n = G.UIT.ROOT,
        config = {
            r = 0.1,
            minw = 5,
            align = "cm",
            padding = 0.1,
            colour = G.C.BLACK,
        },
        nodes = { -- configuration options
            {
                n = G.UIT.C, --- container
                config = {
                    align = "cm",
                },
                nodes = { -- options
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            padding = 0.1,
                            colour = G.C.GREY,
                            r = 0.2,
                        },
                        nodes = {
                            create_toggle({ -- option toggle
                                label = localize('frj_save_joker'),
                                label_scale = 0.4,
                                info = { localize("frj_save_joker_d") },
                                ref_table = FRJM.mod.config,
                                ref_value = 'save_joker',
                                callback = function() FRJM.mod:save_config() end,
                            }),
                        }
                    },
                    {
                        n = G.UIT.R, -- separator
                        config = {
                            align = "cm",
                        },
                        nodes = {{
                            n = G.UIT.B,
                            config = {
                                h = 0.3,
                                w = 1,
                            }
                        }}
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            padding = 0.1,
                            colour = G.C.GREY,
                            r = 0.2,
                        },
                        nodes = {
                            create_toggle({ -- option toggle
                                label = localize('frj_base_price'),
                                label_scale = 0.4,
                                info = { localize("frj_base_price_d") },
                                ref_table = FRJM.mod.config,
                                ref_value = 'base_price',
                                callback = function() SMODS.save_mod_config(FRJM.mod) end
                            }),
                        }
                    }
                }
            }
        }
    }
end
