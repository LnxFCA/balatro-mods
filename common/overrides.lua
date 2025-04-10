---@diagnostic disable:duplicate-set-field


LNXFCA.overrides.save_run = _G.save_run
function save_run()
    if LNXFCA.INJECT.has_run_before then
        LNXFCA.INJECT:run("save_run")
    end

    LNXFCA.overrides.save_run()

    if LNXFCA.INJECT.has_run_after then
        LNXFCA.INJECT:run("save_run", true)
    end
end


LNXFCA.overrides.Game = {}
LNXFCA.overrides.Game.start_run = Game.start_run
function Game.start_run(self, args)
    if LNXFCA.INJECT.has_run_before then
        LNXFCA.INJECT:run("start_run", false, args)
    end

    LNXFCA.overrides.Game.start_run(self, args)

    if LNXFCA.INJECT.has_run_after then
        LNXFCA.INJECT:run("start_run", true, args)
    end
end
