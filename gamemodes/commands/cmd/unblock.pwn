//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ unblock ]------------------------------------------------//
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

YCMD:unblock(playerid, params[], help)
{
	new string[128];

    if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		if(isnull(params))
		{
			sendTipMessage(playerid, "U�yj /unblock [nick]");
			return 1;
		}
		new unblock_val = MruMySQL_Unblock(params, playerid);
        if(unblock_val == 0)
        {
			sendErrorMessage(playerid, sprintf("Nie uda�o si� unblockowa� gracza %s ! (b��d SQL)", params));
        }
		else if(unblock_val == 1)
        {
    		format(string, sizeof(string), "Administrator %s nada� unblocka na posta� %s", GetNickEx(playerid), params);
            //SendPunishMessage(string);
            ABroadCast(COLOR_YELLOW,string,1);
            Log(punishmentLog, INFO, "Admin %s odblokowa� %s", GetPlayerLogName(playerid), params);
        }
		else
		{
			sendErrorMessage(playerid, sprintf("Nie uda�o si� unblockowa� gracza %s ! (posta� nie istnieje)", params));
		}
	}
	return 1;
}
