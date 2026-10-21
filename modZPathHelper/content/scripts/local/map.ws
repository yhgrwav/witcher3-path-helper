// Path Helper - map.
// qreveal() - show every hidden "?" point of interest on the map (same list the game uses for its debug ShowKnownPins).
//             Places stay undiscovered: go there yourself to clear them.

exec function qreveal()
{
	var manager : CCommonMapManager;
	var tags : array< name >;
	var i, shown : int;

	manager = theGame.GetCommonMapManager();
	tags = manager.GetKnownableEntityNames();

	for ( i = 0; i < tags.Size(); i += 1 )
	{
		if ( manager.IsEntityMapPinKnown( tags[i] ) || manager.IsEntityMapPinDiscovered( tags[i] ) )
			continue;
		manager.SetEntityMapPinKnown( tags[i], true );
		shown += 1;
	}

	// "?" pins are hidden on the map unless the HUD option for question marks is on
	manager.ShowKnownEntities( true );

	theGame.GetGuiManager().ShowNotification( "Revealed on the map: " + shown + " places.<br>They stay as \"?\" until you visit them." );
}
