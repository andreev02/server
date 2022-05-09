public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

Dialog:REGISTRATION_PASSWORD(playerid, response, listitem, inputtext[])
{
	if (!response) return Kick(playerid);
	return 1;
}