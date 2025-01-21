function LTDM.utils.lock_card(self, card)
    local parent = self.parent()
    local key = card.config.center.key

    parent.state.ltd_button_text[key] = localize('ltd_button_locked')
    parent.state.lock_table[key] = {
        key = key,
        set = card.config.center.set,
        editon = card.edition,
        cost = card.cost,
    }
end

function LTDM.utils.unlock_card(self, key)
    local parent = self.parent()

    if not parent.state.lock_table[key] then return end
    parent.state.lock_table[key] = nil
    parent.state.ltd_button_text[key] = localize('ltd_button_lock')
end


function LTDM.utils.remove_card(self, key)
    local parent = self.parent()

    if not parent.state.lock_table[key] then return end
    parent.state.lock_table[key] = nil
    parent.state.ltd_button_text[key] = nil
end

function LTDM.utils.keybind_activate(self)
    print("Hello World!")
end


function LTDM.utils.check_keybind(self)
    local parent = self.parent()
    local status = 0 -- 0 sucess, 1 key invalid, 2 key exists

    -- Check for keybind value
    local keybind = parent.mod.config.lock_keybind
    if string.len(keybind or "") ~= 1 then
        return 1
    end

    -- Do nothing
    if keybind:lower() == parent.state.lock_keybind then return 0 end

    -- Check for keybind on SMODS global
    for _, v in pairs(SMODS.Keybinds --[=[@as SMODS.Keybind[]]=]) do
        if v.key_pressed == keybind:lower() then status = 2; break end
    end

    return status
end


function LTDM.utils.update_lock_keybind(self)
    local parent = self.parent()
    local mconfig = parent.mod.config

    if not mconfig.lock_default_keybind then return end

    -- keybind not initialized when mod is loaded
    if not parent.state.keybind and mconfig.lock_keybind_enable then
        parent.state.keybind = SMODS.Keybind({
            action = function () self:keybind_activate() end,
            key_pressed = parent.state.lock_keybind,
            event = 'pressed',
        })

        return true
    end

    -- update keybind
    if parent.state.keybind then parent.state.keybind.key_pressed = parent.state.lock_keybind end
end


function LTDM.utils.save_config(self)
    local parent = self.parent()
    local mconfig = parent.mod.config

    -- don't save empty or invalid keybinds
    if parent.utils:check_keybind() ~= 0 then
        mconfig.lock_keybind = parent.state.lock_keybind:upper()
    end

    SMODS.save_mod_config(parent.mod)
end


function LTDM.utils.debug(self, msg, funcv)
    local parent = self.parent()
    local message = (msg and funcv and "%s:%d %s() - %s") or (funcv and "%s:%d %s()") or ""

    local func = (type(funcv) == "function" and debug.getinfo(funcv)) or funcv
    if func then
        message = string.format(message, func.short_src, func.linedefined, func.name or "anonymous", msg)
    else
        message = msg or ""
    end

    sendDebugMessage(message, parent.mod_id)
end

