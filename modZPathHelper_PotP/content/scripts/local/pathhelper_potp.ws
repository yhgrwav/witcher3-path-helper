// Path Helper - Progress on the Path add-on. Install ONLY together with Progress on the Path.
// pp()          - unfinished quests and Gwent cards in the current region according to PotP
// pp( "type" )  - list them: "contract", "side", "main", "hunt", "scavenger", "event", "gwent"
//                 pp( "contract", 1 ) for the next page

function PHP_CurrentRegion() : PotP_Preview_Region
{
	switch( theGame.GetCommonMapManager().GetCurrentArea() )
	{
		case 'AN_Prologue_Village':
		case 'AN_Prologue_Village_Winter':	return PotP_R_WO;
		case 'AN_Velen':
		case 'AN_NMLandNovigrad':			return PotP_R_VE;	// Velen and Novigrad share one world, see PHP_InRegion
		case 'AN_Skellige_ArdSkellig':		return PotP_R_SK;
		case 'AN_Kaer_Morhen':				return PotP_R_KM;
		case 'AN_Wyzima':					return PotP_R_VI;
		case 'AN_Dlc_Bob':					return PotP_R_TO;
	}
	return PotP_R_NA;
}

function PHP_InRegion( entry : CPotP_Entry, region : PotP_Preview_Region ) : bool
{
	if ( region == PotP_R_VE )
		return entry.region == PotP_R_VE || entry.region == PotP_R_NO;
	return entry.region == region;
}

function PHP_Kind( entry : CPotP_Entry ) : string
{
	if ( entry.category == PotP_A_Gwent )
		return "gwent";
	if ( entry.category == PotP_A_Event )
		return "event";
	if ( entry.category != PotP_A_Quest )
		return "";

	switch( entry.filter )
	{
		case PotP_I_Mains:	return "main";
		case PotP_I_Sides:	return "side";
		case PotP_I_Conts:	return "contract";
		case PotP_I_Scavs:	return "scavenger";
		case PotP_I_Hunts:	return "hunt";
	}
	return "";
}

function PHP_Title( entry : CPotP_Entry ) : string
{
	if ( entry.title != "" )
		return entry.title;
	return entry.entry_name;
}

function PHP_GetCatalog() : CPotP_Catalog
{
	var main : CPotP_Main;

	main = PotP_Get();
	if ( !main || !main.catalog || !main.catalog.is_ready )
		return NULL;
	return main.catalog;
}

exec function pp( optional kind : string, optional page : int )
{
	var catalog : CPotP_Catalog;
	var entries : array< CPotP_Entry >;
	var region : PotP_Preview_Region;
	var kinds : array< string >;
	var counts, active : array< int >;
	var text, entryKind : string;
	var i, k, shown : int;

	catalog = PHP_GetCatalog();
	if ( !catalog )
	{
		theGame.GetGuiManager().ShowNotification( "Progress on the Path is not ready yet. Wait a moment or open its menu once." );
		return;
	}

	region = PHP_CurrentRegion();
	if ( region == PotP_R_NA )
	{
		theGame.GetGuiManager().ShowNotification( "Unknown region." );
		return;
	}

	kinds.PushBack( "main" );
	kinds.PushBack( "side" );
	kinds.PushBack( "contract" );
	kinds.PushBack( "hunt" );
	kinds.PushBack( "scavenger" );
	kinds.PushBack( "event" );
	kinds.PushBack( "gwent" );
	counts.Resize( kinds.Size() );
	active.Resize( kinds.Size() );

	for ( i = 0; i < catalog.entries.Size(); i += 1 )
	{
		// Gwent cards in PotP are not tied to a region
		if ( catalog.entries[i].IsDone() || catalog.entries[i].status == PotP_S_Missed )
			continue;
		entryKind = PHP_Kind( catalog.entries[i] );
		if ( entryKind == "" || ( entryKind != "gwent" && !PHP_InRegion( catalog.entries[i], region ) ) )
			continue;

		k = kinds.FindFirst( entryKind );
		counts[k] += 1;
		if ( catalog.entries[i].status == PotP_S_InProgress )
			active[k] += 1;
		if ( entryKind == StrLower( kind ) )
			entries.PushBack( catalog.entries[i] );
	}

	if ( kind == "" )
	{
		text = "Progress on the Path, this region:<br>";
		for ( k = 0; k < kinds.Size(); k += 1 )
		{
			if ( counts[k] > 0 )
				text += kinds[k] + ": " + counts[k] + " left (" + active[k] + " in journal)<br>";
		}
		text += "<br>List: pp(\"contract\"), pp(\"side\") ...<br>Not started contracts: bauto() takes them from boards";
		theGame.GetGuiManager().ShowNotification( text );
		return;
	}

	for ( i = page * 10; i < entries.Size() && i < page * 10 + 10; i += 1 )
	{
		text += PHP_Title( entries[i] );
		if ( entries[i].status == PotP_S_InProgress )
			text += " - in journal";
		if ( entries[i].is_missable )
			text += " - MISSABLE";
		text += "<br>";
		shown += 1;
	}

	if ( shown == 0 )
		text = "Nothing left: " + kind;
	else
		text += "<br>" + entries.Size() + " left. Next page: pp(\"" + kind + "\", " + ( page + 1 ) + ")";
	theGame.GetGuiManager().ShowNotification( text );
}
