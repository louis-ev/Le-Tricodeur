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
  
  String monSketchPath = sketchPath("").replaceAll(" ", "\\ ");
  //monSketchPath = monSketchPath;
  
  Boolean commandIsRunning = false;
  Boolean startCommand = false;
  


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
      
      
      
      
      if ( commandIsRunning ) {
          fill( 0, 0, 0, 140 );
          rect( 0,0, width, height );
          textAlign(CENTER);
          fill(255);
          text("img2track est actuellement lancé, fermer le pour reprendre", width/2, height/3);
          
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
    
    public void mouseDragged() {
      
    }
    
    
    public void mouseReleased() {

      if ( mouseX > saveIMGxy.x && mouseY > saveIMGxy.y && mouseX < saveIMGxy.x + 100 && mouseY < saveIMGxy.y + 50 ) {
        println("Exporting to PNG");
//      image(mesMailles.returnRaw(), 0, 0);
        exportToImg();
     }
      if ( mouseX > tricoterIMGxy.x && mouseY > tricoterIMGxy.y && mouseX < tricoterIMGxy.x + 100 && mouseY < tricoterIMGxy.y + 50 ) {
         println("Sending to img2track with PNG");   
         commandIsRunning = true;
      }
      if ( mouseX > dossierIMGxy.x && mouseY > dossierIMGxy.y && mouseX < dossierIMGxy.x + 100 && mouseY < dossierIMGxy.y + 50 ) {
         openFolder();
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
/*

  From KnitPatternConverter

 Knitting pattern turns whatever is drawn in the sketch into an imitation of a knitted piece.
 It is done by recreating each pixel of the image as a "stitch". The knitting texture consists of a tiled texture 4x10 stitches. Each of which,
 gets colored according to pixels[] array of the original sketch drawing.
 
 */
class KnittingPattern {

  PGraphics buf;
  import java.awt.Color;

  // Répertoire des stitches
  String stitchPatternPath = "data/StitchPattern/";

  //Main offset of the big knitted image that's going to be drawn in the buffer
  int _offsetX = 0;
  int _offsetY = 0;

  // facteur d'étirement
  float scaleY = 1.3;

  //Knitting texture
  ArrayList <Stitch[]> knitTexture = new ArrayList ();


  //------------------------------------------------------------------------------------------------------------------------------------
  //CONSTRUCTOR-----------------------------------------------
  KnittingPattern() {

    //Init knit texture.
    knitTexture.add(new Stitch [4]); 
    knitTexture.add(new Stitch [4]);
    knitTexture.add(new Stitch [4]);
    knitTexture.add(new Stitch [4]);
    knitTexture.add(new Stitch [4]);
    knitTexture.add(new Stitch [4]);
    knitTexture.add(new Stitch [4]);
    knitTexture.add(new Stitch [4]);
    knitTexture.add(new Stitch [4]);
    knitTexture.add(new Stitch [4]);


    // go through rows/cols to init each Stitch in the pattern
    for (int row=0; row < knitTexture.size(); row ++) {        
      for (int col=0; col < knitTexture.get(row).length; col ++) {
        String path = stitchPatternPath + (row+1) + "-" + (col+1) + ".png";                
        knitTexture.get(row)[col] = new Stitch(row, col, path);
      }
    }

    // go through rows/cols to setup relative X position of each stitch and account for xOffsets that are unique to each stitch
    for (int row=0; row < knitTexture.size(); row ++) {
      int myX = 0;
      for (int col=0; col < knitTexture.get(row).length; col ++) {        
        knitTexture.get(row)[col].relX = myX;        
        myX += knitTexture.get(row)[col].stitchImage.width;
        myX -= knitTexture.get(row)[col].xOffset;
      }
    }

    // go through cols/rows to setup relative Y position of each stitch and account for yOffsets that are unique to each stitch
    for (int col=0; col < 4; col ++) {        
      int myY = 0;
      for (int row=0; row < knitTexture.size(); row ++) {
        knitTexture.get(row)[col].relY = myY;
        myY += knitTexture.get(row)[col].stitchImage.height;
        myY -= knitTexture.get(row)[col].yOffset;
      }
    }
  }


  //------------------------------------------------------------------------------------------------------------------------------------
  //Init the converter by loading pixels in the sketch and initializing the buffer based on the sketch height and width.
  void init(float _stretchFactor) {    
    int bufHeight = floor(height*7);
    buf = createGraphics(width * 10, bufHeight);
    
    scaleY = _stretchFactor;
    
  }
  
  PGraphics update() {
    int bufHeight = floor(height*7);
    buf = createGraphics(width * 10, bufHeight);
    return generate();    
  }
  
  //------------------------------------------------------------------------------------------------------------------------------------
  //Generate stitch pattern and draw it into the buffer
  PGraphics generate() {
    
    int x, y, row, col;
    int chunkX, chunkY;
    int indexX, indexY;
    int yOffset = 0;

    loadPixels();

    //Begin drawing the texture into buffer    
    buf.beginDraw();
    //buf.image(bgTexture, 0, 0);

    //Cycyle through "pixels" array and create a "stitch" for every pixel in the buffer.
    for (int i=0; i < pixels.length; i++) {
      //find out which row and column we are on, based one a 1-dimensional pixels array
      row = i/width;
      col = i%width;

      //how many WHOLE chunks have we already drawn? This will affect our offsets
      chunkX = col/4;
      chunkY = row/10;

      //Which row and column of a tiled pattern (knitted pattern chunk) are we drawing?
      indexX = (col-chunkX*4)%4;
      indexY = (row-chunkY*10)%10;

      //setup the Stitch and draw it in according position
      Stitch _s = knitTexture.get(indexY)[indexX];
      if (indexX == 0) {
        x = _s.relX +  40 * chunkX + _offsetX + int((indexX%2));
      } 
      else {
        x = _s.relX +  40 * chunkX + _offsetX;
      }      
      y = _s.relY +  68 * chunkY + _offsetY;

      //TINT the stitch and draw it in the buffer
      buf.tint(pixels[i]);
      buf.image(_s.stitchImage, x, y);
    }

    buf.endDraw();
    
    //Create another buffer.
    //After initial conversion to a pattern, we have to stretch it vertically by 30%, becase the stitches aren't a 1 to 1 ratio. They are thinner and scew the design
    //We also have to up the saturation/levels of the design. This is done by a "saturate" function    
    PGraphics buf1 = createGraphics(buf.width, int(buf.height*scaleY));
    buf1.beginDraw();
    buf1.image(buf, 0, 0, buf1.width, buf1.height);    
//  saturate(buf1);
    buf1.endDraw();

    //Save the pattern into a folder
//    buf1.save(patternSavePath + imageName);

    //image(buf1,0,0);
    return buf1;
        
    //Up the patternIndex, in case we are saving more images from this program in the future
//    patternIndex += 1;
  } // end generate
  
  
  //Saturate the design, because simply tinting the stitches makes their colors dull---------------------------------------------------
  void saturate(PGraphics buf1){
    buf1.loadPixels();
    for (int x = 0; x < buf1.pixels.length; x++) {
        float r, g, b;
        r = red (buf1.pixels[x]);
        g = green (buf1.pixels[x]);
        b = blue (buf1.pixels[x]);
        //Get RGB Value of each pixel
        if (buf1.pixels[x] != 0){
          //Convert RGB to HSB
          float [] _HSB = new float[3];
          Color.RGBtoHSB(int(r),int(g),int(b), _HSB);
          colorMode(HSB, 100);
          //Increase "Saturation" and "Black" values, making them less dark and more saturated.
          color c = color(_HSB[0]*100,_HSB[1]*100,_HSB[2]*310);
          buf1.pixels[x] = c;
        }
    }
    buf1.updatePixels();
  }
}
import java.io.BufferedReader;
import java.io.InputStreamReader;

void exportImpression ( String commandToRun ) {

  // what command to run
  // String commandToRun = "whoami";
//  String commandToRun = "/Applications/img2track.app/Contents/MacOS/img2track /Users/louis/Desktop/c3.png";
  // String commandToRun = "wc -w sourcefile.extension";
  // String commandToRun = "cp sourcefile.extension destinationfile.extension";
  // String commandToRun = "./yourBashScript.sh";

  File workingDir = new File("/Users/");   // where to do it - should be full path
  String returnedValues;                                                                     // value to return any results

  // give us some info:
  println("Running command: " + commandToRun);
  println("Location:        " + workingDir);
  println("---------------------------------------------\n");  

  // run the command!
  try {

    // complicated!  basically, we have to load the exec command within Java's Runtime
    // exec asks for 1. command to run, 2. null which essentially tells Processing to 
    // inherit the environment settings from the current setup (I am a bit confused on
    // this so it seems best to leave it), and 3. location to work (full path is best)
    Process p = Runtime.getRuntime().exec(commandToRun, null, workingDir);

    // variable to check if we've received confirmation of the command
    int i = p.waitFor();

    // if we have an output, print to screen
    if (i == 0) {

      // BufferedReader used to get values back from the command
      BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));

      // read the output from the command
      while ( (returnedValues = stdInput.readLine ()) != null) {
        println(returnedValues);
      }
    }

    // if there are any error messages but we can still get an output, they print here
    else {
      BufferedReader stdErr = new BufferedReader(new InputStreamReader(p.getErrorStream()));

      // if something is returned (ie: not null) print the result
      while ( (returnedValues = stdErr.readLine ()) != null) {
        println(returnedValues);
      }
    }
  }

  // if there is an error, let us know
  catch (Exception e) {
    println("Error running command!");  
    println(e);
  }

  // when done running command, quit
  println("\n---------------------------------------------");
  println("DONE!");
}

class Stitch {
  public int yOffset = 0;
  public int xOffset = 0;
  public int w;
  public int h;
  
  public int relX;
  public int relY;
  
  PImage stitchImage;
  
  //Since each stitch is different, they all have different offsets fot X and Y
  int [][] xOffsets = {  
    {0,0,0,0}, //1
    {2,1,1,0}, //2
    {1,1,1,0}, //3
    {1,2,0,0}, //4
    {2,0,1,0}, //5
    {0,1,0,0}, //6
    {0,1,1,0}, //7
    {1,1,1,0}, //8
    {0,0,1,0}, //9
    {0,0,0,0}  //10  
  };
  
  int [][] yOffsets = {  
    //{1,2,1,2},  //0
    {5,5,6,6}, //1
    {5,5,5,5}, //2
    {6,6,6,5}, //3
    {6,5,6,5}, //4
    {5,6,5,5}, //5
    {5,6,5,5}, //6
    {4,7,5,6}, //7
    {4,4,6,7}, //8
    {5,4,4,5}, //9    
    {5,5,5,5}
  };
  
  Stitch(int row, int col, String path){
    
    stitchImage = loadImage(path);
    w = stitchImage.width;
    h = stitchImage.height;
    
    xOffset = xOffsets[row][col];
    yOffset = yOffsets[row][col];
    
  }
  
}

