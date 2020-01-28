//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 mojagrupa                                                 //
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
// Kod wygenerowany automatycznie narz�dziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN� NADPISANE PO WYWO�ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================


//-------<[ include ]>-------
#include "mojagrupa_impl.pwn"

//-------<[ initialize ]>-------
command_mojagrupa()
{
    new command = Command_GetID("mojagrupa");

    //aliases
    Command_AddAlt(command, "mygroup");
    Command_AddAlt(command, "grupanapadu");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:mojagrupa(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komenda, kt�ra ukazuje spis os�b bior�cych udzia� w organizowanym przez nas napadzie.");
        return 1;
    }
    
    
    //command body
    return command_mojagrupa_Impl(playerid);
}