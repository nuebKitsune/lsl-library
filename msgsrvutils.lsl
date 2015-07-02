integer MessageServer4(list lAction, list lParams, string sReturn, string sJsonType) {
    return MessageServer(MessageServer4Json(lAction, lParams, sReturn, sJsonType));
}
string MessageServer4Json(list lAction, list lParams, string sReturn, string sJsonType) {
    list temp;
    temp += ["action", llList2Json(JSON_ARRAY, lAction)];
    
    if(llGetListLength(lParams) > 0)
        temp += ["params", llList2Json(sJsonType, lParams)];
    
    if(sReturn != "")
        temp += ["return", sReturn];
        
    return llList2Json(JSON_OBJECT, temp);
}
integer MessageServer3(list lAction, list lParams, string sReturn) {
    return MessageServer(MessageServer3Json(lAction, lParams, sReturn));
}
string MessageServer3Json(list lAction, list lParams, string sReturn) {
    list temp;
    temp += ["action", llList2Json(JSON_ARRAY, lAction)];
    
    if(llGetListLength(lParams) > 0)
        temp += ["params", llList2Json(JSON_OBJECT, lParams)];
    
    if(sReturn != "")
        temp += ["return", sReturn];
        
    return llList2Json(JSON_OBJECT, temp);
}
integer MessageServer(string lData) {
    return MessageLinkedPrim("service.dataserve", lData);
}