LTDM.mod.extra_tabs = function ()
    ---@type SMODS_T.Mod.ExtraTab[]
    return {{
        label = localize('ltd_mod_about_label'),
        tab_definition_function = function ()
            local mod_info = SMODS.load_file("ltdm/info.lua", LTDM.mod_id)
            return LNXFCA.UIDEF.create_about_tab(mod_info --[[@as LnxFCA.UIDEF.AboutTabArgs]] and mod_info())
        end,
    }}
end
