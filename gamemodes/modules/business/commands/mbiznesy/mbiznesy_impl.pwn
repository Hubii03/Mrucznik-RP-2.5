//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  mbiznesy                                                 //
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
command_mbiznesy_Impl(playerid)
{
    SendClientMessage(playerid, COLOR_GREEN, "==========<[ Biznesy Mrucznik Role Play 2.0 ]>==========");
    SendClientMessage(playerid, COLOR_WHITE, "Autor: Simeone");
    SendClientMessage(playerid, COLOR_WHITE, "Nowy system biznes�w Mrucznik Role Play opiera si� na dowolno�ci wyboru."); 
    SendClientMessage(playerid, COLOR_WHITE, "Gracz mo�e wybra� jaki typ biznesu chce prowadzi�, a tak�e swobodnie wybra� lokalizacj� w mie�cie.");
    SendClientMessage(playerid, COLOR_WHITE, "Biznesy s� stale aktualizowane, zapisywane, dokumentowane - dzi�ki czemu straty z tym zwi�zane s� minimalne.");
    SendClientMessage(playerid, COLOR_WHITE, "Gracze uzyskuj� komendy takie jak: /mbizbuy /mbizsell, /mbizinvite, /mbizquit [..]");
    SendClientMessage(playerid, COLOR_WHITE, "Aby zakupi� w�asny biznes nale�y uda� si� do urz�du miasta, dozwolone s� 2 typy [.]");
    SendClientMessage(playerid, COLOR_WHITE, "[.] Przemys�owy, Us�ugowy. Us�ugowe s� to np. sklepy 24/7, kasyna, restauracje.");
    SendClientMessage(playerid, COLOR_WHITE, "Przemys�owe s� to np. Kopalnie, rafinerie, fabryki odzie�y. ");
    SendClientMessage(playerid, COLOR_GREEN, "=====================<[ Koniec ]>====================");
    return 1;
}

//end