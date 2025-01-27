---@type LnxFCA.UIDEF.AboutTabArgs
return {
    title = FRJM.mod.name,
    author = FRJM.mod.author,
    description = localize('frj_mod_description'),
    version = FRJM.mod.version,
    links = {
        { label = 'GitHub', link = 'https://github.com/LnxFCA/balatro-mods', bg_colour = HEX("FFFFFF"), fg_colour = G.C.UI.TEXT_DARK, },
        { label = 'NexusMods', link = 'https://www.nexusmods.com/balatro/mods/105', bg_colour = G.C.ORANGE, },
    },
    updates = 'https://www.nexusmods.com/balatro/mods/105',
    documentation = {
        {
            label = "Usage Guide",
            link = 'https://github.com/LnxFCA/balatro-mods/tree/main/first-round-joker#usage',
            fg_colour = G.C.BLUE,
        },
        {
            label = "Update Guide",
            link = 'https://github.com/LnxFCA/balatro-mods#updating',
            fg_colour = G.C.GREEN,
        },
    },
}
