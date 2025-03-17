function FRSM.activate(self)
    self.state.ui_active = true

    -- Remove overlays menus
    G.FUNCS.exit_overlay_menu()

    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu({
        definition = FRSM.UIDEF.frsm_ui(),
    })

    FRSM.UIDEF.UI = G.OVERLAY_MENU

    local card1 = Card(
        FRSM.UIDEF.shop_jokers.T.x + FRSM.UIDEF.shop_jokers.T.w / 2, FRSM.UIDEF.shop_jokers.T.y, G.CARD_W, G.CARD_H,
        nil, G.P_CENTERS.j_joker
    )
    local card2 = Card(
        FRSM.UIDEF.shop_jokers.T.x + FRSM.UIDEF.shop_jokers.T.w / 2, FRSM.UIDEF.shop_jokers.T.y, G.CARD_W, G.CARD_H,
        nil, FRSM.UIDEF.P_CENTERS.empty_joker
    )

    local voucher = Card(
        FRSM.UIDEF.shop_vouchers.T.x + FRSM.UIDEF.shop_vouchers.T.w / 2, FRSM.UIDEF.shop_vouchers.T.y, G.CARD_W, G.CARD_H,
        nil, FRSM.UIDEF.P_CENTERS.empty_voucher
    )

    local booster1 = Card(
        FRSM.UIDEF.shop_booster.T.x + FRSM.UIDEF.shop_booster.T.w / 2, FRSM.UIDEF.shop_booster.T.y, G.CARD_W * 1.15,
        G.CARD_H * 1.15, nil, FRSM.UIDEF.P_CENTERS.empty_pack
    )
    local booster2 = Card(
        FRSM.UIDEF.shop_booster.T.x + FRSM.UIDEF.shop_booster.T.w / 2, FRSM.UIDEF.shop_booster.T.y, G.CARD_W * 1.15,
        G.CARD_H * 1.15, nil, FRSM.UIDEF.P_CENTERS.empty_pack
    )

    FRSM.UIDEF.shop_jokers:emplace(card1)
    FRSM.UIDEF.shop_jokers:emplace(card2)

    FRSM.UIDEF.shop_vouchers:emplace(voucher)
    FRSM.UIDEF.shop_booster:emplace(booster1)
    FRSM.UIDEF.shop_booster:emplace(booster2)
end

--- FRSM callback handler
--- Used to prevent namespace collision with other mods or the game itself
---@param e BALATRO_T.UIElement
function G.FUNCS.frsm_callback_handler(e)
    local handler = string.sub(e.config.id, 6)

    -- FRSM.callbacks[handler](e)
end


function FRSM.callbacks.open_card_selector(set)
    print(set)
end
