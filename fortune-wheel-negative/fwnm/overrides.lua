LNXFCA.INJECT:add('save_run', {
    order = 5,
    before = true,
    func = function()
        if FWNM.state.saved or G.F_NO_SAVING or G.STATE == G.STATES.SELECTING_HAND then return end

        print("Saving mod configuration...")
        FWNM.state:save(FWNM.mod)
    end,
})


LNXFCA.INJECT:add('start_run', {
    order = 5,
    before = true,

    ---@param args BALATRO.Game.RunArgs
    func = function(args)
        FWNM.state = FWNM.mt.State()

        print("Running at run start")

        -- Load saved state
        if args and args.savetext then
            print("Loading saved state")
            FWNM.state:load(FWNM.mod.config.state) end
    end,
})
