//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   napad                                                   //
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
// Data utworzenia: 26.01.2020


//

//------------------<[ Implementacja: ]>-------------------
command_napad_Impl(playerid, actionToDo[64], giveplayerid)
{
    if(IsAPrzestepca(playerid) && IsAPrzestepca(giveplayerid))
    {
        sendErrorMessage(playerid, "Ty lub osoba, kt�r� pr�bujesz doda�/usun�� nie jeste�cie w organizacji przest�pczej!");
        noAccessMessage(playerid);  
        return 1;
    }
    if(PlayerInfo[playerid][pRank] <= 4)
    {
        sendErrorMessage(playerid, "Potrzebujesz rangi > 4 aby m�c organizowa� napady.");
        return 1;
    }
    if(GetPlayerOrg(playerid) != GetPlayerOrg(giveplayerid))
    {
        sendErrorMessage(playerid, "Nie jeste�cie w tej samej organizacji!"); 
        return 1;
    }
    if(GetPlayerOrgType(playerid) != ORG_TYPE_GANG)
    {
        sendErrorMessage(playerid, "Napada� mog� tylko gangi"); 
        return 1;
    }
    new playeridORG = GetPlayerOrg(playerid);  
    if(strcmp(actionToDo, "dodaj", false) == true)
    {
        for(new i; i != MAX_TEAMROBBERY+1; i++)
        {
            if(RobbersFromOrg[playeridORG] == MAX_TEAMROBBERY)
            {
                format(string, sizeof(string), "Masz ju� maksymaln� liczb� cz�onk�w napadu [%d]. Nie mo�esz doda� kolejnego!", MAX_TEAMROBBERY); 
                sendErrorMessage(playerid, string); 
                break; 
            }
            if(robberyTeam[playeridORG][i] != INVALID_PLAYERID)
            {
                robberyTeam[playeridORG][i] = giveplayerid; 
                isRobbery[giveplayerid] = true;
                isRobbery[playerid] = true;
                RobbersFromOrg[playeridORG]++;  
            }
        }
    }
    else if(strcmp(actionToDo, "usu�", false) == true)
    {
        if(!isRobbery[giveplayerid])
        {
            sendErrorMessage(playerid, "Ta osoba nie jest w grupie napadu!"); 
            return 1;
        }
        if(isRobbery[playerid])
        {
            sendErrorMessage(playerid, "Nie organizujesz napadu!"); 
            return 1;
        }
        for(new i; i != MAX_TEAMROBBERY+1; i++)
        {
            if(robberyTeam[playeridORG][i] == giveplayerid)
            {
                RemovePlayerFromRobbery(giveplayerid); 
                robberyTeam[playeridORG][i] == INVALID_PLAYERID;
                sendTipMessage(playerid, "Pomy�lnie usuni�to tego gracza z teamu napadu!"); 
                break;
            }
        }

    }
    else 
    {
        sendErrorMessage(playerid, "Nieprawid�owa czynno��, u�yj [Dodaj [ID]] lub [Usu� [ID]].")
    }
    return 1;
}

//end