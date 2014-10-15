/*

  Workshop TRICODEUR
  10-12 octobre 2014
  
  Organisé par Sew&Laine • sewetlaine.com
  avec la collaboration de Processing Bordeaux • processingbordeaux.org
  et animé par Louis Eveillard • louiseveillard.com
  avec l'aide de 2Roqs • 2roqs.fr
  
  Sketch écrit par Louis Eveillard sous licence CC BY-SA
  
  Processing 2.2.1
  Visualisation des derniers messages facebook
  
*/
  
  
// importation de la bibliothèque de Maille
ControlWindow mailleControlWindow;
color bgColor = color(255,255,255,1);

XML xml;

XML[] filDeDiscussion;

PFont maTypo;

String[] auteurDesMessages;
String[] contenuDesMessages;
String[] contenuDesMessagesClasses;
String[] auteurDesMessagesClasses;

void setup() {
  
  size( 108, 300);
  background( bgColor );
  noSmooth();

// Chargement de la bibliothèque de Maille
  ControlWindow mailleControlWindow = new ControlWindow();
  float stretchFactor = 1;
  mailleControlWindow.init(stretchFactor);

  noFill();
  stroke(0);
  strokeWeight(1);
  
  // charger le fichier de donnée XML Facebook. Exporté avec www.givememydata.com
  xml = loadXML("DATASET/facebook-messages.xml");

//  dans ce fichier, aller chercher tous le blocs "<data>" situés dans data/data > fils de discussion
//  <inbox>
//    <data>
//      <data>
//        <id>XXX</id>
//        <to>XXX</to>
//        <comments>
//          XXX
//        </comments>
//      </data>
//      <data>
//        <id>YYY</id>
//        <to>YYY</to>
//        <comments>
//          YYY
//        </comments>
//      </data>
//
//      etc.
//
//  </inbox>
  
  filDeDiscussion = xml.getChildren("data/data");
    
  prepareFacebookData();
    
// charger la famille de caractère Tricofont, en taille 8 (la plus petite)
  maTypo = createFont( "tricofonttype", 8 );
  textFont( maTypo );
  
  
  
//les formes et textes seront dessinés en noir, sans contour  
  fill(0);
  noStroke();

}

void draw() {

  background(bgColor);
  
  /*************************************** VISUALISATION *********************************************/  
 
/* 
   Rendu ici nous avons donc deux tableux de la même longueur : auteurDesMessages[] et contenuDesMessages[]
   
   auteurDesMessages[], contient les auteurs de chaque message (à l'exception de l'auteur)
   
   Pour aller chercher dedans, il suffit de donner un index à auteurDesMessages. 
   Par exemple
   -> auteurDesMessages[0] donne Jérémie Lasnier
   -> auteurDesMessages[1] donne Francois Belain,
    etc. 
    
   contenuDesMessages contient tous les textes des auteurs mis bout à bout
   -> contenuDesMessages[0] donne Lorem Ipsum...
   -> contenuDesMessages[1] donne Hello World...
   
   -->contenuDesMessagesClasses et -->auteurDesMessages contiennent les même informations 
   mais classées par ordre croissant de quantité de messages échangés
   
  
*/  

  background(0);
  
  int nombreProfilsAffiches = 8;
    
  for (int i = contenuDesMessagesClasses.length-1; i > contenuDesMessagesClasses.length-1 - nombreProfilsAffiches; i = i - 1 ) {
       
     // s'il n'y a pas d'entrée à cet index
     if ( contenuDesMessagesClasses[i] == null ) {
        // on stop la boucle
        break;
     }
     
     // on compte la longueur des messages
     int longueurMessage = contenuDesMessagesClasses[i].length();
  
     float longueurMessageMAP = map(longueurMessage, 0, mouseX*100, width/2, 0);

     stroke(255);
     fill(255,255,255, 80 );
     ellipse( width, height/2, longueurMessageMAP, longueurMessageMAP*1.4 );

  }

  // ECRIRE LES AUTEURS (au-dessus des cercles)
  for (int i=auteurDesMessagesClasses.length-1;    i > auteurDesMessagesClasses.length-1 - nombreProfilsAffiches;    i=i-1 ) {
 
    float hauteurMessages = map( i, auteurDesMessagesClasses.length-1, auteurDesMessagesClasses.length - 1 - nombreProfilsAffiches, 10, height-10);
     int longueurMessage = contenuDesMessagesClasses[i].length();
  
     float longueurMessageMAP = map(longueurMessage, 0, mouseX*100, width/2, 0);

     // on récupère tous les auteurs d'un fil
     String auteurs = auteurDesMessagesClasses[i];
     // ne prendre que le premier nom
     auteurs = split( auteurs, " ")[0];
     
     // println( "auteurs " + auteurs) ;
     
     // si i est un nombre impair
     if ( i%2 == 1 ) {
       stroke(255);
       noFill();
       line( 3, height/2 - longueurMessageMAP/2 *1.4, width,  height/2 - longueurMessageMAP/2 *1.4);
       noStroke();
       fill(255);
       rect( 3, height/2 - longueurMessageMAP/2 *1.4 - 9, auteurs.length() * 4 +2, 10 );
       fill(0); 
       text( auteurs, 5, height/2 - longueurMessageMAP/2 * 1.4 - 2);       
     } else {
       stroke(255);
       noFill();
       line( 3, height/2 + longueurMessageMAP/2 *1.4, width,  height/2 + longueurMessageMAP/2 *1.4);
       noStroke();
       fill(255);
       rect( 3, height/2 + longueurMessageMAP/2 *1.4, auteurs.length() * 4 +2, 10 );
       fill(0); 
       text( auteurs, 5, height/2 + longueurMessageMAP/2 *1.4 + 8);              
     }
  
  }


}

