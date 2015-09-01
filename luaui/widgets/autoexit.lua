--check here to see if a better solution is found:
--http://springrts.com/phpbb/viewtopic.php?f=23&t=27057
--http://springrts.com/mantis/view.php?id=2796

function widget:GetInfo()
  return {
    name      = "fast exit",
    desc      = "exit spring-headless after 1000 frames",
    author    = "abma",
    date      = "1.9.2015",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true,
  }
end

local maxframes = 100 -- max frames to run before auto exit

function widget:GameFrame(n)
	if (n == maxframes) then
		Spring.Echo("maxframes reached, exiting...")
		Spring.SendCommands("quitforce")
	end
end

