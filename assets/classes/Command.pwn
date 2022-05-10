CMD:vehicle(playerid)
{
    new Float:x, Float:y, Float:z, Float:angle;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, angle);
    CreateVehicle(522, x, y, z, angle, 1, 1, 0, 1);
    return 1;
}