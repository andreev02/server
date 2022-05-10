#define MAX_PLAYER_PASSWORD_LENGHT 18


enum E_PLAYER 
{
	E_PLAYER_ID,
	E_PLAYER_SKIN,
	Float:E_PLAYER_HEALTH,
	Float:E_PLAYER_ARMOUR,
	bool:E_PLAYER_ISLOGGED
}



new gPlayer[MAX_PLAYERS][E_PLAYER];
const DEFAULT_KICK_DELAY = 1000;



stock GetPlayerCurrentName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	return name;
}

stock ClearPlayerData(playerid)
{
	gPlayer[playerid][E_PLAYER_ID] = 0;
	gPlayer[playerid][E_PLAYER_SKIN] = 0;

	gPlayer[playerid][E_PLAYER_HEALTH] = 0.0;
	gPlayer[playerid][E_PLAYER_ARMOUR] = 0.0;

	gPlayer[playerid][E_PLAYER_ISLOGGED] = false;
}

stock LoadPlayerData(playerid)
{
	cache_get_value_name_int(0, "ID", gPlayer[playerid][E_PLAYER_ID]);
	cache_get_value_name_int(0, "Skin", gPlayer[playerid][E_PLAYER_SKIN]);

	cache_get_value_name_float(0, "Health", gPlayer[playerid][E_PLAYER_HEALTH]);
	cache_get_value_name_float(0, "Armour", gPlayer[playerid][E_PLAYER_ARMOUR]);
}

stock KickPlayerWithDelay(playerid, delay)
{	
	SetTimerEx("OnPlayerKicked", delay, 0, "i", playerid);
}



forward OnPlayerKicked(playerid);
public OnPlayerKicked(playerid)
{
	Kick(playerid);
	return 1;
}

forward IsPlayerAccountCreated(playerid);
public IsPlayerAccountCreated(playerid)
{
	if(cache_num_rows() == 1)
	{
		OpenDialog(playerid, "REGISTRATION_PASSWORD", DIALOG_STYLE_PASSWORD,
			LANG_AUTORIZATION_HEADER,
			LANG_AUTORIZATION_BODY, 
			LANG_ENTER, LANG_EXIT);
		return 1;
	}
	else if(cache_num_rows() == 0)
	{
		SendClientMessage(playerid, COLOR_WHITE, LANG_ACCOUNT_IS_NOT_REGISTERED);
	}
	else 
	{
		SendClientMessage(playerid, COLOR_WHITE, LANG_DATABASE_ERROR(100));
	}
	KickPlayerWithDelay(playerid, DEFAULT_KICK_DELAY);
	
	return 0;
}

forward IsPlayerPasswordCorrect(playerid, const password[]);
public IsPlayerPasswordCorrect(playerid, const password[])
{
	if(cache_num_rows() == 1)
	{
		new account_password[MAX_PLAYER_PASSWORD_LENGHT];
		cache_get_value_name(0, "Password", account_password);

		if(strcmp(password, account_password, false) == 0)
		{
			gPlayer[playerid][E_PLAYER_ISLOGGED] = true;

			LoadPlayerData(playerid);

			DeletePVar(playerid, "TryPassword");
			SpawnPlayer(playerid);
		}
		else
		{
			SetPVarInt(playerid, "TryPassword", GetPVarInt(playerid, "TryPassword") + 1);
			
			if(GetPVarInt(playerid, "TryPassword") == 3)
			{
				SendClientMessage(playerid, COLOR_RED, LANG_AUTORIZATION_FAILED);
				KickPlayerWithDelay(playerid, DEFAULT_KICK_DELAY);
			}
			else
			{
				OpenDialog(playerid, "REGISTRATION_PASSWORD", DIALOG_STYLE_PASSWORD,
					LANG_AUTORIZATION_HEADER,
					LANG_AUTORIZATION_BODY_INCORRECTPASSWORD(3 - GetPVarInt(playerid, "TryPassword")),
					LANG_ENTER, LANG_EXIT);
			}

			return 0;
		}

		return 1;
	}
	else if(cache_num_rows() == 0)
	{
		SendClientMessage(playerid, COLOR_WHITE, LANG_ACCOUNT_IS_NOT_REGISTERED);
	}
	else 
	{
		SendClientMessage(playerid, COLOR_WHITE, LANG_DATABASE_ERROR(100));
	}
	KickPlayerWithDelay(playerid, DEFAULT_KICK_DELAY);
	
	return 0;
}



public OnPlayerConnect(playerid)
{
	new query[128];
	format(query, sizeof(query), "SELECT * FROM `Players` WHERE `Name` = '%s'", GetPlayerCurrentName(playerid));
	mysql_tquery(gDataBaseHandler, query, "IsPlayerAccountCreated", "i", playerid);

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	ClearPlayerData(playerid);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 19228.2783, 1343.3572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid))
	{
		return 1;
	}

	if(!gPlayer[playerid][E_PLAYER_ISLOGGED]) 
	{
		Kick(playerid);
		return 0;
	}

	SetPlayerSkin(playerid, gPlayer[playerid][E_PLAYER_SKIN]);

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