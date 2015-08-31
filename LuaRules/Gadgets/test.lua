function gadget:GetInfo()
	return {
		name      = "Test",
		desc      = "test gadget",
		author    = "abma",
		date      = "Sep. 2015",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true  --  loaded by default?
	}
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- synced only
if (not gadgetHandler:IsSyncedCode()) then
	return false
end

-- https://springrts.com/mantis/view.php?id=4942
function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
	Spring.Echo("game_spawn.lua: SetUnitDirection")
	Spring.SetUnitDirection(unitID, 1, 0, 0)
end

