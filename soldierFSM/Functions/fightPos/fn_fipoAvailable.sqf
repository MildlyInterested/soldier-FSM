params[
	"_fipo", 
	["_ignoreMan", false]
];

// FIPO has already been taken
private _fipoMan = [_fipo] call SFSM_fnc_fipoMan;

if(_ignoreMan       isEqualTo false
&&{isNil "_fipoMan" isEqualTo false})
exitWith{false;};

//Positions marked as "Allow FUBAR" will be deactivated when conditions described in the module are true.
private _disabeled = [_fipo] call SFSM_fnc_fipoIsFUBAR;
if(_disabeled isEqualTo true)exitwith{false;};

//Positions marked as hit and run will have a cooldown
private _remainingCoolDown = [_fipo] call SFSM_fnc_fipoCooldownLeft;
if(_remainingCoolDown > 0) exitWith{false;};

//To avoid get-in spam the following code is implemented.
private _allowAttempt = [_fipo] call SFSM_fnc_fipoAttemptAllowed;
if(_allowAttempt isEqualTo false)exitwith{false;};

// Dynamic FIPOs with nobody in firing range are not usable.
if(_fipo getVariable "dynamicFipo"
&&{([_fipo] call SFSM_fnc_unitsInFireSector) isEqualTo []})
exitWith{false;};

true;