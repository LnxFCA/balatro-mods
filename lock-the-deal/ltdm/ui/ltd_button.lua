local ltd_button_defaults = {
    {
        width = 2.2,
        label_scale = 0.4,
        locked_offset_x = {
            voucher = -0.66,
            other = -0.46,
            consumeable = -0.52,
            booster = -0.75,
        },
        lock_offset_x = {
            voucher = -0.85,
            other = -0.64,
            consumeable = -0.72,
            booster = -0.9,
        },
        languages = { 'es_ES', 'es_419', 'pt_BR', }
    },
    {
        width = 1.8,
        label_scale = 0.4,
        locked_offset_x = {
            voucher = -0.42,
            other = -0.23,
            consumeable = -0.3,
            booster = -0.48,
        },
        lock_offset_x = {
            voucher = -0.8,
            other = -0.6,
            consumeable = -0.7,
            booster = -0.86,
        },
        languages = { 'it' }
    },
    {
        width = 1.8,
        label_scale = 0.4,
        locked_offset_x = {
            voucher = -0.45,
            other = -0.22,
            consumeable = -0.32,
            booster = -0.5,
        },
        lock_offset_x = {
            voucher = -0.65,
            other = -0.42,
            consumeable = -0.52,
            booster = -0.68,
        },
        languages = { 'de' }
    },
    {
        width = 2.4,
        label_scale = 0.4,
        locked_offset_x = {
            voucher = -0.66,
            other = -0.46,
            consumeable = -0.56,
            booster = -0.75,
        },
        lock_offset_x = {
            voucher = -0.55,
            other = -0.35,
            consumeable = -0.4,
            booster = -0.55,
        },
        languages = { 'fr', }
    },
    default = {
        width = 1.68,
        label_scale = 0.5,
        locked_offset_x = {
            voucher = -0.35,
            other = -0.15,
            consumeable = -0.25,
            booster = -0.43,
        },
        lock_offset_x = {
            voucher = -0.78,
            other = -0.58,
            consumeable = -0.65,
            booster = -0.83,
        },
    },
}

-- Process list
local ltd_button_conf = {}
for _, v in ipairs(ltd_button_defaults) do
    for _, l in ipairs(v.languages) do
        ltd_button_conf[l] = v
    end
    v.languages = nil
end


--- Get the default configartion for current language
---@return LTDM.ButtonConfig
function LTDM.UIDEF.get_ltd_button_conf()
    local config = ltd_button_conf[G.SETTINGS.language]
    if not config then return ltd_button_defaults.default end

    -- Load defaults
    return setmetatable(config, { __index = ltd_button_defaults.default })
end


---@param card LTDM.Card
function LTDM.UIDEF.add_ltd_button(card)
    local ltd_btn_config = LTDM.UIDEF.get_ltd_button_conf()
    local offset = { x = ltd_btn_config.lock_offset_x.other, y = 0 }

    -- Fix alignment
    if card.ability.set == 'Booster' then
        offset.x = ltd_btn_config.lock_offset_x.booster
    elseif card.ability.consumeable then
        offset.x = ltd_btn_config.lock_offset_x.consumeable
    elseif card.ability.set == 'Voucher' then
        offset.x = ltd_btn_config.lock_offset_x.voucher
        offset.y = 0.2
    end

    ---@type UIDef
    local button = {
        n = G.UIT.ROOT,
        config = {
            id = 'ltd_button', ref_table = card, minh = 0.8, padding = 0.1, align = "cr",
            shadow = true, r = 0.08, minw = ltd_btn_config.width, button = 'ltd_lock_unlock',
            hover = true, func = 'ltd_can_lock_unlock', emboss = 0.05, ltd_btn_conf = ltd_btn_config,
        },
        nodes = {{
            n = G.UIT.O,
            config = {
                object = DynaText({
                    string = {{ ref_table = card.ltdm_state.button, ref_value = 'label' }},
                    colours = { G.C.UI.TEXT_LIGHT }, scale = ltd_btn_config.label_scale or 0.5, x_offset = offset.x,
                })
            },
        }},
    }

    card.children.ltd_button = UIBox({
        definition = button,
        config = {
            align = "cr",
            offset = offset,
            major = card,
            bond = 'Weak',
            parent = card,
        },
    })

    -- Inject custom tooltip
    local o_hover = card.children.ltd_button.UIRoot.hover
    function card.children.ltd_button.UIRoot:hover()
        self.config.h_popup = LTDM.UIDEF.create_ltd_button_tooltip(card)
        self.config.h_popup_config = { align = "tm", offset = { x = 0, y = -0.15 }, parent = self }

        o_hover(self)
    end
end


--- Create LTD button tooltip
---@param card LTDM.Card
---@return UIDef
function LTDM.UIDEF.create_ltd_button_tooltip(card)
    ---@type UIDef
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.05, r = 0.1, colour = HEX("F5F5F5"), emboss = 0.05, shadow = true, },
        nodes = {{
            n = G.UIT.C,
            config = { align = "cm", colour = HEX("6C757D"), r = 0.1, emboss = 0.05, minw = 1.4, padding = 0.08 },
            nodes = {
                {  --- Title
                    n = G.UIT.R,
                    config = { align = "cm" }, nodes = {{
                        n = G.UIT.C,
                        config = { align = "cm", colour = HEX("6C757D"), padding = 0.1, r = 0.1, }, nodes = {{
                            n = G.UIT.O,
                            config = { object = DynaText({
                                string = { localize('ltd_button_tooltip_title') },
                                colours = { G.C.UI.TEXT_LIGHT, }, scale = 0.5, pop_in = 0.1,
                            })},
                        }},
                    }},
                },
                {  -- Body
                    n = G.UIT.R,
                    config = { align = "cm", }, nodes = {{
                        n = G.UIT.C,
                        config = { align = "cm", colour = HEX("F9F9F9"), padding = 0.1, r = 0.1, minw = 1.1 }, nodes = {{
                            n = G.UIT.O,
                            config = { object = DynaText({
                                string = {{ ref_table = card.ltdm_state.button, ref_value = 'price' }},
                                colours = { G.C.ORANGE, }, scale = 0.45,
                            })},
                        }},
                    }},
                },
            },
        }},
    }
end
