// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_battleField", "_timer"];

if(isNil "_battleField")exitWith{};

private _action = [_man, "action"] call SFSM_fnc_unitData;

if("hunker" in _action)
then{
        private _objectHash = [_man, "hunkObjectHash"] call SFSM_fnc_unitData;
        [_man, _objectHash, "Need to hide from enemy Vehicle"] call SFSM_fnc_endHunker;
    };

        _action = [_man, "action"] call SFSM_fnc_unitData;
private _tempActions = ["dodging", "reacting", "flinch", "healing", "fire"];
private _tempOcupied = [_action, _tempActions] call Tcore_fnc_substringsPresent;



if((! _tempOcupied)
&& {!(_action == "none")})
exitWith{"cannot break current action, man cannot hide from vehicle" call dbgmsg};


if(_tempOcupied)
then{
        waitUntil     
        {
            sleep 1;
            _action = [_man, "action"] call SFSM_fnc_unitData;
            private _available   = _action == 'none';
            private _battleEnded = isNil "_battleField";
            private _dead        = !alive _man;

            if(_available)exitWith{true};
            if(_battleEnded)exitWith{true};
            if(_dead)exitWith{true};
            if(time > _timer)exitWith{true};

            false;
        };
    };

true;