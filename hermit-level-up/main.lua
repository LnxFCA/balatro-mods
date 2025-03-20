---@diagnostic disable:missing-fields
HLUM = {} --[[@as HLUM]]


function HLUM.init(self)
    self.UIDEF  = {}
    self.overrides = {}
    self.callbacks = {}
    self.mt = {}

    self.mod = SMODS.current_mod  --[[@as HLUM.Mod]]
    self.mod_id = self.mod.id
end


HLUM:init()

LNXFCA.include_list({
    'hlum/hlu.lua',
    'hlum/hermit.lua',
    'hlum/ui/extra_tabs.lua',
}, HLUM.mod_id)


HLUM.state = HLUM.mt.State()
