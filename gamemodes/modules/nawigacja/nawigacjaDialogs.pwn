//-----------------------------------------------<< Defines >>-----------------------------------------------//
//                                              nawigacjaDialogs                                             //
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
// Data utworzenia: 04.02.2020

//

//------------------<[ Dialogi: ]>-------------------
nawigacja_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_NAWI_MAIN)
    {
       if(response)
       {
           switch(listitem)
           {
               case 0:
               {
                   ShowNawiDialog(playerid, DIALOG_NAWI_ZNANEMIEJSCA);
               }
               case 1:
               {
                   ShowNawiDialog(playerid, DIALOG_NAWI_BIZNESY); 
               }
               case 2:
               {
                   ShowNawiDialog(playerid, DIALOG_NAWI_ULICE); 
               }
               case 3:
               {
                   sendErrorMessage(playerid, "Nie za�o�y�e� nikomu nadajnika GPS"); //Wkr�tce
               }
           }
       }
    }
    else if(dialogid == DIALOG_NAWI_ZNANEMIEJSCA)
    {
        if(!response)
        {
            return ShowNawiDialog(playerid, DIALOG_NAWI_MAIN); 
        }
        else{
            new string[124];
            if(navigationCheckPoint[playerid] != INVALID_STREAMER_ID)
            {
                sendErrorMessage(playerid, "Masz w��czon� nawigacj� na inny cel");
                sendTipMessage(playerid, "Wpisz /mnawigacjaoff aby wy��czy� nawigacj�.");
                return 1;
            }
            switch(listitem)
            {
                case 0://urzad
                {
                    sendTipMessageEx(playerid, COLOR_GREEN, "==============<[ Mrucznik Navigation ]>==============");
                    sendTipMessageEx(playerid, COLOR_GREEN, "Wybrano cel: {FFFFFF}Urz�d Miasta Los Santos");
                    format(string, sizeof(string), "Do celu pozosta�o %0.2f metr�w!", 
                    GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_UMLS][N_POSX], posNawi[NAWI_UMLS][N_POSY], posNawi[NAWI_UMLS][N_POSZ]));
                    sendTipMessage(playerid, string); 
                    SetPVarString(playerid, "miejsceDoceloweStr", "Urz�d Miasta Los Santos");
                    SetPVarInt(playerid, "miejsceDoceloweID", NAWI_UMLS); 
                    StartNavigation(playerid, NAWI_UMLS); 
                }
                case 1://bank
                {
                    sendTipMessageEx(playerid, COLOR_GREEN, "==============<[ Mrucznik Navigation ]>==============");
                    sendTipMessageEx(playerid, COLOR_GREEN, "Wybrano cel: {FFFFFF}Bank 0Verte oddzia� LS");
                    format(string, sizeof(string), "Do celu pozosta�o %0.2f metr�w!", 
                    GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_BANK][N_POSX], posNawi[NAWI_BANK][N_POSY], posNawi[NAWI_BANK][N_POSZ]));
                    sendTipMessage(playerid, string);
                    SetPVarString(playerid, "miejsceDoceloweStr", "Bank 0Verte");
                    SetPVarInt(playerid, "miejsceDoceloweID", NAWI_BANK); 
                    StartNavigation(playerid, NAWI_BANK); 
                }
                case 2://lspd
                {
                    sendTipMessageEx(playerid, COLOR_GREEN, "==============<[ Mrucznik Navigation ]>==============");
                    sendTipMessageEx(playerid, COLOR_GREEN, "Wybrano cel: {FFFFFF}Los Santos Police Department");
                    format(string, sizeof(string), "Do celu pozosta�o %0.2f metr�w!", 
                    GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_LSPD][N_POSX], posNawi[NAWI_LSPD][N_POSY], posNawi[NAWI_LSPD][N_POSZ]));
                    sendTipMessage(playerid, string); 
                    SetPVarString(playerid, "miejsceDoceloweStr", "Los Santos Police Dep.");
                    SetPVarInt(playerid, "miejsceDoceloweID", NAWI_LSPD); 
                    StartNavigation(playerid, NAWI_LSPD);
                }
                case 3://baza mech�w
                {
                    sendTipMessageEx(playerid, COLOR_GREEN, "==============<[ Mrucznik Navigation ]>==============");
                    sendTipMessageEx(playerid, COLOR_GREEN, "Wybrano cel: {FFFFFF}Centralna siedziba mechanik�w");
                    format(string, sizeof(string), "Do celu pozosta�o %0.2f metr�w!", 
                    GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_BAZA][N_POSX], posNawi[NAWI_BAZA][N_POSY], posNawi[NAWI_BAZA][N_POSZ]));
                    sendTipMessage(playerid, string); 
                    SetPVarString(playerid, "miejsceDoceloweStr", "Baza mechanik�w");
                    SetPVarInt(playerid, "miejsceDoceloweID", NAWI_BAZA); 
                    StartNavigation(playerid, NAWI_BAZA);
                }
                case 4://vinyl
                {
                    sendTipMessageEx(playerid, COLOR_GREEN, "==============<[ Mrucznik Navigation ]>==============");
                    sendTipMessageEx(playerid, COLOR_GREEN, "Wybrano cel: {FFFFFF}Vinyl Club");
                    format(string, sizeof(string), "Do celu pozosta�o %0.2f metr�w!", 
                    GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_VINYL][N_POSX], posNawi[NAWI_VINYL][N_POSY], posNawi[NAWI_VINYL][N_POSZ]));
                    sendTipMessage(playerid, string);
                    SetPVarString(playerid, "miejsceDoceloweStr", "Vinyl Club");
                    SetPVarInt(playerid, "miejsceDoceloweID", NAWI_VINYL); 
                    StartNavigation(playerid, NAWI_VINYL); 
                }
                case 5://ibiza
                {
                    sendTipMessageEx(playerid, COLOR_GREEN, "==============<[ Mrucznik Navigation ]>==============");
                    sendTipMessageEx(playerid, COLOR_GREEN, "Wybrano cel: {FFFFFF}Ibiza Club");
                    format(string, sizeof(string), "Do celu pozosta�o %0.2f metr�w!", 
                    GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_IBIZA][N_POSX], posNawi[NAWI_IBIZA][N_POSY], posNawi[NAWI_IBIZA][N_POSZ]));
                    sendTipMessage(playerid, string); 
                    SetPVarString(playerid, "miejsceDoceloweStr", "Ibiza Club");
                    SetPVarInt(playerid, "miejsceDoceloweID", NAWI_IBIZA); 
                    StartNavigation(playerid, NAWI_IBIZA);
                }
            }
        }
    }
    else if(dialogid == DIALOG_NAWI_BIZNESY)
    {
        if(response)
        {
            if(strval(inputtext) == 0)//Ci�g nie jest liczb�
            {
                new checkedBiz;
                for(new i; i<= MAX_BIZ; i++)
                {
                    if(checkedBiz == loadedBiz)
                    {
                        sendErrorMessage(playerid, "Nie uda�o si� znale�� wpisanego przez Ciebie biznesu w systemie nawigacji!"); 
                        return 1;
                    }
                    if(BizExist(i))
                    {
                        if(strfind(inputtext, mBiz[i][b_Name], false, 0))
                        {
                            new bIDE = i; 
                            new string[256];
                            format(string, sizeof(string), 
                            "Uda�o si� znale�� biznes!\nZnaleziony biznes: %s [%d]\nLokalizacja: %s\nW�a�ciciel: %s\nCzy chcesz si� tam uda�?",
                            GetBusinessName(bIDE), bIDE, mBiz[bIDE][b_Location], GetBusinessOwnerName(bIDE));
                            SetPVarInt(playerid, "ZnalazlBiz", bIDE); 
                            ShowPlayerDialogEx(playerid, DIALOG_NAWI_BIZNESY2, DIALOG_STYLE_MSGBOX, defaultDialogCaption, string, "Tak", "Nie"); 
                            return 1;
                        }
                        checkedBiz++;
                    }
                }
            }
            else 
            {
                new bIDE = strval(inputtext);
                new string[256];
                if(BizExist(bIDE))
                {
                    format(string, sizeof(string), 
                    "Uda�o si� znale�� biznes!\nZnaleziony biznes: %s [%d]\nLokalizacja: %s\nW�a�ciciel: %s\nCzy chcesz si� tam uda�?",
                    GetBusinessName(bIDE), bIDE, mBiz[bIDE][b_Location], GetBusinessOwnerName(bIDE));
                    SetPVarInt(playerid, "ZnalazlBiz", bIDE); 
                    ShowPlayerDialogEx(playerid, DIALOG_NAWI_BIZNESY2, DIALOG_STYLE_MSGBOX, defaultDialogCaption, string, "Tak", "Nie"); 
                }
                else 
                {
                    sendErrorMessage(playerid, "Nie istnieje taki biznes!"); 
                    return 1;
                }
            }
        }
    }
    else if(dialogid == DIALOG_NAWI_BIZNESY2)
    {
        if(response)
        {
            new bIDE = GetPVarInt(playerid, "ZnalazlBiz"); 
            StartNavigationEx(playerid, GetBusinessName(bIDE), mBiz[bIDE][b_enX], mBiz[bIDE][b_enY], mBiz[bIDE][b_enZ]); 
        }
    }
    return 1;
}

//end