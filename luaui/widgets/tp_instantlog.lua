--check here to see if a better solution is found:
--http://springrts.com/phpbb/viewtopic.php?f=23&t=27057
--http://springrts.com/mantis/view.php?id=2796

function widget:GetInfo()
  return {
    name      = "instant log",
    desc      = "write console to file (instantlog.txt) without buffering",
    author    = "knorke",
    date      = "Nov 2011",
    license   = "GNU GPL, v2 or later or horse",
    layer     = 0,
    enabled   = true,
  }
end

local logfile = nil
function widget:AddConsoleLine(msg, priority)
	if (not Spring.IsCheatingEnabled()) then return end
	writelog (msg)
end

function writelog (text)
	local logfile_fn = "instantlog.txt"
	if (logfile==nil) then
		logfile = io.open (logfile_fn, "w")
		--if (not logfile) then Spring.Echo ("could not open " .. logfile_fn) end
	end
	logfile:write (text .. "\n")	
	logfile:flush()
end

function widget:Initialize()
	writelog ("instantlog active!")
end