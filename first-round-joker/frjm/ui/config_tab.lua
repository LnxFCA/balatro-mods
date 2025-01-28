FRJM.mod.config_tab = function ()
    local mconfig = FRJM.mod.config
    local mrconfig = FRJM.state
    mrconfig.selection_ui_active = true

    ---@type UIDef
    return {
        n = G.UIT.ROOT, config = { r = 0.1, minw = 8, align = "cm", padding = 0.1, colour = G.C.BLACK, },
        nodes = {{
            n = G.UIT.C, config = { align = "cm", padding = 0.2, },
            nodes = {
                LNXFCA.UIDEF.config_create_option_box({
                    LNXFCA.UIDEF.config_create_option_toggle({
                        label = localize('frj_save_joker'),
                        info = localize('frj_save_joker_d'),
                        ref_table = FRJM.mod.config,
                        ref_value = 'save_joker',
                        callback = function ()
                            FRJM:save_config()
                        end,
                    }),
                }),
                LNXFCA.UIDEF.config_create_option_box({
                    LNXFCA.UIDEF.config_create_option_toggle({
                        label = localize('frj_base_price'),
                        info = localize('frj_base_price_d'),
                        ref_table = FRJM.mod.config,
                        ref_value = 'base_price',
                        callback = function ()
                            FRJM:save_config()
                        end,
                    }),
                }),
                LNXFCA.UIDEF.config_create_option_box({
                    LNXFCA.UIDEF.config_create_option_toggle({
                        label = localize('frj_enable_button'),
                        info = localize('frj_enable_button_d'),
                        ref_table = FRJM.mod.config,
                        ref_value = 'enable_frjm_button',
                        callback = function ()
                            FRJM:save_config()
                        end,
                    }),
                }),
                -- LNXFCA.UIDEF.config_create_option_box({
                --     LNXFCA.UIDEF.config_create_option_toggle({
                --         label = localize('frj_disable_restriction'),
                --         info = localize('frj_disable_restriction_d'),
                --         ref_table = FRJM.mod.config,
                --         ref_value = 'disable_restriction',
                --         callback = function ()
                --             FRJM:save_config()
                --         end,
                --     })
                -- }),
                LNXFCA.UIDEF.config_create_option_box({
                    LNXFCA.UIDEF.config_create_option_toggle({
                        label = localize('frj_use_custom_keybind'),
                        info = localize('frj_use_custom_keybind_d'),
                        ref_table = FRJM.mod.config,
                        ref_value = 'use_custom_keybind',
                        callback = function ()
                            FRJM:save_config()
                            FRJM:update_keybind()
                        end,
                    }),
                    {
                        n = G.UIT.R, config = { align = "cm"},
                        nodes = {
                            create_text_input({
                                colour = G.C.GREEN, w = 1, text_scale = 0.4, max_length = 1, all_caps = true,
                                prompt_text = FRJM.mod.config.custom_keybind, ref_table = FRJM.mod.config, ref_value = 'custom_keybind',
                                callback = function ()
                                    FRJM:save_config()
                                    FRJM:update_keybind()
                                end,
                            }),
                        },
                    },
                }),
            },
        }},
    }
end
