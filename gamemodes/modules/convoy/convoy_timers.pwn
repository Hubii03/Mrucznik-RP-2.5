//-----------------------------------------------<< Timers >>------------------------------------------------//
//                                                   convoy                                                  //
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
// Data utworzenia: 20.10.2019
//Opis:
/*
	System konwoj�w.
*/

//

//-----------------<[ Timery: ]>-------------------
task ConvoyTimer[1000]()
{
	if(convoyCar != -1)
	{
		new Float:health;
		GetVehicleHealth(convoyCar, Float:health);

		//utrata hp przez pojazd konwojowy
		if(health < CONVOY_CAR_HP/2 && health < convoyCarHP)
		{
			convoyCarHPAcc += convoyCarHP - health;
			convoyCarHP = health;

			new hpPerPackage = CONVOY_HP_PER_PACKAGE;
			if(convoyCarHPAcc >= hpPerPackage)
			{
				convoyCarHPAcc -= hpPerPackage;
				DropBoxFromCar(convoyCar);
			}
		}

		//zniszczenie pojazdu konwojowego
		if(health < 350) {
			StopConvoy();
		}
	}
}

timer ConvoyDelay[10800]()
{
	convoyDelayed = false;
	foreach(new i : Player)
	{
		if(IsACop(i))
		{
			SendClientMessage(i, COLOR_LFBI, "HQ: Kolejny konw�j z towarem czeka na zorganizowanie.");
		}
	}
}

//end