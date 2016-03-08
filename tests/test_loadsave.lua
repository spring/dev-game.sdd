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

local script = [[
[game]
{
[allyteam0]
{
numallies=0;
}
[modoptions]
{
maxspeed=20;
minimalsetup=1;
}
[player0]
{
name=UnnamedPlayer;
team=0;
}
[team0]
{
allyteam=0;
teamleader=0;
}
ishost=1;
gametype=;
mapname=DeltaSiegeDry;
myplayername=UnnamedPlayer;
savefile=devgame.ssf;
}

]]

-- replace gametype with current game (can't hardcode this)
script = string.gsub(script, "gametype=[^;]+;", "gametype=" .. Game.gameName .. " " .. Game.gameVersion .. ";", 1)

LOADTESTCONFIGVAR = "TestSaveLoadStatus"

local status = Spring.GetConfigInt(LOADTESTCONFIGVAR)
local stopframe = 10

function gadget:GameFrame(n)
	if (n == stopframe) then
		if status == 0 then
			Spring.Echo("Saving game...")
			Spring.SendCommands("save devgame -y")
			Spring.SetConfigInt(LOADTESTCONFIGVAR)
			--assert(Spring.GetConfigInt(LOADTESTCONFIGVAR) == 1) -- try to avoid endless loop
			Spring.Reload(script)
			return
		end
	end
	if (n > stopframe) then
		gadget:TestDone(false, "test failed")
	end
end

function gadget:Initialize()
	Spring.Echo(string.format("gadget:Initialize() status: %d", status))
	if status == 0 then -- before safe
		assert(Spring.GetGameFrame() == 0)
	else -- after safe
		Spring.SetConfigInt(LOADTESTCONFIGVAR, 0) -- reset status
		assert(Spring.GetGameFrame() == stopframe) -- gameframe has to be the same as the loaded frame
		gadget:TestDone(true, "ok")
	end
end

