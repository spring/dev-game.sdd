function gadget:GetInfo()
	return {
		name      = "Test Float conversions",
		desc      = "number conversion test gadget",
		author    = "abma",
		date      = "Sep. 2016",
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
function gadget:Initialize()

	assert(tonumber("5.1") == 5.1)
	assert(tonumber("5,1") == nil)

	Spring.Echo(string.format("%f", 5.1))
	assert(string.format("%f", 5.1) == "5.0999999")

	gadget:TestDone(true, "ok")
end
