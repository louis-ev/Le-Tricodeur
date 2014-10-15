/*

  Workshop TRICODEUR
  10-12 octobre 2014
  
  Organisé par Sew&Laine • sewetlaine.com
  avec la collaboration de Processing Bordeaux • processingbordeaux.org
  et animé par Louis Eveillard • louiseveillard.com
  avec l'aide de 2Roqs • 2roqs.fr
    
  Bibliothèque de maille v1.02c
  > conçue et développée par Louis Eveillard
  > pour Processing 2.2.1 et plus
  > utilise du code issu de KnitPatternConverter par Ivan Sharko et Joel Glovier (repris ici avec leur aimable permission)
  > **toutes plateformes** permet d'exporter des fichiers prêt à être tricoté 
  > **MacOS** permet d'envoyer les motifs à img2track, interface de connection à une machine à tricoter développé par Daviworks daviworks.com/knitting/

  Licence CC BY-SA
  creativecommons.org/licenses/by-sa/3.0/

*/
  
  
  
  
PFont maTypo;


void setup() {
  
  size( 100, 100);
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
  text( "tricodeur", 5, 10 );

  ellipse( mouseX, mouseY , 5, 5);


}
