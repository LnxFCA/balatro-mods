---@diagnostic disable duplicate-set-field

-- Reset FRJ every game run
FRJM.original.start_run = Game.start_run
function Game:start_run(args)
    FRJM.config.enable = true

    return FRJM.original.start_run(self, args)
end


-- Apply custom Joker card
FRJM.original.create_card_for_shop = create_card_for_shop
function create_card_for_shop(area)
    local card = nil
    if FRJM.utils.enabled(area) then  -- should the mod activate?
        FRJM.config.enable = false  -- prevents the card from appearing after 1st round

        -- create the user selected Joker
        card = SMODS.create_card({
            set = 'Joker',
            area = area,
            key = FRJM.config.joker_key,
            edition = { negative = true }
        })

        -- Base price?
        if FRJM.mod.config.base_price then
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
