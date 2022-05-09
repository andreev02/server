enum E_PLAYER 
{
	E_PLAYER_ID,
	E_PLAYER_SKIN,
	E_PLAYER_HEALTH,
	E_PLAYER_ARMOUR,
}

new gPlayer[MAX_PLAYERS][E_PLAYER];



stock GetPlayerCurrentName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	return name;
}

stock GetPlayerAccountID(playerid)
{
	new query[128], Cache:cache;
	format(query, sizeof(query), "SELECT `ID` FROM `Players` WHERE `Name` = '%s'", GetPlayerCurrentName(playerid));
	cache = mysql_query(gDataBaseHandler, query, true);

	if(cache_num_rows() == 1)
	{
		new account_id;
		cache_get_value_name_int(0, "ID", account_id);
		return account_id;
	}

	cache_delete(cache);
	return 0;
}



forward PlayerKick(playerid);
public PlayerKick(playerid)
{
	Kick(playerid);
	return 1;
}



public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 19228.2783, 1343.3572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(!GetPlayerAccountID(playerid)) 
	{
		SendClientMessage(playerid, COLOR_WHITE, LANG_ACCOUNT_IS_NOT_REGISTERED);
		return SetTimerEx("PlayerKick", 1000, 0, "i", playerid);
	}

	OpenDialog(playerid, "REGISTRATION_PASSWORD", DIALOG_STYLE_PASSWORD,
		LANG_REGISTRATION,
		"Test", 
		LANG_ENTER, LANG_EXIT);

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}