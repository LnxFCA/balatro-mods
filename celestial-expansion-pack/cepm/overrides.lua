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
