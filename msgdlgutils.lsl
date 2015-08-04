integer MessageBoxTo(string sId, key kTo, string sText, list lButtons, list lData, string sScript) {
    return MessageLinkedPrimList("service.menus", [sId, kTo, sText, llList2Json(JSON_ARRAY, lButtons), llList2Json(JSON_ARRAY, lData), sScript]);
}
integer InputBoxTo(string sId, key kTo, string sText, list lData, string sScript) {
    return MessageLinkedPrimList("service.inputs", [sId, kTo, sText, llList2Json(JSON_ARRAY, lData), sScript]);
}
integer MessageBox(string sId, string sText, list lButtons, list lData, string sScript) {
    return MessageBoxTo(sId, llGetOwner(), sText, lButtons, lData, sScript);
}
integer InputBox(string sId, string sText, list lData, string sScript) {
    return InputBoxTo(sId, llGetOwner(), sText, lData, sScript);
}
integer MessageBoxNumberedTo(string sId, key kTo, string sText, list lButtons, list lData, string sScript) {
    list buttons;
    integer i;
    for(i = 0; i < getKeyValueLength(lButtons); i++) {
        list lPair = getKeyValuePair(lButtons, i);
        sText += "\n" + (string)i + " - " + llList2String(lPair, 1);
        buttons += [llList2String(lPair, 0), (string)i];
    }
    return MessageBoxTo(sId, kTo, sText, buttons, lData, sScript);
}
integer MessageBoxNumbered(string sId, string sText, list lButtons, list lData, string sScript) {
    return MessageBoxNumberedTo(sId, llGetOwner(), sText, buttons, lData, sScript);
}
list Records2Buttons(list lList, string sKey, string sVal) {
    list buttons;
                        
    integer i;  
    for(i = 0; i < getRecordCount(lList); i++) {
        list lBirth = getRecordByIndex(lList, i);
        buttons += [getKeyValue(lBirth, sKey), getKeyValue(lBirth, sVal)];
    }
    
    return buttons;
}

Message(key kAvatar, string sMessage) {
    MessageLinkedRootScriptList("function.message", [kAvatar, llStringToBase64(sMessage)]);
}
Say(string sType, integer iChannel, string sMessage) {
    MessageLinkedRootScriptList("function.say", [sType, iChannel, llStringToBase64(sMessage)]);
}