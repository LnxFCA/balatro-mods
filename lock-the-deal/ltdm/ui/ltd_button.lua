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
                    string = {{ ref_table = LTDM.state.ltd_button_text, ref_value = card.config.center.key }},
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
end
