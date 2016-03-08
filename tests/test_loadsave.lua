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
gametype=devgame $VERSION;
ishost=1;
mapname=DeltaSiegeDry;
myplayername=UnnamedPlayer;
savefile=devgame.ssf;
}


]]

function gadget:GameFrame(n)
	--Spring.SetConfigString
	if (n == 10) then
		Spring.Echo("Saving game...")
		Spring.SendCommands("save devgame -y")
	end
	if (n == 1000) then
		Spring.Reload(script)
	end
end

