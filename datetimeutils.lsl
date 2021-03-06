integer ReturnMinuteDiff(string datetime1, string datetime2) {
    list dt1 = llParseString2List(datetime1, ["-", "T", ":", ".", " "], []);
    list dt2 = llParseString2List(datetime2, ["-", "T", ":", ".", " "], []);
    
    return 0;
}
list uUnix2StampLst( integer vIntDat ){
    if (vIntDat / 2145916800){
        vIntDat = 2145916800 * (1 | vIntDat >> 31);
    }
    integer vIntYrs = 1970 + ((((vIntDat %= 126230400) >> 31) + vIntDat / 126230400) << 2);
    vIntDat -= 126230400 * (vIntDat >> 31);
    integer vIntDys = vIntDat / 86400;
    list vLstRtn = [vIntDat % 86400 / 3600, vIntDat % 3600 / 60, vIntDat % 60];
 
    if (789 == vIntDys){
        vIntYrs += 2;
        vIntDat = 2;
        vIntDys = 29;
    }else{
        vIntYrs += (vIntDys -= (vIntDys > 789)) / 365;
        vIntDys %= 365;
        vIntDys += vIntDat = 1;
        integer vIntTmp;
        while (vIntDys > (vIntTmp = (30 | (vIntDat & 1) ^ (vIntDat > 7)) - ((vIntDat == 2) << 1))){
            ++vIntDat;
            vIntDys -= vIntTmp;
        }
    }
    return [vIntYrs, vIntDat, vIntDys] + vLstRtn;
}
integer uStamp2UnixInt( list vLstStp ){
    integer vIntYear = llList2Integer( vLstStp, 0 ) - 1902;
    integer vIntRtn;
    if (vIntYear >> 31 | vIntYear / 136){
        vIntRtn = 2145916800 * (1 | vIntYear >> 31);
    }else{
        integer vIntMnth = ~-llList2Integer( vLstStp, 1 );
        integer vIntDays = ~-llList2Integer( vLstStp, 2 );
        vIntMnth = llAbs( (vIntMnth + !~vIntMnth) % 12 );
        vIntRtn = 86400 * ((integer)(vIntYear * 365.25 + 0.25) - 24837 +
          vIntMnth * 30 + (vIntMnth - (vIntMnth < 7) >> 1) + (vIntMnth < 2) -
          (((vIntYear + 2) & 3) > 0) * (vIntMnth > 1) +
          llAbs( (vIntDays + !~vIntDays) % 31 ) ) +
          llAbs( llList2Integer( vLstStp, 3 ) % 24 ) * 3600 +
          llAbs( llList2Integer( vLstStp, 4 ) % 60 ) * 60 +
          llAbs( llList2Integer( vLstStp, 5 ) % 60 );
    }
    return vIntRtn;
}
integer uStamp2Unix(string timestamp) {
    return uStamp2UnixInt(llParseString2List(timestamp, ["-", "T", ":", ".", " "], []));
}
integer uUnixTimeAdd(integer unixtime, string adding) {
    list lUnits = llParseString2List(llToLower(adding), [" "], []);
    
    integer i;
    for(i = 0; i < getKeyValueLength(lUnits); i++) {
        list lPair = getKeyValuePair(lUnits, i);
        
        if(llList2String(lPair, 1) == "seconds")
            unixtime += llList2Integer(lPair, 0);
            
        if(llList2String(lPair, 1) == "minutes")
            unixtime += llList2Integer(lPair, 0) * 60;
        
        if(llList2String(lPair, 1) == "hours")
            unixtime += llList2Integer(lPair, 0) * 60 * 60; 
            
        if(llList2String(lPair, 1) == "days")
            unixtime += llList2Integer(lPair, 0) * 60 * 60 * 24;
        
        if(llList2String(lPair, 1) == "weeks")
            unixtime += llList2Integer(lPair, 0) * 60 * 60 * 24 * 7;
        
        if(llList2String(lPair, 1) == "months")
            unixtime += llList2Integer(lPair, 0) * 60 * 60 * 24 * 7 * 4;
            
        if(llList2String(lPair, 1) == "years")
            unixtime += llList2Integer(lPair, 0) * 60 * 60 * 24 * 365;
            
    }
    
    return unixtime;
}
     
integer CompareDateTime(string datetime1, string datetime2) {
    list dt1 = llParseString2List(datetime1, ["-", "T", ":", ".", " "], []);
    list dt2 = llParseString2List(datetime2, ["-", "T", ":", ".", " "], []);
    
    integer i = 0;
    while((llList2Integer(dt1, i) == llList2Integer(dt2, i)) && (i < llGetListLength(dt1)))
        i++;
        
    return (llList2Integer(dt1, i) - llList2Integer(dt2, i)) / llAbs(llList2Integer(dt1, i) - llList2Integer(dt2, i));
    
}
integer DateDiffDays(integer dt1, integer dt2) {
    integer diff = dt2 - dt1;
    return (diff / 60 / 60 / 24);
}
string uLongMonth(integer iMonth) {
    if(iMonth == 1)
        return "January";
    if(iMonth == 2)
        return "February";
    if(iMonth == 3)
        return "March";
    if(iMonth == 4)
        return "April";
    if(iMonth == 5)
        return "May";
    if(iMonth == 6)
        return "June";
    if(iMonth == 7)
        return "July";
    if(iMonth == 8)
        return "August";
    if(iMonth == 9)
        return "September"; 
    if(iMonth == 10)
        return "October";
    if(iMonth == 11)
        return "November";
    if(iMonth == 12)
        return "December";
    
    return "";
}
string uDaySuperScript(integer iDay) {
    string sResult;
    if(iDay == 1 || iDay == 21 || iDay == 31)
        return "st";
    if(iDay == 2 || iDay == 22)
        return "nd";
    if(iDay == 3 || iDay == 23)
        return "rd";
    
    return "th";
}
string uLongDateString(integer iTimestamp) {
    list lTimestamp = uUnix2StampLst(iTimestamp);
    string sResult;
    sResult += uLongMonth(llList2Integer(lTimestamp, 1)) + " ";
    sResult += llList2String(lTimestamp, 2) + uDaySuperScript(llList2Integer(lTimestamp, 2)) + ", ";
    sResult += llList2String(lTimestamp, 0);
    return sResult;
}
string uLongTimeString(integer iTimestamp) {
    list lTimestamp = uUnix2StampLst(iTimestamp);
    string sResult;
    sResult += llList2String(lTimestamp, 3) + ":";
    sResult += llList2String(lTimestamp, 4) + ":";
    sResult += llList2String(lTimestamp, 5);
    return sResult;
}
string uLongDateTimeString(integer iTimestamp) {
    string sResult;
    sResult += uLongDateString(iTimestamp);
    sResult += " ";
    sResult += uLongTimeString(iTimestamp);
    return sResult;
}