---@diagnostic disable missing-field

-- mod globals
FRJM = {} ---@type FRJM


-- Initialize the mod
FRJM.init = function (self)
    -- initialize globals
    self.UI = {}
    self.original = {}
    self.utils = {}
    self.config = {}  -- runtime
    self.config.card_selection = {}  -- card selection state
    self.project_page = {}  -- revelant project links

    self.mod = SMODS.current_mod
    self.mod_id = self.mod.id or "first-round-joker"

    -- initialize runtime configuration
    local mconfig = self.mod.config

    self.config.enabled = true
    self.config.joker_key = (mconfig.save_joker and mconfig.joker_key) or nil  -- load from config
    self.config.keybind = mconfig.default_keybind
    self.config.selection_ui_active = false  -- selection overlay state
    self.config.card_selection.key =  self.config.joker_key  -- selection info state
    self.config.card_selection.name = mconfig.joker_name  -- selection info state

    -- use the custom keybind if enabled
    if mconfig.use_custom_keybind and mconfig.custom_keybind ~= "" then
        self.config.keybind = mconfig.custom_keybind
    end

    self.config.keybind = string.lower(self.config.keybind)  -- keybind is stored in uppercase


    -- dynamically load and execute a file from the mod directory
    self.include = function (filename)
        SMODS.load_file(filename, self.mod_id)()
    end


    -- store a instance of self
    self.utils.parent = function () return self end

    -- save init configuration
    SMODS.save_mod_config(self.mod)
end


-- FRJM setup
FRJM:init()

FRJM.include("frjm/overrides.lua")
FRJM.include("frjm/utils.lua")
FRJM.include("frjm/ui/config_tab.lua")
FRJM.include("frjm/ui/card_selection.lua")
FRJM.include("frjm/ui/extra_tabs.lua")
FRJM.include("frjm/info.lua")

-- Called when activation key is pressed. Default F
FRJM.activate = function (_)
    -- don't active when the selection overlay is visible
    if FRJM.config.selection_ui_active then return end

    -- show the selection overlay
    FRJM.utils:show_card_selection_overlay()

    -- handle the selection event
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function ()
            local card = nil

            -- don't handle anything if the overlay isn't active
            if not FRJM.config.selection_ui_active then return true end

            -- handle the clicked card if different from previous card
            card = G.CONTROLLER.clicked.target
            if card and card:is(Card)
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
