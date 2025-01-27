---@diagnostic disable duplicate-set-field

-- Reset FRJ every game run
FRJM.original.start_run = Game.start_run
Game.start_run = function(self, args)
    if not args.savetext then
        FRJM.state.enabled = true
    end

    return FRJM.original.start_run(self, args)
end


-- Apply custom Joker card
FRJM.original.create_card_for_shop = create_card_for_shop
function create_card_for_shop(area)
    if not FRJM:can_activate(area) then return FRJM.original.create_card_for_shop(area) end
    FRJM.state.enabled = false  -- prevents the card from appearing after 1st round

    -- create the user selected Joker
    local card = SMODS.create_card({
        set = 'Joker',
        area = area,
        key = FRJM.state.joker_key,
        edition = { negative = true }
    })

    -- Base price?
    if FRJM.mod.config.base_price then
        card.extra_cost = 0 + G.GAME.inflation
        card.cost = card.base_cost + card.extra_cost
    end

    -- LTDM support
    card.frjm_shop_joker = true

    create_shop_card_ui(card, 'Joker', area)

    return card
end


-- Reset selection overlay state when closed
FRJM.original.exit_overlay_menu = G.FUNCS.exit_overlay_menu
G.FUNCS.exit_overlay_menu = function ()
    local state = FRJM.state

    FRJM.original.exit_overlay_menu()
    if state.selection_ui_active then state.selection_ui_active = false end
end


FRJM.original.main_menu = G.main_menu
function G.main_menu(self, change_context)
    FRJM.original.main_menu(self, change_context)

    FRJM.UI.create_frjm_button()
end


G.FUNCS.frjm_button_callback = function ()
    FRJM:activate()
end

G.FUNCS.can_frjm_button = function(e)
    if FRJM.mod.config.enable_frjm_button and G.STAGE == G.STAGES.MAIN_MENU then
        e.UIBox.states.visible = true
    else
        e.UIBox.states.visible = false
    end
end
