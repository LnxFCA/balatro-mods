--- Empty card focus UI
---@param card BALATRO_T.Card
function FRSM.UIDEF.card_focus_ui(card)
    local card_width = card.T.w + (card.ability.consumeable and -0.1 or card.ability.set == 'Voucher' and -0.16 or 0)
    local tcnx, tcny = card.T.x + card.T.w/2 - G.ROOM.T.w/2, card.T.y + card.T.h/2 - G.ROOM.T.h/2

    local base_background = UIBox{
        T = {card.VT.x,card.VT.y,0,0},
        definition = {
            n = G.UIT.ROOT, config = {
                align = "cm",minw = card_width + 0.3, minh = card.T.h + 0.3, r = 0.3, colour = adjust_alpha(G.C.BLACK, 0.7),
                outline_colour = lighten(G.C.JOKER_GREY, 0.5), outline = 0.5, line_emboss = 0.8,
            },
            nodes = {{ n = G.UIT.R, config = { id = 'ATTACH_TO_ME', }, nodes = {}}},
        },
        config = {
            align = 'cm', offset = { x = 0.007 * tcnx * card.T.w, y = 0.007 * tcny * card.T.h }, parent = card,
            r_bond = 'Weak',
        },
    }

    base_background.set_alignment = function()
        local cnx, cny = card.T.x + card.T.w/2 - G.ROOM.T.w/2, card.T.y + card.T.h/2 - G.ROOM.T.h/2
        Moveable.set_alignment(card.children.focused_ui, {offset = {x= 0.007*cnx*card.T.w, y = 0.007*cny*card.T.h}})
    end


    return base_background
end


--- Empty card h_popup
---@param card FRSM.Card
---@return UIDef
function FRSM.UIDEF.empty_card_h_popup(card)
    local AUT = card.ability_UIBox_table
    local card_type_colour = get_type_colour(card.config.center)
    local card_type_background = (card_type_colour and darken(G.C.BLACK, 0.1)) or { 0, 1, 1, 1 }
    local outer_padding = 0.05
    local card_type = localize('k_'..string.lower(AUT.card_type))
    local badges = {}

    table.insert(badges, create_badge(card_type, card_type_colour, nil, 1.2))

    ---@type UIDef
    return {
        n = G.UIT.ROOT, config = { align = "cm", colour = G.C.CLEAR, },
        nodes = {{ n = G.UIT.C, config = { align = "cm", object = Moveable() }, nodes = {{
            n = G.UIT.R, config = { padding = outer_padding, r = 0.12, colour = lighten(G.C.JOKER_GREY, 0.5), emboss = 0.07, },
            nodes = {{
                n = G.UIT.R, config = { align = "cm", padding = 0.07, r = 0.1, colour = adjust_alpha(card_type_background, 0.8), },
                nodes = {
                    name_from_rows(AUT.name, nil),
                    desc_from_rows(AUT.main),
                    { n = G.UIT.R, config = { align = "cm", padding = 0.08, }, nodes = badges },
                },
            }},
        }}}},
    }
  end


function FRSM.UIDEF.empty_card_h_popup_ui_table(center)

    local full_ui_table = {
        main = {}, info = {}, type = {}, name = nil, badges = { card_type = center.set, }, card_type = center.set,
    }

    full_ui_table.name = localize({
        type = 'name', set = (center.set == "Booster" and "Other") or center.set, key = center.key,
        nodes = full_ui_table.name,
    })

    localize({
        type = "descriptions", key = center.key, set = (center.set == "Booster" and "Other") or center.set,
        nodes = full_ui_table.main, vars = {},
    })


    return full_ui_table
end
