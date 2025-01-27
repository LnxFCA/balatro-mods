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
