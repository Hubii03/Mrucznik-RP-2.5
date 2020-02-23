//-----------------------------------------------<< Defines >>-----------------------------------------------//
//                                               businessDialogs                                             //
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
business_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_BIZ_BUY)
    {
        if(!response)
        {
            sendTipMessage(playerid, "Zrezygnowa�e� z zakupu biznesu!"); 
            return 1;
        }
        if(PlayerInfo[playerid][pBusinessOwner] != INVALID_BUSINESSID)
        {
            sendTipMessage(playerid, "Najpierw zrezygnuj z obecnego biznesu!"); 
            return 1;
        }
        if(response)
        {
            new valueID = strval(inputtext); 
            if(valueID > MAX_BIZ || valueID <= 0)
            { 
                sendTipMessage(playerid, "Nieprawid�owe ID biznesu!"); 
                return 1;
            }
            if(!BizExist(valueID))
            {
                sendErrorMessage(playerid, "Taki biznes nie istnieje!"); 
                return 1;
            }
            SetPVarInt(playerid, "BuyBiz_ID", valueID);
            ShowPlayerDialogEx(playerid, DIALOG_BIZ_BUY2, DIALOG_STYLE_LIST, "Wybierz Typ", "Us�ugowy\nPrzemys�owy", "Dalej", "Anuluj");
        }
    }
    else if(dialogid == DIALOG_BIZ_BUY2)
    {
        if(!response) 
        {
            sendTipMessage(playerid, "Przerwano kupno biznesu!"); 
            SetPVarInt(playerid, "BuyBiz_ID", INVALID_BUSINESSID); 
            return 1;
        }
        if(response)
        {
            switch(listitem)
            {
                case 0: 
                {
                    ShowPlayerDialogEx(playerid, DIALOG_BIZ_BUY3, DIALOG_STYLE_TABLIST_HEADERS, "Wybierz podtyp", 
                    "Typ\tDodatkowa Cena\n\
                    Sklep 24-7\t500.000$\n\
                    Sklep z ubraniami\t750.000$\n\
                    Kasyno\t1.000.000$\n\
                    Restauracja\t1.000.000$", "Dalej", "Anuluj");
                }
                case 1:
                {
                    sendTipMessage(playerid, "Ten typ biznes�w zostanie odblokowany ju� nied�ugo!"); 
                }
            }
        }
    }
    else if(dialogid == DIALOG_BIZ_BUY3)
    {
        if(!response)
        {
            sendErrorMessage(playerid, "Zrezygnowa�e� z zakupu biznesu!"); 
            SetPVarInt(playerid, "BuyBiz_ID", INVALID_BUSINESSID); 
            return 1;
        }
        if(response)
        {
            new string[124];
            new pBizID = GetPVarInt(playerid, "BuyBiz_ID"); 
            switch(listitem)
            {
                case 0: 
                {

                    format(string, sizeof(string), "Potwierd� zakup biznesu %s\nKoszt biznesu to: %d$\nLokalizacja: %s",
                    pBizID, 
                    mBiz[pBizID][b_cost]+COST_SHOP24, 
                    mBiz[pBizID][b_Location]); 
                    SetPVarInt(playerid, "BuyBizChoice", 1); 
                    ShowPlayerDialogEx(playerid, DIALOG_BIZ_BUYBOX, DIALOG_STYLE_MSGBOX, "Mrucznik Role Play", string, "Kupuj�", "Rezygnuj�"); 
                }
                case 1:
                {

                }
                case 2:
                {

                }
                case 3:
                {

                }
            }
        }
    }
    else if(dialogid == DIALOG_BIZ_BUYBOX)
    {
        if(response)
        {
            new pBizID = GetPVarInt(playerid, "BuyBiz_ID");
            new bChoice = GetPVarInt(playerid, "BuyBizChoice"); 
            if(bChoice == 1)//Zakup sklepu 24-7
            {
                if(mBiz[pBizID][b_ownerUID] == 0)
                {
                    if(kaska[playerid] >= mBiz[pBizID][b_cost]+COST_SHOP24)
                    {
                        ZabierzKase(playerid, mBiz[pBizID][b_cost]+COST_SHOP24);
                        GiveBizToPlayer(playerid, pBizID, BTYPE_SERVICES, BTYPE2_SHOP); 
                    }
                    else
                    {
                        sendErrorMessage(playerid, "Nie masz wystarczaj�cej ilo�ci got�wki!"); 
                        return 1;
                    }
                }
                else{ 
                    sendErrorMessage(playerid, "Ten biznes ma ju� swojego w�a�ciciela!"); 
                    return 1;
                }
            }
        }
        else
        {
            SetPVarInt(playerid, "BuyBiz_ID", INVALID_BUSINESSID); 
        }
    }
    else if(dialogid == BIZ_DIALOG_INFO)
    {
        if(response)
        {
            //Co� tu ma sie zadzia� (Timer)
        }
    }
    else if(dialogid == DIALOG_BIZ_ADMINEDIT)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0://Przenie� wej�cie
                {
                    //new choiceTwo = GetPVarInt(playerid, "bizChoice");
                    SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_PRZENIES); 
                    sendTipMessage(playerid, "Sta� w miejscu, w kt�rym ma zosta� przeniesiony biznes i wpisz ponownie komend�.");
                    sendErrorMessage(playerid, "Pami�taj, �e wpisanie komendy zmieni automatycznie pozycje!");  
                    sendTipMessage(playerid, "Je�li chcesz anulowa� przenoszenie biznesu wpisz /bizback");
                }
                case 1://Dodaj wyj�cie
                {
                    SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_DODAJ); 
                    sendTipMessage(playerid, "Sta� w miejscu, w kt�rym ma powsta� wyj�cie (interior).");
                    sendTipMessage(playerid, "Mo�esz u�y� /setvw i /setint do ustawienia INT i VW (pLocal tak�e)"); 
                    sendErrorMessage(playerid, "Pami�taj, �e wpisanie komendy zmieni automatycznie pozycje!");  
                    sendTipMessage(playerid, "Je�li chcesz anulowa� przenoszenie biznesu wpisz /bizback");
                }
                case 2://Usu� biznes
                {
                    SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_USUN_BIZ); 
                    sendTipMessage(playerid, "Potwierd� usuni�cie biznesu wpisuj�c ponownie komend�!"); 
                    sendTipMessage(playerid, "Je�li chcesz anulowa� usuwanie biznesu wpisz /bizback");
                }
                case 3://Usu� w�a�ciciela
                {
                    SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_USUN_WLAS); 
                    sendTipMessage(playerid, "Potwierd� usuni�cie w�a�ciciela biznesu wpisuj�c ponownie komend�!");
                    sendErrorMessage(playerid, "Pami�taj, �e wpisanie komendy usunie automatycznie w�a�ciciela!");  
                    sendTipMessage(playerid, "Je�li chcesz anulowa� usuwanie w�a�ciciela biznesu wpisz /bizback");
                }
                case 4://Wyzeruj pieni�dze biznesu
                {
                    SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_WYZERUJ_KASE); 
                    sendTipMessage(playerid, "Potwierd� wyzerowanie got�wki zebraniej w sejfie biznesu wpisuj�c komend� ponownie!");
                    sendErrorMessage(playerid, "Pami�taj, �e wpisanie komendy usunie automatycznie got�wk�!");  
                    sendTipMessage(playerid, "Je�li chcesz anulowa� usuwanie got�wki biznesu wpisz /bizback");   
                }
                case 5://Zmie� cen� biznesu
                {
                    sendTipMessage(playerid, "Ta opcja pojawi si� ju� nied�ugo!"); 
                }
            }
        }
    }
    return 1;
}

//end