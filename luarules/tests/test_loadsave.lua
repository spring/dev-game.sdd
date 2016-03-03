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

function gadget:GameFrame(n)
	--Spring.SetConfigString
	if (n == 10) then
		Spring.Echo("Saving game...")
		Spring.SendCommands("save test")
		Spring.Restart("test.sff")
	end
end

