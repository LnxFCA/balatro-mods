FRSM.UIDEF.EmptyCard = Moveable:extend()

FRSM.UIDEF.EmptyCard.P_CENTER = {
    empty_joker = {
        unlocked = true, discoverd = true, cost = 0, name = "Empty Joker", pos = { x = 0, y = 0 }, set = "Joker",
        config = {},
    },
    empty_voucher = {
        unlocked = true, discoverd = true, cost = 0, name = "Empty Voucher", pos = { x = 1, y = 0 }, set = "Voucher",
        config = {},
    },

    empty_pack = {
        unlocked = true, discoverd = true, cost = 0, name = "Empty Pack", pos = { x = 2, y = 0 }, set = "Booster",
        config = {},
    },
}


function FRSM.UIDEF.EmptyCard.init(self, X, Y, W, H, center)
    Moveable.init(self, X, Y, W, H)

    self.CT = self.VT
    self.config = { card = {}, center = center, }

    self.tilt_var = {mx = 0, my = 0, dx = 0, dy = 0, amt = 0}
    self.ambient_tilt = 0.2

    self.states.collide.can = true
    self.states.hover.can = true
    self.states.drag.can = false
    self.states.click.can = true

    self.children = {}
    self.cost = 0
    self.base_cost = 0

    self.children.shadow = Moveable(0, 0, 0, 0)
    self.unique_val = 1-self.ID / 1603301
    self.edition = nil

    self:set_ability(center, false)
    self:set_base(self.config.card, true)

    self.facing = 'front'
    self.sprite_facing = 'front'
    self.flipping = nil
    self.area = nil
    self.highlighted = false
    self.click_timeout = 0.3
    self.T.scale = 0.95
    self.debuff = false

    self.rank = nil
    self.added_to_deck = nil

    if self.children.front then self.children.front.VT.w = 0 end
    self.children.back.VT.w = 0
    self.children.center.VT.w = 0

    if self.children.front then self.children.front.parent = self; self.children.front.layered_parallax = nil end
    self.children.back.parent = self; self.children.back.layered_parallax = nil
    self.children.center.parent = self; self.children.center.layered_parallax = nil

    self:set_cost()
end


function FRSM.UIDEF.EmptyCard.set_ability(self, center, delay_sprites)
    self.config.center = center
    self.sticker_run = nil
    self.ability = {}

    if delay_sprites then
        G.E_MANAGER:add_event(Event({
            func = function()
                if not self.REMOVED then self:set_sprites(center) end

                return true
            end
        }))
    else
        self:set_sprites(center)
    end
end


function FRSM.UIDEF.EmptyCard.set_sprites(self, _center, _front)
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
                print("Here..")
                self.children.center = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS['frs_frsm_empty_card'], self.config.center.pos)

                self.children.center.states.hover = self.states.hover
                self.children.center.states.click = self.states.click
                self.children.center.states.drag = self.states.drag
                self.children.center.states.collide.can = false
                self.children.center:set_role({major = self, role_type = 'Glued', draw_major = self})
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


function FRSM.UIDEF.EmptyCard.set_base(self, card, _)
    card = card or {}
    self.config.card = card

    if next(card) then self:set_sprites(nil, card) end

    self.base = {
        name = self.config.card.name,
    }
end


function FRSM.UIDEF.EmptyCard.draw(self, layer)
    layer = layer or 'both'
    self.hover_tilt = 0
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


function FRSM.UIDEF.EmptyCard.hover(self)
    self:juice_up(0.05, 0.03)


    --if this is the focused card
    if self.states.focus.is and not self.children.focused_ui then
        self.children.focused_ui = G.UIDEF.card_focus_ui(self)
    end

    if self.facing == 'front' and (not self.states.drag.is or G.CONTROLLER.HID.touch) and not self.no_ui and not G.debug_tooltip_toggle then
        -- self.config.h_popup = G.UIDEF.card_h_popup(self)
        -- self.config.h_popup_config = self:align_h_popup()

        Node.hover(self)
    end
end


function FRSM.UIDEF.EmptyCard.click(self) FRSM.callbacks.open_card_selector(self.config.center.set) end


FRSM.UIDEF.EmptyCard.set_card_area = Card.set_card_area
FRSM.UIDEF.EmptyCard.juice_up = Card.juice_up
FRSM.UIDEF.EmptyCard.stop_hover = Card.stop_hover
FRSM.UIDEF.EmptyCard.set_cost = Card.set_cost
FRSM.UIDEF.EmptyCard.highlight = Card.highlight
