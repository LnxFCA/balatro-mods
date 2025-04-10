---@class LnxFCA.Inject
---@field funcs LnxFCA.Inject.Table
---@field run_before LnxFCA.Inject.Table
---@field run_after LnxFCA.Inject.Table
---@field has_run_before? boolean
---@field has_run_after? boolean
LNXFCA.INJECT = {}


--- Initializes storage
---@param self LnxFCA.Inject
function LNXFCA.INJECT.init(self)
    self.funcs = {
        save_run = {},
        start_run = {},
    }

    self.run_before = {
        save_run = {},
        start_run = {},
    }

    self.run_after = {
        save_run = {},
        start_run = {},
    }

    for k, _ in pairs(self.funcs) do
        for i = 1, 9, 1 do
            self.funcs[k][i] = {}
            self.run_after[k][i] = {}
            self.run_before[k][i] = {}
        end
    end
end


--- Inject a new hook onto `target`
---@param self LnxFCA.Inject
---@param target LnxFCA.Inject.Type
---@param data LnxFCA.Inject.Target
---@return number, number
function LNXFCA.INJECT.add(self, target, data)
    _data = data
    _data.order = data.order or 9
    _data.order = _data.order < 1 and 1 or _data.order
    _data.order = _data.order > 9 and 9 or _data.order
    _data.after = type(data.after) ~= 'nil' and data.after or false
    _data.before = type(data.before) ~= 'nil' and data.before or true

    self.has_run_after = self.has_run_after or _data.after
    self.has_run_before = self.has_run_before or _data.before

    table.insert(self.funcs[target][_data.order], _data)
    self:sort_trigger(target)

    return #self.funcs[target][_data.order], _data.order
end


--- Remove a hook
---@param self LnxFCA.Inject
---@param target LnxFCA.Inject.Type
---@param id number
---@param order number
---@return LnxFCA.Inject.Target?
function LNXFCA.INJECT.remove(self, target, id, order)
    return table.remove(self.funcs[target][order], id)
end



--- Sort functions by `before` and `after` properties.
---@param self LnxFCA.Inject
---@param target LnxFCA.Inject.Type
function LNXFCA.INJECT.sort_trigger(self, target)
    local pool = self.funcs[target]

    for o, v in ipairs(pool) do
        for _, t in ipairs(v) do
            table.insert(t.after and self.run_after[target][o] or self.run_before[target][o], t)
        end
    end
end


--- Run an hook function
---@param self LnxFCA.Inject
---@param target LnxFCA.Inject.Type
---@param after? boolean
function LNXFCA.INJECT.run(self, target, after, ...)
    local args = { ... }
    local pool = after and self.run_after[target] or self.run_before[target]
    for o = 1, 9 do
        for i = 1, #pool[o] do pool[o][i].func(args[1]) end
    end
end
