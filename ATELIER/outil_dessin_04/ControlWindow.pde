KnittingPattern mesMailles;

import java.util.*;
 import java.io.BufferedReader;
import java.io.InputStreamReader;

class ControlWindow {
 
  SecondApplet s;
  import javax.swing.*; 
  KnittingPattern mesMailles = new KnittingPattern();
  PImage saveIMG = loadImage("data/ICONES/icones-01.png");
  PImage tricoterIMG = loadImage("data/ICONES/icones-02.png");
  PImage effacerIMG = loadImage("data/ICONES/icones-03.png");
  PImage dossierIMG = loadImage("data/ICONES/icones-04.png");
  int exportBouttonX = 20;
  int exportBouttonY = 20;
  int exportBouttonWidth = 100;
  int exportBouttonHeight = 50;

  PVector tricoterIMGxy = new PVector(20, 20);
  PVector effacerIMGxy = new PVector(20, 80);
  
  String monSketchPath = sketchPath("").replaceAll(" ", "\\ ");
  //monSketchPath = monSketchPath;
  
  String textString = "";
  float pourcentX, pourcentY;
  
  Boolean commandIsRunning = false;
  Boolean startCommand = false;
  
  Boolean drawLine = true;
  Boolean drawEllipse = false;
  Boolean drawText = false;

  PApplet parentApplet;
  PFont tricofont;

  ControlWindow() {
  }
  
  void init(float _stretchFactor ) {
    mesMailles.init( _stretchFactor );
    PFrame f = new PFrame(width*10, floor(height*7*_stretchFactor));
    f.setTitle("Simulation en maille");
  }
  
  void update(PGraphics mailleTemp) {

  }
  
  PImage returnRaw() {
     return get(); 
  }
  
  void blankBackground() {
     background( 255,255,255, 255 );
  }
  

  public class PFrame extends JFrame {
    public PFrame(int width, int height) {
      setBounds(100, 100, width, height);
      s = new SecondApplet();
      add(s);
      s.init();
      show();
    }
  }
  public class SecondApplet extends PApplet {
    public void setup() {
      background(0);
      noStroke();
      //noSmooth();
      println( monSketchPath );
      tricofont = createFont("tricofonttype", 32);
      textFont( tricofont);
      textAlign(CENTER, CENTER);
      
    }

    public void draw() {

      image( mesMailles.update(), 0,0);
      drawBouttons();
      
      
      // si on clique
      if ( mousePressed ) {
        
        println( "mouseX : " + mouseX + " mouseY : " + mouseY );
        
        if ( mouseX != 0 && mouseY != 0 ) {
          // si pas les boutons de gauche
          if ( mouseX > tricoterIMGxy.x + 100 || mouseY > tricoterIMGxy.y + 50 ) {
            
            // si pas les boutons de droite 
            if ( mouseX < width - 20 - 50 || mouseY > 20 + 50 + 10 + 50 + 10 + 50 ) {
            
              pourcentX = (float) mouseX / width;
              pourcentY = (float) mouseY / height;
              
              if ( drawEllipse ) {
                drawFromMaille( "ellipse", pourcentX, pourcentY );     
              } else if ( drawLine ) {
                drawFromMaille( "line", pourcentX, pourcentY );     
              } else if ( drawText ) {
                textString = ".";
                drawFromMaille( "text-" + textString, pourcentX, pourcentY );   
              }
            }
          }
          
          
        }   
      }
      
      
      if ( commandIsRunning ) {
          fill( 0, 0, 0, 140 );
          rect( 0,0, width, height );
          textAlign(CENTER);
          fill(255);
          text("Le logiciel img2track est actuellement lancé, fermer le pour reprendre le dessin.", width/3, height/3, width/3, height/2);
          
          if ( startCommand ) {
            exportToImg2track();
            commandIsRunning = false;
            startCommand = false;
          }
          
          if ( commandIsRunning ) {
            startCommand = true;
          }
      }
      
    }
    
    public void keyReleased() {

     if ( drawText ) {
        textString += key;          
        
        drawFromMaille( "text-" + textString, pourcentX, pourcentY );   
     }
    }
    
    
    public void mouseReleased() {

      if ( mouseX > tricoterIMGxy.x && mouseY > tricoterIMGxy.y && mouseX < tricoterIMGxy.x + 100 && mouseY < tricoterIMGxy.y + 50 ) {
         println("Sending to img2track with PNG");   
         commandIsRunning = true;
      }
      if ( mouseX > effacerIMGxy.x && mouseY > effacerIMGxy.y && mouseX < effacerIMGxy.x + 100 && mouseY < effacerIMGxy.y + 50 ) {
         blankBackground();
      }
      // click colonne droite
      if ( mouseX > width-20-50 && mouseX < width-20 ) {
        
        // si click première vignette ( ligne )
        if (  mouseY > 20 && mouseY < 20 + 50 ) {
          drawEllipse = false;
          drawLine = true;
          drawText = false;
        } else 
        if (  mouseY > 20 + 50 + 10 && mouseY < 20 + 50 + 10 + 50 ) {
          drawEllipse = true;
          drawLine = false;
          drawText = false;
        } else
        if (  mouseY > 20 + 50 + 10 + 50 + 10 && mouseY < 20 + 50 + 10 + 50 + 10 + 50 + 10 ) {
          drawEllipse = false;
          drawLine = false;
          drawText = true;
        }
      }

    }
    
    public void drawBouttons() {

      cursor(ARROW);
      tint(255, 150);


      if ( mouseX > tricoterIMGxy.x && mouseY > tricoterIMGxy.y && mouseX < tricoterIMGxy.x + 100 && mouseY < tricoterIMGxy.y + 50 ) {
         cursor(HAND);
      }
      if ( mouseX > effacerIMGxy.x && mouseY > effacerIMGxy.y && mouseX < effacerIMGxy.x + 100 && mouseY < effacerIMGxy.y + 50 ) {
         cursor(HAND);
      } 
      if ( mouseX >= tricoterIMGxy.x && mouseX <= tricoterIMGxy.x + 100 && mouseY >= 0 && mouseY <= effacerIMGxy.y+50 ) {
          noTint();
      }

      strokeWeight(1);
      
      // draw line tool
      pushMatrix();
        translate( width-20, 20 );
        fill( 255,255,255, 80 );

        stroke( 255 );        
        if ( drawLine ) {
          stroke( #ff2719 );        
        }
        
        strokeWeight(1);
        rect( 0, 0, -50, 50 );
        fill(255);
        
        
        stroke( 0 );
        strokeWeight(2);
        line( -40, 10, -10, 40);
      popMatrix();
      // draw ellipse tool
      pushMatrix();
        translate( width-20, 80 );
        fill( 255,255,255, 80 );
        stroke( 255 );
        if ( drawEllipse ) {
          stroke( #ff2719 );        
        }

        strokeWeight(1);
        rect( 0, 0, -50, 50 );

        noFill();
        strokeWeight(2);
        stroke( 0 );
        ellipse( -25, 25, 30, 30);
      popMatrix();
      
      // draw text tool
      pushMatrix();
        translate( width-20, 140 );
        fill( 255,255,255, 80 );
        stroke( 255 );
        if ( drawText ) {
          stroke( #ff2719 );        
        }

        strokeWeight(1);
        rect( 0, 0, -50, 50 );

        fill(0);
        noStroke();
        text( "T", -24, 25);
        
      popMatrix();
     

       image(tricoterIMG, tricoterIMGxy.x, tricoterIMGxy.y);
       image(effacerIMG, effacerIMGxy.x, effacerIMGxy.y);
       
        noTint();
     
     }
      
      
      public void exportToImg() {
        String timestamp = year() + nf(month(),2) + nf(day(),2) + "-"  + nf(hour(),2) + nf(minute(),2) + nf(second(),2);
        String nomFichier = "tricot-" + timestamp + ".png";
        String exportPath = monSketchPath + "export/";
        returnRaw().save(exportPath + nomFichier);
      }
      
      public void exportToImg2track() {
        String timestamp = year() + nf(month(),2) + nf(day(),2) + "-"  + nf(hour(),2) + nf(minute(),2) + nf(second(),2);
        String nomFichier = "tricot-" + timestamp + ".png";
        String exportPath = monSketchPath + "export/";

        returnRaw().save(exportPath + nomFichier);
        exportImpression("/Applications/img2track.app/Contents/MacOS/img2track " + exportPath + nomFichier);        
      }

      public void openFolder() {
        String exportPath = monSketchPath + "export/";
        open(exportPath); 
      }
    
    
    
  }
}
