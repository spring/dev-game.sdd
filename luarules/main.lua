
VFS.Include("LuaGadgets/gadgets.lua",nil, VFS.BASE)

local TESTS_DIR = Script.GetName():gsub('US$', '') .. '/tests'
local gadgetFiles = VFS.DirList(TESTS_DIR, "*.lua", VFSMODE)
local CONFIGVAR = "CurrentTest"
local curtest = Spring.GetConfigString(CONFIGVAR)
local curgadget = nil

function gadgetHandler:StartTest(testfile)
	curtest = testfile
	Spring.Echo("Starting test " .. testfile)
	Spring.SetConfigString(CONFIGVAR, testfile)
	curgadget = gadgetHandler:LoadGadget(testfile)
	if not (curgadget) then
		Spring.Echo("error in test: " .. testfile)
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
		if found or curtest == "" then
			gadgetHandler:StartTest(gf)
			return
		end
		if gf == curtest then
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
	Spring.Echo("XXXXXXXXXXXXX Test " .. curtest .. " is done: " .. status .. " ".. msg)
--gadget.ghInfo.name
	gadgetHandler:DisableGadget(curgadget.ghInfo.name)
	gadgetHandler:NextTest()
end

--System.TestDone = function (_) gadgetHandler:TestDone(gadget)      end

if curtest == "" then
	gadgetHandler:NextTest(curtest)
else
	gadgetHandler:StartTest(curtest)
end

