// Path Helper - notice boards: take all notice board quests.
// btake()      - take every quest from notice boards loaded around Geralt (whole area, ~2 km)
// blist()      - notice boards in the current region, nearest first ("NEW" = has quests or never visited)
// bgo( number ) - teleport to a board from blist(), then run btake()
// btour()      - teleport to the nearest board that still has quests (repeat btour + btake)
// bauto( all ) - automatic tour of the current region: teleport to each board, wait, take quests, next one.
//                bauto() visits boards marked NEW, bauto(true) visits every board. bstop() stops.

function BT_TakeFromBoard( board : W3NoticeBoard ) : int
{
	var keys : array< string >;
	var i, taken : int;

	board.UpdateBoard( true );

	for ( i = 0; i < board.activeErrands.Size(); i += 1 )
	{
		if ( board.activeErrands[i].errandPosition > 0 && board.activeErrands[i].newQuestFact != "flaw" && !board.activeErrands[i].displayAsFluff )
		{
			keys.PushBack( board.activeErrands[i].errandStringKey );
		}
	}

	for ( i = 0; i < keys.Size(); i += 1 )
	{
		board.AcceptNewQuest( keys[i] );
		LogChannel( 'BoardTaker', "Taken " + keys[i] + " from " + board.GetReadableName() );
		taken += 1;
	}

	if ( !board.visited )
	{
		board.visited = true;
	}
	theGame.GetCommonMapManager().InvalidateStaticMapPin( board.entityName );
	return taken;
}

exec function btake()
{
	var ents : array< CGameplayEntity >;
	var board : W3NoticeBoard;
	var i, boards, taken : int;

	FindGameplayEntitiesInRange( ents, thePlayer, 2000.0, 1000, , , , 'W3NoticeBoard' );

	for ( i = 0; i < ents.Size(); i += 1 )
	{
		board = (W3NoticeBoard)ents[i];
		if ( !board || board.noticeboardDisabled )
			continue;
		boards += 1;
		taken += BT_TakeFromBoard( board );
	}

	theGame.GetGuiManager().ShowNotification( "Boards checked: " + boards + ", quests taken: " + taken + "<br>Far boards may be unloaded: use blist() / bgo(n) / btour()" );
}

function BT_GetBoards( out positions : array< Vector >, out isNew : array< bool > )
{
	var pins : array< SCommonMapPinInstance >;
	var playerPos, pos : Vector;
	var i, j : int;
	var inserted : bool;

	pins = theGame.GetCommonMapManager().GetMapPinInstances( theGame.GetWorld().GetDepotPath() );
	playerPos = thePlayer.GetWorldPosition();

	for ( i = 0; i < pins.Size(); i += 1 )
	{
		if ( pins[i].type != 'NoticeBoard' && pins[i].type != 'NoticeBoardFull' )
			continue;

		pos = pins[i].position;
		inserted = false;
		for ( j = 0; j < positions.Size(); j += 1 )
		{
			if ( VecDistance2D( pos, playerPos ) < VecDistance2D( positions[j], playerPos ) )
			{
				positions.Insert( j, pos );
				isNew.Insert( j, pins[i].type == 'NoticeBoardFull' );
				inserted = true;
				break;
			}
		}
		if ( !inserted )
		{
			positions.PushBack( pos );
			isNew.PushBack( pins[i].type == 'NoticeBoardFull' );
		}
	}
}

exec function blist( optional page : int )
{
	var positions : array< Vector >;
	var isNew : array< bool >;
	var text : string;
	var i, newCount : int;

	BT_GetBoards( positions, isNew );

	for ( i = 0; i < isNew.Size(); i += 1 )
	{
		if ( isNew[i] )
			newCount += 1;
	}

	for ( i = page * 12; i < positions.Size() && i < page * 12 + 12; i += 1 )
	{
		text += i + ": " + RoundF( VecDistance2D( positions[i], thePlayer.GetWorldPosition() ) ) + " m";
		if ( isNew[i] )
			text += " - NEW";
		text += "<br>";
	}

	if ( positions.Size() == 0 )
		text = "No notice boards on the map in this region.";
	else
		text += "<br>Boards: " + positions.Size() + ", with quests: " + newCount + ". Next page: blist(" + ( page + 1 ) + ")<br>Teleport: bgo(number)";

	theGame.GetGuiManager().ShowNotification( text );
}

function BT_Teleport( pos : Vector ) : bool
{
	if ( thePlayer.IsInCombat() )
	{
		theGame.GetGuiManager().ShowNotification( "Not in combat." );
		return false;
	}
	pos.Z += 1.0;
	thePlayer.Teleport( pos );
	return true;
}

exec function bgo( optional index : int )
{
	var positions : array< Vector >;
	var isNew : array< bool >;

	BT_GetBoards( positions, isNew );

	if ( index < 0 || index >= positions.Size() )
	{
		theGame.GetGuiManager().ShowNotification( "Wrong number. Run blist() first." );
		return;
	}
	if ( BT_Teleport( positions[index] ) )
		theGame.GetGuiManager().ShowNotification( "Wait for loading, then btake()" );
}

exec function btour()
{
	var positions : array< Vector >;
	var isNew : array< bool >;
	var i : int;

	BT_GetBoards( positions, isNew );

	for ( i = 0; i < positions.Size(); i += 1 )
	{
		// skip the board we are standing at
		if ( isNew[i] && VecDistance2D( positions[i], thePlayer.GetWorldPosition() ) > 30.0 )
		{
			if ( BT_Teleport( positions[i] ) )
				theGame.GetGuiManager().ShowNotification( "Board " + i + ". Wait for loading, then btake(), then btour() again" );
			return;
		}
	}
	theGame.GetGuiManager().ShowNotification( "No more boards with quests in this region." );
}

@addField( CR4Player )
var bt_queue : array< Vector >;

@addField( CR4Player )
var bt_total : int;

@addField( CR4Player )
var bt_waiting : bool;

exec function bauto( optional all : bool )
{
	var positions, ordered : array< Vector >;
	var isNew : array< bool >;
	var current : Vector;
	var i, best : int;

	BT_GetBoards( positions, isNew );
	for ( i = positions.Size() - 1; i >= 0; i -= 1 )
	{
		if ( !all && !isNew[i] )
			positions.Erase( i );
	}

	// greedy route: always the nearest board to the previous one
	current = thePlayer.GetWorldPosition();
	while ( positions.Size() > 0 )
	{
		best = 0;
		for ( i = 1; i < positions.Size(); i += 1 )
		{
			if ( VecDistance2D( positions[i], current ) < VecDistance2D( positions[best], current ) )
				best = i;
		}
		current = positions[best];
		ordered.PushBack( current );
		positions.Erase( best );
	}

	if ( ordered.Size() == 0 )
	{
		theGame.GetGuiManager().ShowNotification( "No boards to visit in this region. Try bauto(true)." );
		return;
	}

	thePlayer.BT_StartTour( ordered );
	theGame.GetGuiManager().ShowNotification( "Auto tour: " + ordered.Size() + " boards, ~4 s each. Stop: bstop()" );
}

exec function bstop()
{
	thePlayer.BT_StopTour();
	theGame.GetGuiManager().ShowNotification( "Auto tour stopped. Quests taken: " + thePlayer.bt_total );
}

function BT_TakeNearby() : int
{
	var ents : array< CGameplayEntity >;
	var board : W3NoticeBoard;
	var i, taken : int;

	FindGameplayEntitiesInRange( ents, thePlayer, 60.0, 50, , , , 'W3NoticeBoard' );
	for ( i = 0; i < ents.Size(); i += 1 )
	{
		board = (W3NoticeBoard)ents[i];
		if ( board && !board.noticeboardDisabled )
			taken += BT_TakeFromBoard( board );
	}
	return taken;
}

// thePlayer is a const handle, so the tour fields are set from inside the class
@addMethod( CR4Player )
function BT_StartTour( ordered : array< Vector > )
{
	RemoveTimer( 'BT_TourTick' );
	bt_queue = ordered;
	bt_total = 0;
	bt_waiting = false;
	AddTimer( 'BT_TourTick', 4.0, true );
}

@addMethod( CR4Player )
function BT_StopTour()
{
	RemoveTimer( 'BT_TourTick' );
	bt_queue.Clear();
}

@addMethod( CR4Player )
timer function BT_TourTick( dt : float, id : int )
{
	if ( IsInCombat() )
		return;	// wait until the fight is over

	// arrived at a board on the previous tick: take its quests
	if ( bt_waiting )
	{
		bt_total += BT_TakeNearby();
		bt_waiting = false;
	}

	if ( bt_queue.Size() == 0 )
	{
		RemoveTimer( 'BT_TourTick' );
		theGame.GetGuiManager().ShowNotification( "Auto tour done. Quests taken: " + bt_total + "<br>With Progress on the Path add-on: pp() shows what is left here" );
		return;
	}

	BT_Teleport( bt_queue[0] );
	bt_queue.Erase( 0 );
	bt_waiting = true;
	theGame.GetGuiManager().ShowNotification( "Boards left: " + bt_queue.Size() + ", quests taken: " + bt_total );
}
