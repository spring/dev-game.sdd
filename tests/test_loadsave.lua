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

