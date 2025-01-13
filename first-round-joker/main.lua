-- mod globals
FRJM = {}
FRJM.UI = {}
FRJM.overrided = {}
FRJM.utils = {}
FRJM.config = {}  -- runtime

FRJM.mod = SMODS.current_mod
FRJM.mod_id = FRJM.mod.id or "first-round-joker"


-- Save mod configuration
SMODS.save_mod_config(FRJM.mod)


--- Load mod runtime configuration
FRJM.utils.load_config = function ()
    local config = {}

    config.enable = true
    config.joker_key = (FRJM.mod.config.save_joker and FRJM.mod.config.joker_key) or nil
    config.keybind = FRJM.mod.config.default_keybind

    if FRJM.mod.config.use_user_keybind and FRJM.mod.config.user_keybind ~= "" then
        config.keybind = FRJM.mod.config.user_keybind
    end

    config.keybind = string.lower(config.keybind)

    FRJM.config = config
end


---@param filename string
FRJM.utils.include = function (filename)
    SMODS.load_file(filename, FRJM.mod_id)()
end


-- Whatever the mod should perform or not
---@return boolean
FRJM.utils.enabled = function (area)
    local enabled = FRJM.config.enable -- true at the
    local enabled_for_round = false -- true on round == 1
    local enabled_for_game = false -- false if tutorial in progress
    local enabled_for_key = false -- true if FRJM.config.joker_key isn't nil
    local enabled_for_area = false -- true if area == G.shop_jokers

    if enabled then
        enabled_for_round = G.GAME.round == 1
        enabled_for_game = not (G.SETTINGS.tutorial_progress and G.SETTINGS.tutorial_progress.forced_shop)
        enabled_for_key = FRJM.config.joker_key ~= nil
        enabled_for_area = G.shop_jokers and area == G.shop_jokers

        enabled = enabled_for_round
            and enabled_for_game
            and enabled_for_key
            and enabled_for_area
    end

    return enabled
end

-- Starup configuration
FRJM.utils.include("ui/card_selection.lua")
FRJM.utils.include("ui/config_tab.lua")

FRJM.utils.load_config()


-- save configuration
FRJM.utils.save_config = function()
    -- save the current Joker key if save_joker is enabled
    if FRJM.mod.config.save_joker then
        FRJM.mod.config.joker_key = FRJM.config.joker_key
    else
        FRJM.mod.config.joker_key = nil
    end

        if FRJM.mod.config.user_keybind == "" or (not FRJM.mod.config.user_keybind) then
            FRJM.mod.config.user_keybind  = FRJM.mod.config.default_keybind
        end

    SMODS.save_mod_config(FRJM.mod)
end


-- Reset FRJ every game run
FRJM.overrided.start_run = Game.start_run
---@diagnostic disable-next-line: duplicate-set-field
Game.start_run = function (self, args)
    FRJM.config.enable = true

    return FRJM.overrided.start_run(self, args)
end


FRJM.overrided.create_card_for_shop = create_card_for_shop
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
        card = FRJM.overrided.create_card_for_shop(area)
    end

    return card
end


FRJM.utils.keyevent = function (self)
    local card = G.CONTROLLER.hovering.target
    if card:is(Card)  -- check if its a discovered Joker card
       and card.config.center.set == 'Joker'
       and card.config.center.discovered
    then -- get the card key and save it if `save_joker` is enabled
        FRJM.config.joker_key = card.config.center.key
        if FRJM.mod.config.save_joker then
            FRJM.utils.save_config()
        end
    end
end


-- Add a Balatro keyboard event
SMODS.Keybind{
    key_pressed = FRJM.config.keybind,
    action = FRJM.utils.keyevent,
    event = 'pressed',
    held_keys = {},
}
