/*

 Workshop TRICODEUR
 10-12 octobre 2014
 
 Organisé par Sew&Laine • sewetlaine.com
 avec la collaboration de Processing Bordeaux • processingbordeaux.org
 et animé par Louis Eveillard • louiseveillard.com
 avec l'aide de 2Roqs • 2roqs.fr
 
 Bibliothèque de maille
 > conçue et développée par Louis Eveillard
 > pour Processing 2.2.1 et plus
 > utilise du code issu de KnitPatternConverter par Ivan Sharko et Joel Glovier (repris ici avec leur permission)
 > (toutes plateformes) permet d'exporter des fichiers prêt à être tricoté 
 > (MacOS) permet d'envoyer les motifs à img2track, interface de connection à une machine à tricoter développé par Daviworks daviworks.com/knitting/
 
 Licence CC BY-SA
 creativecommons.org/licenses/by-sa/3.0/
 
 */
PFont maTypo;
String url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22bordeaux%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"; 

int infMaxPrevision=-1;
int supMaxPrevision=-1;
int infMinPrevision=-1;
int supMinPrevision=-1;

JSONArray jsonForecast;

float wText = 30;
float hText = 20;
float wMeteo;
float hMeteo;

void setup() {
  /******** chargement de la bibliothèque de maille ********/
  ControlWindow mailleControlWindow = new ControlWindow();
  float stretchFactor = 1.4;
  mailleControlWindow.init(stretchFactor);
  /*********************************************************/
  noSmooth();
  maTypo = createFont("tricofonttype", 8);
  textFont(maTypo);

  JSONObject jsonMeteo = loadJSONObject(url);
  jsonForecast = jsonMeteo.getJSONObject("query").getJSONObject("results").getJSONObject("channel").getJSONObject("item").getJSONArray("forecast");

  for (int i=0; i<jsonForecast.size (); i++)
  {
    int max = Integer.parseInt( jsonForecast.getJSONObject(i).getString("high") ); 
    int min = Integer.parseInt( jsonForecast.getJSONObject(i).getString("low") ); 

    println("jour "+i+", max="+max+", min="+min);  

    if (infMaxPrevision == -1 || max<infMaxPrevision) infMaxPrevision = max;
    if ( supMaxPrevision == -1 || max>supMaxPrevision ) supMaxPrevision = max;

    if (infMinPrevision == -1 || min<infMinPrevision) infMinPrevision = min;
    if ( supMinPrevision == -1 || min>supMinPrevision ) supMinPrevision = min;
  }

  println("Le maximum varie entre "+infMaxPrevision+" et "+supMaxPrevision);
  println("Le minimum varie entre "+infMinPrevision+" et "+supMinPrevision);

  size(100, 100);

  wMeteo = width-wText;
  hMeteo = height-hText;
}

void draw() {

  background(255);
  noStroke();
  float wCase = wMeteo/float(jsonForecast.size());
  float hCase = hMeteo/2;
  int jour=0;
  for (float x=wText; x<width; x=x+wCase)
  {
    int min = Integer.parseInt( jsonForecast.getJSONObject(jour).getString("low") ); 
    int max = Integer.parseInt( jsonForecast.getJSONObject(jour).getString("high") ); 

    int minGreyLevel = (int)map(min, infMinPrevision, supMaxPrevision, 30, 255);
    int maxGreyLevel = (int)map(max, infMinPrevision, supMaxPrevision, 30, 255);

    // Min
    fill(minGreyLevel);
    rect(x, hText, x+wCase, hCase);

    // Max
    fill(maxGreyLevel);
    rect(x, hText+hCase, x+wCase, 2*hCase);

    fill(0);
    text(jour, x+6, hText/2);

    jour = jour + 1;
  }

  fill(0);
  text("J. Bdx", 4, hText/2);

  fill(0);
  text("T. min", 4, hText+hCase/2);

  fill(0);
  text("T. max", 4, hText+hCase+hCase/2);
}

