function LNXFCA.UIDEF.create_multiline_text(text, args)
    text = (type(text) == 'string' and { text }) or text
    args = args or {}

    ---@type UIDef[]
    local lines = {}
    for _, v in ipairs(text --[=[@as string[]]=]) do
        table.insert(lines, {
            n = G.UIT.R,
            config = { align = args.align or "cm", minh = 0.05, padding = args.padding or 0 },
            nodes = {{
                n = G.UIT.T,
                config = {
                    text = v, colour = args.colour or G.C.TEXT_LIGHT, scale = args.scale or 0.4,
                },
            }},
        })
    end

    return lines
end


--- Create a coloured text
function LNXFCA.UIDEF.create_coloured_text(text, args)
    ---@type UIDef
    return {
        n = args.col or G.UIT.C, config = { align = args.align or "cm", padding = args.padding or 0, },
        nodes = {{ n = G.UIT.T, config = { text = text, colour = args.colour or G.C.UI.TEXT_LIGHT, scale = args.scale or 0.5, } }},
    }
end
