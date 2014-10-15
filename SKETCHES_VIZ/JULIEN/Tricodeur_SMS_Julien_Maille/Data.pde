int SMSData_countReceivedMax = -1;
int SMSData_countReceivedMin = -1;

int SMSData_countSentMax = -1;
int SMSData_countSentMin = -1;


class SMSData
{
  int year;
  int hour;
  int countReceived=0;
  int countSent=0;
  
  
  

  SMSData(int year_, int hour_)
  {
    this.year = year_;
    this.hour = hour_;
  }

  void setReceivedSent(int received_, int sent_)
  {
    this.countReceived = received_;
    this.countSent = sent_;


    // Save min / max here
    if (this.countReceived > SMSData_countReceivedMax || SMSData_countReceivedMax == -1)         SMSData_countReceivedMax = this.countReceived;
    else if (this.countReceived < SMSData_countReceivedMin || SMSData_countReceivedMin == -1)    SMSData_countReceivedMin = this.countReceived;

    if (this.countSent > SMSData_countSentMax || SMSData_countSentMax == -1)          SMSData_countSentMax = this.countSent;
    else if (this.countSent < SMSData_countSentMin || SMSData_countSentMin == -1)     SMSData_countSentMin = this.countSent;

  }
  
  String toString()
  {
    return "SMSData - year="+year+" ;hour="+hour+" ;received="+countReceived+" ;sent="+countSent;
  }
}
