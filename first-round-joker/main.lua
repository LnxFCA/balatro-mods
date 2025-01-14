-- mod globals
FRJM = {}

FRJM.init = function (self)
    -- initialize globals
    self.UI = {}
    self.original = {}
    self.utils = {}
    self.config = {}  -- runtime

    self.mod = SMODS.current_mod
    self.mod_id = FRJM.mod.id or "first-round-joker"

    -- initialize runtime configuration
    local mconfig = self.mod.config

    self.config.enable = true
    self.config.joker_key = (mconfig.save_joker and mconfig.joker_key) or nil
    self.config.keybind = mconfig.default_keybind

    if mconfig.use_user_keybind and mconfig.user_keybind ~= "" then
        self.config.keybind = mconfig.user_keybind
    end

    self.config.keybind = string.lower(self.config.keybind)


    -- include func
    ---@param filename string
    self.include = function (filename)
        SMODS.load_file(filename, self.mod_id)()
    end


    -- self (parent)
    self.utils.parent = function () return self end

    -- save init configuration
    SMODS.save_mod_config(self.mod)
end


-- FRJM starup
FRJM:init()

FRJM.include("frjm/overrides.lua")
FRJM.include("frjm/utils.lua")
FRJM.include("frjm/ui/config_tab.lua")
FRJM.include("frjm/ui/card_selection.lua")


FRJM.utils.keyevent = function (self)
    local card = G.CONTROLLER.hovering.target
    if card:is(Card)  -- check if its a discovered Joker card
       and card.config.center.set == 'Joker'
       and card.config.center.discovered
    then -- get the card key and save it if `save_joker` is enabled
        FRJM.config.joker_key = card.config.center.key
        if FRJM.mod.config.save_joker then
            FRJM:save_config()
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
