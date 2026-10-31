// Path Helper: places and quests a mod broke (autoloot took the item a quest waits for, a wall can no longer be destroyed...)
// Progress on the Path comes precompiled, so nothing here uses its code. A place counts as done in PotP and in the game
// when its map pin is discovered and greyed out, the state the game gives a cleared place. That is what these commands set.
//
// qpins( r )  - every map pin within r metres (default 30): type and state, also written to scriptslog.txt
// qdone( r )  - clear every unfinished place within r metres (default 50) and open the "?" around
// qfix()      - on the loaded map: open every "?" the game already counts as done (greyed out, never discovered)
// qdoneall()  - how many unfinished places are on the loaded map; qdoneall( "", 1 ) clears ALL of them, done or not
// questdone() - finish the quest tracked in the journal (not main quests)
// qevent( r ) - mark Progress on the Path random events ("!") within r metres (default 10) as done
// With the -debugscripts launch option every message is also written to Documents\The Witcher 3\scriptslog.txt

// The notification can expire unseen while the console is open, the log keeps it
function PHP_Say( text : string )
{
	LogChannel( 'PathHelper', StrReplaceAll( text, "<br>", " | " ) );
	theGame.GetGuiManager().ShowNotification( text );
}

function PHP_Bool( value : bool ) : string
{
	if ( value )
		return "1";
	return "0";
}

// 0 - not a place, 1 - discover only (signposts, stashes...), 2 - discover and grey out (nests, camps, treasure...)
function PHP_PinKind( type : name ) : int
{
	var regularTypes, disabledTypes, discoverable : array< name >;
	var manager : CCommonMapManager;

	manager = theGame.GetCommonMapManager();
	manager.GetDisableableMapPinTypes( regularTypes, disabledTypes );
	if ( regularTypes.Contains( type ) )
		return 2;
	manager.GetDiscoverableMapPinTypes( discoverable );
	if ( discoverable.Contains( type ) )
		return 1;
	return 0;
}

function PHP_IsUnfinished( pin : SCommonMapPinInstance ) : bool
{
	var kind : int;

	if ( pin.tag == '' )
		return false;
	kind = PHP_PinKind( pin.type );
	// a greyed out place can still hang as "?" when it was never discovered
	return ( kind == 2 && ( !pin.isDisabled || !pin.isDiscovered ) ) || ( kind == 1 && !pin.isDiscovered );
}

// A signpost is only discovered, a disabled signpost would block fast travel
function PHP_ClearPin( pin : SCommonMapPinInstance )
{
	var manager : CCommonMapManager;

	manager = theGame.GetCommonMapManager();
	manager.SetEntityMapPinKnown( pin.tag, true );
	manager.SetEntityMapPinDiscoveredScript( pin.type == 'RoadSign' || pin.type == 'Harbor', pin.tag, true );
	if ( PHP_PinKind( pin.type ) == 2 )
		manager.SetEntityMapPinDisabled( pin.tag, true );
	LogChannel( 'PathHelper', "cleared " + NameToString( pin.tag ) + " type=" + NameToString( pin.type )
		+ " disabled=" + PHP_Bool( manager.IsEntityMapPinDisabled( pin.tag ) ) );
}

function PHP_Pins() : array< SCommonMapPinInstance >
{
	return theGame.GetCommonMapManager().GetMapPinInstances( theGame.GetWorld().GetDepotPath() );
}

exec function qpins( optional radius : float )
{
	var pins : array< SCommonMapPinInstance >;
	var playerPos : Vector;
	var line, text : string;
	var i, shown : int;

	if ( radius <= 0 )
		radius = 30;

	playerPos = thePlayer.GetWorldPosition();
	LogChannel( 'PathHelper', "qpins: area " + NameToString( theGame.GetCommonMapManager().GetCurrentArea() )
		+ ", world " + theGame.GetWorld().GetDepotPath() + ", at " + VecToString( playerPos ) );

	pins = PHP_Pins();
	for ( i = 0; i < pins.Size(); i += 1 )
	{
		if ( VecDistance2D( playerPos, pins[i].position ) > radius )
			continue;
		line = NameToString( pins[i].tag ) + " type=" + NameToString( pins[i].type ) + " visible=" + NameToString( pins[i].visibleType )
			+ " known=" + PHP_Bool( pins[i].isKnown ) + " discovered=" + PHP_Bool( pins[i].isDiscovered ) + " disabled=" + PHP_Bool( pins[i].isDisabled )
			+ " dist=" + FloorF( VecDistance2D( playerPos, pins[i].position ) );
		LogChannel( 'PathHelper', line );
		if ( shown < 8 )
			text += NameToString( pins[i].type ) + " " + FloorF( VecDistance2D( playerPos, pins[i].position ) ) + " m"
				+ " d" + PHP_Bool( pins[i].isDiscovered ) + " x" + PHP_Bool( pins[i].isDisabled ) + "<br>";
		shown += 1;
	}
	PHP_Say( "Map pins within " + FloorF( radius ) + " m: " + shown + "<br>" + text + "(d - discovered, x - greyed out)" );
}

// qdone( r ) - for a place you cannot finish: stand there and clear everything unfinished within r metres
exec function qdone( optional radius : float )
{
	var pins : array< SCommonMapPinInstance >;
	var playerPos : Vector;
	var text : string;
	var i, cleared : int;

	if ( radius <= 0 )
		radius = 50;

	playerPos = thePlayer.GetWorldPosition();
	pins = PHP_Pins();
	for ( i = 0; i < pins.Size(); i += 1 )
	{
		if ( VecDistance2D( playerPos, pins[i].position ) > radius || !PHP_IsUnfinished( pins[i] ) )
			continue;
		PHP_ClearPin( pins[i] );
		if ( cleared < 10 )
			text += NameToString( pins[i].type ) + "<br>";
		cleared += 1;
	}

	if ( cleared == 0 )
	{
		PHP_Say( "Nothing unfinished within " + FloorF( radius ) + " m. Try a bigger radius: qdone(100), or qpins() to see the pins" );
		return;
	}
	PHP_Say( "Cleared within " + FloorF( radius ) + " m: " + cleared + "<br>" + text );
}

// Only the loaded map can be changed. Velen and Novigrad are one map.
function PHP_WorldMatches( regionName : string ) : bool
{
	var path : string;

	path = theGame.GetWorld().GetDepotPath();
	regionName = StrLower( regionName );
	if ( regionName == "" )										return true;
	if ( regionName == "velen" || regionName == "novigrad" )	return StrFindFirst( path, "novigrad" ) >= 0;
	if ( regionName == "skellige" )								return StrFindFirst( path, "skellige" ) >= 0;
	if ( regionName == "toussaint" )							return StrFindFirst( path, "bob" ) >= 0;
	if ( regionName == "whiteorchard" )							return StrFindFirst( path, "prolog" ) >= 0;
	if ( regionName == "kaermorhen" )							return StrFindFirst( path, "kaer_morhen" ) >= 0;
	if ( regionName == "vizima" )								return StrFindFirst( path, "wyzima" ) >= 0;
	return false;
}

// qdoneall()        - how many places ("?" included) are unfinished on the loaded map
// qdoneall( "", 1 ) - clear ALL of them, broken or not. A name ("skellige") only checks that you are there.
exec function qdoneall( optional regionName : string, optional confirm : int )
{
	var pins : array< SCommonMapPinInstance >;
	var i, places, hidden : int;

	if ( !PHP_WorldMatches( regionName ) )
	{
		PHP_Say( "Only the map you are on can be changed. Travel to " + regionName + " first.<br>Names: whiteorchard, velen, novigrad, skellige, toussaint, kaermorhen, vizima" );
		return;
	}

	pins = PHP_Pins();
	for ( i = 0; i < pins.Size(); i += 1 )
	{
		if ( !PHP_IsUnfinished( pins[i] ) )
			continue;
		places += 1;
		if ( !pins[i].isDiscovered )
			hidden += 1;
		if ( confirm == 1 )
			PHP_ClearPin( pins[i] );
	}

	if ( confirm != 1 )
	{
		PHP_Say( "Unfinished places on this map: " + places + " (still \"?\": " + hidden + ")"
			+ "<br>This clears ALL of them, broken or not. Save first, then:<br>qdoneall(\"" + regionName + "\", 1)" );
		return;
	}
	PHP_Say( "Cleared on this map: " + places + " places. Progress on the Path updates in a few seconds." );
}

// questdone() - a quest that can no longer be finished: track it in the journal, then run this.
//                Completes it in the journal, PotP reads the journal. Main quests are refused.
exec function questdone()
{
	var journal : CWitcherJournalManager;
	var jquest : CJournalQuest;

	journal = theGame.GetJournalManager();
	jquest = journal.GetTrackedQuest();
	if ( !jquest )
	{
		PHP_Say( "Track the broken quest in the journal first." );
		return;
	}
	if ( jquest.GetType() == Story || jquest.GetType() == Chapter )
	{
		PHP_Say( "This is a main quest, finishing it by hand can break the story." );
		return;
	}
	journal.ActivateEntry( jquest, JS_Success, true );
	PHP_Say( "Quest completed." );
}

// qfix() - the safe one for a whole map: only places the game already counts as done but still shows as "?".
//                Unfinished places are left alone.
exec function qfix()
{
	var manager : CCommonMapManager;
	var pins : array< SCommonMapPinInstance >;
	var i, fixed : int;

	manager = theGame.GetCommonMapManager();
	pins = PHP_Pins();
	for ( i = 0; i < pins.Size(); i += 1 )
	{
		if ( pins[i].tag == '' || !pins[i].isDisabled || pins[i].isDiscovered )
			continue;
		manager.SetEntityMapPinKnown( pins[i].tag, true );
		manager.SetEntityMapPinDiscoveredScript( pins[i].type == 'RoadSign' || pins[i].type == 'Harbor', pins[i].tag, true );
		LogChannel( 'PathHelper', "fixed " + NameToString( pins[i].tag ) + " type=" + NameToString( pins[i].type ) );
		fixed += 1;
	}
	PHP_Say( "Bugged \"?\" fixed on this map: " + fixed + "<br>(done places that still showed as \"?\")" );
}

// Random events ("!" on the map) are Progress on the Path's own pins. PotP counts an event as done when the fact named after it
// exists, a fact only PotP reads, so the game's own quests are not touched.
struct PHP_Event
{
	var world : string;
	var fact : string;
	var pos : Vector;
}

function PHP_AddEvent( out events : array< PHP_Event >, world : string, fact : string, x : float, y : float )
{
	var e : PHP_Event;

	e.world = world;
	e.fact = fact;
	e.pos = Vector( x, y );
	events.PushBack( e );
}

// Copied from PotP's EventDefinitions.ws
function PHP_Events() : array< PHP_Event >
{
	var events : array< PHP_Event >;

	PHP_AddEvent( events, "novigrad", "PotP_Event_AtTheMercyOfStrangers_1_NG", 641.454102, 533.142456 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_CaravanAttack_NG_1", 1311.539551, 404.800537 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_CaravanAttack_NG_2", 207.837814, 75.866135 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_DeadlyCrossing_3_NG", -29.826519, -101.255219 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_DeadlyCrossing_1_NG", 794.722107, 266.272644 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_DeadlyCrossing_2_NG", 1087.826294, -295.390381 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_FaceMeIfYouDare_1_NG", 213.855240, -32.358776 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_HarassingATroll_NG", 138.532272, 811.463623 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_HighwayRobbery_NG", 300.595459, -135.326324 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_HighwaymansCache_NG", 519.180176, -212.923065 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_LootersHeatherton_NG", 151.509430, 508.062775 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_LootersCodgersQuarry_NG", 1221.132690, 831.181274 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_LootersToderas_NG", 1720.736694, 67.942719 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_MansBestFriend_NG", 643.049805, 799.665344 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_AWarmWelcome_NG", 1347.046143, 1591.817261 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_AtTheMercyOfStrangers_2_NG", 393.423737, 1265.788696 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_DrunkenRabble_NG", 543.444885, 1839.808228 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_FaceMeIfYouDare_2_NG", 899.003479, 1732.530640 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_FaceMeIfYouDare_3_NG", 505.266266, 1915.563843 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_KarmicJustice_NG", 862.002502, 1831.773438 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_NeverTrustChildren_NG", 765.527771, 1932.638062 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_RacistsOfNovigradFC_NG", 858.879944, 1819.517700 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_RacistsOfNovigradHS_NG", 553.651428, 1677.662231 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_StrangersInTheNight_NG", 1370.983887, 1507.835815 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_StrumpetInDistress_NG", 411.762390, 1672.084839 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_SuspiciousShakedown_NG", 739.579529, 1761.638062 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_TheFlameOfHatred_NG_1", 714.057678, 1861.176392 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_TheFlameOfHatred_NG_2", 793.164673, 1868.151978 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_TheMostTruestOfBasilisks_NG", 1911.729736, 1141.309082 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_ThePriceOfPassage_NG_1", 1678.246338, 1037.727295 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_ThePriceOfPassage_NG_2", 1766.244873, 1038.741089 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_ThePriceOfPassage_NG_3", 1932.989990, 1070.466309 );
	PHP_AddEvent( events, "novigrad", "PotP_Event_WitchHunterRaids_NG", 580.663086, 1569.924316 );
	PHP_AddEvent( events, "skellige", "PotP_Event_CallOfTheWild_NG", -526.447571, -340.631042 );
	PHP_AddEvent( events, "skellige", "PotP_Event_FartingTrolls_NG", -283.890625, -769.414673 );
	PHP_AddEvent( events, "skellige", "PotP_Event_SirensCall_NG", -409.181061, -202.543701 );
	PHP_AddEvent( events, "skellige", "PotP_Event_SweetBait_NG", -443.542175, -307.774261 );
	PHP_AddEvent( events, "skellige", "PotP_Event_TheFourFacesOfHemdall_NG", 2011.217651, -1851.521729 );
	PHP_AddEvent( events, "skellige", "PotP_Event_WoeIsMe_NG", 552.972961, -411.028778 );
	PHP_AddEvent( events, "skellige", "PotP_Event_YustiannaDisturbed_NG", 677.762207, 635.591064 );
	PHP_AddEvent( events, "kaer_morhen", "PotP_Event_TrailOfEchoes_NG", -327.778656, 175.190674 );
	return events;
}

// qevent( r ) - an event you already went through still shows "!": stand at it and run this, then meditate
exec function qevent( optional radius : float )
{
	var events : array< PHP_Event >;
	var playerPos : Vector;
	var path, text : string;
	var i, closed, nearest, dist : int;

	// two Novigrad events are 12 m apart
	if ( radius <= 0 )
		radius = 10;

	events = PHP_Events();
	playerPos = thePlayer.GetWorldPosition();
	path = theGame.GetWorld().GetDepotPath();
	nearest = -1;
	for ( i = 0; i < events.Size(); i += 1 )
	{
		if ( StrFindFirst( path, events[i].world ) < 0 || FactsQuerySum( events[i].fact ) > 0 )
			continue;
		dist = FloorF( VecDistance2D( playerPos, events[i].pos ) );
		if ( dist > radius )
		{
			if ( nearest < 0 || dist < nearest )
				nearest = dist;
			continue;
		}
		FactsAdd( events[i].fact, 1, -1 );
		LogChannel( 'PathHelper', "event done " + events[i].fact );
		text += StrReplace( events[i].fact, "PotP_Event_", "" ) + "<br>";
		closed += 1;
	}

	if ( closed == 0 )
	{
		if ( nearest < 0 )
			PHP_Say( "No open random event within " + FloorF( radius ) + " m" );
		else
			PHP_Say( "No open random event within " + FloorF( radius ) + " m. Nearest one: " + nearest + " m" );
		return;
	}
	PHP_Say( "Random events marked done: " + closed + "<br>" + text + "Meditate (or press the PotP update key) to remove the \"!\"" );
}
