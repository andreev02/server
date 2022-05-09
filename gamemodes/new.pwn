#include <a_samp>


#include "../include/streamer"
#include "../include/sscanf2"
#include "../include/foreach"
#include "../include/crashdetect"
#include "../include/a_mysql"
#include "../include/dc_cmd"
#include "../include/progress"


#include "../assets/assets.pwn"


main() { }


public OnGameModeInit()
{
	SetGameModeText("Blank Script");
	return 1;
}

public OnGameModeExit()
{
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