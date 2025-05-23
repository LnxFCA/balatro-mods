---@meta


---@class LnxFCA.UIDEF.OptionToggleArgs
---@field ref_table table
---@field ref_value string
---@field inactive_colour BALATRO.UI.Colour? Inactive color
---@field active_colour BALATRO.UI.Colour? Active color
---@field callback fun() Function to call when the toggle state changes
---@field info (string[] | string)? Toggle description
---@field label string Toggle label


---@class LnxFCA.UIDEF.MultineTextArgs
---@field colour BALATRO.UI.Colour? Text color
---@field align BALATRO.UI.Align? Container align value
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
---@field bg_colour BALATRO.UI.Colour? Background color
---@field fg_colour BALATRO.UI.Colour? Text color
---@field minw number? Container minw value
---@field minh number? Container minh value
---@field padding number? Container padding value
---@field scale number? Button label scale value
---@field r number? Container r value
---@field col number? Container type, e.g. G.UIT.C
---@field callback fun(e: BALATRO.UIElement | table)? A function to execute when the button is clicked


---@class LNXFCA.UIDEF.ButtonArgs
---@field align? BALATRO.UI.Align
---@field col? BALATRO.UIT
---@field padding? number
---@field controller_control? string
---@field content string | BALATRO.UI.Node[]
---@field scale? number
---@field button string
---@field data? any
---@field width? number
---@field height? number
---@field fixed? boolean
---@field background? BALATRO.UI.Colour
---@field foreground? BALATRO.UI.Colour
---@field r? number
---@field hover? boolean
---@field shadow? boolean
---@field focus_args? table
---@field extra? table<string, any>


---@class LnxFCA.UIDEF
---@field config_create_option_box fun(contents: BALATRO.UI.Node[]): BALATRO.UI.Node Create a configuration option box
---@field config_create_option_toggle fun(args: LnxFCA.UIDEF.OptionToggleArgs): BALATRO.UI.Node Create an option toggle (used with `config_create_option_toggle`)
---@field create_multiline_text fun(text: string | string[], args: LnxFCA.UIDEF.MultineTextArgs): BALATRO.UI.Node[] Create multline text boxes for `text`
---@field create_about_tab fun(info: LnxFCA.UIDEF.AboutTabArgs): BALATRO.UI.Node Create mod about tab
---@field create_coloured_text fun(text: string, args: LnxFCA.UIDEF.MultineTextArgs): BALATRO.UI.Node Create a colorized text fragment
---@field create_spacing_box fun(args: { h: number?, w: number?, col: number?, padding: number?, colour: table? }): BALATRO.UI.Node Create a spacing box
---@field create_open_button fun(args: LNXFCA.UIDEF.OpenButtonArgs): BALATRO.UI.Node Create a open link button
---@field create_open_button_grid fun(rows: number, args: LNXFCA.UIDEF.OpenButtonArgs[], spacing: number?): BALATRO.UI.Node[] Create a grid of n buttons per row.
---@field create_button fun(args: LNXFCA.UIDEF.ButtonArgs): BALATRO.UI.Node Create a button
---@field generate_collection fun(pool: table[], rows: table, args: table)
---@field create_collection_box fun(args: table): BALATRO.UI.Node
---@field collection table


---@class LnxFCA.Utils
---@field debug fun(mod_id: string, msg: string?, funcv?: string) Print debug message
---@field open_link fun(link: string): boolean? Open a link with (uses `love.system.openURL`)
local Utils = {}


--- Performs a deep copy of `t` and returns it.
---@generic T
---@param t T
---@return T
Utils.copy_table = function(t) end


---@class LnxFCA.Callbacks
---@field update_collection_page fun(args: table)


---@class LnxFCA.Inject.Target
---@field order? number
---@field func function
---@field before? boolean
---@field after? boolean


---@alias LnxFCA.Inject.Table LnxFCA.Inject.Table.Base | table<string, LnxFCA.Inject.Target[][]>

---@class LnxFCA.Inject.Table.Base
---@field save_run LnxFCA.Inject.Target[][]

---@alias LnxFCA.Inject.Type
---| "save_run"
---| "start_run"


---@class LnxFCA
---@field UIDEF LnxFCA.UIDEF
---@field is_mod boolean `true` if initialized as standalone
---@field utils LnxFCA.Utils Common functions used by other mods
---@field include fun(path: string, mod_id: string?): unknown Load a file in the current context
---@field include_list fun(paths: string[], mod_id: string?) Load a list of files in the `mod_id` context
---@field callbacks LnxFCA.Callbacks
---@field overrides table<string, function | table>
---@field INJECT LnxFCA.Inject
LNXFCA = {}

--- Initialize the API
function lnxfca_common_init() end
