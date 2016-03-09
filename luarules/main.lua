
Spring.Echo([[

WARNING
this custom gadget handler currently uses very ugly hacks and should not be
used in real games as it uses unsynced functions (Spring.SetConfig / Spring.GetConfig)
 --> it will desync any network game instantly
don't use it!
]])

VFS.Include("LuaGadgets/gadgets.lua",nil, VFS.BASE)

local gadgetFiles = VFS.DirList("tests", "*.lua", VFSMODE)
local CONFIGVAR = "CurrentTest"
local currentTest = Spring.GetConfigString(CONFIGVAR)

if not VFS.FileExists(currentTest, VFSMODE) then
    currentTest = ""
end
local currentGadget

local SEC = "tests"

function gadgetHandler:StartTest(testfile)
	currentTest = testfile
	Spring.Echo("Starting test " .. testfile)
	Spring.SetConfigString(CONFIGVAR, testfile)
	currentGadget = self:LoadGadget(testfile)
	if not (currentGadget) then
		Spring.Log(SEC, LOG.ERROR, "Test is disabled: ".. testfile)
		return false
	end
	currentGadget.TestDone = gadgetHandler.TestDone
	Spring.Log(SEC, LOG.INFO, "Loaded Gadget test " .. testfile)
	gadgetHandler:InsertGadget(currentGadget)
	return true
end

function gadgetHandler:NextTest()
	local found = false
	for k,gf in ipairs(gadgetFiles) do
		if found or currentTest == "" then
			if gadgetHandler:StartTest(gf) then
				return
			end
		end
		if gf == currentTest then
			found = true
		end
	end
	Spring.SetConfigString(CONFIGVAR,"")
	Spring.Echo("All tests run, exiting!")
	Spring.SendCommands("quitforce")
end

function gadgetHandler:TestDone(result, msg)
	if result then
		Spring.Echo("Test " .. currentTest .. " is fine: " .. msg)
	else
		Spring.Log(SEC, LOG.ERROR, "Test " .. currentTest .. " failed: " .. msg)
	end

	gadgetHandler:RemoveGadget(currentGadget)
	gadgetHandler:NextTest()
end

if currentTest == "" then
	gadgetHandler:NextTest(currentTest)
else
	gadgetHandler:StartTest(currentTest)
end

