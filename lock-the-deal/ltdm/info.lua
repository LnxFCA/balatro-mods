---@type LnxFCA.UIDEF.AboutTabArgs
return {
    title = LTDM.mod.name,
    author = LTDM.mod.author,
    description = localize('ltd_mod_description'),
    version = LTDM.mod.version,
    links = {
        { label = 'GitHub', link = 'https://github.com/LnxFCA/balatro-mods', bg_colour = HEX("FFFFFF"), fg_colour = G.C.UI.TEXT_DARK, },
        { label = 'NexusMods', link = 'https://www.nexusmods.com/balatro/mods/183', bg_colour = G.C.ORANGE, },
    },
    updates = {
        check_url = 'https://github.com/LnxFCA/balatro-mods/raw/refs/heads/release/first-round-joker/VERSION',
        download_page = 'https://www.nexusmods.com/balatro/mods/183',
    },
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
