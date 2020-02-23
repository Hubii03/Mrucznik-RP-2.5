//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 nawigacja                                                 //
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
// Data utworzenia: 09.02.2020
//Opis:
/*
	Prosty system nawigacji, wskazuj�cy punkt docelowy.
*/

//

//-----------------<[ Funkcje: ]>-------------------
ShowNawiDialog(playerid, dTYPE)
{
	new string[456];
	if(dTYPE == DIALOG_NAWI_MAIN)
	{
		ShowPlayerDialogEx(playerid, DIALOG_NAWI_MAIN, DIALOG_STYLE_LIST, nameToDialogs, "Znane Miejsca\nBiznesy\nUlice\nTelefon innego gracza", "Dalej", "Wyjd�"); 
	}
	else if(dTYPE == DIALOG_NAWI_ZNANEMIEJSCA)
	{
		format(string, sizeof(string), 
		"Nazwa\tOdleg�o��\n\
		Urz�d Miasta LS\t%0.2f metr�w\n\
		Bank 0Verte\t%0.2f metr�w\n\
		LSPD\t%0.2f metr�w\n\
		Baza mechanik�w\t%0.2f metr�w\n\
		Vinyl Club\t%0.2f metr�w\n\
		Ibiza Club\t%0.2f metr�w",
		GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_UMLS][N_POSX], posNawi[NAWI_UMLS][N_POSY], posNawi[NAWI_UMLS][N_POSZ]),
		GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_BANK][N_POSX], posNawi[NAWI_BANK][N_POSY], posNawi[NAWI_BANK][N_POSZ]),
		GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_LSPD][N_POSX], posNawi[NAWI_LSPD][N_POSY], posNawi[NAWI_LSPD][N_POSZ]), 
		GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_BAZA][N_POSX], posNawi[NAWI_BAZA][N_POSY], posNawi[NAWI_BAZA][N_POSZ]),
		GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_VINYL][N_POSX], posNawi[NAWI_VINYL][N_POSY], posNawi[NAWI_VINYL][N_POSZ]),
		GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_IBIZA][N_POSX], posNawi[NAWI_IBIZA][N_POSY], posNawi[NAWI_IBIZA][N_POSZ]));
		ShowPlayerDialogEx(playerid, DIALOG_NAWI_ZNANEMIEJSCA, DIALOG_STYLE_TABLIST_HEADERS, nameToDialogs, 
		string, "Jed�", "Wyjd�");
	}
	else if(dTYPE == DIALOG_NAWI_BIZNESY)
	{
		sendErrorMessage(playerid, "Wyst�pi� problem - nawigacja nie mo�e po�aczy� si� z baz� biznes�w");
	}
	else if(dTYPE == DIALOG_NAWI_ULICE)
	{
		sendErrorMessage(playerid, "Wyst�pi� problem - nawigacja nie mo�e po��czy� si� z baz� ulic"); 
	}
	else //nie powinno si� wydarzy�
	{
		sendErrorMessage(playerid, "Nie znany dType (dialog choice)"); 
	}
	return 1;
}
StartNavigation(playerid, NAWI)
{
	navigationCheckPoint[playerid] = CreateDynamicCP(posNawi[NAWI][N_POSX], posNawi[NAWI][N_POSY], posNawi[NAWI][N_POSZ], 5.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid); 
	return 1;
}
//end