---@diagnostic disable:missing-fields

-- Globals
LNXFCA = LNXFCA or {}


function lnxfca_common_init()
    if LNXFCA.initialized then
        print(":: Shared module already initialized.")
        return
    end

    print(":: Initializing shared module.")
    LNXFCA = {} --[[@as LnxFCA]]

    LNXFCA.is_mod = SMODS.current_mod.id == 'lnxfca-common'
    LNXFCA.UIDEF = {}
    LNXFCA.utils = {}

    local iprefix = (LNXFCA.is_mod and '') or 'common/'

    local function include(path)
        local chunk = SMODS.load_file(iprefix .. path, SMODS.current_mod.id)
        if chunk then chunk() end
    end

    -- Load shared modules
    include("ui/mtab.lua")
    include("ui/text.lua")
    include("ui/other.lua")
    include("utils.lua")

    LNXFCA.initialized = true
end


-- Initialize as a mod
if SMODS.current_mod.id == 'lnxfca-common' then lnxfca_common_init() end

-- To load when installed as `mod/common`, simply use:
-- lnxfca_common_init()
