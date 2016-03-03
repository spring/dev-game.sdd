
VFS.Include("LuaGadgets/gadgets.lua",nil, VFS.BASE)

local TESTS_DIR = Script.GetName():gsub('US$', '') .. '/tests'
local gadgetFiles = VFS.DirList(TESTS_DIR, "*.lua", VFSMODE)
local CONFIGVAR = "CurrentTest"
local currentTest = Spring.GetConfigString(CONFIGVAR)

if not VFS.FileExists(currentTest, VFSMODE) then
    currentTest = ""
end
local currentGadget

function gadgetHandler:StartTest(testfile)
	currentTest = testfile
	Spring.Echo("Starting test " .. testfile)
	Spring.SetConfigString(CONFIGVAR, testfile)
	curgadget = gadgetHandler:LoadGadget(testfile)
	if not (curgadget) then
		Spring.Echo("Error in test: " .. testfile)
		return
	end
	curgadget.TestDone = function (result, msg) self:TestDone(result, msg)      end
	Spring.Echo("StartTest: Loaded Gadget")
	gadgetHandler:InsertGadget(curgadget)
	gadgetHandler:UpdateCallIns()
end

function gadgetHandler:NextTest()
	local found = false
	for k,gf in ipairs(gadgetFiles) do
		Spring.Echo(gf)
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
	Spring.SendCommands("quit")
end

function gadgetHandler:TestDone(result, msg)
	if result then
		status = "Ok"
	else
		status = "Failed"
	end
	Spring.Echo("Test " .. currentTest .. " is done: " .. status .. " ".. msg)
	Spring.Echo("")
	Spring.Echo("")
	Spring.Echo("")
	gadgetHandler:RemoveGadget(currentGadget)
	gadgetHandler:NextTest()
end

if currentTest == "" then
	gadgetHandler:NextTest(currentTest)
else
	gadgetHandler:StartTest(currentTest)
end

