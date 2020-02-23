//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ apteczka ]-----------------------------------------------//
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

YCMD:apteczka(playerid, params[], help)
{
	new playa, giveplayer[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME], string[144];
	if(sscanf(params, "k<fix>", playa))
	{
		sendTipMessage(playerid, "U�yj /apteczka [ID gracza]");
		return 1;
	}
	if(!IsPlayerConnected(playa) || playa == INVALID_PLAYER_ID) 
	{
		return sendErrorMessage(playerid, "Nie ma takiego gracza.");
	}

	if(playa == playerid)
	{
		return sendErrorMessage(playerid, "Nie mo�esz sam siebie opatrzy�.");
	}

	if(PlayerInfo[playerid][pBW] > 0 || PlayerInfo[playerid][pInjury] > 0) return sendErrorMessage(playerid, "Nie mo�esz u�y� apteczki gdy jeste� ranny!");

	GetPlayerName(playa, giveplayer, sizeof(giveplayer));
	GetPlayerName(playerid, sendername, sizeof(sendername));

	if(GetDistanceBetweenPlayers(playerid,playa) > 5)
	{
		format(string, sizeof(string),"Jeste� zbyt daleko od gracza %s", giveplayer);
		return SendClientMessage(playerid, COLOR_GRAD1, string);
	}

	if((PlayerInfo[playerid][pMember] == 4 || PlayerInfo[playerid][pLider] == 4) && (OnDuty[playerid] == 1 || JobDuty[playerid] == 1))
	{	
		if(PlayerInfo[playa][pBW] == 0 && PlayerInfo[playa][pInjury] == 0) return sendTipMessage(playerid, "Gracz nie jest wystarczaj�co ranny wi�c nie wymaga interwencji.");
		format(string, sizeof string, "Proponujesz %s zastosowanie apteczki i wyleczenie mu ran.", GetNick(playa));
		SendClientMessage(playerid, -1, string);
		format(string, sizeof string, "* Lekarz %s proponuje Ci wyleczenie ran i udzielenie pomocy medycznej.", GetNick(playerid));
		SetPVarInt(playa, "HealthPackOffer", playerid);
		ShowPlayerDialogEx(playa, D_UZYCIE_APTECZKI, DIALOG_STYLE_MSGBOX, "Pomoc medyczna", string, "Przyjmij", "Anuluj");
		ApplyAnimation(playerid,"MEDIC","CPR",4.1,0,1,1,1,1);
	}
	else
	{
		if(PlayerInfo[playerid][pHealthPacks] < 1) return sendErrorMessage(playerid, "Nie posiadasz przy sobie apteczki, mo�esz je kupi� u medyk�w!");

		if(PlayerInfo[playa][pBW] > 0)
		{
			return sendTipMessage(playerid, "Gracz wymaga interwencji lekarza! (/wezwij medyk, /dzwon 911)");
		}

		if(PlayerInfo[playa][pInjury] == 0)
		{
			return sendTipMessage(playerid, "Gracz nie jest wystarczaj�co ranny wi�c nie wymaga interwencji.");
		}

		format(string, sizeof string, "Proponujesz %s zastosowanie apteczki i wyleczenie mu ran.", GetNick(playa));
		SendClientMessage(playerid, -1, string);
		format(string, sizeof string, "* %s proponuje Ci wyleczenie ran i udzielenie pomocy medycznej.", GetNick(playerid));
		SetPVarInt(playa, "HealthPackOffer", playerid);
		ShowPlayerDialogEx(playa, D_UZYCIE_APTECZKI, DIALOG_STYLE_MSGBOX, "Pomoc medyczna", string, "Przyjmij", "Anuluj");
		ApplyAnimation(playerid,"MEDIC","CPR",4.1,0,1,1,1,1);
	}
	return 1;
}