integer MessageBox(string sId, string sText, list lButtons, list lData, string sScript) {
    return MessageLinkedPrimList("service.menus", [sId, sText, llList2Json(JSON_ARRAY, lButtons), llList2Json(JSON_ARRAY, lData), sScript]);
}
integer InputBox(string sId, string sText, list lData, string sScript) {
    return MessageLinkedPrimList("service.inputs", [sId, sText, llList2Json(JSON_ARRAY, lData), sScript]);
}
integer MessageBoxNumbered(string sId, string sText, list lButtons, list lData, string sScript) {
    list buttons;
    integer i;
    for(i = 0; i < getKeyValueLength(lButtons); i++) {
        list lPair = getKeyValuePair(lButtons, i);
        sText += "\n" + (string)i + " - " + llList2String(lPair, 1);
        buttons += [llList2String(lPair, 0), (string)i];
    }
    return MessageBox(sId, sText, buttons, lData, sScript);
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