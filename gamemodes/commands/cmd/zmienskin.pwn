//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ zmienskin ]-----------------------------------------------//
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

YCMD:zmienskin(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if (IsAHA(playerid) || PlayerInfo[playerid][pMember] == 2 || PlayerInfo[playerid][pLider] == 2)
        {
            if(PlayerInfo[playerid][pRank] >= 1)
            {
                if(GetPVarInt(playerid, "IsAGetInTheCar") == 1)
                {
                    sendErrorMessage(playerid, "Jeste� podczas wsiadania - odczekaj chwile");
                    return 1;
                }
                SetPVarInt(playerid, "CheatDetected", 1);
                ShowPlayerDialogEx(playerid, DIALOG_HA_ZMIENSKIN(0), DIALOG_STYLE_LIST, "Zmiana ubrania", DialogListaFrakcji(), "Start", "Anuluj");
            } 
            else
            {
                sendTipMessage(playerid, "Dozwolone tylko dla rangi 1 lub wi�kszych");
            }
        } 
        else
        {
            sendTipMessage(playerid, "Tylko dla Hitman Agency i FBI.");
        }
    }
    return 1;
}
