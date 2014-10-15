
// charger l'outil de formattage des dates Java
import java.util.*;
import java.text.*;

// pour récupérer les jours, mois, et années des dates,
// il faut d'abord déclarer le format qu'on souhaite obtenir
SimpleDateFormat toSeconde = new SimpleDateFormat("ss");
SimpleDateFormat toMinute = new SimpleDateFormat("mm");
SimpleDateFormat toHeure = new SimpleDateFormat("HH");
SimpleDateFormat toJour = new SimpleDateFormat("dd");
SimpleDateFormat toMois = new SimpleDateFormat("MM");
SimpleDateFormat toAnnee = new SimpleDateFormat("YYYY");
 
 
void prepareTwitterData() {

  
  /*************************************** PRÉPARATION DES DONNÉES *********************************************/  

  int lignesDuFichier = tweets.getRowCount();

  println( lignesDuFichier + " lignes dans le fichier"); 

  int index = 0;
  
  idDesTweets = new int[lignesDuFichier];
  dateDesTweets = new Date[lignesDuFichier];
  contenuDesTweets = new String[lignesDuFichier];
  
  // on prépare le formattage des dates pour les lire correctement dans le CSV
  SimpleDateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ZZZZZ");
  
  // charger toutes les lignes individuellement
  for (TableRow row : tweets.rows()) {
    
    idDesTweets[index] = row.getInt("tweet_id");
    try {
      dateDesTweets[index] = dateFormater.parse( row.getString("timestamp") );
    } catch (Exception e) {
      println("Unable to parse date stamp");
    }
    contenuDesTweets[index] = row.getString("text");
        
    index++;
    
  }
  
  // ne récupérer que les lignes qui contiennent un mot : 
  // for (TableRow row : tweets.matchRows("LE MOT.*", "text")) {
  
  println( "Lignes correspondants : " + index );
  
  /***************************************************************************************/


}

void nettoyerCSVDeTwitter( String fichierEnEntree, String fichierEnSortie ) {
  
  //println( "lines.length : " + lines.length);
 
  String lines[] = loadStrings( fichierEnEntree );

  String linesNew[] = new String[lines.length]; 
  
  int indexNewLines = 0;
  
  for(int i = 0; i < lines.length; i++){ 
        
    // si lines finit par "" alors on l'ajoute tranquillement
    if ( lines[i].substring(lines[i].length() -1).equals("\"") ) {
      linesNew[indexNewLines] = lines[i];
    } else {
      // et sinon, cela veut dire qu'on a à faire à un tweet coupé en plusieurs bouts
      
      // on récupère le premier bout
      String TweetComplet = "";
      // on créé un tableau 2d qui va contenir les autres bouts (max 10)
      String resteDuTweet[] = new String[10];
      int index = 0;
      // et on va chercher les autres bouts, tant qu'ils 

//      println( "BUG ON lines[" + i + "] = " + lines[i] ); 
//      println( "ce qui est sur lines[" + (i+1) + "] = " + lines[i+1] ); 
      
//println( "lines[i+1].substring(lines[i+1].length() -1) : " + lines[i+1].substring(lines[i+1].length() -1) );
      
      resteDuTweet[index] = lines[i];
      
//      println( "resteDuTweet[index].substring( resteDuTweet[index].length() -1) : " + resteDuTweet[index].substring( resteDuTweet[index].length() -1 ) ); 
      
      while ( resteDuTweet[index].substring( resteDuTweet[index].length() -1).equals("\"") == false ) {
        i++;
        index++;
        resteDuTweet[index] = lines[i];
      }
      
//      println("index : " + index);
//      println("resteDuTweet : " + resteDuTweet[0]);
//      println("resteDuTweet : " + resteDuTweet[1]);
//      println("resteDuTweet : " + resteDuTweet[2]);
//      println("resteDuTweet : " + resteDuTweet[3]);
//      println("resteDuTweet : " + resteDuTweet[4]);
//      println("resteDuTweet : " + resteDuTweet[5]);

      for( int j=0; j <= index; j++ ) {
         if (  resteDuTweet[j] != null ) {
           TweetComplet += resteDuTweet[j];
         }
      }
  
      //println("TweetComplet : " + TweetComplet );      
            
      linesNew[indexNewLines] = TweetComplet;
      
    }
      
    //println( "linesNew[" + indexNewLines + "] = " + linesNew[indexNewLines] ); 
    indexNewLines++;
    
  }
  
//  println( "---------------------------------" );
//  printArray ( linesNew );
//  println( "indexNewLines : " + indexNewLines);
  
   String linesNewShort[] = new String[indexNewLines];  
  arrayCopy(linesNew, linesNewShort, indexNewLines);
//   printArray ( linesNewShort );
 
  saveStrings( fichierEnSortie, linesNewShort );
  
}

// Code par @quark, de http://forum.processing.org/two/discussion/3350/getting-the-day-of-the-week-without-calendar/p1
// d = day in month
// m = month (January = 1 : December = 12)
// y = 4 digit year
// Returns 0 = Sunday .. 6 = Saturday

public int dayOfWeek(int d, int m, int y) {
  if (m < 3) {
    m += 12;
    y--;
  }
  return (d + int((m+1)*2.6) +  y + int(y/4) + 6*int(y/100) + int(y/400) + 6) % 7;
}
