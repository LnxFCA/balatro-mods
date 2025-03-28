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


--- Hermit use
---@param obj SMODS.Consumable
---@param card BALATRO.Card
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


--- Hermit calculate
---@param _ SMODS.Consumable
---@param card BALATRO.Card
---@param context table
function HLUM.callbacks.hermit_calculate(_, card, context)
    if not context.using_consumeable then return end

    -- Only update on card usage
    if context.consumeable.config.center.key ~= 'c_hermit' then return end

    -- Don't update the used card
    if card == context.consumeable then return end

    local money_msg = '+' .. localize('$') .. HLUM.state.money_scale

    for _, v in ipairs(G.consumeables.cards) do
        if v.config.center.key == 'c_hermit' then
            card_eval_status_text(v, 'extra', nil, nil, nil, { message = money_msg, colours = G.C.MONEY, })
        end
    end
end


--- Hermit loc_vars
--- @return table
function HLUM.callbacks.hermit_loc_vars()
    local current_level = (G.STAGE == G.STAGES.RUN and HLUM.state.level) or HLUM.state.level_d

    return {
        vars = {
            (G.STAGE == G.STAGES.RUN and HLUM.state.money_cap) or HLUM.state.money_cap_d or G.P_CENTERS.c_hermit.config.extra,
            current_level,
            colours = { (current_level == 1 and G.C.UI.TEXT_DARK) or G.C.HAND_LEVELS[math.min(7, HLUM.state.level)], },
        },
    }
end


SMODS.Consumable:take_ownership('hermit', {
    loc_vars = HLUM.callbacks.hermit_loc_vars,
    use = HLUM.callbacks.hermit_use,
    calculate = HLUM.callbacks.hermit_calculate,
})
