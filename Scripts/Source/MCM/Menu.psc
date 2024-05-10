Scriptname MCM:Menu Extends ScriptObject
{The basic type for a Mod Configuration Menu}

Struct Option
    String id
    {a unique ID for this toggle}
    String stitle
    {The title which appears in the option list and on the right side at the top}
    String sDescription
    {The summary which shows on the right side below}
    String sType
    {Valid types are 'TOGGLE', 'SELECT', 'SLIDER'}
    String sValue
    {The current value of the option}
    String sDefault
    {The default value of the option, will reset to this if the user resets to defaults}
    ; String[] sOptions
    ; {The selectable options, only applies if sType is "SELECT"}
    Float fMaxValue = 100
    {The maximum value, only applies if sType is 'SLIDER', default 100}
    Float fMinValue = 0
    {The minimum value, only applies if sType is 'SLIDER', default 0}
    Float fStepSize = 1
    {The step size when moving the slider, only applies if sType is 'SLIDER', default 1}
    Bool bDisabled = false
    {Is the option currently disabled, default false}
EndStruct

Struct RegisterdMenuArrays
    ; String[] IDs
    ; {The menu IDs}
    ; MCM:ConfigMenu[] Menus
    ; {The menus}
EndStruct

MCM:Menu:RegisterdMenuArrays Property Registered Auto Hidden;
{The MCM menus that have been registered.}

Event OnInit()
    ; Registered = new MCM:Menu:RegisterdMenuArrays
    ; Registerd.IDs = new String[0]
    ; Registerd.Menus = new MCM:Menu:RegisteredMenu[0]
    ; Debug.Trace("MCM Startup complete, awaiting menu registrations")
EndEvent

Bool Function AddRegisteredMenu(MCM:ConfigMenu menu)
;     if (Registered.IDs.find(menu.id, 0) >= 0)
;         Deubug.Trace("MCM already registred. Ignoring re-reigster: "+menu.id)
;         return false
;     EndIf
;     RegisteredMenus.IDs(menu.id)
;     RegisteredMenus.Menus.add(menu)
;     Debug.Trace("Successfully registred menu: "+menu.sTitle+" ("+menu.id+") from "+menu.sPluginName)
    return true
EndFunction

MCM:ConfigMenu Function RegisterMCMMenu(String sMenuId, MCM:ConfigMenu menu)
    ; Creates a new MCM menu and returns it
    ; callingObject - the form that calls to register the menu (usually a quest)
    ; sMenuId - a unique ID for the menu
    ; menu - a BaseMenu struct containing the basic details. 
    ; ---------------------------------------------------------


    ; Work out which plugin this menu came from
    ; string sPluginName = ""
    ; Not possible via SFSE yet so we need to ask for it manually
    if (Game.IsPluginInstalled(menu.sPluginName))
        Debug.Trace("MCM plugin not found ID: "+menu.id+"  Plugin: "+menu.sPluginName, 2)
    EndIf

    ; Read the saved config from the INI file or create a new blank one with the defaults.
    ; TBC requires SKSE

    ; Save the menu into out array
    AddRegisteredMenu(menu)

    ; push the menu back into the calling script
    menu.thisMenu = menu
    
    ; return the new, registered menu
    return menu
EndFunction