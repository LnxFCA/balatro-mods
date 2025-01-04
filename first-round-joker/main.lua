-- MOD: First Round Joker
FRJ = SMODS.current_mod

frj_key = FRJ.config["save_joker"] and FRJ.config["key"] or nil
frj_enable = true


-- Reset frj_enable on new game
frj_start_run = Game.start_run
Game.start_run = function (self, args)
    frj_enable = true
    return frj_start_run(self, args)
end


-- save joker key
FRJ.save_config = function(self)
    if self.config["save_joker"] then
        FRJ.config["key"] = frj_key
    else
        FRJ.config["key"] = nil
    end

    SMODS.save_mod_config(self)
end


-- configuration
FRJ.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = {
            r = 0.1,
            minw = 5,
            align = "cm",
            padding = 0.1,
            colour = G.C.BLACK,
        },
        nodes = { -- configuration options
            {
                n = G.UIT.C, --- container
                config = {
                    align = "cm",
                },
                nodes = { -- options
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            padding = 0.1,
                            colour = G.C.GREY,
                            r = 0.2,
                        },
                        nodes = {
                            create_toggle({ -- option toggle
                                label = localize('frj_save_joker'),
                                label_scale = 0.4,
                                info = { localize("frj_save_joker_d") },
                                ref_table = FRJ.config,
                                ref_value = 'save_joker',
                                callback = function() FRJ:save_config() end,
                            }),
                        }
                    },

                    {
                        n = G.UIT.R, -- separator
                        config = {
                            align = "cm",
                        },
                        nodes = {{
                            n = G.UIT.B,
                            config = {
                                h = 0.3,
                                w = 1,
                            }
                        }}
                    },

                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            padding = 0.1,
                            colour = G.C.GREY,
                            r = 0.2,
                        },
                        nodes = {
                            create_toggle({ -- option toggle
                                label = localize('frj_base_price'),
                                label_scale = 0.4,
                                info = { localize("frj_base_price_d") },
                                ref_table = FRJ.config,
                                ref_value = 'base_price',
                                callback = function() SMODS.save_mod_config(FRJ) end
                            }),
                        }
                    }
                }
            }
        }
    }
end


local frj_create_card_for_shop = create_card_for_shop
function create_card_for_shop(area)
    ---@type Card
    local card = nil
    if G.GAME.round == 1 and frj_enable and not not frj_key then  -- should the mod activate?
        frj_enable = false  -- prevents the card from appearing after 1st round

        -- create the user selected Joker
        card = SMODS.create_card({
            set = 'Joker',
            area = area,
            key = frj_key,
            edition = { negative = true }
        })

        -- Base price?
        if FRJ.config["base_price"] then
            card.extra_cost = 0 + G.GAME.inflation
            card.cost = card.base_cost + card.extra_cost
        end

        -- Show
        create_shop_card_ui(card, 'Joker', area)
    else  -- default behavior
        card = frj_create_card_for_shop(area)
    end

    return card
end


-- Add a Balatro keyboard event
local frj_keyevent = function (self)
    ---@type Card
    local card = G.CONTROLLER.hovering.target
    if card:is(Card)  -- check if its a discovered Joker card
       and card.config.center.set == 'Joker'
       and card.config.center.discovered
    then -- get the card key and save it if `save_joker` is enabled
        frj_key = card.config.center.key
        if FRJ.config["save_joker"] and not (FRJ.config["key"] == frj_key) then
            FRJ.config["key"] = frj_key
            SMODS.save_mod_config(FRJ)
        end
    end
end


SMODS.Keybind{
    key_pressed = 'f',
    action = frj_keyevent,
    event = 'pressed',
    held_keys = {},
}
