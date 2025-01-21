---@type fun(args: table, info_args: table | nil): UIDef
FRJM.UI.create_config_tab_toggle = function(args, info_args)
    local toggle = create_toggle(args)

    info_args = info_args or {}
    local info = {}
    for _, v in ipairs(args.info or {}) do
        table.insert(info, {
            n = G.UIT.R,
            config = {
                align = info_args.align or "cm",
                minh = info_args.minh or 0.005,
            },
            nodes = {{
                n = G.UIT.T,
                config = {
                    text = v,
                    scale = info_args.scale or 0.3,
                    colour = info_args.colour or HEX("b8c7d4"),
                },
            }},
        })
    end

    info = {
        n = G.UIT.R,
        config = {
            align = "cm",
            minh = args.minh or 0.05,
        },
        nodes = info,
    }

    if args.info then
        toggle.nodes[2] = info
    end

    return toggle
end


---@type fun(content: UIDef, args: table | nil): UIDef
FRJM.UI.create_config_option = function(content, args)
    args = args or {}

    ---@type UIDef
    return {
        n = G.UIT.R,
        config = {
            align = "cm",
            padding = args.padding or 0.1,
            colour = args.colour or G.C.L_BLACK,
            r = args.r or 0.1 ,
        },
        nodes = {
            content,
        }
    }
end


---@type fun(args: table, cargs: table | nil): UIDef
FRJM.UI.create_config_option_toggle = function(args, cargs)
    args = args or {}

    local option_toggle = FRJM.UI.create_config_tab_toggle({
        label = args.label,
        info = args.info,
        active_colour = args.active_colour or G.C.BLUE,
        inactive_colour = args.inactive_colour or G.C.WHITE,
        ref_table = args.ref_table or FRJM.mod.config,
        ref_value = args.ref_value,
        callback = args.callback or function() FRJM:save_config() end,
    })

    return FRJM.UI.create_config_option(option_toggle, cargs)
end

FRJM.mod.config_tab = function ()
    local mconfig = FRJM.mod.config
    local mrconfig = FRJM.state
    mrconfig.selection_ui_active = true

    ---@type UIDef
    return {
        n = G.UIT.ROOT,
        config = {
            r = 0.1,
            minw = 8.8,
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
                    FRJM.UI.create_config_option_toggle({
                        label = localize('frj_save_joker'),
                        info = localize('frj_save_joker_d'),
                        ref_value = 'save_joker',
                    }),
                    FRJM.UI.create_config_option_toggle({
                        label = localize('frj_base_price'),
                        info = localize('frj_base_price_d'),
                        ref_value = 'base_price',
                    }),
                    FRJM.UI.create_config_option_toggle({
                        label = localize('frj_enable_button'),
                        info = localize('frj_enable_button_d'),
                        ref_value = 'enable_frjm_button',
                        callback = function ()
                            FRJM:save_config()

                            if mconfig.enable_frjm_button and G.STAGE == G.STAGES.MAIN_MENU then
                                FRJM.UI.create_frjm_button()
                            elseif mrconfig.frjm_button then
                                mrconfig.frjm_button:remove()
                                mrconfig.frjm_button:recalculate()
                            end
                        end,
                    }),
                    FRJM.UI.create_config_option_toggle({
                        label = localize('frj_disable_restriction'),
                        info = localize('frj_disable_restriction_d'),
                        ref_value = 'disable_restriction',
                    }),
                    FRJM.UI.create_config_option({
                        n = G.UIT.C,
                        config = {
                            align = "cm",
                        },
                        nodes = {
                            FRJM.UI.create_config_tab_toggle({ -- option toggle
                                label = localize('frj_use_custom_keybind'),
                                info = localize('frj_use_custom_keybind_d'),
                                active_colour = G.C.BLUE,
                                inactive_colour = G.C.WHITE,
                                ref_table = mconfig,
                                ref_value = 'use_custom_keybind',
                                callback = function()
                                    FRJM:save_config()
                                    FRJM:update_keybind()
                                end,
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
                                        callback = function()
                                            FRJM:save_config()
                                            FRJM:update_keybind()
                                        end,
                                    }),
                                },
                            },
                        },
                    }),
                },
            },
        },
    }
end
