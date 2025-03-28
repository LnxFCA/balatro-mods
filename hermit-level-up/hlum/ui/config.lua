HLUM.mod.config_tab = function ()
    local o_loc = localize('hlum_loc')
    local m_scale_cycle = create_option_cycle({
        colour = G.C.RED, options = { 5, 10, 20 }, opt_callback = 'hlum_callback_handler',
        current_option = HLUM.mod.config.cycle_config.current_option,
        current_option_val = HLUM.mod.config.cycle_config.current_option_val,
        scale = 0.75,
    })

    local m_scale_o = {
        n = G.UIT.C, config = { align = "cm", padding = 0.1, }, nodes = {
            LNXFCA.UIDEF.create_multiline_text(o_loc.o_money_scale, { scale = 0.4, })[1],
            LNXFCA.UIDEF.create_spacing_box({ h = 0.025, }),
            LNXFCA.UIDEF.create_multiline_text(o_loc.o_money_scale_d, { scale = 0.3, colour = HEX("b8c7d4"), })[1],
            LNXFCA.UIDEF.create_spacing_box({ h = 0.03, }),
            m_scale_cycle,
        },
    }

    return {
        n = G.UIT.ROOT, config = { align = "cm", padding = 0.1, r = 0.5, colour = G.C.BLACK, }, nodes = {{
            n = G.UIT.C, config = { align = "cm", padding = 0.2, minw = 8, minh = 6 }, nodes = {
                LNXFCA.UIDEF.config_create_option_box({ m_scale_o }),
            },
        }},
    }
end
