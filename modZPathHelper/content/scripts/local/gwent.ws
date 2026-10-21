// Path Helper - Gwent.
// glist( page )  - missing cards with where to get them, current region first ("*" = can teleport there)
// gnext()        - teleport to the nearest source of a missing card in the current region
//                  (a player you have not beaten yet or a merchant). Talk to them yourself, then gnext() again.
// gcheat()       - for those who skip Gwent: give every missing card and complete the Gwent side quests in the journal
//                  (tournaments are left alone). Players will still offer games, story checks may not see the wins.

function PH_AreaMatches( originArea : string ) : bool
{
	var area : name;

	area = theGame.GetCommonMapManager().GetCurrentArea();
	switch( originArea )
	{
		case "NML":
		case "Novigrad":	return area == 'AN_NMLandNovigrad' || area == 'AN_Velen';
		case "Skellige":	return area == 'AN_Skellige_ArdSkellig';
		case "Prologue":	return area == 'AN_Prologue_Village' || area == 'AN_Prologue_Village_Winter';
		case "Vizima":		return area == 'AN_Wyzima';
		case "KaerMorhen":	return area == 'AN_Kaer_Morhen';
	}
	return false;
}

// card_sources.csv keeps coordinates as text; take the first two numbers found in it
function PH_ParseCoords( text : string, out pos : Vector ) : bool
{
	var numbers : array< float >;
	var token, c : string;
	var i : int;

	text += " ";
	for ( i = 0; i < StrLen( text ); i += 1 )
	{
		c = StrMid( text, i, 1 );
		if ( StrFindFirst( "0123456789.-", c ) >= 0 )
		{
			token += c;
		}
		else if ( token != "" )
		{
			if ( token != "-" && token != "." )
				numbers.PushBack( StringToFloat( token ) );
			token = "";
		}
	}

	if ( numbers.Size() < 2 )
		return false;

	pos = Vector( numbers[0], numbers[1], 0 );
	return true;
}

function PH_CardName( cardName : name ) : string
{
	var text : string;

	text = GetLocStringByKeyExt( thePlayer.inv.GetItemLocalizedNameByName( cardName ) );
	if ( text == "" )
		text = NameToString( cardName );
	return text;
}

function PH_SourceText( src : SCardSourceData ) : string
{
	var line : string;

	if ( src.originArea == "Random" )
		return "random merchant";

	line = src.source + ", " + src.originArea;
	if ( src.originQuest != "" )
		line += ", " + src.originQuest;
	if ( src.details != "" )
		line += ", " + src.details;
	return line;
}

function PH_GetSources() : array< SCardSourceData >
{
	var sources, here, other : array< SCardSourceData >;
	var i : int;

	sources = thePlayer.inv.FindCardSources( thePlayer.inv.GetMissingCards() );
	for ( i = 0; i < sources.Size(); i += 1 )
	{
		if ( PH_AreaMatches( sources[i].originArea ) )
			here.PushBack( sources[i] );
		else
			other.PushBack( sources[i] );
	}
	for ( i = 0; i < other.Size(); i += 1 )
	{
		here.PushBack( other[i] );
	}
	return here;
}

exec function glist( optional page : int )
{
	var sources : array< SCardSourceData >;
	var pos : Vector;
	var text, line : string;
	var i : int;

	sources = PH_GetSources();
	if ( sources.Size() == 0 )
	{
		theGame.GetGuiManager().ShowNotification( "All Gwent cards collected!" );
		return;
	}

	for ( i = page * 8; i < sources.Size() && i < page * 8 + 8; i += 1 )
	{
		line = i + ": " + PH_CardName( sources[i].cardName ) + " - " + PH_SourceText( sources[i] );
		if ( PH_AreaMatches( sources[i].originArea ) && PH_ParseCoords( sources[i].coords, pos ) )
			line += " *";
		text += line + "<br>";
		LogChannel( 'PathHelper', line + " [" + NameToString( sources[i].cardName ) + "] coords=" + sources[i].coords );
	}

	text += "<br>Missing sources: " + sources.Size() + ". Next page: glist(" + ( page + 1 ) + ")<br>* = gnext() can take you there";
	theGame.GetGuiManager().ShowNotification( text );
}

exec function gnext()
{
	var sources : array< SCardSourceData >;
	var pos, bestPos, playerPos : Vector;
	var best, i : int;
	var hit, norm : Vector;

	if ( thePlayer.IsInCombat() )
	{
		theGame.GetGuiManager().ShowNotification( "Not in combat." );
		return;
	}

	sources = PH_GetSources();
	playerPos = thePlayer.GetWorldPosition();
	best = -1;

	for ( i = 0; i < sources.Size(); i += 1 )
	{
		if ( !PH_AreaMatches( sources[i].originArea ) || !PH_ParseCoords( sources[i].coords, pos ) )
			continue;
		if ( best < 0 || VecDistance2D( pos, playerPos ) < VecDistance2D( bestPos, playerPos ) )
		{
			best = i;
			bestPos = pos;
		}
	}

	if ( best < 0 )
	{
		theGame.GetGuiManager().ShowNotification( "No missing cards with a known place in this region. See glist()." );
		return;
	}

	// already standing there: the card is still missing, so the game was not won yet
	if ( VecDistance2D( bestPos, playerPos ) < 15.0 )
	{
		theGame.GetGuiManager().ShowNotification( "Still missing: " + PH_CardName( sources[best].cardName ) + "<br>" + PH_SourceText( sources[best] ) + "<br>Talk to them and win / buy it, then gnext()" );
		return;
	}

	// same ground search as the vanilla xy() command
	if ( theGame.GetWorld().StaticTrace( Vector( bestPos.X, bestPos.Y, 1000.f ), Vector( bestPos.X, bestPos.Y, -1000.f ), hit, norm ) )
		bestPos.Z = hit.Z + 0.1f;
	else
		bestPos.Z = 500.1f;

	thePlayer.Teleport( bestPos );
	theGame.GetGuiManager().ShowNotification( PH_CardName( sources[best].cardName ) + "<br>" + PH_SourceText( sources[best] ) + "<br>Talk to them and win / buy it, then gnext()" );
}

function PH_IsGwentSideQuest( baseName : string ) : bool
{
	switch( baseName )
	{
		case "CG : No Man's Land":
		case "CG: Novigrad":
		case "CG: Innkeepers":
		case "CG: Talar":
		case "CG: Skellige":
		case "CG: Old Friends":
		case "Card Game Meta: Gather All":
		case "cg700_all_cards":
			return true;
	}
	return false;
}

exec function gcheat()
{
	var manager : CWitcherJournalManager;
	var entries : array< CJournalBase >;
	var missing : array< name >;
	var jq : CJournalQuest;
	var status : EJournalStatus;
	var quests : string;
	var i, done : int;

	missing = thePlayer.inv.GetMissingCards();
	for ( i = 0; i < missing.Size(); i += 1 )
	{
		thePlayer.inv.AddAnItem( missing[i], 1 );
	}

	manager = theGame.GetJournalManager();
	manager.GetActivatedOfType( 'CJournalQuest', entries );
	for ( i = 0; i < entries.Size(); i += 1 )
	{
		jq = (CJournalQuest)entries[i];
		if ( !jq || !PH_IsGwentSideQuest( jq.baseName ) )
			continue;
		status = manager.GetEntryStatus( jq );
		if ( status == JS_Success || status == JS_Failed )
			continue;

		if ( manager.GetTrackedQuest() == jq )
			manager.SetTrackedQuest( NULL );
		manager.ActivateEntry( jq, JS_Success, false );
		quests += GetLocStringById( jq.GetTitleStringId() ) + "<br>";
		done += 1;
	}

	if ( quests == "" )
		quests = "none (not started yet or already done)<br>";
	theGame.GetGuiManager().ShowNotification( "Cards added: " + missing.Size() + "<br>Gwent quests completed: " + done + "<br>" + quests );
}
