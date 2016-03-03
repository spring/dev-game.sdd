--check here to see if a better solution is found:
--http://springrts.com/phpbb/viewtopic.php?f=23&t=27057
--http://springrts.com/mantis/view.php?id=2796

function gadget:GetInfo()
  return {
    name      = "test_save-load",
    desc      = "",
    author    = "abma",
    date      = "2016.03.03",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true,
  }
end

local maxframes = 100 -- max frames to run before auto exit

function gadget:Initialize()
	enabled = Spring.GetConfigInt("UseCREGSaveLoad") == 1
	if not enabled then
		Spring.Echo("UseCREGSaveLoad not enabled, enabling!")
		Spring.SetConfigInt("UseCREGSaveLoad", 1)
		assert(Spring.GetConfigInt("UseCREGSaveLoad") == 1)
	end
end

function gadget:GameFrame(n)
	--Spring.SetConfigString
	if (n == 10) then
		Spring.Echo("Saving game...")
		Spring.SendCommands("save test")
		Spring.SendCommands("savegame test")
		Spring.SendCommands("/save test")
		Spring.SendCommands("/savegame test")
	end
	if (n == 1000) then
		Spring.Reload("test.sff")
	end
end

