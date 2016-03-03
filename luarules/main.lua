
VFS.Include("LuaGadgets/gadgets.lua",nil, VFS.BASE)

local TESTS_DIR = Script.GetName():gsub('US$', '') .. '/tests'
local gadgetFiles = VFS.DirList(TESTS_DIR, "*.lua", VFSMODE)
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
		Spring.Echo("Error in test: " .. testfile)
		Spring.SendCommands("forcequit")
		return
	end
	--curgadget.TestDone = function (result, msg) self:TestDone(result, msg)      end
	currentGadget.TestDone = gadgetHandler.TestDone
	Spring.Log(SEC, LOG.INFO, "Loaded Gadget test " .. testfile)
	gadgetHandler:InsertGadget(currentGadget)
end

function gadgetHandler:NextTest()
	local found = false
	for k,gf in ipairs(gadgetFiles) do
		if found or currentTest == "" then
			gadgetHandler:StartTest(gf)
			return
		end
		if gf == currentTest then
			found = true
		end
	end
	Spring.SetConfigString(CONFIGVAR,"")
	Spring.Echo("All tests run, exiting!")
	Spring.SendCommands("forcequit")
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

