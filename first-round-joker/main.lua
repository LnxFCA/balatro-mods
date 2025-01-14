-- mod globals
FRJM = {}

-- Initialize the mod
FRJM.init = function (self)
    -- initialize globals
    self.UI = {}
    self.original = {}
    self.utils = {}
    self.config = {}  -- runtime
    self.config.card_selection = {}  -- card selection state

    self.mod = SMODS.current_mod
    self.mod_id = FRJM.mod.id or "first-round-joker"

    -- initialize runtime configuration
    local mconfig = self.mod.config

    self.config.enable = true
    self.config.joker_key = (mconfig.save_joker and mconfig.joker_key) or nil
    self.config.keybind = mconfig.default_keybind
    self.config.selection_ui_active = false
    self.config.card_selection.key =  self.config.joker_key
    self.config.card_selection.name = mconfig.joker_name

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


-- Called when activation key is pressed. Default F
FRJM.activate = function (_)
    if FRJM.config.selection_ui_active then return end

    FRJM.utils:show_card_selection_overlay()

    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function ()
            local card = nil

            if not FRJM.config.selection_ui_active then return true end
            if not G.CONTROLLER.clicked.target then return false end

            card = G.CONTROLLER.clicked.target
            if card:is(Card)
               and card.config.center.set == 'Joker'
               and card.config.center.key ~= FRJM.config.card_selection.key
            then
                FRJM.utils:select_joker_card(card)
            end
        end
    }))
end


-- Add a Balatro keyboard event
SMODS.Keybind{
    key_pressed = FRJM.config.keybind,
    action = FRJM.activate,
    event = 'pressed',
    held_keys = {},
}
