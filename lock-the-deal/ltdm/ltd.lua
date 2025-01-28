---@class LTDM.mt.State.Saved
---@field lock_list LTDM.LockItem[]
---@field length integer
---@field price_mult integer
---@field price integer
---@field local_state table<string, LTDM.LockItem.State?>
---@field forced_length integer


---@class LTDM.mt.State
---@field lock_list LTDM.LockItem[] The list of locked items
---@field length integer The current number of locked items
---@field price_mult integer Used to calculate the lock price
---@field price integer The current lock price
---@field local_state table<string, LTDM.LockItem.State?>
---@field forced_length integer Then number of force unlcked items
---@field _generated_items table<string, boolean?> The current generated items.
---@field saved_state LTDM.mt.State.Saved?
LTDM.mt.State = {}

function LTDM.mt.State.new(self)
    local obj = setmetatable({}, self)
    for k, v in pairs(self) do
        obj[k] = v
    end

    obj:init()

    return obj
end


--- Initializes the state fiels, if `saved_state` is not nil, it loads
--- the state from it.
---@param self LTDM.mt.State
---@param saved_state LTDM.mt.State.Saved? The saved state to load from
function LTDM.mt.State.init(self, saved_state)
    self.lock_list = {}
    self.local_state = {}
    self.length = 0
    self.price_mult = 1
    self.forced_length = 0
    self.price = 1
    self._generated_items = {}
    self.saved_state = saved_state

    if self.saved_state then self:load() end
end


--- Lock the given item
---@param self LTDM.mt.State
---@param card LTDM.Card
function LTDM.mt.State.lock_item(self, card)
    -- Check if the current don't exist
    if self:check_item(card.ltdm_state.id) then return true end

    -- Update lock list size
    self.length = self.length + 1

    -- Force unlock don't cost money
    if self.local_state[card.ltdm_state.id].force_lock then
        self.forced_length = self.forced_length + 1
    else
        -- Update use money
        self:ease_dollars(card.ltdm_state.id)
    end

    -- Update item local state
    self.local_state[card.ltdm_state.id].no_locked = false
    self.local_state[card.ltdm_state.id].locked = true

    -- Update LTD button
    self:update_btn_lock_price(card.ltdm_state.id)
    self.local_state[card.ltdm_state.id].button.label = localize('ltd_button_locked')

    -- Add item to lock table
    table.insert(self.lock_list, {
        id = card.ltdm_state.id,
        key = card.ltdm_state.key,
        enhancement = LTDM.utils.get_ehnacement_key(card.ability),
        state = card.ltdm_state,
        price = card.cost,
        set = card.config.center.set,
        edition = card.edition and { [card.edition.type or "e_base"] = card.edition[card.edition.type]},
        seal = card.seal,
    } --[[@as LTDM.LockItem]])
end


--- Unlocks an item
---@param self LTDM.mt.State
---@param id string Item id
function LTDM.mt.State.unlock_item(self, id)
    -- Update LTD button
    self.local_state[id].button.label = localize('ltd_button_lock')
    self.local_state[id].locked = false

    -- Remove item from the lock list
    for i, v in ipairs(self.lock_list) do
        if v.id == id then
            self.length = self.length - 1  -- Set new length
            if v.state.force_lock then self.forced_length = self.forced_length - 1 end
            table.remove(self.lock_list, i)  -- Remove the item
        end
    end
end

--- Update the lock price for specific id or all registered items
---@param self LTDM.mt.State
---@param id string? The specific item id
function LTDM.mt.State.update_btn_lock_price(self, id)
    local cprice = '$' .. (1 * self.price_mult)

    -- Update single item price
    if id then
        local no_locked = self.local_state[id].no_locked
        self.local_state[id].button.price = (no_locked and cprice) or localize('ltd_button_tooltip_free')
    end

    -- Update all
    for _, v in pairs(self.local_state) do
        if v.no_locked then
            v.button.price = cprice
        end
    end
end


--- Update the price multipler
---@param self LTDM.mt.State
---@param mult integer? The new price
function LTDM.mt.State.update_price_mult(self, mult)
    self.price_mult = mult or self.price_mult + 1

    -- price_mult can't be zero
    if self.price_mult <= 0 then self.price_mult = 1 end
    self.price = 1 * self.price_mult

    -- Update all
    self:update_btn_lock_price()
end


--- Reduce lock price from use money
---@param self LTDM.mt.State
---@param id string The item to check for
function LTDM.mt.State.ease_dollars(self, id)
    if self.local_state[id].no_locked then
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function ()
                ease_dollars(-(1 * self.price_mult))

                -- Update price
                self:update_price_mult()

                return true
            end
        }))
    end
end

--- Check if a item is already on the lock list
---@param self LTDM.mt.State
---@param id string The item id
---@return boolean Lock status
function LTDM.mt.State.check_item(self, id)
    local locked = false
    for _, v in ipairs(self.lock_list) do
        if v.id == id then
            locked = true
            break
        end
    end

    return locked
end

--- Register a new card on the sate manager
---@param self LTDM.mt.State
---@param card LTDM.Card
---@param area string
---@return LTDM.LockItem.State? Card local state
function LTDM.mt.State.register(self, card, area, force_lock)
    if not card then return end

    -- Load card state from ID
    ---@type LTDM.LockItem.State?
    local ltdm_state = self:get_state_by_id(card.ltdm_saved_id)

    -- Register new card
    if not ltdm_state then
        ltdm_state = {
            id = LTDM.utils.generate_uuid(),
            no_locked = true,
            button = { price = '$' .. 1 * self.price_mult, label = localize('ltd_button_lock'), },
            key = card.config.center.key,
            locked = false,
            area = area,
            force_lock = force_lock,
        }
    end

    -- Set item local status
    card.ltdm_state = ltdm_state

    -- Store item local status
    self.local_state[ltdm_state.id] = ltdm_state

    -- Force unclock
    if force_lock then
        self._generated_items[card.ltdm_state.id] = true
        self:lock_item(card)
    end
end


--- Retuns the local item state
---@param self LTDM.mt.State
---@param id string?
---@return LTDM.LockItem.State?
function LTDM.mt.State.get_state_by_id(self, id)
    return self.local_state[id]
end

--- Get a un-generated lock item for specific area.
---@param self LTDM.mt.State
---@param area string?
---@return LTDM.LockItem? Lock item data or nil
function LTDM.mt.State.get_lock_item(self, area)
    -- Check lock size
    if self.length == 0 then return nil end

    local item_area = area
    local item = nil

    -- Check for supported items
    if not item_area then return nil end

    -- Generate item for `area`
    for _, v in ipairs(self.lock_list) do
        if not self._generated_items[v.id] and v.state.area == item_area then
            self._generated_items[v.id] = true  -- Item generated

            -- Link state
            v.state = self:get_state_by_id(v.id) or v.state
            item = v

            break
        end
    end

    return item
end

--- Update a locked item or all locked data
---@param self LTDM.mt.State
---@param id string?
---@param update { func: fun(item: LTDM.LockItem?), key: string?, val: any? }
function LTDM.mt.State.update_locked_item(self, id, update)
    -- Skip invalid item id
    if id == false then return end

    for _, item in ipairs(self.lock_list) do
        if id and item.id == id then
            if update.func then update.func(item)
            elseif update.key then item[update.key] = update.val end
            break
        else
            if update.func then update.func(item)
            elseif update.key then item[update.key] = update.val end
        end
    end
end


--- Reset lock status, generator and price
---@param self LTDM.mt.State
function LTDM.mt.State.reset_lock(self)
    -- Reset price mult
    self.price_mult = 1

    -- Voucher can't be "unlocked" in re-rolls, same for Booster packs
    if G.STATE == G.STATES.SHOP or G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.PLANET_PACK
       or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.STANDARD_PACK or G.STATE == G.STATES.BUFFOON_PACK then
        for _, v in pairs(self.local_state) do
            -- Check for valid items
            if (v.area == 'vouchers' or v.area == 'booster') and not v.no_locked and not v.locked then
                self.price_mult = self.price_mult + 1
            end
        end
    end

    -- Update price
    self:update_price_mult((self.length + self.price_mult) - self.forced_length)
    self._generated_items = {}
end


--- Reset item if any, and reset status
---@param self LTDM.mt.State
---@param card LTDM.Card
function LTDM.mt.State.reset(self, card)
    -- Reset only the given item
    if card then
        self:unlock_item(card.ltdm_state.id)
        card.children.ltd_button:remove()
        card.children.ltd_button = nil

        -- Decrease price_mult if card has been locked
        if not card.ltdm_state.no_locked then
            self:update_price_mult(self.price_mult - 1)
        end

        self.local_state[card.ltdm_state.id] = nil
        card.ltdm_state = nil
    else
        -- Full reset
        self:reset_lock()
    end
end

--- Loads a saved state
---@param self LTDM.mt.State
---@param state LTDM.mt.State.Saved? The saved state
function LTDM.mt.State.load(self, state)
    self.saved_state = state or self.saved_state

    if not self.saved_state then return end

    -- Load state
    for k, v in pairs(self.saved_state) do
        self[k] = v
    end

    -- Reset saved_state
    self.saved_state = nil
end

---Load the saved state from Mod's configuration
---@param self LTDM.mt.State
---@param mod LTDM.Mod
function LTDM.mt.State.load_saved(self, mod)
    if not mod then return end

    -- Make a deep copy of the table to prevent errors
    self.saved_state = LNXFCA.utils.copy_table(mod.config.ltd or {})

    self:load()
end


--- Save the current state into Mod's configuration
---@param self LTDM.mt.State
---@param mod LTDM.Mod?
function LTDM.mt.State.save(self, mod)
    if not mod then return end

    -- Save a deep copy of the table to prevent errors
    mod.config.ltd = LNXFCA.utils.copy_table({
        lock_list = self.lock_list,
        local_state = self.local_state,
        length = self.length,
        price_mult = self.price_mult,
        price = self.price,
        forced_length = self.forced_length,
    })

    -- Save the state to disk
    SMODS.save_mod_config(mod)
end


--- Remove unused states from `local_state`
---@param self LTDM.mt.State
function LTDM.mt.State.clear_local_state(self)
    -- Cleaup non-locked items
    for k, v in pairs(self.local_state) do
        if not v.locked then
            v.button = nil  -- LTD button
            self.local_state[k] = nil  -- Local state
        end
    end
end
