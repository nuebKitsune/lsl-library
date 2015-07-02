#include "datetimeutils.lsl"

float getStatus(string sBirth, string sDays) {
    integer iBirth = uStamp2Unix(sBirth);
    integer iAdult = uUnixTimeAdd(iBirth, sDays + " days");
    return (float)(llGetUnixTime() - iBirth) / (float)(iAdult - iBirth);
}
string getStatusLabel(float fStatus) {
    if(fStatus > 1.0)
        return "Adult";
    
    if(fStatus > 0.7)
        return "Young Adult";
        
    if(fStatus > 0.3)
        return "Adolescence";
    
    if(fStatus > 0.0)
        return "Child";
    
    return "Adult";
        
}
string getGenderLabel(string sGender) {
    if(sGender == "M")
        return "Male";
    
    if(sGender == "F")
        return "Female";
    
    if(sGender == "H")
        return "Herm";
    
    return "Unknown";
}
string GenderGenerator() {
    float val = llFrand(100.0);
    if(val < 1.0)
        return "H";
        
    if(val < 50.0)
        return "M";
        
    if(val < 100.0)
        return "F";
    
    return "A";
}