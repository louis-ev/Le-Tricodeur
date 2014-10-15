
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

  int nombreDeTweets = dateDesTweets.length;
  
  // instancesDeAt[0] correspond à @mokafolio 
  // instancesDeAt[1] correspond à @julapy 
  // instancesDeAt[2] correspond à @zachlierberman 
  instancesDeAt = new int[nombreDeTweets];
  nomDesUsers = new String[nombreDeTweets];
  
  int index1 = 0;
  
  for ( int i=0; i < nombreDeTweets; i++ ) {

      //println( "contenuDesTweets[i] : " + contenuDesTweets[i] );
      String contenuDuTweet = contenuDesTweets[i];
    
      // si il y a un @
      if ( contenuDuTweet.indexOf("@") != -1 ) {
        // trouver sa position
        int positionDuAt = contenuDuTweet.indexOf("@");
        // couper la chaine pour récupérer de sa position à la fin
        String morceauContenantAt = contenuDuTweet.substring( positionDuAt );
        println( "-morceauContenantAt : " + morceauContenantAt );
        
        int nextCharEspace = morceauContenantAt.indexOf(" ");
        int nextCharDeuxpoints = morceauContenantAt.indexOf(":");
        int nextCharParenthese = morceauContenantAt.indexOf(")");
        int nextCharPoint = morceauContenantAt.indexOf(".");
        
        nextCharEspace = nextCharEspace == -1 ? 200: nextCharEspace;
        nextCharDeuxpoints = nextCharDeuxpoints == -1 ? 200: nextCharDeuxpoints;
        nextCharParenthese = nextCharParenthese == -1 ? 200: nextCharParenthese;
        nextCharPoint = nextCharPoint == -1 ? 200: nextCharPoint;
        
        int nextChar = min( nextCharEspace, nextCharDeuxpoints);
        nextChar = min( nextChar, nextCharParenthese );
        nextChar = min( nextChar, nextCharPoint );
       
        String atUser;
       
        if ( nextChar == 200 ) {
          atUser = morceauContenantAt;
        } else {       
          atUser = morceauContenantAt.substring(0, nextChar);
        }
        
        
        println( "-nextCharEspace : " + nextCharEspace ); 
        println( "-nextCharDeuxpoints : " + nextCharDeuxpoints ); 
        println( "-nextChar : " + nextChar ); 
        
        println( "-atUser : " + atUser );
        
        if ( atUser.length() != 0 && atUser != null ) {
          nomDesUsers[index1] = atUser.toUpperCase();
          index1++;
        }
      }
  
      

  }  
  
  //println( "nombre de citations de @mokafolio : " +   instancesDeAt[0] );
  printArray( nomDesUsers );
  nomDesUsersUniques = new String[index];    
  for( int i=0; i< index-1; i++ ) {
    nomDesUsersUniques[i] = "";
  }
  
  int indexUU = 0;
  
  for( int i=0; i<nomDesUsers.length; i++ ) {
    
     String nomDuUser = nomDesUsers[i];
     
     boolean existingUser = false;
     
     //println( "nomDuUser " + nomDuUser );
     
     if (  nomDuUser == null ) {
       continue;  
     }
     
     for( int j=0; j< index - 1; j++ ) {
         if ( nomDesUsersUniques[j] == null ) {
           break;
         }
         if ( nomDuUser.toUpperCase().equals( nomDesUsersUniques[j].toUpperCase() ) ) {
           existingUser = true;
         }
     }
     
     
     print( existingUser );
     
     if ( existingUser == false ) {
        nomDesUsersUniques[indexUU] = nomDuUser;
        indexUU++;
     }
  }
  

  
  //println( "nomDesUsersUniques" );
  //println( nomDesUsersUniques );
  
  compteRetweet = new int[nomDesUsersUniques.length];
  
  for( int i = 0; i < nomDesUsersUniques.length ; i ++ ) {
    String nomDuUser = nomDesUsersUniques[i];
    
    //println( "nom du user " + nomDuUser );
    
    for( int j = 0; j < nomDesUsers.length ; j ++ ) {
      
      
     if ( nomDesUsers[j] != null ) {
        if ( nomDesUsers[j].equals(nomDuUser) ) {
          compteRetweet[i]++;
        }
     }
    
    }
  }
  
  for (int i=0; i < nomDesUsersUniques.length; i++) {
    if ( compteRetweet[i] > 0 ) {
      println( "nomDesUsersUniques[" + i + "] :" + nomDesUsersUniques[i] );      println( "compteRetweet[" + i + "] :" + compteRetweet[i] );
    }
  }
  
  int index3 = 0;
//  
//  compteRetweetClasses = new int[nomDesUsersUniques.length];
//  nomDesUsersUniquesClasses = new String[nomDesUsersUniques.length];
//  
//         
//  for (int i=0; i < compteRetweetClasses.length; i++) {
//    
//      //println( "Le message fait : " + contenuDesMessages[i].length() );
//
//          
//      for ( int j=0; j <= index3; j++ ) {
//        
//        //println( "Dans index :  " +  contenuDesMessagesClasses[j].length() );
//      
//        // si la valeur est plus haute on le pousse à la fin
//      
//      
//        // si le message compté est plus long, on va le pousser à la fin
//        if ( compteRetweet[i] > compteRetweetClasses[j] ) {
//          
//          if ( index3 == j ) {
//            
//            compteRetweetClasses[j] = compteRetweet[i];
//            nomDesUsersUniquesClasses[j] = nomDesUsersUniques[i];
//            index3++;          
// 
////            println("index3 == j == " + j);
////            println("compteRetweetClasses[j] : " + compteRetweetClasses[j]);
//
//            break; 
//          }
//          
//        } else {
//          
//          // pousser tout ceux qui viennent après
//          for ( int k=index3; k > j; k-- ) {
//            compteRetweetClasses[k] = compteRetweetClasses[k - 1];
//            nomDesUsersUniquesClasses[k] = nomDesUsersUniquesClasses[k - 1];
//          }
//        
//          compteRetweetClasses[j] = compteRetweet[i];
//          //auteurDesMessagesClasses[j] = auteurDesMessages[i];
//
//          index3++;          
//          break; 
//        }
//      }
//  }
//  

  //println( "index3 : " +index3 );
//  for ( int i=compteRetweetClasses.length-1; i > compteRetweetClasses.length-300; i-- ) {
//    //printArray( "-compteRetweet[" + i + "] : " + compteRetweet[i] );
//    //printArray( "-compteRetweetClasses[" + i + "] : " + compteRetweetClasses[i] );
//    //printArray( "-nomDesUsersUniquesClasses[" + i + "] : " + nomDesUsersUniquesClasses[i] );
//  }
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
