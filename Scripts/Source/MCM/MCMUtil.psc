ScriptName MCM:MCMUtil Extends Form Hidden

Bool Function ValidateNewValue(String sType, Var newValue) Global
; Checks the new value passed in matches the type required by the option
    if (sType == "TOGGLE" && newValue as Bool)
        return true
    elseif (sType == "SELECT" && newValue as String)
        return true
    elseif (sType == "SLIDER" && newValue as Int)
        return true
    else
        Debug.Trace("Value type mismatch: "+newValue+" is not type "+sType, 2)
        return false
    EndIf
EndFunction