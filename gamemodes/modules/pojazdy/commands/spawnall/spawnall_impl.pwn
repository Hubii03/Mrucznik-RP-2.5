//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  spawnall                                                 //
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
// Autor: mrucznik
// Data utworzenia: 02.06.2020


//

//------------------<[ Implementacja: ]>-------------------
command_spawnall_Impl(playerid)
{
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
		new veh = PlayerInfo[playerid][pCars][i];
        if(veh != 0)
        {
            if(CarData[veh][c_ID] != 0) continue;

            Car_Spawn(veh);
            Log(serverLog, INFO, "Gracz %s zespawnował pojazd %s", GetPlayerLogName(playerid), GetVehicleLogName(veh));
        }
    }
    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wszystkie pojazdy zespawnowane!");
    return 1;
}

//end