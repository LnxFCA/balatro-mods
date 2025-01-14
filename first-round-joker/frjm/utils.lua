-- Whatever the mod should perform or not
---@return boolean
FRJM.enabled = function (self, area)
    local mrconfig = self.config

    local enabled = mrconfig.enable -- always true at starup
    local enabled_for_round = false -- true on round == 1
    local enabled_for_game = false -- false if tutorial in progress
    local enabled_for_key = false -- true if FRJM.config.joker_key isn't nil
    local enabled_for_area = false -- true if area == G.shop_jokers

    if enabled then
        enabled_for_round = G.GAME.round == 1
        enabled_for_game = not (G.SETTINGS.tutorial_progress and G.SETTINGS.tutorial_progress.forced_shop)
        enabled_for_key = mrconfig.joker_key ~= nil
        enabled_for_area = G.shop_jokers and area == G.shop_jokers

        enabled = enabled_for_round
            and enabled_for_game
            and enabled_for_key
            and enabled_for_area
    end

    return enabled
end


-- Save mod configuration
FRJM.save_config = function(self)
    local mconfig = self.mod.config  -- mod configuration
    local mrconfig = self.config -- runtime mod configuration

    -- save the current Joker key if save_joker is enabled
    if mconfig.save_joker then
        mconfig.joker_key = mrconfig.joker_key
    else
        mconfig.joker_key = nil
    end

    if mconfig.user_keybind == "" or (not mconfig.user_keybind) then
        mconfig.user_keybind  = mconfig.default_keybind
    end

    SMODS.save_mod_config(self.mod)
end
