---@meta

---@class LnxFCA.UIDEF.OptionToggleArgs
---@field ref_table table
---@field ref_value string
---@field inactive_colour BALATRO_T.UIDef.Config.Colour?
---@field active_colour BALATRO_T.UIDef.Config.Colour?
---@field callback fun()
---@field info (string[] | string)?
---@field label string

---@class LnxFCA.UIDEF.MultineTextArgs
---@field colour BALATRO_T.UIDef.Config.Colour?
---@field align BALATRO_T.UIDef.Config.Align?
---@field scale number?
---@field padding number?
---@field col number?


---@class LnxFCA.UIDEF.AboutTabArgs
---@field author string[]
---@field developed_by string?
---@field documentation LNXFCA.UIDEF.OpenButtonArgs[]
---@field description string
---@field title string
---@field version string
---@field links LNXFCA.UIDEF.OpenButtonArgs[]
---@field copyright? string
---@field updates { check_url: string, download_page: string }


---@class LNXFCA.UIDEF.OpenButtonArgs
---@field link string
---@field label string
---@field bg_colour BALATRO_T.UIDef.Config.Colour?
---@field fg_colour BALATRO_T.UIDef.Config.Colour?
---@field minw number?
---@field minh number?
---@field padding number?
---@field scale number?
---@field r number?
---@field col number?
---@field callback fun(e: BALATRO_T.UIElement | table)?


---@class LnxFCA.UIDEF
---@field config_create_option_box fun(contents: UIDef[]): UIDef
---@field config_create_option_toggle fun(args: LnxFCA.UIDEF.OptionToggleArgs): UIDef
---@field create_multiline_text fun(text: string | string[], args: LnxFCA.UIDEF.MultineTextArgs): UIDef[]
---@field create_about_tab fun(info: LnxFCA.UIDEF.AboutTabArgs): UIDef
---@field create_coloured_text fun(text: string, args: LnxFCA.UIDEF.MultineTextArgs): UIDef
---@field create_spacing_box fun(args: { h: number?, w: number?, col: number?, padding: number?, colour: table? }): UIDef
---@field create_open_button fun(args: LNXFCA.UIDEF.OpenButtonArgs): UIDef
---@field create_open_button fun(args: LNXFCA.UIDEF.OpenButtonArgs)
---@field create_open_button_grid fun(rows: number, args: LNXFCA.UIDEF.OpenButtonArgs[], spacing: number?): UIDef[]


---@class LnxFCA.Utils
---@field copy_table fun(t: table<any, any>): table Performs a deep copy of `t` and returns it.
---@field debug fun(mod_id: string, msg: string?, funcv?: string) Print debug message
---@field open_link fun(link: string): boolean?


---@class LnxFCA
---@field UIDEF LnxFCA.UIDEF
---@field is_mod boolean
---@field utils LnxFCA.Utils
---@field include fun(path: string, mod_id: string?) Load a file in the current context.
LNXFCA = {}

function lnxfca_common_init() end
