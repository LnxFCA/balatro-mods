function LNXFCA.utils.copy_table(stable)
    local output = {}
    for k, v in pairs(stable) do
        if type(v) == 'table' then  -- perform deep copy
            output[k] = LNXFCA.utils.copy_table(v)
        else
            output[k] = v  -- primitive
        end
    end

    return output
end


function LNXFCA.utils.open_link(link)
    return love.system.openURL(link)
end


function LNXFCA.utils.debug(mod_id, msg, funcv)
    local message = (msg and funcv and "%s:%d %s() - %s") or (funcv and "%s:%d %s()") or ""

    local func = (type(funcv) == "function" and debug.getinfo(funcv)) or funcv
    if func then
        message = string.format(message, func.short_src, func.linedefined, func.name or "anonymous", msg)
    else
        message = msg or ""
    end

    sendDebugMessage(message, mod_id)
end


function LNXFCA.include(path, mod_id)
    local chunk = SMODS.load_file(path, mod_id)

    if chunk then chunk() end
end
