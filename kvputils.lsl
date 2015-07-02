integer containsKey(list lPairs, string sKey) { return (indexOf(lPairs, sKey) % 2 == 0.0); }
integer indexOf(list lPairs, string sKey) { return llListFindList(lPairs, [sKey]); }
string getKeyValue(list lPairs, string sKey)
{
    integer index = indexOf(lPairs, sKey);
    if(index >= 0)
        return llList2String(lPairs, index + 1); 
        
    return "";
}
list setKeyValue(list lPairs, string sKey, string sVal) {
    integer index = indexOf(lPairs, sKey);
    if(index >= 0)
        return llListReplaceList(lPairs, [sKey, sVal], index, index + 1); 
    
    return (lPairs + [sKey, sVal]);
}
integer getKeyValueLength(list lList) {
    return llGetListLength(lList) / 2;
}
list getKeyValuePair(list lList, integer iIndex) {
    integer index = iIndex * 2;
    return [llList2String(lList, index), llList2String(lList, index + 1)];
}