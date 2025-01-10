-- globals
FRJM = { UI = {}, override = {}, util = {} }
FRJM.mod = SMODS.current_mod

-- Load mod files
---@param filename string
function include(filename)
    SMODS.load_file(filename, SMODS.current_mod.id)()
end

-- MOD files
include("ui/card_selection.lua")
include("ui/config_tab.lua")

frj_key = FRJM.mod.config["save_joker"] and FRJM.mod.config["key"] or nil
frj_enable = true


-- MOD configuration UI
FRJM.mod.config_tab = FRJM.UI.config_tab

-- MOD save configuration
FRJM.mod.save_config = function(self)
    if self.config["save_joker"] then
        FRJM.mod.config["key"] = frj_key
    else
        FRJM.mod.config["key"] = nil
    end

    SMODS.save_mod_config(self)
end


-- Reset frj_enable on new game
FRJM.override.start_run = Game.start_run
---@diagnostic disable-next-line: duplicate-set-field
Game.start_run = function (self, args)
    frj_enable = true
    return FRJM.override.start_run(self, args)
end


FRJM.override.create_card_for_shop = create_card_for_shop
function create_card_for_shop(area)
    local not_tutorial = not (G.SETTINGS.tutorial_progress and G.SETTINGS.tutorial_progress.forced_shop)
    local card = nil
    if G.GAME.round == 1 and frj_enable and not_tutorial and (not not frj_key) then  -- should the mod activate?
        frj_enable = false  -- prevents the card from appearing after 1st round

        -- create the user selected Joker
        card = SMODS.create_card({
            set = 'Joker',
            area = area,
            key = frj_key,
            edition = { negative = true }
        })

        -- Base price?
        if FRJM.mod.config["base_price"] then
            card.extra_cost = 0 + G.GAME.inflation
            card.cost = card.base_cost + card.extra_cost
        end

        -- Show
        create_shop_card_ui(card, 'Joker', area)
    else  -- default behavior
        card = FRJM.override.create_card_for_shop(area)
    end

    return card
end


local frj_keyevent = function (self)
    local card = G.CONTROLLER.hovering.target
    if card:is(Card)  -- check if its a discovered Joker card
       and card.config.center.set == 'Joker'
       and card.config.center.discovered
    then -- get the card key and save it if `save_joker` is enabled
        frj_key = card.config.center.key
        if FRJM.mod.config["save_joker"] and not (FRJM.mod.config["key"] == frj_key) then
            FRJM.mod.config["key"] = frj_key
            SMODS.save_mod_config(FRJM.mod)
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
