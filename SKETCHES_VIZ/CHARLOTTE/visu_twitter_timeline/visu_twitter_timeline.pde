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

Table tweets; // créer la variable qui va stocker le fichier CSV

// créer les tableaux qui contiendront nos données
int[] idDesTweets;
Date[] dateDesTweets;
String[] contenuDesTweets;

void setup() {
  
  // TAILLE DU DESSIN
  size( 100,40);
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
  maTypo = createFont( "tricofonttype", 8 );
  textFont( maTypo );  
  
}

void draw() {
  
  /*************************************** VISUALISATION *********************************************/  
 
  /******** INSTRUCTIONS ***********/  
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
  /********************************/  
  /******* DEBUT DU DESSIN ********/  


//println( dateDesTweets[0] );

background(255);

int nombreDeTweets = dateDesTweets.length;

for( int i=0; i < nombreDeTweets; i = i+1 ) {


  int jourDuTweet = int( toJour.format( dateDesTweets[ i ] ) );
  int heureDuTweet = int( toHeure.format( dateDesTweets[ i ] ) );
  
  int jourDuTweetMap = jourDuTweet * 3;
  int heureDuTweetMap = int(heureDuTweet * 1.5);
  
  fill(0);
  noStroke();
  rect( jourDuTweetMap + 5, heureDuTweetMap+1, 1, 1);
  
  text("00H", 1, 6 );
  text("23H", 1, 37 );
  
}

//int jourDuTweet = int( toJour.format( dateDesTweets[ 0 ] ) );   

/*int anneeDuTweet = int( toAnnee.format( dateDesTweets[ i ] ) );
  int moisDuTweet = int( toMois.format( dateDesTweets[ i ] ) );
  int jourDuTweet = int( toJour.format( dateDesTweets[ i ] ) );
  
  
  int anneeDuTweetMap = anneeDuTweet - 2011;
  anneeDuTweetMap = (anneeDuTweetMap*20) + 4;
  int jourDuTweetMap = jourDuTweet * 3;
  
  fill(0);
  noStroke();
  rect( jourDuTweetMap, anneeDuTweetMap + moisDuTweet, 1, 1);
  
  
*/

stop();




















  
  /*************************************** FIN DE LA VISUALISATION *********************************************/  
}
