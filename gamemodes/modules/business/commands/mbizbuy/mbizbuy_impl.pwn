//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  mbizbuy                                                  //
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

//------------------<[ Implementacja: ]>-------------------
command_mbizbuy_Impl(playerid)
{
    new string[124]; 
    if(PlayerInfo[playerid][pLVL] < LVL_TO_BUY_BIZ)
    {
        format(string, sizeof(string), "Nie mo�esz zakupi� biznesu, musisz posiada� %d LVL!", LVL_TO_BUY_BIZ);
        sendErrorMessage(playerid, string); 
        return 1;
    }
    if(GetPLocal(playerid) != PLOCAL_FRAC_DMV)
    {
        sendErrorMessage(playerid, "Aby tego u�y� musisz si� znajdowa� w Urz�dzie Miasta!"); 
        return 1;
    }
    ShowPlayerDialogEx(playerid, DIALOG_BIZ_BUY, DIALOG_STYLE_INPUT, "Zakup biznes", "Wprowad� poni�ej numer biznesu, kt�ry chcia�by� zakupi�:", "Dalej", "Anuluj");
    return 1;
}

//end