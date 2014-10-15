
void prepareFacebookData() {

  
  /*************************************** PRÉPARATION DES DONNÉES *********************************************/  
  
  // compter le nombre de fil de discussion
  int nombreFils = filDeDiscussion.length;
  
// on va récupérer l'intégralité des auteurs et des messages échangés dans le tableau
  auteurDesMessages = new String [nombreFils];
  contenuDesMessages = new String [nombreFils];
  
// arpenter successivement chaque fil de discussion
// -> pour le premier fil de discussion, le deuxième, le troisième, etc.
  for( int i=0; i < nombreFils; i = i+1) {
    
// AUTEURS

    // aller chercher les auteurs
    XML[] auteurs = filDeDiscussion[i].getChildren( "to/data/data/name" );

    // compter le nombre d'auteurs du fil en question
    int nombreAuteurs = auteurs.length;

    // initialiser la variable locale qui contiendra 
    // l'intégralité des auteurs d'un fil de discussion
    String auteursDuFil = "";

    // chercher dans les auteurs
    for( int j = 0; j < nombreAuteurs; j = j + 1 ) {
      if ( !auteurs[j].getContent().equals("Louis Eveillard") ) {
        auteursDuFil += auteurs[j].getContent() + " "; 
      }
    }
  
    // ajouter auteursDesMessages à auteurMessages    
    auteurDesMessages[i] = auteursDuFil;
    

// MESSAGES
    // aller chercher tous les blocs <message>
    XML[] messages = filDeDiscussion[i].getChildren( "comments/data/data/message" );

    // initialiser la variable locale qui contiendra l'intégralité des messages d'un fil de discussion
    String contenuDuFil = "";

    // compter le nombre de message que nous récupérons
    int nombreMessages = messages.length;
    
    // pour chacun des messages récupérés
    for( int j = 0; j < nombreMessages; j = j + 1 ) {
      // aller chercher le contenu de chaque message, l'ajouter à contenuDesMessages
      contenuDuFil += messages[j].getContent() + " "; 
    }
    
    // ajouter contenuDesMessages à contenuMessages
    contenuDesMessages[i] += contenuDuFil;
  
  }
  
  contenuDesMessagesClasses = new String[nombreFils];
  auteurDesMessagesClasses = new String[nombreFils];
  
  // les classer par longueur : les plus longs à la fin, plus courts au début
  println ( "contenuDesMessages.length : " + contenuDesMessages.length );
  
  for (int i=0; i < contenuDesMessagesClasses.length; i++) {
    contenuDesMessagesClasses[i] = "";
    auteurDesMessagesClasses[i] = "";
  }
 
   int index = 0; 
     
  for (int i=0; i < contenuDesMessages.length; i++) {
    
      //println( "Le message fait : " + contenuDesMessages[i].length() );

          
      for ( int j=0; j <= index; j++ ) {
        
        //println( "Dans index :  " +  contenuDesMessagesClasses[j].length() );
      
        // si le message compté est plus long, on va le pousser à la fin
        if ( contenuDesMessages[i].length() > contenuDesMessagesClasses[j].length() ) {
          
          if ( index == j ) {
            contenuDesMessagesClasses[j] = contenuDesMessages[i];
            auteurDesMessagesClasses[j] = auteurDesMessages[i];
            index++;          
            break; 
          }
          
        } else {
          
          // pousser tout ceux qui viennent après
          for ( int k=index; k > j; k-- ) {
            contenuDesMessagesClasses[k] = contenuDesMessagesClasses[k - 1];
            auteurDesMessagesClasses[k] = auteurDesMessagesClasses[k - 1];
          }
        
          contenuDesMessagesClasses[j] = contenuDesMessages[i];
          auteurDesMessagesClasses[j] = auteurDesMessages[i];

          index++;          
          break; 
        }
      }
  }
  
  for (int i=0; i < contenuDesMessagesClasses.length; i++) {
     println( "- contenuDesMessagesClasses[" + i + "].length() - " + contenuDesMessagesClasses[i].length() ); 
     println( "- auteurDesMessagesClasses[" + i + "].length() - " + auteurDesMessagesClasses[i] ); 
  }
   
  
  
  
  
  
  
  
  
  /***************************************************************************************/


}
