//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  komendy                                                  //
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
// Autor: Mrucznik
// Data utworzenia: 13.05.2019
//Opis:
/*
	Podstawowe komendy.
*/

//

#include <YSI\y_hooks>


//-----------------<[ Callbacki: ]>-----------------
/*
        Error & Return type

    COMMAND_ZERO_RET      = 0 , // The command returned 0.
    COMMAND_OK            = 1 , // Called corectly.
    COMMAND_UNDEFINED     = 2 , // Command doesn't exist.
    COMMAND_DENIED        = 3 , // Can't use the command.
    COMMAND_HIDDEN        = 4 , // Can't use the command don't let them know it exists.
    COMMAND_NO_PLAYER     = 6 , // Used by a player who shouldn't exist.
    COMMAND_DISABLED      = 7 , // All commands are disabled for this player.
    COMMAND_BAD_PREFIX    = 8 , // Used "/" instead of "#", or something similar.
    COMMAND_INVALID_INPUT = 10, // Didn't type "/something".
*/ 
public e_COMMAND_ERRORS:OnPlayerCommandPerformed(playerid, cmdtext[], e_COMMAND_ERRORS:success)
{
	#if DEBUG == 1
		printf("%s wykonal komende %s", GetNick(playerid), cmdtext);
	#endif
	return success;
}

/*
        Error & Return type

    COMMAND_ZERO_RET      = 0 , // The command returned 0.
    COMMAND_OK            = 1 , // Called corectly.
    COMMAND_UNDEFINED     = 2 , // Command doesn't exist.
    COMMAND_DENIED        = 3 , // Can't use the command.
    COMMAND_HIDDEN        = 4 , // Can't use the command don't let them know it exists.
    COMMAND_NO_PLAYER     = 6 , // Used by a player who shouldn't exist.
    COMMAND_DISABLED      = 7 , // All commands are disabled for this player.
    COMMAND_BAD_PREFIX    = 8 , // Used "/" instead of "#", or something similar.
    COMMAND_INVALID_INPUT = 10, // Didn't type "/something".
*/ 
public e_COMMAND_ERRORS:OnPlayerCommandReceived(playerid, cmdtext[], e_COMMAND_ERRORS:success)
{
	#if DEBUG == 1
		printf("%s wpisal komende %s", GetNick(playerid), cmdtext);
	#endif

	//antyspam
    if(GetTickDiff(GetTickCount(), StaryCzas[playerid]) < 100)
	{
		SendClientMessage(playerid, COLOR_WHITE, "SERWER: "SZARY"Odczekaj chwil� zanim wpiszesz nast�pn� komende!");
		return COMMAND_OK;
	}
	else 
	{
		StaryCzas[playerid] = GetTickCount();
	}

	if(GUIExit[playerid] != 0 || gPlayerLogged[playerid] == 0)
	{
		SendClientMessage(playerid, COLOR_WHITE, "SERWER: "SZARY"Nie jeste� zalogowany/Masz otwarte okno dialogowe!");
		return COMMAND_DENIED;
	}

    if(IsCommandBlocked(cmdtext))
    {
        SendClientMessage(playerid, COLOR_WHITE, "SERWER: "SZARY"Komenda jest wy��czona.");
        return COMMAND_DISABLED;
    }

	switch(success)
	{
		case COMMAND_ZERO_RET:
		{
			sendErrorMessage(playerid, "Komenda zwr�ci�a warto�� zerow�."); //TODO: delete
		}
		case COMMAND_BAD_PREFIX:
		{
			sendErrorMessage(playerid, "Z�y prefix! U�yj \"/\".");
		}
		case COMMAND_DENIED:
		{
			sendErrorMessage(playerid, "Nie jeste� uprawniony do u�ywania tej komendy.");
		}
		case COMMAND_INVALID_INPUT:
		{
			sendErrorMessage(playerid, "Podano nieprawid�owe argumenty do komendy.");
		}
		case COMMAND_NO_PLAYER:
		{
			sendErrorMessage(playerid, "Nie powiniene� istnie�.");
		}
		case COMMAND_UNDEFINED, COMMAND_HIDDEN:
		{
			sendErrorMessage(playerid, "Ta komenda nie istnieje. Wpisz /komendy aby zobaczy� list� dost�pnych komend.");
		}
	}

	return success;
}

//-----------------<[ Funkcje: ]>-------------------
RunCommand(playerid, command[], params[]) //temporary
{
	return Command_ReProcess(playerid, sprintf("%s %s", command, params), false);
}

//-----------------<[ Timery: ]>-------------------
//------------------<[ MySQL: ]>--------------------

//end