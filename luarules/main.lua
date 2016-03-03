
VFS.Include("LuaGadgets/gadgets.lua",nil, VFS.BASE)

local TESTS_DIR = Script.GetName():gsub('US$', '') .. '/tests'
local gadgetFiles = VFS.DirList(TESTS_DIR, "*.lua", VFSMODE)
local CONFIGVAR = "CurrentTest"
local curtest = Spring.GetConfigString(CONFIGVAR)


function gadgetHandler:StartTest(testfile)
	Spring.Echo("Starting test " .. testfile)
	Spring.SetConfigString(CONFIGVAR, testfile)
	self:LoadGadget(testfile)
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
	Spring.Echo("Test " .. curtest .. " is done: " .. result .. msg)
	gadgetHandler:NextTest()
end

-- how to register gadgetHandler:TestDone() so it can be called from gadgets?

System.TestDone = function (_) self:TestDone(gadget)      end

if curtest == "" then
	gadgetHandler:NextTest(curtest)
else
	gadgetHandler:StartTest(curtest)
end

