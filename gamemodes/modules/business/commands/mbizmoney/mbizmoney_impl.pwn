//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 mbizmoney                                                 //
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
// Autor: Simeone
// Data utworzenia: 08.02.2020


//

//------------------<[ Implementacja: ]>-------------------
command_mbizmoney_Impl(playerid)
{
    new string[256];
    if(PlayerInfo[playerid][pBusinessOwner] == INVALID_BUSINESSID)
    {
        sendErrorMessage(playerid, "Nie jeste� w�a�cicielem �adnego biznesu!"); 
        return 1;
    }
    if(PlayerMoneyFromBiz[playerid] == 0)
    {
        sendErrorMessage(playerid, "Nie przewozisz �adnej got�wki!"); 
        return 1;
    }
    Log(businessCashLog, INFO, "Gracz %s bezpiecznie dowiozl i otrzymal $%d z biznesu %s", GetPlayerLogName(playerid), PlayerMoneyFromBiz[playerid], GetBusinessLogName(PlayerInfo[playerid][pBusinessOwner]));
    format(string, sizeof(string), "%s bezpiecznie dowozi i wp�aca do banku $%d.", GetNick(playerid), PlayerMoneyFromBiz[playerid]);
	ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE); 
    DajKase(playerid, PlayerMoneyFromBiz[playerid]); 
    PlayerMoneyFromBiz[playerid] = 0; 
    return 1;
}

//end