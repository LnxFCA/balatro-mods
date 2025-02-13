---@diagnostic disable:missing-fields
CEPM = {}  ---@type CEPM


function CEPM.init(self)
    self.original = {}
    self.cards = {}
    self.utils = {}

    self.mod = SMODS.current_mod
    self.mod_id = self.mod_id

    self.state = {}
    self.state.cards = {}
end


CEPM:init()


if not LNXFCA and not LNXFCA.initialized and lnxfca_common_init then
    lnxfca_common_init()
end


LNXFCA.include("cepm/cards.lua", CEPM.mod_id)
LNXFCA.include("cepm/cep.lua", CEPM.mod_id)
LNXFCA.include("cepm/utils.lua", CEPM.mod_id)
