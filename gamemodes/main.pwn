#include <a_samp>


#include "../include/streamer"
#include "../include/sscanf2"
#include "../include/foreach"
#include "../include/crashdetect"
#include "../include/a_mysql"
#include "../include/dc_cmd"
#include "../include/progress"
#include "../include/tdw_dialog.inc"

#include "../assets/assets.pwn"


main() { }


public OnGameModeInit()
{
	SetGameModeText("project");
	DisableInteriorEnterExits();

	gDataBaseHandler = mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_BASE);
	if(mysql_errno(gDataBaseHandler) == 0) print("Database connected");
	else printf("Error #%i. Connection to database failed!", mysql_errno(gDataBaseHandler));

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