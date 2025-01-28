---@type LnxFCA.UIDEF.AboutTabArgs
return {
    title = LTDM.mod.name,
    author = LTDM.mod.author,
    description = localize('ltd_mod_description'),
    version = LTDM.mod.version,
    links = {
        { label = 'GitHub', link = 'https://github.com/LnxFCA/balatro-mods', bg_colour = HEX("FFFFFF"), fg_colour = G.C.UI.TEXT_DARK, },
        { label = 'NexusMods', link = 'https://www.nexusmods.com/balatro/mods/191', bg_colour = G.C.ORANGE, },
    },
    updates = "https://www.nexusmods.com/balatro/mods/191",
    documentation = {
        {
            label = "Usage Guide",
            link = 'https://github.com/LnxFCA/balatro-mods/tree/main/lock-the-deal#usage',
            fg_colour = G.C.BLUE,
        },
        {
            label = "Update Guide",
            link = 'https://github.com/LnxFCA/balatro-mods#updating',
            fg_colour = G.C.GREEN,
        },
    },
}
