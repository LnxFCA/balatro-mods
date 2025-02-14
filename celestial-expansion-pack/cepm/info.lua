---@type LnxFCA.UIDEF.AboutTabArgs
return {
    title = CEPM.mod.name,
    author = CEPM.mod.author,
    description = localize('cepm_loc').mod_description,
    version = CEPM.mod.version,
    links = {
        { label = 'GitHub', link = 'https://github.com/LnxFCA/balatro-mods', bg_colour = HEX("FFFFFF"), fg_colour = G.C.UI.TEXT_DARK, },
        { label = 'NexusMods', link = 'https://www.nexusmods.com/balatro/mods/240', bg_colour = G.C.ORANGE, },
    },
    updates = "https://www.nexusmods.com/balatro/mods/240",
    documentation = {
        {
            label = "Usage Guide",
            link = 'https://github.com/LnxFCA/balatro-mods/tree/main/celestial-expansion-pack#usage',
            fg_colour = G.C.BLUE,
        },
        {
            label = "Update Guide",
            link = 'https://github.com/LnxFCA/balatro-mods#updating',
            fg_colour = G.C.GREEN,
        },
    },
}
