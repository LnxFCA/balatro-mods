function FRSM.activate(self)
    self.state.ui_active = false

    -- Remove overlays menus
    G.FUNCS.exit_overlay_menu()

    G.FUNCS.overlay_menu({
        definition = FRSM.UIDEF.frsm_ui(),
    })

    FRSM.UIDEF.UI = G.OVERLAY_MENU

    -- local card = Card(
    --     FRSM.UIDEF.shop_jokers.T.x + FRSM.UIDEF.shop_jokers.T.w / 2, FRSM.UIDEF.shop_jokers.T.y, G.CARD_W, G.CARD_H,
    --     G.P_CARDS.empty, G.P_CENTERS.j_joker, { bypass_discovery_center = true, bypass_discovery_ui = true, }
    -- )

    -- FRSM.UIDEF.shop_jokers:emplace(card)
end
