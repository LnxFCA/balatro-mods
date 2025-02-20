---@diagnostic disable:duplicate-set-field

CEPM.original.start_run = Game.start_run
function Game.start_run(self, args)
    if args.savetext then
        CEPM.state:load(CEPM.mod.config.cep and LNXFCA.utils.copy_table(CEPM.mod.config.cep))
    else
        CEPM.state = CEPM.mt.State:new()
        CEPM.mod.config.cep = nil
    end

    CEPM.original.start_run(self, args)
end


CEPM.original.save_run = save_run
function save_run()
    CEPM.original.save_run()

    if G.F_NO_SAVING == true then return end
    CEPM.state:save(CEPM.mod --[[@as CEPM.Mod]])
end


CEPM.original.level_up_hand = level_up_hand
--- Level up a Poker Hand.
--- Needed for vanilla Planet or other Planet Cards.
---@param card BALATRO_T.Card
---@param hand string
---@param instant boolean
---@param amount number
level_up_hand = function (card, hand, instant, amount)
    amount = amount or 1
    if card.ability.set == 'Planet' then
        amount = amount * CEPM.state.level_mult
    end

    CEPM.original.level_up_hand(card, hand, instant, amount)
end


CEPM.original.use_card = G.FUNCS.use_card
--- Intercet consumable use.
---@param e BALATRO_T.UIElement
---@param mute boolean
---@param nosave any
G.FUNCS.use_card = function (e, mute, nosave)
    local is_planet_card = e.config.ref_table and e.config.ref_table.ability.set == 'Planet'
    local key = e.config.ref_table and e.config.ref_table.config.center.key

    CEPM.original.use_card(e, mute, nosave)

    if is_planet_card and key ~= 'c_cep_hyperion' then
        CEPM.state.level_mult = 1
    end
end
