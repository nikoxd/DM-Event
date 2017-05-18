#if defined DME

				 Death Match Event System By RxErT!
					   First Version: 1.0
				 
#endif


//====== INCLUDES & DEFINES =======//
#include <a_samp>
#include <zcmd>
#include <sscanf>
#define SCM    SendClientMessage //defining SendClientMessage to be more easier to write it and to stop wasting time in writing it completely.
#define SCMTA  SendClientMessageToAll //same to SendClientMessage's story.

//======== EVENT VARIABLES =========//
new InEvent[MAX_PLAYERS]; //Checking player if he is in/out event.
new EventOpened[MAX_PLAYERS]; //Checking if Event is opened to join it.
new weapon; //Weapon variable.
new Float:RandomEventSpawns[][] =
{
    {-1351.4404,27.2709,14.1484,229.3567},
    {-1270.1122,-52.0604,14.1484,44.1982},
    {-1284.0488,13.3623,14.1484,132.5356}
}; //This is Random Event spawns.

//======== FORWARD =========//
forward EventStart(); //we did forwarded this as timer to event stats.

//======= COMMANDS AND MAP AND EVENT THINGYS GOES HERE! ========//
CMD:dmevent(playerid, params[])
{
 if(IsPlayerAdmin(playerid))
 {
   if(EventOpened[playerid] == 0)
   {
   new string[128];
   if(sscanf(params,"i",weapon)) return SCM(playerid,-1,"{fdfe1d}Syntax: {FFFFFF}/dmevent <weaponid>");
   if(weapon < 0 || weapon > 46) return SCM(playerid,-1,"{f00f00}[ERROR]: {F00f00}Invalid WeaponID");
   EventOpened[playerid] = 1;
   SCMTA(-1,"{800080}[EVENT INFO] {fef65b}An Administrator has opened a DM Event!");
   format(string,sizeof(string),"{800080}[EVENT INFO] {fef65b}Type {2faced}/joindm {fef65b}to join the DM Event! {F00f00}(Weapon: %d)",weapon);
   SCMTA(-1,string);
   GameTextForAll("~R~DM ~W~EVENT ~G~OPENED!",3000,3);
   SetTimerEx("EventStart", 1000, false, "i", playerid);
   }
   else
   {
   if(EventOpened[playerid] == 1)
   {
   SCMTA(-1,"{800080}[EVENT INFO] {fef65b}An Administrator has closed the DM Event!");
   GameTextForAll("~R~DM ~W~EVENT ~R~CLOSED!",3000,3);
   EventOpened[playerid] = 0;
   }
   }
 }
 else
 {
 SCM(playerid, -1,"{F00f00}[ERROR]: {FFFFFF}You aren't authorized to use this command!");
 }
 return 1;
}


CMD:fire(playerid,params[])
{
   new string[128];
   new ID;
   new tname[MAX_PLAYER_NAME];
   GetPlayerName(ID, tname,sizeof(tname));
   if(sscanf(params,"ii",ID,params)) return SCM(playerid,-1,"{fdfe1d}Syntax: {FFFFFF}/fire <id> <reason>");
   if(!IsPlayerAdmin(playerid)) return  SCM(playerid, -1, "{F00f00}[ERROR]: {FFFFFF}You are not authorized to use this command!");
   if(!IsPlayerConnected(ID)) return SCM(playerid, -1, "{f00f00}[ERROR]: {FFFFFF}Player isn't connected!");
   if(InEvent[ID] == 0) return SCM(playerid, -1, "{f00f00}[ERROR]: {FFFFFF}Player isn't in the DM Event!");
   format(string,sizeof(string),"{800080}[EVENT FIRE] {Fef65b}%s has been fired from the DM Event! {f00f00}[REASON: %d]",tname,params);
   SCMTA(-1,string);
   InEvent[ID] = 0;
   SpawnPlayer(ID);
   return 1;
}


CMD:joindm(playerid,params[])
{
	   if(InEvent[playerid] == 1) return SendClientMessage(playerid,-1,"{f00f00}[ERROR]: {FFFFFF}You're already in the DM Event!");
	   if(EventOpened[playerid] == 0) return SendClientMessage(playerid, -1,"{f00f00}[ERROR]: {FFFFFF}there isn't any DM Event At moment!");
       new Random = random(sizeof(RandomEventSpawns));
       SetPlayerPos(playerid,RandomEventSpawns[Random][0], RandomEventSpawns[Random][1], RandomEventSpawns[Random][2]);
       TogglePlayerControllable(playerid, 0);
       ResetPlayerWeapons(playerid);
       GivePlayerWeapon(playerid, weapon, 99999);
       SetPlayerArmour(playerid, 100);
       SetPlayerHealth(playerid, 100);
       InEvent[playerid] = 1;
	   SCM(playerid, -1,"{800080}[EVENT INFO] {fef65b}You Have Joined the DM Event!");
       GameTextForPlayer(playerid, "~W~Event Will Start in ~P~Minutes!",3000,3);
       return 1;
}
       
CMD:startdm(playerid, params[])
{
   for(new i = 0; i<MAX_PLAYERS; i++)
   {
  if(IsPlayerConnected(i))
  {
  TogglePlayerControllable(i, 1);
  SCMTA(-1,"{800080}[EVENT STARTED] {fef65b}An Administrator has Started the DM Event!");
  GameTextForPlayer(i, "~W~EVENT ~Y~HAS ~G~BEEN ~B~STARTED!",3000,3);
  if(!IsPlayerAdmin(playerid)) return SCM(playerid, -1, "{f00f00}[ERROR]: {FFFFFF}You are not authorized to use this command!");
  EventOpened[playerid] = 0;
  InEvent[playerid] = 1;
  }
   }
   return 1;
}

public EventStart()
{
CreateObject(3453, -1221.230957, 432.340606, 9.336962, 0.000000, 0.000000, 0.000000);
CreateObject(3452, -1215.755615, 460.229461, 9.311964, 0.000000, 0.000000, 90.000000);
CreateObject(3453, -1222.101562, 474.111846, 9.367557, 0.000000, 0.000000, 90.000000);
CreateObject(3452, -1251.935424, 479.604248, 9.405378, 0.000000, 0.000000, 180.000000);
CreateObject(3453, -1241.440185, -24.832351, 15.722908, 0.000000, 0.000000, 45.000000);
CreateObject(3452, -1258.452270, -0.125663, 15.747909, 0.000000, 0.000000, 134.999969);
CreateObject(3452, -1300.089477, 41.548461, 15.697910, 0.000000, 0.000000, 134.999969);
CreateObject(3453, -1325.257934, 57.730583, 15.647909, 0.000000, 0.000000, 134.999969);
CreateObject(3452, -1350.413452, 40.271453, 15.647911, 0.000000, 0.000000, 225.000030);
CreateObject(3452, -1371.132446, 19.394195, 15.672910, 0.000000, 0.000000, 225.000030);
CreateObject(3452, -1257.617675, -50.034523, 15.722909, 0.000000, 0.000000, 45.000000);
CreateObject(3452, -1278.682861, -70.883903, 15.697908, 0.000000, 0.000000, 45.000000);
CreateObject(3453, -1386.855834, -5.336665, 15.715358, 0.000000, 0.000000, 225.000030);
CreateObject(3453, -1303.802490, -88.125671, 15.647909, 0.000000, 0.000000, 315.000000);
CreateObject(3452, -1369.440307, -30.486749, 15.747909, 0.000000, 0.000000, 315.000000);
CreateObject(3452, -1328.677368, -72.280700, 15.597913, 0.000000, 0.000000, 315.000000);
CreateObject(3279, -1327.697753, 47.628265, 13.224054, 0.000000, 0.000000, 134.999969);
CreateObject(3279, -1373.739013, 1.586212, 13.224054, 0.000000, 0.000000, 134.999969);
CreateObject(3279, -1253.568603, -26.533119, 13.224054, 0.000000, 0.000000, 315.000000);
CreateObject(3279, -1299.551025, -72.534378, 13.224054, 0.000000, 0.000000, 315.000000);
CreateObject(16776, -1241.716308, -69.387710, 22.292963, 0.000000, 0.000000, 315.000000);
CreateObject(7392, -1262.929931, 32.618263, 40.102794, 0.000000, 0.000000, 45.000000);
CreateObject(7073, -1277.822631, 50.415985, 31.428398, 0.000000, 0.000000, 45.000000);
CreateObject(3452, -1279.342285, 20.789491, 15.722909, 0.000000, 0.000000, 134.999969);
CreateObject(3749, -1346.161132, -48.366500, 19.006851, 0.000000, 0.000000, 315.000000);
CreateObject(971, -1357.530395, -39.579605, 16.718370, 0.000000, 0.000000, 225.000030);
CreateObject(971, -1362.657348, -44.729606, 16.743370, 0.000000, 0.000000, 45.000000);
CreateObject(971, -1352.056396, -39.570392, 16.768369, 0.000000, 0.000000, 134.999969);
CreateObject(971, -1337.760986, -60.380943, 16.743370, 0.000000, 0.000000, 225.000030);
CreateObject(971, -1342.364746, -65.028961, 16.743370, 0.000000, 0.000000, 225.000030);
CreateObject(971, -1337.698242, -54.490985, 16.693370, 0.000000, 0.000000, 134.999969);
CreateObject(14467, -1354.408935, -46.069114, 15.882230, 0.000000, 0.000000, 45.000000);
CreateObject(14467, -1343.873657, -57.543529, 15.882230, 0.000000, 0.000000, 225.000030);
CreateObject(10281, -1253.928955, 16.057811, 27.112640, 0.000000, 0.000000, 315.000000);
CreateObject(9527, -1348.007324, -50.055614, 20.397682, 0.000000, 0.000000, 315.000000);
CreateObject(9191, -1339.683349, -74.586944, 16.470876, 0.000000, 0.000000, 315.000000);
CreateObject(9190, -1327.904907, -86.385421, 16.420877, 0.000000, 0.000000, 315.000000);
CreateObject(9190, -1371.315429, -41.996185, 16.470876, 0.000000, 0.000000, 315.000000);
CreateObject(9191, -1382.572875, -30.718606, 16.470876, 0.000000, 0.000000, 315.000000);
CreateObject(9188, -1394.302368, -18.988555, 16.470876, 0.000000, 0.000000, 315.000000);
CreateObject(9188, -1316.148437, -98.181648, 16.420877, 0.000000, 0.000000, 315.000000);
CreateObject(7093, -1352.766357, -41.006092, 25.340902, 0.000000, 0.000000, 0.000000);
CreateObject(9191, -1400.149291, -4.900668, 16.470876, 0.000000, 0.000000, 270.000000);
CreateObject(972, -1387.840576, 11.532464, 12.677876, 0.000000, 0.000000, 134.999969);
CreateObject(972, -1370.220947, 29.158786, 12.685426, 0.000000, 0.000000, 134.999984);
CreateObject(972, -1352.855712, 46.681182, 12.660427, 0.000000, 0.000000, 134.999984);
CreateObject(972, -1338.070312, 61.488784, 12.685424, 0.000000, 0.000000, 134.999984);
CreateObject(972, -1319.473388, 64.975769, 12.658924, 0.000000, 0.000000, 78.750000);
CreateObject(9190, -1302.253662, -102.315498, 16.420877, 0.000000, 0.000000, 11.250030);
CreateObject(972, -1289.466796, -91.362266, 12.410429, 0.000000, 0.000000, 315.000000);
CreateObject(972, -1271.873901, -73.712463, 12.382879, 0.000000, 0.000000, 315.000000);
CreateObject(972, -1254.444335, -56.299110, 12.418819, 0.000000, 0.000000, 315.000000);
CreateObject(972, -1239.102050, -38.207252, 12.504232, 0.000000, 0.000000, 326.249969);
CreateObject(972, -1233.524902, -18.601697, 12.585428, 0.000000, 0.000000, 11.250030);
CreateObject(972, -1242.772094, 1.222285, 12.620326, 0.000000, 0.000000, 45.000000);
CreateObject(972, -1260.213378, 18.620136, 12.645326, 0.000000, 0.000000, 45.000000);
CreateObject(972, -1300.708129, 53.481170, 12.645326, 0.000000, 0.000000, 45.000000);
CreateObject(972, -1280.746337, 37.279335, 12.545328, 0.000000, 0.000000, 56.250000);
CreateObject(974, -1268.357666, 32.086219, 15.768571, 0.000000, 0.000000, 315.000000);
CreateObject(987, -1243.385375, 33.131969, 12.820373, 0.000000, 0.000000, 134.999969);
CreateObject(987, -1249.803222, 39.503234, 12.862133, 0.000000, 0.000000, 134.999969);
CreateObject(982, -1263.090332, -32.494636, 13.831992, 0.000000, 0.000000, 315.000000);
CreateObject(982, -1281.185913, -50.588050, 13.804745, 0.000000, 0.000000, 315.000000);
CreateObject(983, -1292.503295, -61.968704, 13.781992, 0.000000, 0.000000, 315.000000);
CreateObject(983, -1297.052124, -66.487190, 13.781992, 0.000000, 0.000000, 134.999969);
CreateObject(982, -1311.596801, -63.880908, 13.831992, 0.000000, 0.000000, 45.000000);
CreateObject(982, -1329.769409, -45.746337, 13.806992, 0.000000, 0.000000, 45.000000);
CreateObject(982, -1347.868774, -27.644811, 13.831992, 0.000000, 0.000000, 45.000000);
CreateObject(982, -1365.989990, -9.540893, 13.856991, 0.000000, 0.000000, 45.000000);
CreateObject(982, -1364.442382, 7.443561, 13.831992, 0.000000, 0.000000, 315.000000);
CreateObject(982, -1346.335815, 25.531946, 13.831992, 0.000000, 0.000000, 315.000000);
CreateObject(983, -1334.998413, 36.842609, 13.831992, 0.000000, 0.000000, 315.000000);
CreateObject(983, -1330.491943, 41.277942, 13.831992, 0.000000, 0.000000, 134.999969);
CreateObject(983, -1327.098388, 44.698101, 13.831992, 0.000000, 0.000000, 134.999969);
CreateObject(982, -1315.922607, 39.280868, 13.831992, 0.000000, 0.000000, 45.000000);
CreateObject(982, -1297.836425, 21.188003, 13.856991, 0.000000, 0.000000, 45.000000);
CreateObject(982, -1279.721069, 3.056617, 13.881991, 0.000000, 0.000000, 45.000000);
CreateObject(982, -1261.634643, -14.932929, 13.856991, 0.000000, 0.000000, 45.000000);
}

public OnPlayerSpawn(playerid)
{
   InEvent[playerid] = 0;
   TogglePlayerControllable(playerid, 1);
   return 1;
}

CMD:dmcmds(playerid, params[])
{
   if(IsPlayerAdmin(playerid))
   {
   new string[500];
   strcat(string, "{fef65b}/dmevent {1ffdc4}-> {fd1f58}to create the DM event!\n");
   strcat(string, "{fef65b}/dmevent {1ffdc4}-> {fd1f58}again type to close the event!\n");
   strcat(string, "{fef65b}/startdm {1ffdc4}-> {fd1f58}to start the DM event!\n");
   strcat(string, "{fef65b}/fire{1ffdc4} -> {fd1f58}to fire/kick someone from the DM event!\n\n");
   strcat(string, "{bbbbee}This DM Event system was created By: {fdfe1d}RxErT!");
   ShowPlayerDialog(playerid, 1884, DIALOG_STYLE_MSGBOX,"DM Event - Commands", string, "Ok", "");
   }
   else
   {
   SCM(playerid, -1, "{F00f00}[ERROR]: {FFFFFF}You are not authorized to use this command!");
   }
   return 1;
}
