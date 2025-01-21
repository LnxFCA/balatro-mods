---@diagnostic disable:missing-fields

-- globals
LTDM = {} ---@type LTDM
LTDM.GameStatus = {
    NEW_RUN = 1, --- A new run
    LOAD_RUN = 2, --- A existent run
}

function LTDM.init(self)
    self.state = {}
    self.original = {}
    self.state = {}
    self.UIDEF = {}
    self.utils = {}

    self.mod = SMODS.current_mod
    self.mod_id = self.mod.id

    self.state.lock_number = 0
    self.state.lock_table = {}
    self.state.ltd_button_text = {}
    self.state.run_status = LTDM.GameStatus.NEW_RUN
    self.state.keybind_status_text = ""


    function self.include(filename)
        local mod_chunk = SMODS.load_file(filename, self.mod_id)
        if mod_chunk then mod_chunk() end
    end


    function self.utils.parent() return self end

end


-- Initialize mod
LTDM:init()
LTDM.include("ltdm/ui/config_tab.lua")
LTDM.include("ltdm/ui/ltd_button.lua")
LTDM.include("ltdm/overrides.lua")
LTDM.include("ltdm/utils.lua")


-- Set sane configuration defaults
if LTDM.utils:check_keybind() ~= 0 then LTDM.mod.config.lock_keybind = LTDM.mod.config.lock_default_keybind end
LTDM.state.lock_keybind = LTDM.mod.config.lock_keybind:lower()

-- Save sane configuration defaults
SMODS.save_mod_config(LTDM.mod)

-- Initialize keybind
LTDM.utils:update_lock_keybind()
