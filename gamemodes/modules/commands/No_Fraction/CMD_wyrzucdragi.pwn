//----------------------------------------------<< Source >>-------------------------------------------------//
//------------------------------------------[ Modu�: komenda/....pwn ]---------------------------------------------//
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

//

//-----------------<[ Funkcje: ]>-------------------


//-----------------<[ Komendy: ]>-------------------


CMD:wd(playerid) return cmd_wywaldragi(playerid);
CMD:wyrzucdragi(playerid) return cmd_wywaldragi(playerid);
CMD:wywaldragi(playerid)
{
    if(PlayerInfo[playerid][pDrugs] == 0) return sendErrorMessage(playerid, "Nie masz przy sobie narkotyk�w");
	new nick[MAX_PLAYER_NAME], string[128];
	GetPlayerName(playerid, nick, sizeof(nick));
	format(string, sizeof(string),"%s wyrzuci� torebeczk� z bia�ym proszkiem na ziemie.", nick);
	ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	format(string, sizeof(string), "* s�ycha� d�wi�k upuszczonej torebeczki ((%s))", nick);
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	PlayerInfo[playerid][pDrugs] = 0;
	return 1;
}


//-----------------<[ Timery: ]>-------------------


//end