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
    local mconfig = FRJM.mod.config
    local mrconfig = FRJM.state
    local card = nil

    if FRJM:check(area) then  -- should the mod activate?
        mrconfig.enabled = false  -- prevents the card from appearing after 1st round

        -- create the user selected Joker
        card = SMODS.create_card({
            set = 'Joker',
            area = area,
            key = mrconfig.joker_key,
            edition = { negative = true }
        })

        -- Base price?
        if mconfig.base_price then
            card.extra_cost = 0 + G.GAME.inflation
            card.cost = card.base_cost + card.extra_cost
        end

        -- Show
        create_shop_card_ui(card, 'Joker', area)
    else  -- default behavior
        card = FRJM.original.create_card_for_shop(area)
    end

    return card
end


-- Reset selection overlay state when closed
FRJM.original.exit_overlay_menu = G.FUNCS.exit_overlay_menu
G.FUNCS.exit_overlay_menu = function ()
    local mrconfig = FRJM.state

    FRJM.original.exit_overlay_menu()
    if mrconfig.selection_ui_active then mrconfig.selection_ui_active = false end
end


--- Add game restart
G.FUNCS.frjm_restart_game = function (_)
    SMODS.save_all_config()
    SMODS.restart_game()
end


-- Open project page links on web browser
G.FUNCS.frjm_open_project_page = function (e)
    if (not e.config.ref_value) and (not e.config.ref_table) then return end

    love.system.openURL(e.config.ref_table[e.config.ref_value])
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
