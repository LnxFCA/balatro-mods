---@meta

---@class LnxFCA.UIDEF.OptionToggleArgs
---@field ref_table table
---@field ref_value string
---@field inactive_colour BALATRO_T.UIDef.Config.Colour?
---@field active_colour BALATRO_T.UIDef.Config.Colour?
---@field callback fun()
---@field info (string[] | string)?
---@field label string

---@class LnxFCA.UIDEF
---@field config_create_option_box fun(contents: UIDef[]): UIDef
---@field config_create_option_toggle fun(args: LnxFCA.UIDEF.OptionToggleArgs): UIDef


---@class LnxFCA.Utils
---@field copy_table fun(t: table<any, any>): table Performs a deep copy of `t` and returns it.
---@field debug fun(mod_id: string, msg: string?, funcv?: string) Print debug message


---@class LnxFCA
---@field UIDEF LnxFCA.UIDEF
---@field is_mod boolean
---@field utils LnxFCA.Utils
---@field include fun(path: string, mod_id: string?) Load a file in the current context.
LNXFCA = {}

function lnxfca_common_init() end
