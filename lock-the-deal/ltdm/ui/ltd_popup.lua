--- Create popup for controller users.
---@param card LTDM.Card
---@return UIDef
function LTDM.UIDEF.create_ltd_popup(card)
    ---@type UIDef
    return {
        n = G.UIT.R, config = { align = "cm", padding = 0.2, r = 0.5, },
        nodes = {{
            n = G.UIT.C, config = { align = "cm", padding = 0.05, colour = G.C.WHITE, r = 0.5, },
            nodes = {{
                n = G.UIT.C, config = { align = "cm", padding = 0.15, colour = G.C.BLACK, r = 0.5, minw = 2.8, },
                nodes = {
                    {
                        n = G.UIT.R, config = { align = "cm", padding = 0.005, },
                        nodes = {{
                            n = G.UIT.C, config = { align = "cm", },
                            nodes = {
                                { n = G.UIT.T, config = { align = "cm", text = "LTD: ", scale = 0.4, colour = G.C.ORANGE, }},
                                {
                                    n = G.UIT.O, config = { object = DynaText({
                                        string = {{ ref_table = card.ltdm_state.button, ref_value = 'c_label', }},
                                        colours = { HEX("b1b1b1"), }, scale = 0.4,
                                    })}
                                },
                                {
                                    n = G.UIT.C, config = {
                                        align = "cl", minw = 0.45, minh = 0.5, ref_table = card, button = 'ltd_lock_unlock',
                                        focus_args = { type = 'none', }, func = 'ltd_can_lock_unlock', ltd_controller = true,
                                    },
                                    nodes = {{
                                        n = G.UIT.R, config = {
                                            align = "cl", focus_args = { button = 'triggerleft', scale = 0.5, type = 'none', },
                                            func = 'set_button_pip',
                                        }
                                    }}
                                },
                            },
                        }},
                    },
                    {
                        n = G.UIT.R, config = { align = "cm", },
                        nodes = {{
                            n = G.UIT.C, config = {
                                align = "cm", r = 0.5, colour = HEX("F9F9F9"), padding = 0.1, minw = 1.1,
                            },
                            nodes = {{
                                n = G.UIT.O, config = { object = DynaText({
                                    string = {{ ref_table = card.ltdm_state.button, ref_value = 'price', }},
                                    colours = { G.C.ORANGE, }, scale = 0.4,
                                })}
                            }}
                        }},
                    },
                },
            }},
        }},
    }
end
