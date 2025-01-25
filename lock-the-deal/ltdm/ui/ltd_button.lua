---@param card LTDM.Card
function LTDM.UIDEF.add_ltd_button(card)
    local offset = { x = -0.55, y = 0 }

    -- Fix alignment
    if card.ability.consumeable or card.ability.set == 'Booster' then
        offset.x = -0.65
    end

    -- Fix Voucher alignment
    if card.ability.set == 'Voucher' then
        offset.x = -0.75
        offset.y = 0.2
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
                    string = {{ ref_table = card.ltdm_state.button, ref_value = 'label' }},
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

    -- Inject custom tooltip
    local o_hover = card.children.ltd_button.UIRoot.hover
    function card.children.ltd_button.UIRoot:hover()
        self.config.h_popup = LTDM.UIDEF.create_ltd_button_tooltip(card)
        self.config.h_popup_config = { align = "tm", offset = { x = 0, y = -0.15 }, parent = self }

        o_hover(self)
    end
end


--- Create LTD button tooltip
---@param card LTDM.Card
---@return UIDef
function LTDM.UIDEF.create_ltd_button_tooltip(card)
    ---@type UIDef
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.05, r = 0.1, colour = HEX("F5F5F5"), emboss = 0.05, shadow = true, },
        nodes = {{
            n = G.UIT.C,
            config = { align = "cm", colour = HEX("6C757D"), r = 0.1, emboss = 0.05, minw = 1.4, padding = 0.08 },
            nodes = {
                {  --- Title
                    n = G.UIT.R,
                    config = { align = "cm" }, nodes = {{
                        n = G.UIT.C,
                        config = { align = "cm", colour = HEX("6C757D"), padding = 0.1, r = 0.1, }, nodes = {{
                            n = G.UIT.O,
                            config = { object = DynaText({
                                string = { localize('ltd_button_tooltip_title') },
                                colours = { G.C.UI.TEXT_LIGHT, }, scale = 0.5, pop_in = 0.1,
                            })},
                        }},
                    }},
                },
                {  -- Body
                    n = G.UIT.R,
                    config = { align = "cm", }, nodes = {{
                        n = G.UIT.C,
                        config = { align = "cm", colour = HEX("F9F9F9"), padding = 0.1, r = 0.1, minw = 1.1 }, nodes = {{
                            n = G.UIT.O,
                            config = { object = DynaText({
                                string = {{ ref_table = card.ltdm_state.button, ref_value = 'price' }},
                                colours = { G.C.ORANGE, }, scale = 0.45,
                            })},
                        }},
                    }},
                },
            },
        }},
    }
end
