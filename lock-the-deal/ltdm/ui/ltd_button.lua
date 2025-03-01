-- Button state color
LTDM.UIDEF.LTD_STATE_COLOR = {
    LOCKED = HEX("6C757D"),
    UNLOCKED = HEX("FFA726"),
    DISABLED = G.C.UI.BACKGROUND_INACTIVE,
}

--- Create a new LTD button for registered shop item
---@param card LTDM.Card
function LTDM.UIDEF.add_ltd_button(card)
    local offset = { x = -0.25, y = 0 }
    local b_spacing = 0.18

    -- Fix alignment
    if card.ability.set == 'Booster' then
        offset.x = -0.55
        b_spacing = 0.25
    elseif card.ability.consumeable then
        offset.x = -0.45
        b_spacing = 0.25
    elseif card.ability.set == 'Voucher' then
        offset.x = -0.5
        b_spacing = 0.2
    end

    ---@type UIDef
    local button = {
        n = G.UIT.ROOT,
        config = {
            id = 'ltd_button', ref_table = card, minh = 0.8, padding = 0.1, align = "cr", shadow = true, r = 0.08,
            button = 'ltd_lock_unlock', hover = true, func = 'ltd_can_lock_unlock', emboss = 0.05,
            colour = (card.ltdm_state.locked and LTDM.UIDEF.LTD_STATE_COLOR.LOCKED) or LTDM.UIDEF.LTD_STATE_COLOR.UNLOCKED,
        },
        nodes = {
            LNXFCA.UIDEF.create_spacing_box({ w = b_spacing, col = G.UIT.C, }),
            { n = G.UIT.O, config = { object = DynaText({
                    string = {{ ref_table = card.ltdm_state.button, ref_value = 'label' }},
                    colours = { G.C.UI.TEXT_LIGHT }, scale = (G.SETTINGS.language == "en-us" and 0.5) or 0.4,
                }),
            }}
        },
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


-- smods Draw API guard
if not SMODS.draw_ignore_keys then
    return
end

SMODS.draw_ignore_keys.ltd_button = true
SMODS.DrawStep({
    key = 'ltd_button',
    order = -100,
    layer = 'card',
    ---@overload fun(card: LTDM.Card)
    func = function(card)
        if card.children.ltd_button and card.highlighted then
            card.children.ltd_button:draw()
        end
    end
})
