function gadget:GetInfo()
  return {
    name      = "test_save-load",
    desc      = "",
    author    = "abma",
    date      = "2016.03.03",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = false, --disabled because assert fails
  }
end

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
		Spring.SendCommands("save devgame -y")
	end
	if (n == 1000) then
		Spring.Restart("Saves/devgame.ssf", "")
	end
end

