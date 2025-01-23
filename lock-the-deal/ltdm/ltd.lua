---@class LTDM.LTDState
---@field lock_list LTDM.LockItem[] The list of current locked items
---@field lock_list_saved LTDM.LockItem[] The state before saving progress
---@field length integer The current number of lockted items
---@field length_saved integer The length of prev
LTDM.mt.LTDState = {}

function LTDM.mt.LTDState.__call(self)
    local obj = setmetatable({}, self)

    obj:init()

    return obj
end


function LTDM.mt.LTDState.init(self)
    self.lock_list = {}
    self.lock_list_prev = {}
    self.length = 0
    self.length = 0
end


--- Lock a item
--- Add the item to the temporal state
---@param card BALATRO_T.Card
function LTDM.mt.LTDState.lock_item(self, card)
    local key = card.config.center.key
    local edition = card.edition and card.edition.type
    ---@type LTDM.LockItem
    local lock_item = {
        id = card.ltdm_data.id,
        key = key,
        price = card.cost,
        set = card.config.center.set,
        edition = { [edition or "e_base"] = (not not edition) or nil },
        ehnacement = LTDM.utils.get_ehnacement_key(card.ability),
        seal = card.seal,
    }

    table.insert(self.lock_list, lock_item)
end


--- Unlocks an item
--- The item is still registered, it only removes from the temporal state
---@param id string The item to unlock
function LTDM.mt.LTDState.unlock_item(self, id)
    for i, v in ipairs(self.lock_list) do
        if v.id == id then
            table.remove(self.lock_list, i)
        end
    end

end


function LTDM.mt.LTDState.register_item(card)
end


function LTDM.mt.LTDState.remove_item(id)
end


function LTDM.mt.LTDState.pop_item()
    
end
