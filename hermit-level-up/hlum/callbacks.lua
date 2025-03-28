function G.FUNCS.hlum_callback_handler(e)
    if not e.cycle_config then return end

    HLUM.state:update_scale(e.to_val)


    HLUM.mod.config.cycle_config.current_option = e.to_key
    HLUM.mod.config.cycle_config.current_option_val = e.to_val
    HLUM.mod.config.money_scale = e.to_val

    SMODS.save_mod_config(HLUM.mod)
end
