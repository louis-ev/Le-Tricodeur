import java.sql.*;

/*

 Workshop TRICODEUR
 10-12 octobre 2014
 
 Organisé par Sew&Laine • sewetlaine.com
 avec la collaboration de Processing Bordeaux • processingbordeaux.org
 et animé par Louis Eveillard • louiseveillard.com
 avec l'aide de 2Roqs • 2roqs.fr
 
 Sketch écrit par Louis Eveillard sous licence CC BY-SA
 
 Processing 2.2.1
 Visualisation de timeline Twitter
 
 */



PFont maTypo; // charger la typo


int wMaille = 100;
int hMaille = 120;
int scale = 1;

SMS sms;
ArrayList<SMSData> smsData;
int smsYear = 2014;

Graph graph;


void setup() 
{

  // TAILLE DU DESSIN
  size(wMaille*scale, hMaille*scale);
  background( 255 );
  noSmooth();

  /***** importation de la bibliothèque de Maille *****/
  ControlWindow mailleControlWindow = new ControlWindow();
  float stretchFactor = 1;
  mailleControlWindow.init(stretchFactor);

  noFill();
  stroke(0);
  strokeWeight(1);

  // charger la famille de caractère Tricofont, en taille 8 (la plus petite)
  maTypo = createFont( "tricofonttype-italic", 8 );
  textFont( maTypo );  

  // SMS stuff
  sms = new SMS();
  smsData = new ArrayList<SMSData>();

  if ( sms.connect("sms.sqlite") )
  {
    for (int h=0 ; h<24; h++)
    {
      SMSData data = new SMSData(smsYear, h);
      data.setReceivedSent(
      sms.getCountPerHour(smsYear, h, SMS.RECEIVED), 
      sms.getCountPerHour(smsYear, h, SMS.SENT)
        );
      smsData.add(data);
      println(data);
    }
  }
  
  graph = new Graph();
  graph.setDrawMode(Graph.ON_TOP);
}

void draw() 
{
  /********************************/
  /******* DEBUT DU DESSIN ********/
  background(255);
  translate(width/2, height/2);
  graph.draw();
  /*************************************** FIN DE LA VISUALISATION *********************************************/
}

void keyPressed()
{
  if (key == '1')
  {
    graph.setDrawMode(Graph.IN_OUT);
  }
  else if (key == '2')
  {
    graph.setDrawMode(Graph.SIDE_BY_SIDE);
  }
  else if (key == '3')
  {
    graph.setDrawMode(Graph.ON_TOP);
  }
}

