FRJM.UI.selected_card_ui = function ()
    local card_selection = FRJM.config.card_selection

    ---@type UIDef
    return {
        n = G.UIT.R,
        config = {
            align = "cm",
            minh = 0.5,
            colour = G.C.BLACK,
            r = 0.1,
            padding = 0.2,
        },
        nodes = {
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = {{
                            ref_table = card_selection, ref_value = 'name',
                            prefix = localize('frj_joker_text_selected')
                        }},
                        colours = { HEX("D7D9DB") },
                        shadow = true,
                        scale = 0.45,
                    })
                }
            }
        }
    }
end


FRJM.UI.create_card_selection_ui = function ()
    local jokers_collection = {}
    local jokers = {}

    -- filter jokers
    for _, v in ipairs(G.P_CENTER_POOLS.Joker) do
        if v.discovered then table.insert(jokers, v) end
    end

    -- generate collection UI
    jokers_collection = SMODS.card_collection_UIBox(jokers, { 4, 4, 4}, {
        no_materialize = true,
        h_mod = 0.95,
        back_func = 'exit_overlay_menu'
    })

    -- insert selection information UI
    ---@see create_UIBox_generic_options
    table.insert(jokers_collection.nodes[1].nodes[1].nodes, 1, FRJM.UI.selected_card_ui())

    ---@type UIDef
    return jokers_collection
end
