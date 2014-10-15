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




String[] donnees;
String[] dateDonnee;
String[] sessionDonnee;

int paquet = 2;

PFont maTypo;


void setup() {
  /******** chargement de la bibliothèque de maille ********/
  ControlWindow mailleControlWindow = new ControlWindow();
  float stretchFactor = 1.4;
  mailleControlWindow.init(stretchFactor);
  /*********************************************************/


  size( 70, 70);
  background( 255 );
  fill(255, 0, 0);
  noSmooth();

  donnees = loadStrings("datessessions.txt");
  dateDonnee = new String[donnees.length];
  sessionDonnee = new String[donnees.length];

  for (int i=0; i<donnees.length; i++)
  {
    if (donnees[i].equals("") == false)
    {
      String[] dateEtSession = split(donnees[i], ',');

      dateDonnee[i] = dateEtSession[0];
      sessionDonnee[i] = dateEtSession[1];
    }
  }


  maTypo = createFont("tricofonttype", 8);
  textFont(maTypo);
}

void draw() {

  background(255);
  fill(0);
  translate(width/2, height/2);

  float anglePas = 360.0 / ( float(donnees.length) / float(paquet) );
  float angle=0.0;
  for (int i=0; i<donnees.length; i = i+paquet)
  {
    float sessionMoyenne = 0.0;

    for (int j=i; j<i+paquet && i<donnees.length; j++)
    {
      sessionMoyenne += Float.parseFloat(sessionDonnee[i]);
    }

    sessionMoyenne /= float(paquet);

    float x = (10+sessionMoyenne*10) * cos( radians(angle) );
    float y = (10+sessionMoyenne*10) * sin( radians(angle) );

    line(0, 0, x, y);
    //text(i/paquet,x,y);

    angle = angle + anglePas;
  }

  stop();
}

