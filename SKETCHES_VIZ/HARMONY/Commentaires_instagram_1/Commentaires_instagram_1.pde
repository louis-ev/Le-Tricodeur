/*

  Workshop TRICODEUR
  10-12 octobre 2014
  
  Organisé par Sew&Laine • sewetlaine.com
  avec la collaboration de Processing Bordeaux • processingbordeaux.org
  et animé par Louis Eveillard • louiseveillard.com
  avec l'aide de 2Roqs • 2roqs.fr
    
  Bibliothèque de maille
  > conçue et développée par Louis Eveillard
  > pour Processing 2.2.1 et plus
  > utilise du code issu de KnitPatternConverter par Ivan Sharko et Joel Glovier (repris ici avec leur permission)
  > (toutes plateformes) permet d'exporter des fichiers prêt à être tricoté 
  > (MacOS) permet d'envoyer les motifs à img2track, interface de connection à une machine à tricoter développé par Daviworks daviworks.com/knitting/

  Licence CC BY-SA
  creativecommons.org/licenses/by-sa/3.0/

*/
  
  
  
  int[] nombreDeCommentaires = { 
  8,0,2,0,0,5,1,5,12,4,0,0,0,2,0,0,5,3,0,2,1,1,2,2,1,2,6,0,1,0,4,0,0,0,2,1,0,1,1,6,12,0,2,1,1,0,0,3,4,4,0,0,3,1,2,4,2,0,2,0,3,2,9,4,0,0,3,10,4,8,6,6,0,0,0,4,1,0,0,0,1,6,0,3,2,9,0,0,0,0,0,2,0,0,5,0,0,0,0,0,0,0,5,0,0,0,0,2,0,0,0,0,0,1,2,0,8,2,0,0,0,2,5,1,0,0,0,0,4,0,4,0,4,0,2,3,5,0,5,1,0,0,0,3,1,0,8,0,1,0,0,2,0,1,2,0,0,0,0,0,0,0,0,1,0,1,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,13,2,0,2,5,4,0,3,0,0,0,0,1,2,2,0,0,0,0,0,0,0,0,0,2,0,1,0,0,0,0,0,0,0,0,0,0,0,2,2,0,1,0,0,3,0,1,0,0,0,0,5,1,0,0,0,0,2,1,0,0,0,2,0,0,0,0,1,0,0,0,2,0,0,0,0,0,1,0,0,0,0 
};

PFont maTypo;

PImage logo;


void setup() {
  
  size( 100, 100);
  background( 0 );
  noSmooth();
  
   logo = loadImage("SEW.jpg");

  /******** chargement de la bibliothèque de maille ********/
  ControlWindow mailleControlWindow = new ControlWindow();
  float stretchFactor = 1.4;
  mailleControlWindow.init(stretchFactor);
  /*********************************************************/
    
  maTypo = createFont("tricofonttype", 8);
  textFont(maTypo);

}

void draw() {
  
  fill(0);
  noStroke();
  

  background( #ffffff );
  
  //rotate( radians (90));
  text("2013", 10, 20);
  
  
    text("2014", 70, 20);
  
  
  
  
  image(logo, 25, 25, 50, 50);


  int nombreDePhoto = nombreDeCommentaires.length;
  //println( nombreDeLike );
  
  for ( int i = 0; i<nombreDePhoto; i = i+1 ) {

    int Commentaires = nombreDeCommentaires[i];
    int posYRect = i;
    fill(0);
    
    pushMatrix();
    translate( width/2, height/2 );
    rotate( radians( i - 45) );
    rect( 30, 0, Commentaires, 5 ); 
    

    popMatrix();
    
    
    
    
  }

println("mouseX : "+ mouseX);

}
