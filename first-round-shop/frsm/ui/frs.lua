---@param contents UIDef[]
---@param args? table<string, any>
---@return UIDef
function FRSM.UIDEF.create_overlay_box(contents, args)
    args = args or {}
    args = {
        align = args.align or "cm",
        padding = args.padding or 0.1,
        minw = args.minw or 8,
        minh = args.minh or 6,
        border_color = args.border_color or G.C.JOKER_GREY,
        background = args.background or G.C.GREY,
        maxw = args.fixed and args.minw or nil,
        maxh = args.fixed and args.minh or nil,
    }

    ---@type UIDef
    return {
        n = G.UIT.ROOT, config = {
            align = "cm", padding = 0.1, colour = { 0.37, 0.45, 0.46, 0.7 }, minw = G.ROOM.T.w * 5, minh = G.ROOM.T.h * 5,
        },
        nodes = {{
            n = G.UIT.C, config = { align = args.align, padding = 0.07, r = 0.3, minw = args.minw, minh = args.minh, colour = args.border_color, },
            nodes = {{
                n = G.UIT.C, config = {
                    align = args.align, padding = args.padding, r = 0.3, minw = args.minw, minh = args.minh, colour = args.background,
                },
                nodes = contents,
            }}
        }},
    }
end


function FRSM.UIDEF.frsm_ui()
    local frsm_loc = localize('frsm_loc')

    FRSM.UIDEF.shop_jokers = CardArea(
        0, G.ROOM.T.y + 9, (G.GAME.shop.joker_max or 2) * 1.2 * G.CARD_W, 1.05 * G.CARD_H,
        { card_limit = G.GAME.shop.joker_max, type = 'shop', highlight_limit = 0, }
    )

    FRSM.UIDEF.shop_vouchers = CardArea(
        0, G.ROOM.T.y + 9, 2.1 * G.CARD_W, 1.05 * G.CARD_H,
        { card_limit = 1, type = 'shop', highlight_limit = 0, }
    )

    FRSM.UIDEF.shop_booster = CardArea(
        0, G.ROOM.T.y + 9, 2.4 * G.CARD_W, 1.15 * G.CARD_H,
        { card_limit = 2, type = 'shop', highlight_limit = 0, card_w = 1.27 * G.CARD_W, }
    )

    local shop_sign = AnimatedSprite(0,0, 1.6, 0.85, G.ANIMATION_ATLAS['shop_sign'])
    shop_sign:define_draw_steps({
      { shader = 'dissolve', shadow_height = 0.05, },
      { shader = 'dissolve', }
    })

    ---@type UIDef[]
    local main_ui = {
        -- Title
        { n = G.UIT.R, config = { align = "cm", padding = 0.1, }, nodes = {
            { n = G.UIT.C, config = { align = "cm", }, nodes = {{
                n = G.UIT.O, config = { object = DynaText({
                    string = { frsm_loc.ui_title }, colours = { lighten(G.C.GOLD, 0.3), }, shadow = true,
                    rotate = true, float = true, bump = true, scale = 0.6, spacing = 0.5, pop_in = 0.05,
                })},
            }}},
            { n = G.UIT.C, config = { align = "cm", }, nodes = {{ n = G.UIT.O, config = { object = shop_sign, }}}},
        }},

        -- Content
    }


    return FRSM.UIDEF.create_overlay_box(main_ui, {
        align = "tm", padding = 0, fixed = true, minw = G.ROOM.T.w * 0.85, minh = G.ROOM.T.h * 0.85,
        background = G.C.DYN_UI.DARK,
    })
end
