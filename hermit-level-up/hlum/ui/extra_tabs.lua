HLUM.mod.extra_tabs = function ()
    ---@type SMODS_T.Mod.ExtraTab[]
    return {{
        label = localize('hlum_loc').about_label,
        tab_definition_function = function ()
            return LNXFCA.UIDEF.create_about_tab(LNXFCA.include("hlum/info.lua", HLUM.mod_id))
        end,
    }}
end
