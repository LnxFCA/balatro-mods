---@type LnxFCA.UIDEF.AboutTabArgs
return {
    title = HLUM.mod.name,
    author = HLUM.mod.author,
    description = localize('hlum_loc').mod_description,
    version = HLUM.mod.version,
    links = {
        { label = 'GitHub', link = 'https://github.com/LnxFCA/balatro-mods', bg_colour = HEX("FFFFFF"), fg_colour = G.C.UI.TEXT_DARK, },
        { label = 'NexusMods', link = 'https://www.nexusmods.com/balatro/mods/331', bg_colour = G.C.ORANGE, },
    },
    updates = "https://www.nexusmods.com/balatro/mods/331",
    documentation = {
        {
            label = "Usage Guide",
            link = 'https://github.com/LnxFCA/balatro-mods/tree/main/hermit-level-up#usage',
            fg_colour = G.C.BLUE,
        },
        {
            label = "Update Guide",
            link = 'https://github.com/LnxFCA/balatro-mods#updating',
            fg_colour = G.C.GREEN,
        },
    },
}
