FRSM.UIDEF.CardArea = CardArea:extend()

--- Override can_highlight
---@param self BALATRO.CardArea
---@param card BALATRO.Card
function FRSM.UIDEF.CardArea.can_highlight(self, card)
    local ckey = card.config.center.key

    if ckey == 'j_frs_empty_joker' or ckey == 'v_frs_empty_voucher' or ckey == 'p_frs_empty_pack' then return false end

    return CardArea.can_highlight(self, card)
end
