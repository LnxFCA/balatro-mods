---@param contents UIDef[]
---@param args? table<string, any>
---@return UIDef
function FRSM.UIDEF.create_overlay_box(contents, args)
    args = args or {}
    args = {
        align = args.align or "cm",
        padding = args.padding or 0.1,
        minw = args.minw or 8,
        minh = args.minh or 6,
        border_color = args.border_color or G.C.JOKER_GREY,
        background = args.background or G.C.GREY,
        maxw = args.fixed and args.minw or nil,
        maxh = args.fixed and args.minh or nil,
    }

    ---@type UIDef
    return {
        n = G.UIT.ROOT, config = {
            align = "cm", padding = 0.1, colour = { 0.37, 0.45, 0.46, 0.7 }, minw = G.ROOM.T.w * 5, minh = G.ROOM.T.h * 5,
        },
        nodes = {{
            n = G.UIT.C, config = { align = args.align, padding = 0.07, r = 0.3, minw = args.minw, minh = args.minh, colour = args.border_color, },
            nodes = {{
                n = args.container or G.UIT.C, config = {
                    align = args.align, padding = args.padding, r = 0.3, minw = args.minw, minh = args.minh, colour = args.background,
                },
                nodes = contents,
            }}
        }},
    }
end


function FRSM.UIDEF.frsm_ui()
    local frsm_loc = localize('frsm_loc')
    local room = { w = G.ROOM.T.w * 0.9, h = G.ROOM.T.h * 0.9 }

    FRSM.UIDEF.shop_jokers = FRSM.UIDEF.CardArea(
        0, G.ROOM.T.y + 9, (G.GAME.shop.joker_max or 2) * 1.2 * G.CARD_W, 1.05 * G.CARD_H,
        { card_limit = G.GAME.shop.joker_max, type = 'shop', highlight_limit = 0, }
    )

    FRSM.UIDEF.shop_vouchers = FRSM.UIDEF.CardArea(
        0, G.ROOM.T.y + 9, 2.1 * G.CARD_W, 1.05 * G.CARD_H,
        { card_limit = 1, type = 'shop', highlight_limit = 0, }
    )

    FRSM.UIDEF.shop_booster = FRSM.UIDEF.CardArea(
        0, G.ROOM.T.y + 9, 2.4 * G.CARD_W, 1.15 * G.CARD_H,
        { card_limit = 2, type = 'shop', highlight_limit = 0, card_w = 1.27 * G.CARD_W, }
    )

    local shop_sign = AnimatedSprite(0,0, room.w * 0.15, room.h * 0.12, G.ANIMATION_ATLAS['shop_sign'])
    shop_sign:define_draw_steps({
      { shader = 'dissolve', shadow_height = 0.05, },
      { shader = 'dissolve', }
    })

    ---@type UIDef[]
    local main_ui = {
        LNXFCA.UIDEF.create_spacing_box({ col = G.UIT.C, w = 0.5 }),
        -- Left
        {
            n = G.UIT.C, config = {
                align = "cm", padding = 0.07, colour = G.C.GREEN, r = 0.3,
            },
            nodes = {{
                n = G.UIT.C, config = {
                    align = "cm", padding = 0.1, colour = HEX("40484c"), r = 0.3, minw = room.w * 0.25, minh = room.h - 0.7,
                    maxw = room.w * 0.25, maxh = room.h - 0.7,
                },
                nodes = {
                    -- Title
                    {
                        n = G.UIT.R, config = {
                            align = "cm", colour = G.C.DYN_UI.DARK, minw = room.w * 0.23, minh = room.h * 0.24, r = 0.3,
                        },
                        nodes = {{
                            n = G.UIT.C, config = {
                                align = "cm", r = 0.3, padding = 0.05,
                            },
                            nodes = {
                                { n = G.UIT.R, config = { align = "cm", }, nodes = {{
                                    n = G.UIT.O, config = { object = DynaText({
                                        string = { frsm_loc.ui_title }, colours = { lighten(G.C.GOLD, 0.3), }, shadow = true,
                                        rotate = true, float = true, bump = true, scale = 0.6, spacing = 0.5, pop_in = 0.05,
                                    })},
                                }}},

                                { n = G.UIT.R, config = { align = "cm", }, nodes = {{ n = G.UIT.O, config = { object = shop_sign, }}}},
                            },
                        }},
                    },

                    LNXFCA.UIDEF.create_spacing_box({ h = 0.5, }),

                    -- Price information
                    { n = G.UIT.R, config = { align = "cm", }, nodes = {{ n = G.UIT.C, config = { align = "cm", }, nodes = {
                        -- Shop price
                        {
                            n = G.UIT.R, config = {
                                align = "cl", padding = 0.1, colour = G.C.DYN_UI.DARK, r = 0.3, minw = room.w * 0.24,
                                maxw = room.w * 0.24, emboss = 0.025,
                            },
                            nodes = {
                                {
                                    n = G.UIT.C, config = {
                                        align = "cm", padding = 0.05, minw = room.w * 0.08, maxw = room.w * 0.08,
                                    },
                                    nodes = {{
                                        n = G.UIT.T, config = { text = frsm_loc.label_shop_price, scale = 0.35, colour = G.C.UI.TEXT_LIGHT, },
                                    }}
                                },
                                {
                                    n = G.UIT.C, config = {
                                        align = "cm", padding = 0.1, colour = G.C.L_BLACK, r = 0.3, minw = room.w * 0.15,
                                        maxw = room.w * 0.13,
                                    },
                                    nodes = {{
                                        n = G.UIT.O, config = { object = DynaText({
                                            string = {{ prefix = localize('$'), ref_table = FRSM.state, ref_value = 'shop_cost'}},
                                            colours = { G.C.MONEY, }, scale = 0.4,
                                        })},
                                    }},
                                },
                            },
                        },

                        LNXFCA.UIDEF.create_spacing_box({ h = 0.2, }),

                        -- FRSM Price
                        {
                            n = G.UIT.R, config = {
                                align = "cl", padding = 0.1, colour = G.C.DYN_UI.DARK, r = 0.3, minw = room.w * 0.24,
                                maxw = room.w * 0.24, emboss = 0.025,
                            },
                            nodes = {
                                {
                                    n = G.UIT.C, config = {
                                        align = "cm", padding = 0.05, minw = room.w * 0.08, maxh = room.w * 0.08,
                                    },
                                    nodes = {{
                                        n = G.UIT.T, config = { text = frsm_loc.label_frs_price, scale = 0.35, colour = G.C.UI.TEXT_LIGHT, },
                                    }},
                                },
                                {
                                    n = G.UIT.C, config = {
                                        align = "cm", padding = 0.1, colour = G.C.L_BLACK, r = 0.3, minw = room.w * 0.15,
                                        maxw = room.w * 0.13,
                                    },
                                    nodes = {{
                                        n = G.UIT.O, config = { object = DynaText({
                                            string = {{ prefix = localize('$'), ref_table = FRSM.state, ref_value = 'cost'}},
                                            colours = { G.C.MONEY, }, scale = 0.4,
                                        })},
                                    }},
                                },
                            },
                        },

                        LNXFCA.UIDEF.create_spacing_box({ h = 0.25, }),
                        -- Preset
                        {
                            n = G.UIT.R, config = {
                                align = "cm", padding = 0.1, colour = G.C.DYN_UI.DARK, r = 0.3, minw = room.w * 0.24,
                                maxw = room.w * 0.24, emboss = 0.05,
                            },
                            nodes = {{ n = G.UIT.C, config = { align = "cm", }, nodes = {
                                -- Label
                                { n = G.UIT.R, config = { align = "cl", padding = 0.15, minw = room.w * 0.22, maxw = room.w * 0.22, }, nodes = {{
                                    n = G.UIT.T, config = { text = frsm_loc.label_preset, scale = 0.3, colour = lighten(G.C.GREY, 0.25), }
                                }}},
                                {
                                    n = G.UIT.R, config = {
                                        align = "cm", padding = 0.1, colour = HEX("40484c"), r = 0.3, minw = room.w * 0.22,
                                        maxw = room.w * 0.22,
                                    },
                                    nodes = {
                                        -- Preset select
                                        {
                                            n = G.UIT.C, config = {
                                                id = 'frsm_preset_select', align = "cm", padding = 0.2, colour = G.C.RED, r = 0.3,
                                                hover = true, button = 'frsm_callback_handler', minw = room.w * 0.08, maxw = room.w * 0.08,
                                            },
                                            nodes = {{
                                                n = G.UIT.T, config = { text = frsm_loc.btn_preset_select, scale = 0.35, colour = G.C.UI.TEXT_LIGHT, },
                                            }},
                                        },

                                        LNXFCA.UIDEF.create_spacing_box({ col = G.UIT.C, w = 0.15, }),

                                        -- Preset new
                                        {
                                            n = G.UIT.C, config = {
                                                id = 'frsm_preset_new', align = "cm", padding = 0.2, colour = G.C.GREEN, r = 0.3,
                                                hover = true, button = 'frsm_callback_handler', minw = room.w * 0.08, maxw = room.w * 0.08,
                                            },
                                            nodes = {{
                                                n = G.UIT.T, config = { text = frsm_loc.btn_preset_new, scale = 0.35, colour = G.C.UI.TEXT_LIGHT, },
                                            }},
                                        },
                                    },
                                },
                            }}},
                        },

                        LNXFCA.UIDEF.create_spacing_box({ h = 0.6, }),

                        -- Save
                        { n = G.UIT.R, config = { align = "cm", padding = 0.1, }, nodes = {{
                            n = G.UIT.C, config = {
                                id = 'frsm_save', align = "cm", padding = 0.2, minw = room.w * 0.15, maxw = room.w * 0.15,
                                hover = true, r = 0.3, shadow = true, button = 'frsm_callback_handler', colour = G.C.BLUE,
                            },
                            nodes = {{
                                n = G.UIT.T, config = { text = frsm_loc.btn_save, scale = 0.35, colour = G.C.UI.TEXT_LIGHT, },
                            }},
                        }}},


                        -- Exit
                        { n = G.UIT.R, config = { align = "cm", padding = 0.1, }, nodes = {{
                            n = G.UIT.C, config = {
                                id = 'frsm_exit', align = "cm", padding = 0.2, minw = room.w * 0.15, maxw = room.w * 0.15,
                                hover = true, r = 0.3, shadow = true, button = 'frsm_callback_handler', colour = G.C.RED,
                            },
                            nodes = {{
                                n = G.UIT.T, config = { text = frsm_loc.btn_exit, scale = 0.35, colour = G.C.UI.TEXT_LIGHT, },
                            }},
                        }}},
                    }}}},
                },
            }}
        },

        LNXFCA.UIDEF.create_spacing_box({ col = G.UIT.C, w = 0.5 }),
        -- Right (content)
        { n = G.UIT.C, config = { align = "cm", emboss = 0.05, }, nodes = {{
            n = G.UIT.C, config = {
                align = "cm", padding = 0.1, colour = G.C.DYN_UI.DARK, r = 0.3, minw = room.w * 0.65, minh = room.h - 1,
                maxw = room.w * 0.65, maxh = room.h - 1,
            },
            nodes = {
                -- Jokers
                { n = G.UIT.R, config = { align = "cm", emboss = 0.05, }, nodes = {
                    -- Action buttons
                    { n = G.UIT.C, config = { align = "cm", minw = room.w * 0.12, maxw = room.w * 0.12, }, nodes = {
                        -- Random
                        {
                            n = G.UIT.R, config = {
                                id = 'frsm_random', align = "cm", colour = G.C.ORANGE, r = 0.3, padding = 0.2, shadow = true,
                                hover = true, button = 'frsm_callback_handler', minw = room.w * 0.11, maxw = room.w * 0.11,
                            },
                            nodes = {{
                                n = G.UIT.T, config = { text = frsm_loc.btn_random, scale = 0.4, colour = G.C.UI.TEXT_LIGHT, },
                            }},
                        },

                        LNXFCA.UIDEF.create_spacing_box({ h = 0.3, }),

                        -- Reset All
                        {
                            n = G.UIT.R, config = {
                                id = 'frsm_reset_all', align = "cm", colour = G.C.RED, r = 0.3, padding = 0.2, shadow = true,
                                hover = true, button = 'frsm_callback_handler', minw = room.w * 0.11, maxw = room.w * 0.11,
                            },
                            nodes = {{
                                n = G.UIT.T, config = { text = frsm_loc.btn_reset, scale = 0.4, colour = G.C.UI.TEXT_LIGHT, },
                            }},
                        },
                    }},

                    LNXFCA.UIDEF.create_spacing_box({ col = G.UIT.C, w = 0.6, }),

                    {
                        n = G.UIT.C, config = { align = "cm", padding = 0.2, colour = G.C.L_BLACK, minw = 8, r = 0.2, },
                        nodes = {{ n = G.UIT.O, config = { object = FRSM.UIDEF.shop_jokers, }}},
                    },
                }},

                LNXFCA.UIDEF.create_spacing_box({ h = 0.25, }),

                { n = G.UIT.R, config = { align = "cm", emboss = 0.05, }, nodes = {
                    -- Vouchers
                    {
                        n = G.UIT.C, config = { align = "cm", padding = 0.2, r = 0.2, colour = G.C.L_BLACK, emboss = 0.05, },
                        nodes = {{
                            n = G.UIT.C, config = {
                                padding = 0.2, r = 0.2, colour = G.C.BLACK, maxh = FRSM.UIDEF.shop_vouchers.T.h + 0.4,
                            },
                            nodes = {{ n = G.UIT.O, config = { object = FRSM.UIDEF.shop_vouchers, }}},
                        }},
                    },

                    LNXFCA.UIDEF.create_spacing_box({ col = G.UIT.C, w = 0.5, }),

                    -- Booster Packs
                    {
                        n = G.UIT.C, config = { align = "cm", padding = 0.15, r = 0.2, colour = G.C.L_BLACK, emboss = 0.05, },
                        nodes = {{ n = G.UIT.O, config = { object = FRSM.UIDEF.shop_booster, }}}
                    },
                }},
            },
        }}},
    }


    return FRSM.UIDEF.create_overlay_box(main_ui, {
        align = "cl", padding = 0, fixed = true, minw = room.w, minh = room.h, background = G.C.L_BLACK, container = G.UIT.R,
    })
end
