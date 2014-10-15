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

  PVector saveIMGxy = new PVector(20, 20);
  PVector tricoterIMGxy = new PVector(20, 80);
  PVector dossierIMGxy = new PVector(20, 140);
  PVector effacerIMGxy = new PVector(20, 200);
  
  String monSketchPath = sketchPath("");

  PApplet parentApplet;

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
      noSmooth();
      println( monSketchPath );
    }

    public void draw() {
      
      image( mesMailles.update(), 0,0);
      drawBouttons();
      
    }
    
    public void mouseReleased() {

      String timestamp = year() + nf(month(),2) + nf(day(),2) + "-"  + nf(hour(),2) + nf(minute(),2) + nf(second(),2);
      String nomFichier = "tricot-" + timestamp + ".png";
      String exportPath = monSketchPath + "/export/";

      if ( mouseX > saveIMGxy.x && mouseY > saveIMGxy.y && mouseX < saveIMGxy.x + 100 && mouseY < saveIMGxy.y + 50 ) {
        println("export");
//      image(mesMailles.returnRaw(), 0, 0);
        returnRaw().save(exportPath + nomFichier);
     }
      if ( mouseX > tricoterIMGxy.x && mouseY > tricoterIMGxy.y && mouseX < tricoterIMGxy.x + 100 && mouseY < tricoterIMGxy.y + 50 ) {
         println("img2track");   
          returnRaw().save(exportPath + nomFichier);
          exportImpression("/Applications/img2track.app/Contents/MacOS/img2track " + exportPath + nomFichier);
      }
      if ( mouseX > dossierIMGxy.x && mouseY > dossierIMGxy.y && mouseX < dossierIMGxy.x + 100 && mouseY < dossierIMGxy.y + 50 ) {
          open(exportPath);
      }
      if ( mouseX > effacerIMGxy.x && mouseY > effacerIMGxy.y && mouseX < effacerIMGxy.x + 100 && mouseY < effacerIMGxy.y + 50 ) {
         blankBackground();
      }

    }
    
    public void drawBouttons() {

      cursor(ARROW);
      tint(255, 150);


      if ( mouseX > saveIMGxy.x && mouseY > saveIMGxy.y && mouseX < saveIMGxy.x + 100 && mouseY < saveIMGxy.y + 50 ) {
         cursor(HAND);
      }
      if ( mouseX > tricoterIMGxy.x && mouseY > tricoterIMGxy.y && mouseX < tricoterIMGxy.x + 100 && mouseY < tricoterIMGxy.y + 50 ) {
         cursor(HAND);
      }
      if ( mouseX > dossierIMGxy.x && mouseY > dossierIMGxy.y && mouseX < dossierIMGxy.x + 100 && mouseY < dossierIMGxy.y + 50 ) {
         cursor(HAND);
      }
      if ( mouseX > effacerIMGxy.x && mouseY > effacerIMGxy.y && mouseX < effacerIMGxy.x + 100 && mouseY < effacerIMGxy.y + 50 ) {
         cursor(HAND);
      } 
      if ( mouseX >= saveIMGxy.x && mouseX <= saveIMGxy.x + 100 && mouseY >= 0 && mouseY <= effacerIMGxy.y+50 ) {
          noTint();
      }

       image(saveIMG, saveIMGxy.x, saveIMGxy.y);
       image(tricoterIMG, tricoterIMGxy.x, tricoterIMGxy.y);
       image(dossierIMG, dossierIMGxy.x, dossierIMGxy.y);
       image(effacerIMG, effacerIMGxy.x, effacerIMGxy.y);
       
        noTint();
     
     }
    
    
    
    
  }
}
