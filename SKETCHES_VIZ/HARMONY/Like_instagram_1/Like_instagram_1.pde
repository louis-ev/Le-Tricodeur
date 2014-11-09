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
  
  
  
  int[] nombreDeLike = { 
  19,18,36,9,23,59,20,25,26,15,43,27,13,35,23,14,16,27,35,11,50,25,37,28,26,43,19,24,16,27,18,13,15,36,19,23,36,20,10,29,25,22,8,5,43,12,31,25,13,17,20,23,14,16,19,21,11,19,8,24,27,9,12,33,22,15,26,33,44,8,23,13,18,26,17,28,10,29,43,24,16,23,55,9,8,8,9,10,32,13,23,33,12,18,25,18,12,10,26,18,26,26,19,22,20,25,21,11,5,5,15,12,26,11,28,19,8,13,18,31,16,20,18,7,12,18,20,17,11,39,19,12,20,23,24,36,20,6,24,14,39,11,14,35,14,12,11,11,16,9,9,15,10,10,11,19,10,9,9,3,31,16,10,6,9,6,12,10,12,5,6,11,6,3,11,7,15,4,2,21,9,9,47,25,20,21,28,15,5,10,4,1,3,5,4,5,7,4,3,5,5,8,11,4,7,4,8,7,8,2,6,3,4,6,5,4,5,9,4,3,8,4,3,2,10,3,11,3,11,2,9,1,5,6,5,3,5,3,2,8,11,9,3,7,6,21,13,14,14,9,3,4,1,8,16,3,4,7,9,5,4,2,2,3 
};

PFont maTypo;


void setup() {
  
  size( 100, nombreDeLike.length);
  background( 255 );
  noSmooth();

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
  text( "tricodeur", 5, 7 );

  background( #ffffff );
 text("2014", 5, 8);
 text("2013", 5, 260);

  int nombreDePhoto = nombreDeLike.length;
  //println( nombreDeLike );
  
  for ( int i = 0; i<nombreDePhoto; i = i+1 ) {

    int Like = nombreDeLike[i];
    int posYRect = i;
    fill(Like);
    
   

    rect( 30, posYRect, width-(2*30), 1);
   // text( Like, 10, posYRect + 10 );
    
    
    
    
  }

println("mouseX : "+ mouseX);

}
