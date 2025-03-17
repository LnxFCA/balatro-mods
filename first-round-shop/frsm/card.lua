---@diagnostic disable:duplicate-set-field


FRSM.overrides.card = {}
FRSM.UIDEF.P_CENTERS = {
    empty_joker = {
        unlocked = true, discovered = true, cost = 0, name = "Empty Joker", pos = { x = 0, y = 0 }, set = "Joker",
        config = {}, key = "j_frs_empty_joker", order = 1, rarity = 1, alerted = true, frsm_empty_card = true,
    },
    empty_voucher = {
        unlocked = true, discovered = true, cost = 0, name = "Empty Voucher", pos = { x = 1, y = 0 }, set = "Voucher",
        config = {}, key = "v_frs_empty_voucher", order = 2, rarity = 1, alerted = true, frsm_empty_card = true,
    },

    empty_pack = {
        unlocked = true, discovered = true, cost = 0, name = "Empty Pack", pos = { x = 2, y = 0 }, set = "Booster",
        config = {}, key = "p_frs_empty_pack", order = 3, rarity = 1, alerted = true, frsm_empty_card = true,
        weight = 1, kind = "Empty",
    },
}


FRSM.overrides.card.init = Card.init
function Card.init(self, X, Y, W, H, card, center, params)
    FRSM.overrides.card.init(self, X, Y, W, H, card, center, params)

    -- Remove card from game context
    if center.frsm_empty_card then
        for i, v in ipairs(G.I.CARD or {}) do if self == v then table.remove(G.I.CARD, i) end end
    end
end


FRSM.overrides.card.set_sprites = Card.set_sprites
function Card.set_sprites(self, _center, _front)
    -- Override empty card sprites
    if not self.config.center.frsm_empty_card then
        FRSM.overrides.card.set_sprites(self, _center, _front)

        return
    end


    if _front then
        local _atlas, _pos = get_front_spriteinfo(_front)
        if self.children.front then
            self.children.front.atlas = _atlas
            self.children.front:set_sprite_pos(_pos)
        else
            self.children.front = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, _atlas, _pos)
            self.children.front.states.hover = self.states.hover
            self.children.front.states.click = self.states.click
            self.children.front.states.drag = self.states.drag
            self.children.front.states.collide.can = false
            self.children.front:set_role({major = self, role_type = 'Glued', draw_major = self})
        end
    end

    if _center then
        if _center.set then
            if self.children.center then
                self.children.center.atlas = G.ASSET_ATLAS['frs_frsm_empty_card']
                self.children.center:set_sprite_pos(_center.pos)
            else
                self.children.center = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, _center.atlas or G.ASSET_ATLAS['frs_frsm_empty_card'], _center.pos)

                self.children.center.states.hover = self.states.hover
                self.children.center.states.click = self.states.click
                self.children.center.states.drag = self.states.drag
                self.children.center.states.collide.can = false
                self.children.center:set_role({ major = self, role_type = 'Glued', draw_major = self })
            end
        end

        if not self.children.back then
            self.children.back = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS["centers"], G.P_CENTERS['b_red'].pos)
            self.children.back.states.hover = self.states.hover
            self.children.back.states.click = self.states.click
            self.children.back.states.drag = self.states.drag
            self.children.back.states.collide.can = false
            self.children.back:set_role({major = self, role_type = 'Glued', draw_major = self})
        end
    end
end


FRSM.overrides.card.draw = Card.draw
function Card.draw(self, layer)
    if not self.config.center.frsm_empty_card then
        FRSM.overrides.card.draw(self, layer)

        return
    end

    layer = layer or 'both'
    self.hover_tilt = 0

    if not self.states.visible then return end
    if layer == 'shadow' then return end
    if layer ~= 'card' and layer ~= 'both' then return end

    if self.children.focused_ui then self.children.focused_ui:draw() end

    self.tilt_var = self.tilt_var or {mx = 0, my = 0, dx = self.tilt_var.dx or 0, dy = self.tilt_var.dy or 0, amt = 0}

    -- Draw buttons

    -- Draw front
    self.children.center:draw_shader('dissolve')
    if self.children.front then self.children.front:draw_shader('dissolve') end

    -- Draw children
    for k, v in pairs(self.children) do
        if k ~= 'focused_ui' and k ~= "front" and k ~= "back" and k ~= "center" and k~= "shadow" and k ~= 'price' and k ~= 'h_popup' then v:draw() end
    end


    add_to_drawhash(self)
    Card.draw_boundingrect(self)
end


FRSM.overrides.card.hover = Card.hover
function Card.hover(self)
    if not self.config.center.frsm_empty_card then
        FRSM.overrides.card.hover(self)

        return
    end

    self:juice_up(0.05, 0.03)
    play_sound('paper1', math.random() * 0.2 + 0.9, 0.35)


    -- If this is the focused card
    if self.states.focus.is and not self.children.focused_ui then
        self.children.focused_ui = G.UIDEF.card_focus_ui(self)
    end

    if self.facing == 'front' and (not self.states.drag.is or G.CONTROLLER.HID.touch) and not self.no_ui and not G.debug_tooltip_toggle then
        self.ability_UIBox_table = FRSM.UIDEF.empty_card_h_popup_ui_table(self.config.center)
        self.config.h_popup = FRSM.UIDEF.empty_card_h_popup(self)
        self.config.h_popup_config = self:align_h_popup()

        Node.hover(self)
    end
end
