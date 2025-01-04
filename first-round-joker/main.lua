-- Misc
function include(filename)
    SMODS.load_file(filename, SMODS.current_mod.id)()
end

-- MOD files
include("ui/ui.lua")

-- MOD globals
FRJ = SMODS.current_mod

frj_key = FRJ.config["save_joker"] and FRJ.config["key"] or nil
frj_enable = true


-- MOD configuration
FRJ.config_tab = FRJ_UI.config_tab

-- MOD save configuration
FRJ.save_config = function(self)
    if self.config["save_joker"] then
        FRJ.config["key"] = frj_key
    else
        FRJ.config["key"] = nil
    end

    SMODS.save_mod_config(self)
end


-- Reset frj_enable on new game
frj_start_run = Game.start_run
---@diagnostic disable-next-line: duplicate-set-field
Game.start_run = function (self, args)
    frj_enable = true
    return frj_start_run(self, args)
end


local frj_create_card_for_shop = create_card_for_shop
function create_card_for_shop(area)
    ---@type Card
    local card = nil
    if G.GAME.round == 1 and frj_enable and not not frj_key then  -- should the mod activate?
        frj_enable = false  -- prevents the card from appearing after 1st round

        -- create the user selected Joker
        card = SMODS.create_card({
            set = 'Joker',
            area = area,
            key = frj_key,
            edition = { negative = true }
        })

        -- Base price?
        if FRJ.config["base_price"] then
            card.extra_cost = 0 + G.GAME.inflation
            card.cost = card.base_cost + card.extra_cost
        end

        -- Show
        create_shop_card_ui(card, 'Joker', area)
    else  -- default behavior
        card = frj_create_card_for_shop(area)
    end

    return card
end


local frj_keyevent = function (self)
    ---@type Card
    local card = G.CONTROLLER.hovering.target
    if card:is(Card)  -- check if its a discovered Joker card
       and card.config.center.set == 'Joker'
       and card.config.center.discovered
    then -- get the card key and save it if `save_joker` is enabled
        frj_key = card.config.center.key
        if FRJ.config["save_joker"] and not (FRJ.config["key"] == frj_key) then
            FRJ.config["key"] = frj_key
            SMODS.save_mod_config(FRJ)
        end
    end
end


-- Add a Balatro keyboard event
SMODS.Keybind{
    key_pressed = 'f',
    action = frj_keyevent,
    event = 'pressed',
    held_keys = {},
}
