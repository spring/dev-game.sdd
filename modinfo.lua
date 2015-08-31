--http://springrts.com/wiki/Modinfo.lua
local modinfo = {
	name = "Dev Test Game",
	shortname = "DTG",
	game = "DTG",
	shortgame = "DTG",
	description = "Basic game to help engine devs testing stuff",
	url = "https://github.com/spring/springdevgame",
	version = "$VERSION", --when zipping .sdz for releasing make this a full integer like 1,2,3
	modtype = 1,
	depend = {
		"cursors.sdz",
	}
}
return modinfo
