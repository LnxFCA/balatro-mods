---@diagnostic disable:missing-fields

-- globals
LTDM = {} ---@type LTDM


function LTDM.init(self)
    self.state = {}
    self.original = {}
    self.state = {}
    self.UIDEF = {}
    self.utils = {}
    self.mt = {}

    self.mod = SMODS.current_mod  --[[@as LTDM.Mod]]
    self.mod_id = self.mod.id

    self.state.keybind_status_text = ""


    function self.include(filename)
        local mod_chunk = SMODS.load_file(filename, self.mod_id)
        if mod_chunk then mod_chunk() end
    end


    function self.utils.parent() return self end
end


-- Initialize mod
LTDM:init()
LTDM.include("ltdm/ltd.lua")
LTDM.include("ltdm/ui/config_tab.lua")
LTDM.include("ltdm/ui/extra_tabs.lua")
LTDM.include("ltdm/ui/ltd_button.lua")
LTDM.include("ltdm/ui/ltd_popup.lua")
LTDM.include("ltdm/overrides.lua")
LTDM.include("ltdm/callbacks.lua")
LTDM.include("ltdm/utils.lua")
LTDM.include("common/main.lua")


if not LNXFCA or not LNXFCA.initialized then
    lnxfca_common_init()
end


-- Set sane configuration defaults
if LTDM.utils:check_keybind() ~= 0 then LTDM.mod.config.lock_keybind = LTDM.mod.config.lock_default_keybind end
LTDM.state.lock_keybind = LTDM.mod.config.lock_keybind:lower()

-- Save sane configuration defaults
SMODS.save_mod_config(LTDM.mod)

-- Initialize keybind
LTDM.utils:update_lock_keybind()


-- Initialize state
LTDM.state.ltd = LTDM.mt.State:new()

-- ===========================================

-- =========================================================
-- SILK TOUCH INTEGRATION (Fully API Compliant)
-- Registers mobile-like touch dragging & native gamepad inputs
-- ===========================================

-- =========================================================
-- SILK TOUCH INTEGRATION (Fully API Compliant)
-- Registers mobile-like touch dragging & native gamepad inputs
-- =========================================================

if SilkTouch then
    
    -- 1. Touchscreen Drag Target
    SilkTouch.DragTarget{
        key = "ltd_lock_drag_area",
        prefix_config = {key = false},
        moveable_t = function()
            local base_x = G.deck.T.x + 0.2
            local base_w = G.deck.T.w - 0.1
            local padding = 0.2

            return Moveable{
                T = {
                    x = base_x + base_w + padding,
                    y = G.deck.T.y - 5.1,
                    w = base_w,
                    h = 4.5,
                }
            }
        end,
        text = function(card)
            if card and card.ltdm_state and card.ltdm_state.locked then
                -- Explicitly shows "Unlock" when dragging an already locked card
                return {"Unlock"} 
            end
            return {localize('ltd_button_lock')}
        end,
        colour = G.C.BLUE,
        drag_condition = function(card)
            return card and card.area and (card.area == G.shop_jokers or card.area == G.shop_vouchers or card.area == G.shop_booster)
        end,
        active_check = function(card)
            return card ~= nil and card.ltdm_state ~= nil
        end,
        release_func = function(card)
            if LTDM and LTDM.state and LTDM.state.ltd and card and card.ltdm_state then
                if card.ltdm_state.locked then
                    LTDM.state.ltd:unlock_item(card.ltdm_state.id)
                else
                    LTDM.state.ltd:lock_item(card)
                end
                card:juice_up()
            end
        end,
    }

    -- 2. Native Gamepad/Controller Button
    SilkTouch.ControllerButton{
        key = "ltd_lock_controller_button",
        button_key = "leftshoulder",
        text = function(card)
            if card and card.ltdm_state and card.ltdm_state.locked then
                -- Explicitly shows "Unlock" for the controller button prompt
                return {"Unlock", single_text = true} 
            end
            return {localize('ltd_controller_lock'), single_text = true}
        end,
        colour = G.C.BLUE,
        focus_condition = function(card)
            return card and card.ltdm_state ~= nil and card.area and (card.area == G.shop_jokers or card.area == G.shop_vouchers or card.area == G.shop_booster)
        end,
        active_check = function(card)
            return card ~= nil and card.ltdm_state ~= nil
        end,
        press_func = function(card)
            if LTDM and LTDM.state and LTDM.state.ltd and card and card.ltdm_state then
                if card.ltdm_state.locked then
                    LTDM.state.ltd:unlock_item(card.ltdm_state.id)
                else
                    LTDM.state.ltd:lock_item(card)
                end
                card:juice_up()
            end
        end,
    }
end

    

