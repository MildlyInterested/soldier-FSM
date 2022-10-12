params["_battleKey"];
private _battlefield   = SFSM_Battles get _battleKey;
if(isNil "_battlefield")exitWith{"BattleField not found" call SFSM_fnc_debugMessage};
private _markers         = _battlefield get "markers";
private _gridVar         = _battlefield get "grid";
private _unitVar         = _battlefield get "units";
private _deadVar         = _battlefield get "deadMen";
private _vehicleVar      = _battlefield get "vehicles";
private _mapObjVarName   = _battlefield get "mapObjects";
private _weaponsVarName  = _battlefield get "weapons";
private _groupsVarName   = _battlefield get "groups";
private _ClustersVarName = _battlefield get "clusterData";
private _hunkObjVarName  = _battlefield get "hunkerObjects";
private _buildingsVarName= _battlefield get "buildings";


private _vehicles= missionNamespace getVariable _vehicleVar;
private _units   = missionNamespace getVariable _unitVar;
private _groups  = missionNamespace getVariable _groupsVarName;
private _endText = ["Battle ", (_battlefield get "name"), " ended."] joinString "";


{
	private _currentBuilding = [_x, "currentBuilding"] call SFSM_fnc_unitData;
	private _pathEnabeled = [_x, "pathEnabeled"] call SFSM_fnc_unitData;
	if!(_currentBuilding == "none")
	then{
          missionNamespace setVariable [_currentBuilding, nil, true];
          [_x, "currentBuilding", "none"] call SFSM_fnc_unitData;
	};


	[_x, "currentBattle", "none"] call SFSM_fnc_unitData;
	[_x, "lastBattle", time]      call SFSM_fnc_unitData;
	if(_pathEnabeled)then{_x enableAI "all";};
	_x setUnitPos "AUTO";
	_x doFollow leader (group _x);
}  forEach _units;

{[_x, "currentBattle", "none"] call SFSM_fnc_groupData;} forEach _groups;
{[_x, "currentBattle", "none"] call SFSM_fnc_vehicleData;} forEach _vehicles;
{deleteMarker _x} forEach _markers;

missionNamespace setVariable [_gridVar,         nil, true];
missionNamespace setVariable [_unitVar,         nil, true];
missionNamespace setVariable [_deadVar,         nil, true];
missionNamespace setVariable [_vehicleVar,      nil, true];
missionNamespace setVariable [_mapObjVarName,   nil, true];
missionNamespace setVariable [_groupsVarName,   nil, true];
missionNamespace setVariable [_weaponsVarName,  nil, true];
missionNamespace setVariable [_ClustersVarName, nil, true];
missionNamespace setVariable [_hunkObjVarName,  nil, true];
missionNamespace setVariable [_buildingsVarName,nil, true];

{_battlefield deleteAt _X}forEach _battlefield;

SFSM_Battles deleteAt _battleKey;
_battlefield = nil;

_endText call SFSM_fnc_debugMessage;

_endText;