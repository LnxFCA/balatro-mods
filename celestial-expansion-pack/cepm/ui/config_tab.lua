CEPM.mod.config_tab = function ()
    local config_loc = localize('cepm_loc').config --[[@as table<string, string | string[]>]]
    ---@type UIDef
    return {
        n = G.UIT.ROOT, config = { align = "cm", minw = 8, colour = G.C.BLACK, r = 0.1, },
        nodes = {{
            n = G.UIT.C, config = { align = "cm", padding = 0.2, },
            nodes = {
                LNXFCA.UIDEF.config_create_option_box({
                    LNXFCA.UIDEF.config_create_option_toggle({
                        label = config_loc.instant_level_up --[[@as string]],
                        info = config_loc.instant_level_up_d,
                        callback = function ()
                            SMODS.save_mod_config(CEPM.mod)
                        end,
                        ref_table = CEPM.mod.config,
                        ref_value = 'instant_level_up',
                    })
                }),
            },
        }},
    }
end
