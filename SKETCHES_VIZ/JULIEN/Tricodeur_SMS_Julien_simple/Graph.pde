class Graph
{
  boolean DEBUG = false;
  boolean DRAW_TEXT = false;

  float rMin, rMax, radius, h;
  int drawMode;

  final static int IN_OUT = 0;
  final static int SIDE_BY_SIDE = 1;
  final static int ON_TOP = 2;
  
  color colorReceived = color(0);
  color colorSent = color(128);

  Graph()
  {
    setDrawMode(SIDE_BY_SIDE);
  }

  void setDebug(boolean is)
  {
    DEBUG = is;
  }
  
  void setDrawMode(int mode_)
  {
    this.drawMode = mode_;

    if (this.drawMode == IN_OUT)
    {
      this.radius = 0.5*min(width/2, height/2);
      this.rMax = this.radius + 0.5*min(width/2, height/2);
      this.rMin = this.radius - 0.4*min(width/2, height/2);
      this.h = 0.3*TWO_PI*radius/float( smsData.size() );
    }
    else if (this.drawMode == SIDE_BY_SIDE)
    {
      radius = 0.3*min(width/2, height/2);
      rMax = radius + 0.9*min(width/2, height/2);
      this.h = TWO_PI*radius/float( smsData.size() );
    }
    else if (this.drawMode == ON_TOP)
    {
      radius = 0.2*min(width/2, height/2);
      rMax = 0.8*min(width/2, height/2);
      this.h = TWO_PI*radius/float( smsData.size() );
    }
  }
  void draw()
  {
    float angle = 0;
    float d = TWO_PI / float( smsData.size() );
    noStroke();

    if (drawMode == IN_OUT)
    {
      pushMatrix();
      rotate(-PI/2);

      float rDelta = 0.05*min(width/2, height/2);

      for (SMSData data : smsData)
      {

        float tReceived = float(data.countReceived)/float(SMSData_countReceivedMax);
        float wReceived = tReceived * (rMax-radius-rDelta);

        float tSent = float(data.countSent)/float(SMSData_countSentMax);
        float wSent = tSent * (radius-rMin-rDelta);

        float hText = h;

        pushMatrix();
        rotate(angle);


        // Received      
        fill(colorReceived);
        pushMatrix();
        translate(radius+rDelta, 0);
        rect(0, -h/2, wReceived, h);
        if (DRAW_TEXT)
        {
          textSize(hText);
          text(data.countReceived, wReceived+5, h/2-2);
        }
        popMatrix();


        // Sent
        fill(colorSent);
        pushMatrix();
        translate(radius-rDelta, 0);
        rect(0, -h/2, -wSent, h);
        popMatrix();
        //      textSize(h);
        //      text(data.countReceived, wReceived+5, h/2-2);

        popMatrix();      
        angle += d;
      }
      popMatrix();

      fill(0);
      text(smsYear, -textWidth(""+smsYear)/2-1, -height/2+8);
    }
    else if (drawMode == SIDE_BY_SIDE)
    {
      pushMatrix();
      rotate(-PI/2);
      for (SMSData data : smsData)
      {
        float tReceived = float(data.countReceived)/float(SMSData_countReceivedMax);
        float wReceived = tReceived * (rMax-radius);

        float tSent = float(data.countSent)/float(SMSData_countSentMax);
        float wSent = tSent * (rMax-radius);

        pushMatrix();
        rotate(angle);
        translate(radius, 0);

        // Received
        fill(colorReceived);
        rect(0, -h/2, wReceived, h/2);

        // Sent
        fill(colorSent);
        rect(0, h/2, wSent, -h/2);

        popMatrix();

        angle += d;
      }
      popMatrix();

      fill(colorReceived);
      text(smsYear, -textWidth(""+smsYear)/2-1, 4);
    }
    else if (drawMode == ON_TOP)
    {
      pushMatrix();
      // scale(1,1.4);
      rotate(-PI/2);
      float wReceived=0, wSent=0;
      for (SMSData data : smsData)
      {
        float tReceived = float(data.countReceived)/float(SMSData_countReceivedMax);
        wReceived = 0.5*tReceived * rMax;

        float tSent = float(data.countSent)/float(SMSData_countSentMax);
        wSent = wReceived+0.5*tSent*rMax;

        pushMatrix();
        rotate(angle);
        translate(radius, 0);

        // Sent
        fill(colorSent);
        rect(0, -h/2, wSent, h);

        // Received
        fill(colorReceived);
        rect(0, -h/2, wReceived, h);

        popMatrix();

        angle += d;
      }
      popMatrix();

      fill(0);
      text(smsYear, -textWidth(""+smsYear)/2-1, 4);


    }

    if (DEBUG)
    {
      pushStyle();
      noFill();
      stroke(0);
      strokeWeight(h);
      ellipse(0, 0, 2*radius, 2*radius);

      noStroke();
      fill(0, 200, 0);
      rectMode(CENTER);
      rect(0, 0, 5, 5);
      popStyle();
    }
  }
}

