---@param card BALATRO_T.Card
function LTDM.UIDEF.add_ltd_button(card)
    local offset = { x = -0.55, y = 0 }

    -- Fix alignment
    if card.ability.consumeable then
        offset.x = -0.65
    end

    ---@type UIDef
    local button = {
        n = G.UIT.ROOT,
        config = {
            id = 'ltd_button', ref_table = card, minh = 0.8, padding = 0.1, align = "cr",
            shadow = true, r = 0.08, minw = 1.6, button = 'ltd_lock_unlock',
            hover = true, func = 'ltd_can_lock_unlock',
        },
        nodes = {{
            n = G.UIT.O,
            config = {
                object = DynaText({
                    string = {{ ref_table = LTDM.state.ltd_button_text[card.config.center.key], ref_value = 'text' }},
                    colours = { G.C.UI.TEXT_LIGHT }, scale = 0.5, x_offset = offset.x,
                })
            },
        }},
    }

    card.children.ltd_button = UIBox({
        definition = button,
        config = {
            align = "cr",
            offset = offset,
            major = card,
            bond = 'Weak',
            parent = card,
        },
    })

    local o_hover = card.children.ltd_button.UIRoot.hover
    function card.children.ltd_button.UIRoot:hover()
        print("Custom tooltip")
        self.config.h_popup = LTDM.UIDEF.create_ltd_button_tooltip(card.config.center.key)
        self.config.h_popup_config = { align = "tm", offset = { x = 0, y = -0.15 }, parent = self }
        o_hover(self)
    end
end


function LTDM.UIDEF.create_ltd_button_tooltip(key)
    ---@type UIDef
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.05, r = 0.1, colour = HEX("F5F5F5"), emboss = 0.05, shadow = true, },
        nodes = {{
            n = G.UIT.C,
            config = { align = "cm", colour = HEX("6C757D"), r = 0.1, emboss = 0.05, minw = 1.4, padding = 0.08 },
            nodes = {
                {
                    n = G.UIT.R,
                    config = { align = "cm" }, nodes = {{
                        n = G.UIT.C,
                        config = { align = "cm", colour = HEX("6C757D"), padding = 0.1, r = 0.1, }, nodes = {{
                            n = G.UIT.O,
                            config = { object = DynaText({
                                string = {{ ref_table = LTDM.state.ltd_button_text[key], ref_value = 'popup_title' }},
                                colours = { G.C.UI.TEXT_LIGHT, }, scale = 0.5,
                            })},
                        }},
                    }},
                },
                {
                    n = G.UIT.R,
                    config = { align = "cm", }, nodes = {{
                        n = G.UIT.C,
                        config = { align = "cm", colour = HEX("F9F9F9"), padding = 0.1, r = 0.1, minw = 1.1 }, nodes = {{
                            n = G.UIT.O,
                            config = { object = DynaText({
                                string = {{ ref_table = LTDM.state.ltd_button_text[key], ref_value = 'popup_text' }},
                                colours = { G.C.ORANGE, }, scale = 0.45,
                            })},
                        }},
                    }},
                },
            },
        }},
    }
end
