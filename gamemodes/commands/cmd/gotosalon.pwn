//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ gotosalon ]-----------------------------------------------//
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

CMD:gotosalon(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 5 || IsAScripter(playerid))
		{
            	SetPlayerInterior(playerid, 0);
    			SetPlayerVirtualWorld(playerid, 0);
				if (GetPlayerState(playerid) == 2)
				{
					SetVehiclePos(GetPlayerVehicleID(playerid), 2129.2078,-1129.9963,25.5823);
				}
				else
				{
					SetPlayerPosEx(playerid, 2129.2078,-1129.9963,25.5823);
				}
   				sendTipMessage(playerid, "[Teleportowa�e� si� do salonu]");
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
    return 1;
}
