---@meta


---@class LnxFCA.UIDEF.OptionToggleArgs
---@field ref_table table
---@field ref_value string
---@field inactive_colour BALATRO_T.UIDef.Config.Colour? Inactive color
---@field active_colour BALATRO_T.UIDef.Config.Colour? Active color
---@field callback fun() Function to call when the toggle state changes
---@field info (string[] | string)? Toggle description
---@field label string Toggle label

---@class LnxFCA.UIDEF.MultineTextArgs
---@field colour BALATRO_T.UIDef.Config.Colour? Text color
---@field align BALATRO_T.UIDef.Config.Align? Container align value
---@field scale number? Text scale number
---@field padding number? Container padding value
---@field col number? Type of container, e.g. G.UIT.R or G.UIT.C


---@class LnxFCA.UIDEF.AboutTabArgs
---@field author string[] Mod author (from mod.autor)
---@field developed_by string? Developer by text replacement
---@field documentation LNXFCA.UIDEF.OpenButtonArgs[] Links to generate button for
---@field description string Formatted mod description
---@field title string Mod title (from mod.name)
---@field version string Mod version (from mod.version)
---@field links LNXFCA.UIDEF.OpenButtonArgs[] External mod links to create buttons for, e.g. GitHub
---@field copyright? string Bottom-left copyright notice
---@field updates string Updates and more info page

---@class LNXFCA.UIDEF.OpenButtonArgs
---@field link string Link to open in browser
---@field label string Label of the button
---@field bg_colour BALATRO_T.UIDef.Config.Colour? Background color
---@field fg_colour BALATRO_T.UIDef.Config.Colour? Text color
---@field minw number? Container minw value
---@field minh number? Container minh value
---@field padding number? Container padding value
---@field scale number? Button label scale value
---@field r number? Container r value
---@field col number? Container type, e.g. G.UIT.C
---@field callback fun(e: BALATRO_T.UIElement | table)? A function to execute when the button is clicked


---@class LnxFCA.UIDEF
---@field config_create_option_box fun(contents: UIDef[]): UIDef Create a configuration option box
---@field config_create_option_toggle fun(args: LnxFCA.UIDEF.OptionToggleArgs): UIDef Create an option toggle (used with `config_create_option_toggle`)
---@field create_multiline_text fun(text: string | string[], args: LnxFCA.UIDEF.MultineTextArgs): UIDef[] Create multline text boxes for `text`
---@field create_about_tab fun(info: LnxFCA.UIDEF.AboutTabArgs): UIDef Create mod about tab
---@field create_coloured_text fun(text: string, args: LnxFCA.UIDEF.MultineTextArgs): UIDef Create a colorized text fragment
---@field create_spacing_box fun(args: { h: number?, w: number?, col: number?, padding: number?, colour: table? }): UIDef Create a spacing box
---@field create_open_button fun(args: LNXFCA.UIDEF.OpenButtonArgs): UIDef Create a open link button
---@field create_open_button_grid fun(rows: number, args: LNXFCA.UIDEF.OpenButtonArgs[], spacing: number?): UIDef[] Create a grid of n buttons per row.


---@class LnxFCA.Utils
---@field copy_table fun(t: table<any, any>): table Performs a deep copy of `t` and returns it.
---@field debug fun(mod_id: string, msg: string?, funcv?: string) Print debug message
---@field open_link fun(link: string): boolean? Open a link with (uses `love.system.openURL`)


---@class LnxFCA
---@field UIDEF LnxFCA.UIDEF
---@field is_mod boolean `true` if initialized as standalone
---@field utils LnxFCA.Utils Common functions used by other mods
---@field include fun(path: string, mod_id: string?) Load a file in the current context
LNXFCA = {}

--- Initialize the API
function lnxfca_common_init() end
