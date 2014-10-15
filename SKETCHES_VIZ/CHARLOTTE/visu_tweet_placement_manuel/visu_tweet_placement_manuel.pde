
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

PImage photo; // charger l'image

PFont maTypo; // charger la typo

Table tweets; // créer la variable qui va stocker le fichier CSV

// créer les tableaux qui contiendront nos données
int[] idDesTweets;
Date[] dateDesTweets;
String[] contenuDesTweets;

void setup() {

  size( 100, 180);
  background( 255 );
  noSmooth();

  /***** importation de la bibliothèque de Maille *****/
  ControlWindow mailleControlWindow = new ControlWindow();
  float stretchFactor = 1;
  mailleControlWindow.init(stretchFactor);

  noFill();
  stroke(0);
  strokeWeight(1);

  // charger le fichier de donnée CSV twitter. Exporté avec twitter.com
  // Comme il n'est pas tout à fait propre, on va le nettoyer grâce à la fonction
  // nettoyerCSVDeTwitter( nom du fichier en entrée, nom du fichier propre qui sera créé );
  nettoyerCSVDeTwitter( "DATASET/tweets-charlotte.csv", "DATASET/tweets-charlotte-new.csv");  

  // on peut maintenant charger le fichier propre
  tweets = loadTable("DATASET/tweets-charlotte-new.csv", "header");
  // la fonction pour préparer les données twitter
  prepareTwitterData();

  // charger la famille de caractère Tricofont, en taille 8 (la plus petite)
  maTypo = createFont( "tricofonttype-italic", 8 );
  textFont( maTypo );

  photo = loadImage("DATASET/Twitter.png");
}

void draw() {

  /*************************************** VISUALISATION *********************************************/

  /* 
   
   Rendu ici nous avons deux tableux de la même longueur : dateDesTweets[] et contenuDesTweets[]
   
   Leur longueur correspond au nombre de tweets que nous avons dans notre fichier CSV
   Pour la récupérer : 
   -> int nombreDeTweets = dateDesTweets.length;
   
   dateDesTweets[], contient les dates de chaque message.
   Ce sont des objets Date et non des chaînes de caractère.
   
   Pour aller chercher dedans, il suffit de donner un index à dateDesTweets. 
   Par exemple
   -> dateDesTweets[0] donne 2014-10-03 08:24:25 +0000
   -> dateDesTweets[1] donne 2014-10-03 07:52:41 +0000
   etc. 
   
   Pour en extraire une valeur précise -> toMinute, toHeure, toJour, toMois, toAnnee
   -> int jourDuTweet = int( toJour.format( dateDesTweets[ 0 ] ) );   
   
   contenuDesTweets contient tous les textes
   -> contenuDesTweets[0] donne Lorem Ipsum...
   -> contenuDesTweets[1] donne Hello World...
   
   */

  background(255);

  int nombreDeTweets = dateDesTweets.length;

  // instancesDeAt[0] correspond à @mathildeD_V 
  // instancesDeAt[1] correspond à @audrey_bardon
  // instancesDeAt[2] correspond à @SimonJumel
  int[] instancesDeAt = new int[10];

  for ( int i=0; i < nombreDeTweets; i++ ) {

    println( "contenuDesTweets[i] : " + contenuDesTweets[i] );
    
    String contenuDuTweet = contenuDesTweets[i];

    if ( contenuDuTweet.indexOf("@mathildeD_V") != -1 ) {
      instancesDeAt[0]++;
    }
    if ( contenuDuTweet.indexOf("@Tart2000") != -1 ) {
      instancesDeAt[1]++;
    }
    if ( contenuDuTweet.indexOf("@SimonJumel") != -1 ) {
      instancesDeAt[2]++;
    }
  }  

  println( "nombre de citations de @mathildeD_V : " +   instancesDeAt[0] );
  println( "nombre de citations de @tart2000 : " +   instancesDeAt[1] );

  int nombreDeAtAffiches = instancesDeAt.length;

  for ( int i = 0; i < nombreDeAtAffiches; i = i + 1 ) {

    int atUser = instancesDeAt[i];

    fill( 0 );

    // instancesDeAt[0] correspond à @mathildeD_V 
    // instancesDeAt[1] correspond à @audrey_bardon
    // instancesDeAt[2] correspond à @SimonJumel


    if ( i == 0 ) {
      text( "@mathildeD_V", 20, atUser/2 +106);  
      image(photo, 25, 100, atUser/2, atUser/2);
    }
    if ( i == 1 ) {
      text( "@audrey_bardon", 4, 175 );
      image(photo, 7, 156, atUser/2, atUser/2);
    }
    if ( i == 2 ) {
      text( "@simonjumel", 50, 165 );
      image(photo, 75, 140, atUser/2, atUser/2);
    }
    
    text( "@LaCasemate", 7, 97 );  
    image(photo, 10, 60, 30, 30);
    
    text( "@RSLNmag", 56, 51 );  
    image(photo, 55, 4, 40, 40);
    
    text( "@Ameauriz", 4, 23 );  
    image(photo, 7, 4, 11, 11);
    
    text( "@jereerej", 10, 53 );  
    image(photo, 17, 26, 20, 20);
    
    text( "@museomix", 60, 88 );  
    image(photo, 75, 65, 15, 15);
    
    
    
  }






  stop();

  /*************************************** FIN DE LA VISUALISATION *********************************************/
}

