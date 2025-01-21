--- Create a new configuration option box.
---@param content UIDef[]
---@return UIDef
function LTDM.UIDEF.config_create_option_box(content)
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
---@param args table
---@return UIDef
function LTDM.UIDEF.config_create_option_toggle(args)
    local toggle_args = args or {}
    toggle_args.ref_table = toggle_args.ref_table or LTDM.mod.config
    toggle_args.inactive_colour = G.C.WHITE
    toggle_args.active_colour = G.C.BLUE
    toggle_args.callback = toggle_args.callback or function() LTDM.utils:save_config() end

    local toggle = create_toggle(toggle_args)

    if args.info then
        local info = {}
        for _, v in ipairs(args.info or {}) do
            table.insert(info, { n = G.UIT.R, config = { align = "cm", minh = 0.005, }, nodes = {{
                n = G.UIT.T,
                config = { text = v, scale = 0.3, colour = HEX("b8c7d4"), },
            }}})
        end

        if info then
            info = { n = G.UIT.R, config = { align = "cm" }, nodes = info }
            toggle.nodes[2] = info
        end
    end

    return toggle
end


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
                LTDM.UIDEF.config_create_option_box({
                    LTDM.UIDEF.config_create_option_toggle({
                        label = localize('ltd_frjm_integration'),
                        info = localize('ltd_frjm_integration_d'),
                        ref_value = 'frjm_integration',
                    })
                }),
                LTDM.UIDEF.config_create_option_box({
                    LTDM.UIDEF.config_create_option_toggle({
                        label = localize('ltd_lock_keybind'),
                        info = localize('ltd_lock_keybind_d'),
                        ref_value = 'lock_keybind_enable',
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
