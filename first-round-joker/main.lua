---@diagnostic disable:missing-fields

-- mod globals
FRJM = {} ---@type FRJM


-- Initialize the mod
FRJM.init = function (self)
    -- initialize globals
    self.UI = {}
    self.original = {}
    self.utils = {}
    self.state = {}  -- runtime
    self.state.card_selection = {}  -- card selection state

    self.mod = SMODS.current_mod
    self.mod_id = self.mod.id

    -- initialize runtime configuration
    local mconfig = self.mod.config

    self.state.enabled = true
    self.state.joker_key = (mconfig.save_joker and mconfig.joker_key) or nil  -- load from config
    self.state.keybind = mconfig.default_keybind
    self.state.selection_ui_active = false  -- selection overlay state
    self.state.card_selection.key =  self.state.joker_key  -- selection info state
    self.state.card_selection.name = mconfig.joker_name  -- selection info state

    -- use the custom keybind if enabled
    if mconfig.use_custom_keybind and mconfig.custom_keybind ~= "" then
        self.state.keybind = mconfig.custom_keybind
    end

    self.state.keybind = string.lower(self.state.keybind)  -- keybind is stored in uppercase


    -- dynamically load and execute a file from the mod directory
    self.include = function (filename)
        local chunk = SMODS.load_file(filename, self.mod_id)
        if chunk then chunk() end
    end


    -- store a instance of self
    self.utils.parent = function () return self end
end


-- FRJM setup
FRJM:init()

FRJM.include("frjm/overrides.lua")
FRJM.include("frjm/utils.lua")
FRJM.include("frjm/ui/config_tab.lua")
FRJM.include("frjm/ui/card_selection.lua")
FRJM.include("frjm/ui/extra_tabs.lua")
FRJM.include("frjm/info.lua")
FRJM.include("common/main.lua")


if not LNXFCA or not LNXFCA.initialized and lnxfca_common_init then
    lnxfca_common_init()
end


FRJM:save_config()

-- Called when activation key is pressed. Default F
FRJM.activate = function (_)
    -- don't active when the selection overlay is visible
    if FRJM.state.selection_ui_active then return end

    -- show the selection overlay
    FRJM.utils:show_card_selection_overlay()

    -- handle the selection event
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function ()
            -- don't handle anything if the overlay isn't active
            if not FRJM.state.selection_ui_active then return true end

            -- handle the clicked card if different from previous card
            local card = G.CONTROLLER.clicked.target
            if card and card:is(Card)
               and card.config.center.set == 'Joker'
               and card.config.center.key ~= FRJM.state.card_selection.key
            then
                FRJM.utils:select_joker_card(card)
            end
        end
    }))
end


-- Add a Balatro keyboard event
FRJM.state.keybind_obj = SMODS.Keybind{
    key_pressed = FRJM.state.keybind,
    action = FRJM.activate,
    event = 'pressed',
    held_keys = {},
}
