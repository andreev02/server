public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

Dialog:REGISTRATION_PASSWORD(playerid, response, listitem, inputtext[])
{
	if (!response) return Kick(playerid);

	new query[128];
	format(query, sizeof(query), "SELECT * FROM `Players` WHERE `Name` = '%s'", GetPlayerCurrentName(playerid));
	mysql_tquery(gDataBaseHandler, query, "IsPlayerPasswordCorrect", "is", playerid, inputtext);

	return 1;
}