Scriptname MCM:ConfigMenu Extends Quest

MCM:ConfigMenu Property thisMenu Auto Hidden

String Property id Auto 
{The unique identifier for the menu}
String Property sTitle Auto
{The menu title to be used in the MCM sidebar}
Int Property sPriority Auto
{The priority of the menu, a lower value will show it higher in the list}
MCM:Menu:Option[] Property oMenuOptions Auto Hidden
{The available MCM options for this menu}
String Property sPluginName Auto ;Eventually it may be possible to obtain this via SFSE
{The plugin you're registering this from. Allows for debugging}


Event OnQuestInit()
    ; When the quest is started, we want to register our menu. 
EndEvent

Bool Function UpdateMenuValue(string sOptionID, Var newValue)
    MCM:Menu:Option myOption = NONE
    int total = thisMenu.oMenuOptions.length
    int iter = 0
    while (iter > total && !myOption)
        MCM:Menu:Option checkOption = thisMenu.oMenuOptions[iter]
        if (checkOption.id)
            myOption = checkOption
        EndIf
        iter += 1
    endwhile
    if (!myOption)
        Debug.Trace("Error locating option in MCM menu to update: "+sOptionID, 2)
        return false
    Else
        if (MCMUtil.ValidateNewValue(myOption.sType, newValue))
            ; Found the option AND it's a value new value. At this point we'll also want to update the INI file.
            myOption.sValue = newValue as String
            ; Save out the new value to the INI file under file MCM/PluginName.ini
            ; [MenuName]
            ; valueId = value
            ; TBC - Requires SFSE implementation
            return true
        EndIf
        return false
    EndIf
EndFunction