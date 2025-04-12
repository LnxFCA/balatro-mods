-- Initialize mod table
FWNM = LNXFCA.include("fwnm/init.lua") --[[@as FWNM]]
LNXFCA.include_list({
    'fwnm/fwn.lua',
    'fwnm/overrides.lua',
}, FWNM.id)

-- Initialize state
FWNM.state = FWNM.mt.State()
