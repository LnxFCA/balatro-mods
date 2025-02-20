CEPM.mod.extra_tabs = function ()
    ---@type SMODS_T.Mod.ExtraTab[]
    return {
        {
            label = localize('cepm_loc').about_tab_label,
            tab_definition_function = function ()
                return LNXFCA.UIDEF.create_about_tab(LNXFCA.include("cepm/info.lua", CEPM.mod_id))
            end
        },
    }
end
