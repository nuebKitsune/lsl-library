RespondLinkedList(string sTo, integer iNum, list lList) {
    RespondLinkedJson(sTo, iNum, lList, JSON_ARRAY);
}
integer MessageLinkedList(string sTo, list lList) {
    return MessageLinkedJson(sTo, lList, JSON_ARRAY);
}
RespondLinkedPair(string sTo, integer iNum, list lList) {
    RespondLinkedJson(sTo, iNum, lList, JSON_OBJECT);
}
integer MessageLinkedPair(string sTo, list lList) {
    return MessageLinkedJson(sTo, lList, JSON_OBJECT);
}
RespondLinkedJson(string sTo, integer iNum, list lList, string sType) {
    RespondLinked(sTo, iNum, llList2Json(sType, lList));
}
integer MessageLinkedJson(string sTo, list lList, string sType) {
    return MessageLinked(sTo, llList2Json(sType, lList));
}
RespondLinked(string sTo, integer iNum, string sString) {
    llMessageLinked(LINK_THIS, iNum, sString, sTo + ":" + llGetScriptName());
    //llMessageLinked(LINK_ALL_OTHERS, iNum, sString, sTo + ":" + llGetScriptName());
}
integer MessageLinked(string sTo, string sString) {
    //integer iHnd = (integer)llFrand(3.402823466E+38);
    integer iHnd = Millisec(llGetTimestamp());
    llMessageLinked(LINK_THIS, iHnd, sString, sTo + ":" + llGetScriptName());
    //llMessageLinked(LINK_ALL_OTHERS, iHnd, sString, sTo + ":" + llGetScriptName());
    return iHnd;
}

/***********************************************************************************/
integer getLinkPrim(string name) {
    integer i;
    for (i = 1; i <= llGetNumberOfPrims(); ++i)
        if (llGetLinkName(i) == name) 
            return i;
            
    return -1;
}
string getLinkName(integer link) {
    return llGetLinkName(link);
}
RespondLinkedPrimList(string sTo, integer iNum, list lList) {
    RespondLinkedPrimJson(sTo, iNum, lList, JSON_ARRAY);
}
integer MessageLinkedPrimList(string sTo, list lList) {
    return MessageLinkedPrimJson(sTo, lList, JSON_ARRAY);
}
RespondLinkedPrimPair(string sTo, integer iNum, list lList) {
    RespondLinkedPrimJson(sTo, iNum, lList, JSON_OBJECT);
}
integer MessageLinkedPrimPair(string sTo, list lList) {
    return MessageLinkedPrimJson(sTo, lList, JSON_OBJECT);
}
RespondLinkedPrimJson(string sTo, integer iNum, list lList, string sType) {
    RespondLinkedPrim(sTo, iNum, llList2Json(sType, lList));
}
integer MessageLinkedPrimJson(string sTo, list lList, string sType) {
    return MessageLinkedPrim(sTo, llList2Json(sType, lList));
}
RespondLinkedPrim(string sTo, integer iNum, string sString) {
    RespondLinkedPrimScript(sTo, iNum, sTo, sString);
}
integer MessageLinkedPrim(string sTo, string sString) {
    return MessageLinkedPrimScript(sTo, sTo, sString);
}

integer MessageLinkedPrimScriptBroadcast(string sScript, string sString) {
    integer iHnd = Millisec(llGetTimestamp());
    llMessageLinked(LINK_ALL_CHILDREN, iHnd, sString, sScript);
    return iHnd;
}
integer MessageLinkedRootScript(string sScript, string sString) {
    integer iHnd = Millisec(llGetTimestamp());
    llMessageLinked(LINK_ROOT, iHnd, sString, sScript);
        
    return iHnd;
}
RespondLinkedPrimScript(string sTo, integer iHnd, string sScript, string sString) {
    integer iPrm = getLinkPrim(sTo);
    
    if(iPrm >= 0)
        llMessageLinked(iPrm, iHnd, sString, sScript);
        
}
integer MessageLinkedPrimScript(string sTo, string sScript, string sString) {
    integer iHnd = Millisec(llGetTimestamp());
    integer iPrm = getLinkPrim(sTo);

    if(iPrm >= 0)
        llMessageLinked(iPrm, iHnd, sString, sScript);
    else
        return 0;
        
    return iHnd;
}
integer Millisec(string Stamp) {
    return (integer)llGetSubString(Stamp, 8, 9) * 86400000 + // Days
        (integer)llGetSubString(Stamp, 11, 12) * 3600000 + // Hours
        (integer)llGetSubString(Stamp, 14, 15) * 60000 + // Minutes
        llRound(((float)llGetSubString(Stamp, 17, -2) * 1000.0)) // Seconds.Milliseconds
        - 617316353; // Offset to fit between [-617316353,2147483547]
}
/*// Released to Public Domain without limitation. Created by Nexii Malthus. //*/