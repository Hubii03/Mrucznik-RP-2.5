//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  mbizedit                                                 //
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
// Data utworzenia: 06.02.2020


//

//------------------<[ Implementacja: ]>-------------------
command_mbizedit_Impl(playerid, bIDE)
{
    new string[124];
    if(!IsABusinessGod(playerid))
    {
        sendErrorMessage(playerid, "Nie maszu prawnie� do zarz�dzania biznesami!"); 
        return 1;
    }
    if(!BizExist(bIDE))
    {
        sendErrorMessage(playerid, "Nie ma takiego biznesu!"); 
        return 1;
    }
    new bChoiceEdit = GetPVarInt(playerid, "bizChoice");
    new Float:pPosX, Float:pPosY, Float:pPosZ;
    new pBVW = GetPlayerVirtualWorld(playerid);
    new pBINT = GetPlayerInterior(playerid); 
    new pBLocal = GetPLocal(playerid); 
    GetPlayerPos(playerid, pPosX, pPosY, pPosZ);
    if(bChoiceEdit == BIZ_CHOICE_NOTHING)
    {
        ShowPlayerDialogEx(playerid, DIALOG_BIZ_ADMINEDIT, DIALOG_STYLE_LIST, "Mrucznik Role Play", "Przenie� wej�cie\nDodaj wyj�cie\nUsu� biznes\nUsu� w�a�ciciela\nWyzeruj pieni�dze biznesu\nZmie� cene biznesu", "Dalej", "Odrzu�"); 
    }
    else if(bChoiceEdit == BIZ_CHOICE_PRZENIES)
    {
        mBiz[bIDE][b_enX] = pPosX;
        mBiz[bIDE][b_enY] = pPosY;
        mBiz[bIDE][b_enZ] = pPosZ; 
        sendTipMessageEx(playerid, COLOR_GREEN, "Pomy�lnie przeniesiono biznes na nowe koordynaty"); 
        sendTipMessage(playerid, "Twoje poczynanie zosta�o zapisane do log�w serwera."); 
        SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_NOTHING);
        SaveBiz(bIDE);
    } 
    else if(bChoiceEdit == BIZ_CHOICE_DODAJ)
    {
        mBiz[bIDE][b_exX] = pPosX;
        mBiz[bIDE][b_exY] = pPosY;
        mBiz[bIDE][b_exZ] = pPosZ; 
        mBiz[bIDE][b_vw] = pBVW;
        mBiz[bIDE][b_int] = pBINT; 
        mBiz[bIDE][b_pLocal] = pBLocal;
        sendTipMessageEx(playerid, COLOR_GREEN, "Pomy�lnie dodano wyj�cie do interioru"); 
        format(string, sizeof(string), "PosX: %f", pPosX);
        sendTipMessage(playerid, string);
        format(string, sizeof(string), "PosY: %f", pPosY);
        sendTipMessage(playerid, string);
        format(string, sizeof(string), "PosZ: %f", pPosZ);
        sendTipMessage(playerid, string);
        format(string, sizeof(string), "VW: [%d] INT: [%d] pLocal: [%d]", pBVW, pBINT, pBLocal);
        sendTipMessage(playerid, string);
        sendTipMessage(playerid, "Twoje poczynanie zosta�o zapisane do log�w serwera."); 
        SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_NOTHING);
        SaveBiz(bIDE); 
    }
    else if(bChoiceEdit == BIZ_CHOICE_USUN_BIZ)
    {
        sendTipMessage(playerid, "Ta opcja ju� niebawem!"); 
        SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_NOTHING);
    }
    else if(bChoiceEdit == BIZ_CHOICE_USUN_WLAS)
    {
        mysql_real_escape_string("Brak", mBiz[bIDE][b_Name_Owner]);
        mBiz[bIDE][b_ownerUID] = 0; 
        mBiz[bIDE][b_TYPE] = BTYPE_DEFAULT;
        mBiz[bIDE][b_TYPE2] = BTYPE2_DEFAULT;
        mBiz[bIDE][b_moneyPocket] = 0; 
        sendTipMessageEx(playerid, COLOR_RED, "Usuni�to w�a�ciciela biznesu, wyzerowano stan got�wki i typy");
        sendTipMessage(playerid, "Twoje poczynanie zosta�o zapisane do log�w serwera.");  
        SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_NOTHING);
    }
    else if(bChoiceEdit == BIZ_CHOICE_WYZERUJ_KASE)
    {
        mBiz[bIDE][b_moneyPocket] = 0;
        sendTipMessageEx(playerid, COLOR_RED, "Wyzerowano kas� biznesu!"); 
        sendTipMessage(playerid, "Twoje poczynanie zosta�o zapisane do log�w serwera."); 
        SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_NOTHING);
    }
    else
    {
        sendErrorMessage(playerid, "Nieznany dla systemu wyb�r!"); 
        SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_NOTHING);
    }
    return 1;
}

//end