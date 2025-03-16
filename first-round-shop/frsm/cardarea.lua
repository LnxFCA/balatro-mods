FRSM.UIDEF.CardArea = CardArea:extend()

--- Override can_highlight
---@param self BALATRO_T.CardArea
---@param card BALATRO_T.Card
function FRSM.UIDEF.CardArea.can_highlight(self, card)
    local ckey = card.config.center.key

    if ckey == 'empty_joker' or ckey == 'empty_voucher' or ckey == 'empty_pack' then return false end

    return CardArea.can_highlight(self, card)
end
