import java.sql.*;

int wMaille = 100;
int hMaille = 140;
int scale = 5;

SMS sms;
ArrayList<SMSData> smsData;
int smsYear = 2014;

Graph graph;

void setup()
{
  sms = new SMS();
  smsData = new ArrayList<SMSData>();
  
  if ( sms.connect("sms.sqlite") )
  {
    for (int h=0 ; h<24; h++)
    {
      SMSData data = new SMSData(smsYear,h);
      data.setReceivedSent(
        sms.getCountPerHour(smsYear,h,SMS.RECEIVED),
        sms.getCountPerHour(smsYear,h,SMS.SENT)
      );
      smsData.add(data);
       println(data);
    }
    
    //noSmooth();
  }

  size(wMaille*scale, hMaille*scale);

  graph = new Graph();
}

void keyPressed()
{
  if (key>='0' && key<='3')
    graph.setDrawMode( int(key-'1') );
}



void draw()
{
  background(255);
  translate(width/2, height/2);
  graph.draw();
}

