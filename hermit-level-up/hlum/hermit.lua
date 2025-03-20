---@diagnostic disable:missing-fields
---@diagnostic disable:duplicate-set-field


HLUM.overrides.start_run = Game.start_run
function Game.start_run(self, args)
    if args.savetext then
        HLUM.state:load(HLUM.mod.config.state)
    else
        HLUM.state = HLUM.mt.State()
    end

    HLUM.overrides.start_run(self, args)
end


HLUM.overrides.save_run = save_run
save_run = function()
    if G.F_NO_SAVING == true then return end

    HLUM.state:save(HLUM.mod)
    SMODS.save_mod_config(HLUM.mod)

    HLUM.overrides.save_run()
end


--- Hermit calculate
---@param obj SMODS.Consumable
---@param card BALATRO_T.Card
function HLUM.callbacks.hermit_use(obj, card)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            play_sound('timpani')

            card:juice_up(0.3, 0.5)
            ease_dollars(math.max(0, math.min(G.GAME.dollars, HLUM.state.money_cap)), true)

            -- Levelup
            HLUM.state:level_up(obj)

            return true
        end,
    }))

    delay(0.6)
end


--- Hermit loc_vars
function HLUM.callbacks.hermit_loc_vars()
    return {
        vars = {
            HLUM.state.money_cap,
            HLUM.state.level,
            colours = { G.C.SECONDARY_SET.Tarot, },
        },
    }
end


SMODS.Consumable:take_ownership('hermit', {
    loc_vars = HLUM.callbacks.hermit_loc_vars,
    use = HLUM.callbacks.hermit_use,
})
