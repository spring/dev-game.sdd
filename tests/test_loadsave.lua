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
gametype=%s;
mapname=%s;
myplayername=UnnamedPlayer;
savefile=devgame.ssf;
}
]]

LOADTESTCONFIGVAR = "TestSaveLoadStatus"
script = string.format(script, Game.gameName .. " " .. Game.gameVersion, Game.mapName) --set current

local status = Spring.GetGameRulesParam(LOADTESTCONFIGVAR) or 0
local stopframe = 10

function gadget:GameFrame(n)
	if (n == stopframe) then
		if status == 0 then -- before save
			Spring.Echo("Saving game...")
			Spring.SetGameRulesParam(LOADTESTCONFIGVAR, 1)
			Spring.SendCommands("save devgame -y")
			Spring.Echo(script)
			Spring.Reload(script)
			return
		else -- after save
			assert(Spring.GetGameFrame() == stopframe) -- gameframe has to be the same as the loaded frame
			gadget:TestDone(true, "ok")
		end
	end
	if (n > stopframe) then
		gadget:TestDone(false, "test failed")
	end
end

