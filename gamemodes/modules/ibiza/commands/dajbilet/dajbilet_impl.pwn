//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  dajbilet                                                 //
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
// Autor: Sanda�
// Data utworzenia: 01.02.2020


//

//------------------<[ Implementacja: ]>-------------------
command_dajbilet_Impl(playerid, giveplayerid)
{
    new var[128];
    if(GetPlayerOrg(playerid) == FAMILY_IBIZA && PlayerInfo[playerid][pRank] >= 4) 
    {
        if(IbizaTicket[giveplayerid] != IBIZA_SUPERVIP)
        {
            format(var, sizeof(var), "Da�e� bilet supervip dla %s", GetNick(giveplayerid));
            sendTipMessageEx(playerid, COLOR_LIGHTBLUE, var);
            format(var, sizeof(var), "Otrzyma�e� bilet supervip od %s", GetNick(playerid));
            sendTipMessageEx(giveplayerid, COLOR_LIGHTBLUE, var);
            format(var, sizeof(var), "** %s podaje bilet Ibiza|[SUPERVIP] %s.", GetNick(playerid), GetNick(giveplayerid));
            ProxDetector(15.0, playerid, var, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            IbizaTicket[giveplayerid] = IBIZA_SUPERVIP;
        }
        else
        {
            sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Ta osoba posiada ju� bilet supervip.");
        }
    }
    else
    {
        noAccessMessage(playerid);
    }
    return 1;
}

//end