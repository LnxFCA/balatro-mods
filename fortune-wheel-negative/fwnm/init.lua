local FWNM = {
    state = {},
    original = {},
    UIDEF = {},
    obj_table = {},
    mod = SMODS.current_mod --[[@as FWNM.Mod]],
    id = SMODS.current_mod.id,
    mt = {},
}  --[[@as FWNM]]


FWNM.obj_table = {
    wheel_of_fortune = SMODS.Tarot:take_ownership('wheel_of_fortune', {
        loc_vars = function(self, _, card)
            return {
                vars = {
                    G.GAME.probabilities.normal,
                    card.ability.extra --[[@as number]],
                },

                key = not FWNM.state.active and self.key or 'c_fwn_wheel_of_fortune'
            }  --[[@as SMODS.LocVars]]
        end,

        use = function(self, card, area, _)
            -- Same as vanilla
            if not (pseudorandom('wheel_of_fortune') < (G.GAME.probabilities.normal / card.ability.extra)) then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        attention_text({
                            text = localize('k_nope_ex'),
                            scale = 1.3,
                            hold = 1.4,
                            major = card,
                            backdrop_colour = G.C.SECONDARY_SET.Tarot,
                            align = (G.STATE == G.STATES.TAROT_PACK) and 'tm' or 'cm',
                            offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK) and -0.2 or 0 },
                            silent = true
                        })

                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4)
                                return true
                            end,
                        }))

                        play_sound('tarot2', 1, 0.4)
                        card:juice_up(0.3, 0.5)

                        return true
                    end,
                }))

                delay (0.6)

                return
            end

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function ()
                    local apply_card = pseudorandom_element(card.eligible_strength_jokers or {}, pseudoseed('wheel_of_fortune'))
                    local edition = poll_edition('wheel_of_fortune', nil, not FWNM.state.active, true, FWNM.state:get_editions_list()) --[[@as BALATRO.Card.Edition.Arg]]

                    apply_card:set_edition(edition, true)
                    if card.ability.name == 'The Wheel of Fortune' then check_for_unlock({ type = 'have_edition' }) end

                    card:juice_up(0.3, 0.5)

                    return true
                end
            }))
        end,
    }) --[[@as SMODS.Consumable]],

    -- negative_spin = SMODS.Voucher({
    --     loc_txt = {},
    --     key = 'negative_spin',
    --     atlas = 'voucher_atlas',
    --     pos = { x = 0, y = 0 },
    -- }),
    --
    -- fortune_inversion = SMODS.Voucher({
    --     loc_txt = {},
    --     key = 'negative_inversion',
    --     atlas = 'voucher_atlas',
    --     pos = { x = 1, y = 0 },
    -- }),
}


return FWNM
