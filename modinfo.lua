-- http://springrts.com/wiki/Modinfo.lua
local modinfo = {
	name = "devgame",
	shortname = "dg",
	game = "dg",
	shortgame = "dg",
	description = "Basic game to help engine devs testing stuff",
	url = "https://github.com/spring/devgame.sdd",
	version = "$VERSION", --when zipping .sdz for releasing make this a full integer like 1,2,3
	modtype = 1,
	depend = {
		"cursors.sdz",
	}
}
return modinfo
