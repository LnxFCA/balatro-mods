--- Switch card collection page
---@param cycle_args table
function LNXFCA.callbacks.update_collection_page(cycle_args)
    if not cycle_args or not cycle_args.cycle_config then return end

    local rows = LNXFCA.UIDEF.collection.rows
    local total_rows = LNXFCA.UIDEF.collection.total_rows
    local pool = LNXFCA.UIDEF.collection.pool
    local card_areas = LNXFCA.UIDEF.collection.card_areas
    local cards_page = LNXFCA.UIDEF.collection.cards_page * (cycle_args.cycle_config.current_option - 1)
    local args = LNXFCA.UIDEF.collection.args

    for r = 1, #card_areas do
            for i = #card_areas[r].cards, 1, -1 do
            local card = card_areas[r]:remove_card(card_areas[r].cards[i])
            card:remove()
            card = nil
            end
        end

    for r = 1, #rows do
        for i = 1, rows[r] do
            local center = pool[i + total_rows[r] + cards_page]
            if not center then break end

            local card = Card(
                card_areas[r].T.x + card_areas[r].T.w / 2, card_areas[r].T.y, G.CARD_W * args.card_scale,
                G.CARD_H * args.card_scale, nil, (args.center and G.P_CENTERS[args.center] or center)
            )

            if not args.no_materialize then card:start_materialize(nil, i > 1 or r > 1) end
            card_areas[r]:emplace(card)
        end
    end
end
