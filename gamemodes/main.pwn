#include <a_samp>


#include "../include/streamer"
#include "../include/sscanf2"
#include "../include/foreach"
#include "../include/crashdetect"
#include "../include/a_mysql"
#include "../include/dc_cmd"
#include "../include/progress"
#include "../include/tdw_dialog"

#include "../assets/assets.pwn"


main() { }


stock IntToStr(value)
{
	new string[11];
	valstr(string, value);
	return string;
}

stock Concat(const string1[], const string2[])
{
	new string:result[126];
	format(result, sizeof(result), "%s%s", string1, string2);
	return result;
}


public OnGameModeInit()
{
	SetGameModeText("project");
	DisableInteriorEnterExits();
	ConnectDataBase();

	return 1;
}

public OnGameModeExit()
{
	DisconnectDataBase();
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}