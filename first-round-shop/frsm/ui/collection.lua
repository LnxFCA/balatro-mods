function FRSM.UIDEF.generate_collection(pool, rows, args)
    args = args or {}
    args.w_mod = args.w_mod or 1
    args.h_mod = args.h_mod or 1
    args.card_scale = args.card_scale or 1
    pool = SMODS.collection_pool(pool)

    local card_areas = {}
    local deck_tables = {}
    local total_rows = {}
    local cards_per_page = 0
    local options = {}

    for i = 1, #rows do
        total_rows[i] = cards_per_page
        cards_per_page = cards_per_page + rows[i]

        card_areas[i] = CardArea(
            G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h, (args.w_mod * rows[i] + 0.25) * G.CARD_W, args.h_mod * G.CARD_H,
            { card_limit = rows[i], type = args.area_type or 'title', highlight_limit = 0, collection = true, }
        )


        table.insert(deck_tables, {
            n = G.UIT.R, config = { align = "cm", padding = 0.07, no_fill = true, }, nodes = {{
                n = G.UIT.O, config = { object = card_areas[i] }
            }}
        })
    end

    FRSM.UIDEF.collection = {
        rows = rows, args = args, card_areas = card_areas, deck_tables = deck_tables, total_rows = total_rows,
        pool = pool, cards_page = cards_per_page, options = options,
    }


    for i = 1, math.ceil(#pool / cards_per_page) do
        table.insert(options, localize('k_page') .. i .. '/' .. math.ceil(#pool / cards_per_page))
    end

    FRSM.callbacks.update_selection_page({ cycle_config = { current_option = 1 }})
end


function FRSM.UIDEF.create_collection_box()
    ---@type UIDef
    return {
        n = G.UIT.C, config = { align = "cm", padding = 0.1, }, nodes = {
            { n = G.UIT.R, config = { align = "cm", r = 0.1, colour = G.C.BLACK, }, nodes = FRSM.UIDEF.collection.deck_tables, },
            { n = G.UIT.R, config = { align = "cm", }, nodes = {
                create_option_cycle({
                    options = FRSM.UIDEF.collection.options, cycle_shoulders = true, opt_callback = 'frsm_callback_handler',
                    current_option = 1, focus_args = { snap_to = true, nav = 'wide', },
                })
            }},
        },
    }
end
