//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ lina ]--------------------------------------------------//
//----------------------------------------------------*------------------------------------------------------//
//----[                                                                                                 ]----//
//----[         |||||             |||||                       ||||||||||       ||||||||||               ]----//
//----[        ||| |||           ||| |||                      |||     ||||     |||     ||||             ]----//
//----[       |||   |||         |||   |||                     |||       |||    |||       |||            ]----//
//----[       ||     ||         ||     ||                     |||       |||    |||       |||            ]----//
//----[      |||     |||       |||     |||                    |||     ||||     |||     ||||             ]----//
//----[      ||       ||       ||       ||     __________     ||||||||||       ||||||||||               ]----//
//----[     |||       |||     |||       |||                   |||    |||       |||                      ]----//
//----[     ||         ||     ||         ||                   |||     ||       |||                      ]----//
//----[    |||         |||   |||         |||                  |||     |||      |||                      ]----//
//----[    ||           ||   ||           ||                  |||      ||      |||                      ]----//
//----[   |||           ||| |||           |||                 |||      |||     |||                      ]----//
//----[  |||             |||||             |||                |||       |||    |||                      ]----//
//----[                                                                                                 ]----//
//----------------------------------------------------*------------------------------------------------------//

// Opis:
/*

*/


// Notatki skryptera:
/*
	
*/

CMD:lina(playerid, cmdtext[])
{
    if(IsAMedyk(playerid) || IsACop(playerid))
    {
        if((OnDuty[playerid] == 1 || JobDuty[playerid] == 1) && IsPlayerInAnyVehicle(playerid) && IsAHeliModel(GetVehicleModel(playerid)) && GetPVarInt(playerid,"roped") == 0)
        {
            if(GetPlayerVehicleSeat(playerid) == 0) return ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", "Jeste� pilotem! Tylko pasa�erowie mog� spu�ci� si� po linie."); 
        
            new sendername[MAX_PLAYER_NAME], string[144];
            GetPlayerName(playerid, sendername, sizeof(sendername));
            GetPlayerPos(playerid,pl_pos[playerid][0],pl_pos[playerid][1],pl_pos[playerid][2]);
            pl_pos[playerid][4] = floatsub(pl_pos[playerid][2],pl_pos[playerid][3]);
            if(pl_pos[playerid][4] > ROPELENGTH) return ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", "Jeste� zbyt wysoko by opu�ci� si� na linie."); 
            if(pl_pos[playerid][4] < 15) return ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", "Jeste� zbyt nisko by opu�ci� si� na linie."); 
            RemovePlayerFromVehicle(playerid);
            SetPVarInt(playerid,"roped",1);
            SetPlayerPos(playerid,pl_pos[playerid][0],pl_pos[playerid][1],floatsub(pl_pos[playerid][2],2));
            SetPlayerVelocity(playerid,0,0,0);
            GameTextForPlayer(playerid, "~n~~n~~n~~b~Opuszczasz sie na linie!~n~~g~Aby zakonczyc wcisnij LPM!", 3000, 5);
            format(string, sizeof(string), "* %s opuszcza si� na linie z helikoptera.", sendername);
            ProxDetector(60.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            for(new i=0;i!=10;i++) ApplyAnimation(playerid,"ped","abseil",2.0,0,0,0,1,0);
            for(new i=0;i<=pl_pos[playerid][4];i++)
            {
                r0pes[playerid][i] = CreateDynamicObject(3004,pl_pos[playerid][0],pl_pos[playerid][1],floatadd(pl_pos[playerid][3],i),87.640026855469,342.13500976563, 350.07507324219);
            }
            SetTimerEx("syncanim",DUR,0,"i",playerid);
        }
        else
        {
            return ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", "Nie jeste� w uprawnionym helikopterze, na s�u�bie lub opuszczasz si� ju� na linie!"); 
        }
    }
	return 1;
}