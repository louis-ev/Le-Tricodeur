/*

  Workshop TRICODEUR
  10-12 octobre 2014
  
  Organisé par Sew&Laine • sewetlaine.com
  avec la collaboration de Processing Bordeaux • processingbordeaux.org
  et animé par Louis Eveillard • louiseveillard.com
  avec l'aide de 2Roqs • 2roqs.fr
    
  Bibliothèque de maille v1.02b
  > conçue et développée par Louis Eveillard
  > pour Processing 2.2.1 et plus
  > utilise du code issu de KnitPatternConverter par Ivan Sharko et Joel Glovier (repris ici avec leur aimable permission)
  > **toutes plateformes** permet d'exporter des fichiers prêt à être tricoté 
  > **MacOS** permet d'envoyer les motifs à img2track, interface de connection à une machine à tricoter développé par Daviworks daviworks.com/knitting/

  Licence CC BY-SA
  creativecommons.org/licenses/by-sa/3.0/

*/
  
  
  
  
PFont tricofontreg, tricofontita, tricofontbol;

float pposX, pposY;

PVector acceleration =  new PVector(0f, 0.025);


void setup() {
  
  size( 60, 90);
  background( 255 );
  noSmooth();

  /******** chargement de la bibliothèque de maille ********/
  ControlWindow mailleControlWindow = new ControlWindow();
  float stretchFactor = 1.4;
  mailleControlWindow.init(stretchFactor);
  /*********************************************************/
    
  tricofontreg = createFont("tricofonttype", 8);
  tricofontita = createFont("tricofonttype-italic", 8);
  tricofontbol = createFont("tricofonttype-bold", 8);
  textFont(tricofontreg);

}

void draw() {
  
  fill(0);
  noStroke();
  textFont( tricofontreg );
  text( "tricodeur", 5, 10 );



}

void drawFromMaille( String currentMode, float pourcentX, float pourcentY ) {
  
  if ( pposX == 0 && pposY == 0 ) {
    pposX = pourcentX;
    pposY = pourcentY; 
  }
  
  //println( "pourcentX :  " + pourcentX + " pourcentY :  " + pourcentY );
  
  int posXMap = round(pourcentX * width);
  int posYMap = round(pourcentY * height);
  int pposXMap = round(pposX * width);
  int pposYMap = round(pposY * height);
  
  println( "posXMap :  " + posXMap + " posYMap :  " + posYMap );
  println( "pposXMap :  " + pposXMap + " pposYMap :  " + pposYMap );


  PVector velocity = new PVector(posXMap-pposXMap, posYMap-pposYMap);
  velocity.add(acceleration);

//  println( "currentMode : " + currentMode );
//  println( "currentMode.substring(0,4) : " + currentMode.substring(0,4) );



  if ( currentMode.equals("ellipse") ) {
    
    float fillEllipse = velocity.mag() * 20;  
    stroke( 0 );
    strokeWeight(1);
    fill( 0 + fillEllipse );
    ellipse( posXMap, posYMap, 15, 15 );
    
  } else if ( currentMode.equals("line") ) {
    
    int strokeWeight = (int)max( 1, map( velocity.mag(), 0, 60, 0, 4 ));  
    stroke( 0 );
    fill( 255 );
    //strokeWeight( strokeWeight );
    println( "strokeWeight : " + strokeWeight );
    line( posXMap, posYMap, pposXMap, pposYMap );
    
  } else if ( currentMode.substring(0,4).equals("text") ) {
    
    String pressedKey = currentMode.substring(5);
    
    println("pressedKey : " + pressedKey );
    
    noStroke();
    fill( 0 );
    
    text( pressedKey, posXMap, posYMap );    
    
  }
  
 
  pposX = pourcentX;
  pposY = pourcentY;
  
  
}
