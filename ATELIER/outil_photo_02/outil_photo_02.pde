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

  Sketch outil_photo pour afficher des images issues de la webcam

*/
  
  
import processing.video.*;  
  
color black = color(0);
color white = color(255);
color grey = color(140);
int numPixels;
Capture video;
  
PFont maTypo;

int threshold = 127;
boolean invertThresholdValue = false;

void setup() {
  
  size( 80, 60);
  background( 255 );
  noSmooth();

  /******** chargement de la bibliothèque de maille ********/
  ControlWindow mailleControlWindow = new ControlWindow();
  float stretchFactor = 1.4;
  mailleControlWindow.init(stretchFactor);
  /*********************************************************/
    
  /* video */
  video = new Capture(this, 80, 60);
  video.start(); 
 
  numPixels = video.width * video.height; 
    
  maTypo = createFont("tricofonttype", 8);
  textFont(maTypo);

}

void draw() {

  displayVideoTreshold();
  

  if ( !invertThresholdValue ) {
    fill(0);
  } else {
    fill( 255 ) ; 
  }
  noStroke();
  text( "tricodeur", 5, 10 );


}

void updateThresholdValue( float mousePercentX ) {
  threshold = round( map( mousePercentX, 0 , 1, 0, 255 )); // Set the threshold value
}

void invertThreshold() {
  invertThresholdValue = !invertThresholdValue;
}

void displayVideoTreshold() {
  
  if (video.available()) {
    video.read();
    video.loadPixels();    
    
    float pixelBrightness; // Declare variable to store a pixel's color
    
    PGraphics videoFeed = createGraphics( video.width, video.height ) ;
    
    // Turn each pixel in the video frame black or white depending on its brightness
    videoFeed.loadPixels();
    for (int i = 0; i < numPixels; i++) {
      pixelBrightness = brightness(video.pixels[i]);
      
      if ( !invertThresholdValue ) {
        if (pixelBrightness > threshold ) { // If the pixel is brighter than the
          videoFeed.pixels[i] = white; // threshold value, make it white
        }
        else { // Otherwise,
          videoFeed.pixels[i] = black; // make it black
        }        
      }
      else {
        if (pixelBrightness < threshold) { // If the pixel is brighter than the
          videoFeed.pixels[i] = white; // threshold value, make it white
        } 
        else { // Otherwise,
          videoFeed.pixels[i] = black; // make it black
        }        
      }
      
    }
    videoFeed.updatePixels();
    // Test a location to see where it is contained. Fetch the pixel at the test
    // location (the cursor), and compute its brightness
    int testValue = get(mouseX, mouseY);
    float testBrightness = brightness(testValue);
    
    image ( videoFeed, 0, 0 );
    
//    if (testBrightness > threshold) { // If the test location is brighter than
//      fill(black); // the threshold set the fill to black
//    } 
//    else { // Otherwise,
//      fill(white); // set the fill to white
//    }
//    ellipse(mouseX, mouseY, 20, 20);

  }
}
