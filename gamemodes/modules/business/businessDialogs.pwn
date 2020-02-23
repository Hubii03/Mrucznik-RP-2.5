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
    //-----------------------[Kupno biznesu]-----------------------
    /*  
        ===[Pierwszy dialog kupna]===
            
            Gracz wpisuje ID biznesu, kt�ry chcia�by zakupi�.
            Dialog sprawdza czy ID jest poprawne, zapisuje ID wpisane przez gracza i odno�ni si� dalej. 
            Wy�wietla dialog (DIALOG_BIZ_BUY2). 

    */
    
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
            if(mBiz[valueID][b_ownerUID] != 0)
            {
                sendErrorMessage(playerid, "Ten biznes posiada ju� w�a�ciciela!"); 
                return 1;
            }
            SetPVarInt(playerid, "BuyBiz_ID", valueID);
            ShowPlayerDialogEx(playerid, DIALOG_BIZ_BUY2, DIALOG_STYLE_LIST, "Wybierz Typ", "Us�ugowy\nPrzemys�owy [Wkr�tce]", "Dalej", "Anuluj");
        }
    }
    /*  
        ===[Drugi dialog kupna]===
            
            Graczowi wy�wietlone zostaj� typy biznesu, w zale�no�ci od poprzedniego wyboru (patrz DIALOG_BIZ_BUY). 
            Mo�liwe do wyboru s� 2 opcje, kt�re wywo�uj� 2 osobne dialogi. 
            W przypadku wyboru us�ugowych - wy�wietla DIALOG_BIZ_BUY3. 

    */
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
            new string[256]; 
            switch(listitem)
            {
                case 0: //Us�ugi
                {
                    format(string, sizeof(string), "Typ\tDodatkowa Cena\n\
                    %s\t%d$\n\
                    %s\t%d$\n\
                    %s\t%d$\n\
                    %s\t%d$\n\
                    %s\t%d$\n\
                    %s\t%d$",
                    BNAME_SHOP, BCOST_SHOP,
                    BNAME_CLOTHESSHOP, BCOST_CLOTHESSHOP,
                    BNAME_RESTAURANT, BCOST_RESTAURANT,
                    BNAME_WORKSHOP, BCOST_WORKSHOP,
                    BNAME_HOTEL, BCOST_HOTEL,
                    BNAME_TRANSPORT, BCOST_TRANSPORT);
                    ShowPlayerDialogEx(playerid, DIALOG_BIZ_BUY3, DIALOG_STYLE_TABLIST_HEADERS, "Wybierz podtyp", 
                    string, "Dalej", "Anuluj");
                }
                case 1://Przemys�
                {
                    sendTipMessage(playerid, "Ten typ biznes�w zostanie odblokowany ju� nied�ugo!"); 
                }
            }
        }
    }
    /*  
        ===[Trzeci dialog kupna]===
            
            Gracz �wcze�nie wpisa� ID biznesu, kt�re jest przechowywane na PVar "BuyBiz_ID", a tak�e wybra� typ biznesu - us�ugowy.
            Je�eli gracz w tym momencie zrezygnuje z kupna - przypisane zostanie na PVAR INVALID_BUSINESSID. 
            W przypadku response - graczowi wy�wietlony zostaje dialog potwierdzaj�cy wybory dokonane w poprzednich dialogach. 
            
    */
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

            /*TODO: Wsadzi� to gdzie� w ten kod tutaj: 
            if(mBiz[pBizID][b_neededType] != 9999)
            {
                if(mBiz[pBizID][b_neededType] != bChoice)
                {
                    sendErrorMessage(playerid, "Tego biznesu nie mo�esz kupi� z tym typem!");
                    sendTipMessage(playerid, "Administrator zablokowa� mo�liwo�� kupna tego biznesu o wybranym przez Ciebie przeznaczeniu.") ;
                    return 1;
                }
            } 
            */
            switch(listitem)
            {
                case 0: //Shop 24
                {

                    format(string, sizeof(string), "Potwierd� zakup biznesu %s\nKoszt biznesu to: %d$\nLokalizacja: %s",
                    pBizID, 
                    mBiz[pBizID][b_cost]+BCOST_SHOP, 
                    mBiz[pBizID][b_Location]); 
                    SetPVarInt(playerid, "BuyBizChoice", BTYPE_SHOP); 
                    ShowPlayerDialogEx(playerid, DIALOG_BIZ_BUYBOX, DIALOG_STYLE_MSGBOX, SetDefaultCaption(), string, "Kupuj�", "Rezygnuj�"); 
                }
                case 1://Shop with Clothes xD 
                {
                    format(string, sizeof(string), "Potwierd� zakup biznesu %s\nKoszt biznesu to: %d$\nLokalizacja: %s",
                    pBizID, 
                    mBiz[pBizID][b_cost]+BCOST_CLOTHESSHOP, 
                    mBiz[pBizID][b_Location]); 
                    SetPVarInt(playerid, "BuyBizChoice", BTYPE_CLOTHESSHOP); 
                    ShowPlayerDialogEx(playerid, DIALOG_BIZ_BUYBOX, DIALOG_STYLE_MSGBOX, SetDefaultCaption(), string, "Kupuj�", "Rezygnuj�");
                    
                }
                case 2:
                {
                    sendTipMessage(playerid, "Ta opcja jest zablokowana - trwaj� prace nad jej odblokowaniem"); 
                }
                case 3:
                {
                    sendTipMessage(playerid, "Ta opcja jest zablokowana - trwaj� prace nad jej odblokowaniem"); 
                }
                case 4:
                {
                    sendTipMessage(playerid, "Ta opcja jest zablokowana - trwaj� prace nad jej odblokowaniem"); 
                }
                case 5:
                {
                    sendTipMessage(playerid, "Ta opcja jest zablokowana - trwaj� prace nad jej odblokowaniem"); 
                }
            }
        }
    }
    /*  
        ===[Czwarty dialog kupna]===
            
            Je�eli gracz potwierdzi (response) - rozpoczyna aukcje, b�d� kupuje biznes.
            Je�eli gracz zrezygnuje warto�ci zostan� ustawione na INVALID. 

    */
    else if(dialogid == DIALOG_BIZ_BUYBOX)
    {
        if(response)
        {
            //Przypisanie warto�ci dla zmiennych
            new pBizID = GetPVarInt(playerid, "BuyBiz_ID");
            new bChoice = GetPVarInt(playerid, "BuyBizChoice");
            
            if(mBiz[pBizID][b_auction] == 2)                            //======> Sprawdza czy biznes mia� ju� kiedy� aukcje
            {
                if(bChoice == BTYPE_SHOP)                              //======> Sprawdza czy wyb�r gracza to sklep
                {
                    if(kaska[playerid] >= mBiz[pBizID][b_cost]+BCOST_SHOP)
                    {
                        ZabierzKase(playerid, mBiz[pBizID][b_cost]+BCOST_SHOP);
                        GiveBizToPlayer(playerid, pBizID, BTYPE_SHOP); 
                        Log(businessLog, INFO, "%s kupil biznes %s jako sklep 24-7 za %d", GetPlayerLogName(playerid), GetBusinessLogName(pBizID), (mBiz[pBizID][b_cost]+BCOST_SHOP));
                    }
                    else
                    {
                        sendErrorMessage(playerid, "Nie masz wystarczaj�cej ilo�ci got�wki!"); 
                        return 1;
                    }     
                }
                else if(bChoice == BTYPE_CLOTHESSHOP)
                {
                    if(kaska[playerid] >= mBiz[pBizID][b_cost]+BCOST_CLOTHESSHOP)
                    {
                        ZabierzKase(playerid, mBiz[pBizID][b_cost]+BCOST_CLOTHESSHOP);
                        GiveBizToPlayer(playerid, pBizID, BTYPE_CLOTHESSHOP); 
                        Log(businessLog, INFO, "%s kupil biznes %s jako sklep z ubraniami za %d", GetPlayerLogName(playerid), GetBusinessLogName(pBizID), (mBiz[pBizID][b_cost]+BCOST_SHOP));
                    }
                    else
                    {
                        sendErrorMessage(playerid, "Nie masz wystarczaj�cej ilo�ci got�wki!"); 
                        return 1;
                    } 
                }
            }
            else if(mBiz[pBizID][b_auction] == 1)//Na biznes trwa ju� licytacja
            {
                sendErrorMessage(playerid, "Na ten biznes aktualnie trwa aukcja!");
                sendTipMessage(playerid, "Je�eli chcia�by� go zalicytowa� podejd� do niego i wpisz /licytuj"); 
            }
            else //Rozpoczecie licytacji
            {
                if(mBiz[pBizID][b_ownerUID] != 0)//Sytacja nie powinna zaistnie�
                {
                    sendErrorMessage(playerid, "Ten biznes ma w�a�ciciela - nie mo�esz rozpocz�� licytacji"); 
                    return 1;
                }
                StartLicytacjaBiz(pBizID, playerid, bChoice); 
            }
        }
        else
        {
            SetPVarInt(playerid, "BuyBiz_ID", INVALID_BUSINESSID); 
        }
    }
    //-----------------------[Kupno biznesu - KONIEC]-----------------------
    //:
    //:
    //-----------------------[Dialogi informacyjne]-----------------------
    else if(dialogid == BIZ_DIALOG_INFO)
    {
        if(response)
        {
            SetTimerEx("OdczekajDialogBiz", 5000, false, "i", playerid);
            SetPVarInt(playerid, "MozeUzycKomendyBiz", 1);
        }
    }
    //-----------------------[Dialogi informacyjne - KONIEC]--------------------
    //:
    //:
    //-----------------------[Panel edycji biznesu]-----------------------
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
                case 6://Okre�l biznes
                {
                    ShowPlayerDialogEx(playerid, DIALOG_OKRESL_BIZNES, DIALOG_STYLE_LIST, SetDefaultCaption(), 
                    "Sklep 24-7\nSklep z ubraniami\nWszystkie", "Dalej", "Odrzu�"); 
                }
            }
        }
    }
    else if(dialogid == DIALOG_OKRESL_BIZNES)
    {
        if(!response)
        {
            sendTipMessage(playerid, "Jak B�g rzek�, tak si� niech stanie - dialog zamkni�ty.");
            return 1;
        }
        else 
        {
            new string[124];
            new bIDE = GetPVarInt(playerid, "dialog-bIDE-admin");
            new stringChoice[32]; 
            switch(listitem)
            {
                case 0:
                {
                    mBiz[bIDE][b_neededType] = BTYPE_SHOP;
                    format(stringChoice, sizeof(stringChoice), "%s", BNAME_SHOP);
                }
                case 1:
                {
                    mBiz[bIDE][b_neededType] = BTYPE_CLOTHESSHOP; 
                    format(stringChoice, sizeof(stringChoice), "%s", BNAME_CLOTHESSHOP);
                }
                case 2:
                {
                    mBiz[bIDE][b_neededType] = BTYPE_DEFAULT; 
                    format(stringChoice, sizeof(stringChoice), "Wszystkie biznesy"); 
                }
            }
            format(string, sizeof(string), "Ustawi�e� biznesowi %s [%d] wymagany TYP jako %s", GetBusinessName(bIDE), bIDE, stringChoice); 
            sendTipMessageEx(playerid, COLOR_RED, string); 
            return 1;
        }
    }
    //--------------------[Panel Edycji Biznesu - KONIEC]-------------------
    //:
    //:
    //:
    //---------------------[Panel w�a�ciciela biznesu]---------------------
    else if(dialogid == DIALOG_BIZ_OWNER)
    {
        if(!response)
        {
            sendTipMessage(playerid, "Wyszed�e� z panelu w�a�ciciela biznesu!"); 
            return 1;
        }
        else
        {
            switch(listitem)
            {
                case 0: //Nazwa biz, zwrot
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_MAIN); 
                }
                case 1:
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_WORKERS); 
                }
                case 2:
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_SEJF); 
                }
                case 3:
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_DOORS);
                }
                case 4:
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_ADDS); 
                }
            }
        }
    }
    else if(dialogid == DIALOG_BIZ_OWNER2)//DIALOG WORKERS
    {
        if(!response)
        {
            ShowBusinessOwnerDialog(playerid, DIALOG_MAIN); 
            return 1;
        }
        else 
        {
            switch(listitem)
            {
                case 0:
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_WORKERS);
                }
                case 1:
                {
                    sendTipMessage(playerid, "Ta opcja pojawi si� ju� nied�ugo!");
                }
                case 2:
                {
                    sendTipMessage(playerid, "Ta opcja pojawi si� ju� nied�ugo!"); 
                }
            }
        }
    }
    else if(dialogid == DIALOG_BIZ_OWNER3)
    {
        if(!response)
        {
            ShowBusinessOwnerDialog(playerid, DIALOG_MAIN);
            return 1;
        }
        else 
        {
            switch(listitem)
            {
                case 0:
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_SEJF); 
                }
                case 1:
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_SEJF);
                }
                case 2:
                {//wp�acanie
                    ShowPlayerDialogEx(playerid, DIALOG_BIZ_WPLAC, DIALOG_STYLE_INPUT, SetDefaultCaption(), 
                    "Wpisz poni�ej sum� jak� chcesz wp�aci�\nWskaz�wka - mo�esz u�ywa� mno�nika k (np. 10k)", "Wp�a�", "Zrezygnuj");  
                }
                case 3://wyp�acanie
                {
                    ShowPlayerDialogEx(playerid, DIALOG_BIZ_WYPLAC, DIALOG_STYLE_INPUT, SetDefaultCaption(), 
                    "Wpisz poni�ej sum� jak� chcesz wyp�aci�\nWskaz�wka - mo�esz u�ywa� mno�nika k (np. 10k)", "Wyp�a�", "Zrezygnuj");
                }
                case 4:
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_SEJF);
                }
                case 5:
                {//Wyp�acanie 
                    PlayerRunWithMoney(playerid); 
                }
                case 6:
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_SEJF); 
                }
            }
        }
    }
    else if(dialogid == DIALOG_BIZ_WPLAC)
    {
        if(!response)
        {
            ShowBusinessOwnerDialog(playerid, DIALOG_SEJF); 
            return 1;
        }
        else 
        {
            new value = FunkcjaK(inputtext); 
            new bIDE = PlayerInfo[playerid][pBusinessOwner];
            new string[124];
            if(mBiz[bIDE][b_moneyPocket]+value > GetPocketMaxSpace(bIDE))
            {
                sendErrorMessage(playerid, "Nie mo�esz wp�aci� takiej ilo�ci got�wki!");
                format(string, sizeof(string), "Tw�j sejf zmie�ci maksymalnie: $%d", GetPocketMaxSpace(bIDE));
                sendTipMessage(playerid, string); 
                return 1;
            }
            if(kaska[playerid] < value)
            {
                sendErrorMessage(playerid, "Nie masz takiej ilo�ci got�wki!"); 
                return 1;
            }
            if(GetPLocal(playerid) != PLOCAL_INNE_BANK && GetNearBusinessID(playerid) != PlayerInfo[playerid][pBusinessOwner])
            {
                sendErrorMessage(playerid, "Aby tego dokona� musisz znajdowa� si� w banku lub w swoim biznesie!"); 
                return 1;
            }
            Log(businessCashLog, INFO, "Gracz %s wplacil do sejfu %s kwote %d stary stan %d nowy stan %d",
            GetPlayerLogName(playerid),
            GetBusinessLogName(bIDE),
            value,
            mBiz[bIDE][b_moneyPocket],
            (mBiz[bIDE][b_moneyPocket]+value));
            format(string, sizeof(string), "Wp�aci�e� do g��wnego sejfu biznesu $%d, nowy stan $%d", value, mBiz[bIDE][b_moneyPocket]+value); 
            mBiz[bIDE][b_moneyPocket] = mBiz[bIDE][b_moneyPocket]+value; 
            sendTipMessageEx(playerid, COLOR_GREEN, string);
            ZabierzKase(playerid, value); 
            SaveBiz(bIDE); 
        }
    }
    else if(dialogid == DIALOG_BIZ_WYPLAC)
    {
        if(!response)
        {
            ShowBusinessOwnerDialog(playerid, DIALOG_SEJF); 
            return 1;
        }
        else 
        {
            new value = FunkcjaK(inputtext); 
            new bIDE = PlayerInfo[playerid][pBusinessOwner];
            new string[124];
            if(mBiz[bIDE][b_moneyPocket] < value)
            {
                sendErrorMessage(playerid, "Tw�j biznes nie posiada takiej sumy!"); 
                return 1;
            }
            if(GetPLocal(playerid) != PLOCAL_INNE_BANK && GetNearBusinessID(playerid) != PlayerInfo[playerid][pBusinessOwner])
            {
                sendErrorMessage(playerid, "Aby tego dokona� musisz znajdowa� si� w banku lub w swoim biznesie!"); 
                return 1;
            }
            Log(businessCashLog, INFO, "Gracz %s wyplacil z sejfu %s kwote %d stary stan %d nowy stan %d",
            GetPlayerLogName(playerid),
            GetBusinessLogName(bIDE),
            value,
            mBiz[bIDE][b_moneyPocket],
            (mBiz[bIDE][b_moneyPocket]-value));
            format(string, sizeof(string), "Wyp�aci�e�z g��wnego sejfu biznesu $%d, nowy stan $%d", value, mBiz[bIDE][b_moneyPocket]-value); 
            mBiz[bIDE][b_moneyPocket] = mBiz[bIDE][b_moneyPocket]-value; 
            sendTipMessageEx(playerid, COLOR_GREEN, string);
            DajKase(playerid, value); 
            SaveBiz(bIDE); 
            
        }
    }
    else if(dialogid == DIALOG_BIZ_OWNER4)//DRZWI
    {
        if(!response)
        {
            ShowBusinessOwnerDialog(playerid, DIALOG_MAIN);
            return 1;
        }
        else 
        {
            sendTipMessage(playerid, "Ta opcja zostanie dodana ju� wkr�tce!"); 
        }
    }
    else if(dialogid == DIALOG_BIZ_OWNER5)//DODATKI
    {
        if(!response)
        {
            ShowBusinessOwnerDialog(playerid, DIALOG_MAIN);
            return 1;
        }
        else 
        {
            new string[256];
            new bIDE = PlayerInfo[playerid][pBusinessOwner];
            switch(listitem)
            {
                case 0: 
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_ADDS); 
                }
                case 1:
                {
                    format(string, sizeof(string), "Wprowad� poni�ej now� nazw� biznesu.\nPami�taj, �e maksymalna liczba znak�w to 64!\nKoszt zmiany: $%d",
                    B_CENA_ZMIENAZWE);
                    ShowPlayerDialogEx(playerid, DIALOG_INPUT_NOWANAZWA, DIALOG_STYLE_INPUT, SetDefaultCaption(), 
                    string, "Akceptuj", "Main");
                }
                case 2:
                {
                    format(string, sizeof(string), "Wprowad� poni�ej nowe MOTD biznesu\nPami�taj, �e maksymalna liczba znak�w to 64!\nKoszt zmiany: $%d",
                    B_CENA_ZMIENMOTD);
                    ShowPlayerDialogEx(playerid, DIALOG_INPUT_NOWEMOTD, DIALOG_STYLE_INPUT, SetDefaultCaption(), 
                    string, "Akceptuj", "Main");
                }
                case 3:
                {
                    sendTipMessage(playerid, "Ta opcja b�dzie dost�pna ju� niebawem!"); 
                }
                case 4:
                {
                    if(kaska[playerid] < B_CENA_SEJFG)
                    {
                        sendErrorMessage(playerid, "Nie masz wystarczaj�cej ilo�ci got�wki!"); 
                        return 1;
                    }
                    if(mBiz[bIDE][b_ulepszenie4]+1 > 10)
                    {
                        sendErrorMessage(playerid, "Ten biznes osi�gn�� maksymaln� liczb� ulepsze� - 10!");
                        format(string, sizeof(string), "Mo�esz w nim zmie�ci� teraz $%d.", GetPocketMaxSpace(bIDE));
                        sendTipMessage(playerid, string);
                        return 1;
                    }
                    ZabierzKase(playerid, B_CENA_SEJFG); 
                    mBiz[bIDE][b_ulepszenie4]++; 
                    sendTipMessage(playerid, "Ulepszy�e� sejf g��wny w swoim biznesie!");
                    format(string, sizeof(string), "Aktualny poziom ulepszenia [%d], mo�esz zmie�ci� w sejfie teraz $%d", mBiz[bIDE][b_ulepszenie4], GetPocketMaxSpace(bIDE));
                    sendTipMessage(playerid, string); 
                    Log(businessLog, INFO, "%s ulepszyl w biznesie %s sejf glowny - aktualny poziom %d", GetPlayerLogName(playerid), GetBusinessLogName(bIDE), mBiz[bIDE][b_ulepszenie4]);
                    SaveBiz(bIDE); 
                }
                case 5:
                {
                    if(kaska[playerid] < B_CENA_SEJFT)
                    {
                        sendErrorMessage(playerid, "Nie masz wystarczaj�cej ilo�ci got�wki!"); 
                        return 1;
                    }
                    if(mBiz[bIDE][b_ulepszenie5]+1 > 10)
                    {
                        sendErrorMessage(playerid, "Ten biznes osi�gn�� maksymaln� liczb� ulepsze� - 10!");
                        format(string, sizeof(string), "Mo�esz w sejfie tymczasowym zmie�ci� teraz $%d.", GetTempPocketMaxSpace(bIDE));
                        sendTipMessage(playerid, string);
                        return 1;
                    }
                    ZabierzKase(playerid, B_CENA_SEJFT); 
                    mBiz[bIDE][b_ulepszenie5]++; 
                    sendTipMessage(playerid, "Ulepszy�e� sejf tymczasowy w swoim biznesie!");
                    format(string, sizeof(string), "Aktualny poziom ulepszenia [%d], mo�esz zmie�ci� w sejfie teraz $%d", mBiz[bIDE][b_ulepszenie5], GetTempPocketMaxSpace(bIDE));
                    sendTipMessage(playerid, string); 
                    Log(businessLog, INFO, "%s ulepszyl w biznesie %s sejf tymczasowy - aktualny poziom %d", GetPlayerLogName(playerid), GetBusinessLogName(bIDE), mBiz[bIDE][b_ulepszenie5]);
                    SaveBiz(bIDE); 
                }
                case 6:
                {
                    ShowInteriorList(playerid); 
                }
                case 7:
                {
                    if(kaska[playerid] < B_CENA_SEJFE)
                    {
                        sendErrorMessage(playerid, "Nie masz wystarczaj�cej ilo�ci got�wki!"); 
                        return 1;
                    }
                    if(mBiz[bIDE][b_ulepszenie1]+1 > 10)
                    {
                        sendErrorMessage(playerid, "Ten biznes osi�gn�� maksymaln� liczb� ulepsze� - 10!");
                        format(string, sizeof(string), "Mo�esz w sejfie materia��w  zmie�ci� teraz $%d.", 2000+(mBiz[bIDE][b_ulepszenie1]*1000));
                        sendTipMessage(playerid, string);
                        return 1;
                    }
                    ZabierzKase(playerid, B_CENA_SEJFE); 
                    mBiz[bIDE][b_ulepszenie1]++; 
                    sendTipMessage(playerid, "Ulepszy�e� sejf element�w w swoim biznesie!");
                    format(string, sizeof(string), "Aktualny poziom ulepszenia [%d], mo�esz zmie�ci� w sejfie teraz $%d", mBiz[bIDE][b_ulepszenie1], (2000+(mBiz[bIDE][b_ulepszenie1]*1000)));
                    sendTipMessage(playerid, string); 
                    Log(businessLog, INFO, "%s ulepszyl w biznesie %s sejf elementow - aktualny poziom %d", GetPlayerLogName(playerid), GetBusinessLogName(bIDE), mBiz[bIDE][b_ulepszenie1]);
                    SaveBiz(bIDE); 
                }
            }
        }
    }
    else if(dialogid == DIALOG_INPUT_NOWANAZWA)
    {
        if(!response)
        {
            return ShowBusinessOwnerDialog(playerid, DIALOG_MAIN);
        }
        else 
        {
            new string[256];
            new bIDE = PlayerInfo[playerid][pBusinessOwner];
            if(kaska[playerid] < B_CENA_ZMIENAZWE)
            {
                sendErrorMessage(playerid, "Nie posiadasz wystarczaj�cej ilo�ci got�wki!"); 
                return 1;
            }
            if(strlen(inputtext) > 64)
            {
                sendErrorMessage(playerid, "Zbyt d�uga nazwa!"); 
                return 1;
            }
            if(CheckVulgarityString(inputtext) == 1)
            {
                sendErrorMessage(playerid, "Nazwa nie mo�e by� wulgarna!");
                return 1;
            }
            format(string, sizeof(string), "Zmieni�e� nazw� biznesu %s na %s", GetBusinessName(bIDE), inputtext); 
            sendTipMessage(playerid, string); 
            Log(businessLog, INFO, "%s zmienil nazwe biznesu %s na %s", GetPlayerLogName(playerid), GetBusinessLogName(bIDE),inputtext);
            ZabierzKase(playerid, B_CENA_ZMIENAZWE); 
            strdel(mBiz[bIDE][b_Name], 0, strlen(mBiz[bIDE][b_Name]));
            strcat(mBiz[bIDE][b_Name], inputtext, MAX_BUSINESS_NAME);
            DestroyBusiness3DText(bIDE);
            CreateBusiness3DText(bIDE); 
            SaveBiz(bIDE);  
        }
    }
    else if(dialogid == DIALOG_INPUT_NOWEMOTD)
    {
        if(!response)
        {
            return ShowBusinessOwnerDialog(playerid, DIALOG_MAIN);
        }
        else 
        {
            new string[256];
            new bIDE = PlayerInfo[playerid][pBusinessOwner];
            new bizName[64]; 
            new bizOwnerName[MAX_PLAYER_NAME]; 
            if(kaska[playerid] < B_CENA_ZMIENMOTD)
            {
                sendErrorMessage(playerid, "Nie posiadasz wystarczaj�cej ilo�ci got�wki!"); 
                return 1;
            }
            if(CheckVulgarityString(inputtext) == 1)
            {
                sendErrorMessage(playerid, "MOTD nie mo�e by� wulgarne!");
                return 1;
            }
            if(!CheckSymbolsInText(inputtext))
            {
                sendErrorMessage(playerid, "B��d - u�yto zablokowanego znaku specjalnego");
                sendTipMessage(playerid, "Je�eli chcesz doda� nazw� biznesu w swoje motd wprowad� w tekst dodatkowo ''[bname]''");
                sendTipMessage(playerid, "Je�eli chcesz doda� sw�j nick w swoje motd wprowad� w tekst dodatkowo ''[oname]''");
                return 1;
            }
            if(strfind(inputtext, "[bname]", false, 0) >= 0)
            {
                format(bizName, sizeof(bizName), "%s", GetBusinessName(bIDE)); 
                new pos = strfind(inputtext, "[bname]"); 
                strdel(inputtext, pos, pos+7);
                strins(inputtext, bizName, pos, 64);
            }
            if(strfind(inputtext, "[oname]", false, 0) >= 0)
            {
                format(bizOwnerName, sizeof(bizOwnerName), "%s", GetNick(playerid)); 
                new pos = strfind(inputtext, "[oname]"); 
                strdel(inputtext, pos, pos+7);
                strins(inputtext, bizOwnerName, pos, 32);
            }
            if(strlen(inputtext) > 64)
            {
                sendErrorMessage(playerid, "Zbyt d�ugie MOTD!"); 
                return 1;
            }
            format(string, sizeof(string), "Zmieni�e� MOTD biznesu %s na %s", GetBusinessName(bIDE), inputtext); 
            sendTipMessage(playerid, string); 
            Log(businessLog, INFO, "%s zmienil motd biznesu %s na %s", GetPlayerLogName(playerid), GetBusinessLogName(bIDE),inputtext);
            ZabierzKase(playerid, B_CENA_ZMIENMOTD); 
            strdel(mBiz[bIDE][b_motd], 0, strlen(mBiz[bIDE][b_motd]));
            strcat(mBiz[bIDE][b_motd], inputtext, MAX_BUSINESS_MOTD); 
            SaveBiz(bIDE); 
        }
    }
    else if(dialogid == DIALOG_BIZ_INTERIORLIST)
    {
        if(!response)
        {
            ShowBusinessOwnerDialog(playerid, DIALOG_MAIN); 
        }
        else
        {
            new bIDE = PlayerInfo[playerid][pBusinessOwner];
            new string[124]; 
            if(kaska[playerid] >= interiorsPos[listitem][i_cost])
            {
                if(interiorsPos[listitem][i_type] != BTYPE_DEFAULT)
                {
                    if(mBiz[bIDE][b_TYPE2] != interiorsPos[listitem][i_type])
                    {
                        sendErrorMessage(playerid, "Nie posiadasz odpowiedniego typu biznesu na ten interior!"); 
                        return 1;
                    }
                }
                ZabierzKase(playerid, interiorsPos[listitem][i_cost]); 
                format(string, sizeof(string), "Kupi�e� interior %s o wielko�ci %s dla swojego biznesu %s!", interiorsPos[listitem][i_name], interiorsPos[listitem][i_size], GetBusinessName(bIDE));
                sendTipMessageEx(playerid, COLOR_RED, string); 
                mBiz[bIDE][b_exX] = interiorsPos[listitem][i_posX];
                mBiz[bIDE][b_exY] = interiorsPos[listitem][i_posY];
                mBiz[bIDE][b_exZ] = interiorsPos[listitem][i_posZ];
                mBiz[bIDE][b_vw] = 1000+bIDE; 
                mBiz[bIDE][b_int] = interiorsPos[listitem][i_int];  
                Log(businessLog, INFO, "%s rozbudowal w swoim biznesie %s interior - %d za $%d", GetPlayerLogName(playerid), GetBusinessLogName(bIDE), listitem, interiorsPos[listitem][i_cost]); 
            }
            else
            {
                sendErrorMessage(playerid, "Nie masz wystarczaj�cej ilo�ci got�wki!"); 
            }
        }
    }
    //-----------------------[Panel w�a�ciciela biznesu - KONIEC]-----------------------
    //:
    //:
    return 1;
}

//end