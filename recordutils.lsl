/*list getRecord(list lRecords, string sColumn, integer sValue) {
    integer i;
    for(i = 0; i < llGetListLength(lRecords); i++) {
        list lRecord = llJson2List(llList2String(lRecords, i));
        if(getFieldInteger(lRecord, sColumn) == sValue)
            return lRecord;
            
    }
    
    return [];
}*/
list getRecord(list lRecords, string sColumn, integer sValue) {
    list lFields = llJson2List(llList2String(lRecords, 0));
    
    integer i;
    for(i = 1; i < llGetListLength(lRecords); i++) {
        list lRecord = llJson2List(llList2String(lRecords, i));
        if(llList2Integer(lRecord, llListFindList(lFields, [sColumn])) == sValue) {
            list lResult;
            
            integer j;
            for(j = 0; j < llGetListLength(lFields); j++) 
                lResult += [llList2String(lFields, j), llList2String(lRecord, j)];
                
            return lResult;
        }
            
    }
    
    return [];
}
list deleteRecord(list lRecords, string sColumn, integer sValue) {
    list lFields = llJson2List(llList2String(lRecords, 0));
    
    integer i;
    for(i = 1; i < llGetListLength(lRecords); i++) {
        list lRecord = llJson2List(llList2String(lRecords, i));
        if(llList2Integer(lRecord, llListFindList(lFields, [sColumn])) == sValue)
            return llDeleteSubList(lRecords, i, i);
            
    }
    
    return lRecords;
}

integer hasRecord(list lRecords, string sColumn, integer sValue) {
    list lFields = llJson2List(llList2String(lRecords, 0));
    
    integer i;
    for(i = 1; i < llGetListLength(lRecords); i++) {
        list lRecord = llJson2List(llList2String(lRecords, i));
        if(llList2Integer(lRecord, llListFindList(lFields, [sColumn])) == sValue) 
            return TRUE;
            
    }
    
    return FALSE;
}
integer getRecordCount(list lRecords) {
    integer v = llGetListLength(lRecords) - 1;
    if(v >= 0)
        return v;

    return 0;
}
list getRecordByIndex(list lRecords, integer iIndex) {
    list lFields = llJson2List(llList2String(lRecords, 0));
    
    list lResult;
    if(iIndex < getRecordCount(lRecords)) {
        list lRecord = llJson2List(llList2String(lRecords, iIndex + 1));
        
        integer j;
        for(j = 0; j < llGetListLength(lFields); j++) 
            lResult += [llList2String(lFields, j), llList2String(lRecord, j)];
            
    }
    
    return lResult;
}
list deleteRecordByIndex(list lRecords, integer iIndex) {
    if(iIndex < getRecordCount(lRecords))
        return llDeleteSubList(lRecords, iIndex + 1, iIndex + 1);
    
    return lRecords;
}