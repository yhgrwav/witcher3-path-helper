// Path Helper - map.
// qreveal() - show every hidden "?" point of interest in the current region on the map.
//             Places stay undiscovered: go there yourself to clear them.

exec function qreveal()
{
	var manager : CCommonMapManager;
	var pins : array< SEntityMapPinInfo >;
	var tag : name;
	var i, shown : int;

	manager = theGame.GetCommonMapManager();
	pins = manager.GetEntityMapPins( theGame.GetWorld().GetDepotPath() );

	for ( i = 0; i < pins.Size(); i += 1 )
	{
		tag = pins[i].entityName;
		if ( !IsNameValid( tag ) || manager.IsEntityMapPinKnown( tag ) || manager.IsEntityMapPinDiscovered( tag ) )
			continue;
		manager.SetEntityMapPinKnown( tag, true );
		shown += 1;
	}

	theGame.GetGuiManager().ShowNotification( "Revealed on the map: " + shown + " places.<br>They stay as \"?\" until you visit them." );
}
