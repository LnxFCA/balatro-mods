LTDM.mod.config_tab = function ()
    ---@type UIDef
    return {
        n = G.UIT.ROOT,
        config = {
            align = "cm",
            colour = G.C.BLACK,
            r = 0.1,
            minw = 8,
        },
        nodes = {{
            n = G.UIT.C,
            config = {
                align = "cm",
                padding = 0.2,
            },
            nodes = {
                LNXFCA.UIDEF.config_create_option_box({
                    LNXFCA.UIDEF.config_create_option_toggle({
                        label = localize('ltd_frjm_integration'),
                        info = localize('ltd_frjm_integration_d'),
                        ref_table = LTDM.mod.config,
                        ref_value = 'frjm_integration',
                        callback = function ()
                            LTDM.utils:save_config()
                        end,
                    })
                }),
                LNXFCA.UIDEF.config_create_option_box({
                    LNXFCA.UIDEF.config_create_option_toggle({
                        label = localize('ltd_booster_pack_enable'),
                        info = localize('ltd_booster_pack_enable_d'),
                        ref_table = LTDM.mod.config,
                        ref_value = 'booster_pack_enabled',
                        callback = function ()
                            LTDM.utils:save_config()
                        end,
                    }),
                }),
                LNXFCA.UIDEF.config_create_option_box({
                    LNXFCA.UIDEF.config_create_option_toggle({
                        label = localize('ltd_lock_keybind'),
                        info = localize('ltd_lock_keybind_d'),
                        ref_table = LTDM.mod.config,
                        ref_value = 'lock_keybind_enable',
                        callback = function ()
                            LTDM.utils:save_config()
                        end,
                    }),
                    {
                        n = G.UIT.R,
                        config = { align = "cm" },
                        nodes = {
                            create_text_input({
                                colour = G.C.GREEN,
                                w = 1,
                                text_scale = 0.4,
                                max_length = 1,
                                all_caps = true,
                                prompt_text = LTDM.mod.config.lock_keybind,
                                ref_table = LTDM.mod.config,
                                ref_value = 'lock_keybind',
                                callback = function ()
                                    local check_status = LTDM.utils:check_keybind()
                                    if check_status == 0 then
                                        LTDM.state.lock_keybind = LTDM.mod.config.lock_keybind:lower()
                                        LTDM.utils:update_lock_keybind()
                                        LTDM.state.keybind_status_text = ""
                                    else
                                        LTDM.mod.config.lock_keybind = LTDM.state.lock_keybind:upper()
                                        LTDM.state.keybind_status_text = (check_status == 1 and localize('ltd_lock_keybind_invalid'))
                                            or localize('ltd_lock_keybind_exist')
                                    end

                                    LTDM.utils:save_config()
                                end
                            }),
                        },
                    },
                }),
                {
                    n = G.UIT.R,
                    config = { minh = 0.4, align = "cl", colour = HEX("3d4d54") },
                    nodes = {{
                        n = G.UIT.O,
                        config = {
                            object = DynaText({ string = {{ ref_table = LTDM.state, ref_value = 'keybind_status_text', }},
                                colours = { G.C.RED, }, scale = 0.35, })
                        },
                    }},
                },
            },
        }},
    }
end
