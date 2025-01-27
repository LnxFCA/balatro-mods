FRJM.UI.selected_card_ui = function ()
    ---@type UIDef
    return {
        n = G.UIT.R,
        config = { align = "cm", minh = 0.5, colour = G.C.BLACK, r = 0.1, padding = 0.2, },
        nodes = {{
            n = G.UIT.O,
            config = {
                object = DynaText({
                    string = {{ ref_table = FRJM.state.card_selection, ref_value = 'name', prefix = localize('frj_joker_text_selected'), }},
                    colours = { HEX("D7D9DB") },
                    shadow = true,
                    scale = 0.45,
                })
            },
        }},
    }
end


FRJM.UI.create_card_selection_ui = function ()
    local jokers_collection = {}
    local jokers = {}

    -- filter jokers
    for _, v in ipairs(G.P_CENTER_POOLS.Joker) do
        if v.discovered or FRJM.mod.config.disable_restriction then table.insert(jokers, v) end
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


---@overload fun()
FRJM.UI.create_frjm_button = function ()
    UIBox({
        ---@type UIDef
        definition = {
            n = G.UIT.ROOT, config = { algin = "cm", colour = G.C.UI.TRANSPARENT_LIGHT, r = 0.1, },
            nodes = {{
                n = G.UIT.C,
                config = {
                    align = "cm", padding = 0.2, minw = 2, colour = G.C.BLUE, r = 0.1, shadow = true, hover = true,
                    button = 'frjm_button_callback', func = 'can_frjm_button',
                },
                nodes = {{ n = G.UIT.T, config = { text = "FRJM", scale = 0.5, colour = G.C.UI.TEXT_LIGHT, }}},
            }},
        },
        config = { algin = "tli", bond = "Weak", offset = { x = 0, y = 0.3, }, major = G.ROOM_ATTACH },
    })
end
