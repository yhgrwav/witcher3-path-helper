// Path Helper: places and quests a mod broke (autoloot took the item a quest waits for, a wall can no longer be destroyed...)
// Progress on the Path comes precompiled, so nothing here uses its code. A place counts as done in PotP and in the game
// when its map pin is discovered and greyed out, the state the game gives a cleared place. That is what these commands set.
//
// qpins( r )  - every map pin within r metres (default 30): type and state, also written to scriptslog.txt
// qdone( r )  - clear every unfinished place within r metres (default 50) and open the "?" around
// qfix()      - on the loaded map: open every "?" the game already counts as done (greyed out, never discovered)
// qdoneall()  - how many unfinished places are on the loaded map; qdoneall( "", 1 ) clears ALL of them, done or not
// questdone() - finish the quest tracked in the journal (not main quests)
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
