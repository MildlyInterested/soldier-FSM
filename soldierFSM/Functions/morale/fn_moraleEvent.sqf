params["_man", "_event"];

if!([_man] call SFSM_fnc_canUpdateMorale)exitWith{};

[_man, "lastMoraleEvent", time]  call SFSM_fnc_unitData;

private _eventData  = [_man, _event]         call SFSM_fnc_moraleEventData;
private _allEvents  = [_man, "moraleEvents"] call SFSM_fnc_unitData;
private _isHitEvent = "hit" in _event;
private _effectTime = _eventData#3;

_allEvents pushBack _eventData;

[_man, "moraleEvents", _allEvents] call SFSM_fnc_unitData;

[_man] call SFSM_fnc_updateMorale;
[_man, _effectTime, _isHitEvent] spawn SFSM_fnc_postMoraleEvent;

["morale_event", [_man, _event, _eventData]] call CBA_fnc_localEvent;

true;