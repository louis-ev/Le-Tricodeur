/**
 * Processing brush for SyntaxHighlighter, updated for version 3.0
 *
 * SyntaxHighlighter is at http://alexgorbatchev.com/SyntaxHighlighter
 * ...............................................................
 *	
 *	 Processing brush and Processing theme created by Leo Catonnet
 *   Brush ver 1.2 // Theme ver 1.0 
 * 	 Based on Processing 2.2.1 
 *
 *	 Léo Catonnet
 *   http//www.leocat.fr/
 *
 *   Special thanks to Colin Mitchell (colin@muffinlabs.com) from whom I took the outdated brush.
 *
 */
;(function()
{
	// returns the regex for the keyword if it's followed by an opening parenthesis
	function getKeywordsPar(a) {
		a = a.replace(/^\s+|\s+$/g, "").replace(/\s+/g, "(?=\\()|");
		return "\\b(?:" + a + "(?=\\())\\b"
	}
	
	// returns the regex for the keyword if it isn't followed by an opening parenthesis
	function getKeywordsNoPar(a) {
		a = a.replace(/^\s+|\s+$/g, "").replace(/\s+/g, "(?!\\()|");
		return "\\b(?:" + a + "(?!\\())\\b"
	}
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;
 
	function Brush()
	{
		var types = 'String boolean byte char color double int float long PFont PImage PVector' +
		' Array ArrayList FloatDict FloatList HashMap IntDict IntList JSONArray JSONObject ' +
		' Object StringDict StringList Table TableRow XML PGraphics PShader PShape BufferedReader PrintWriter';
		var structures = 'for if do else while catch try switch synchronized';
		var keywords = 'abstract assert break case class continue ' +
			'default enum extends const false final finally goto ' +
			'implements import instanceof interface native new null package private ' +
			'protected public return short static strictfp super this throw ' +
			'throws transient void volatile true';
		var variables =	' mousePressed keyPressed key keyCode  mouseX mouseY pmouseX pmouseY ' +
			' height width frameCount frameRate displayWidth displayHeight focused pixels ';
		var functionsBold =	'setup draw mousePressed keyPressed keyReleased keyTyped mouseReleased mouseClicked mouseDragged ';
		var functions =	' exit loop noLoop redraw beginDraw endDraw pushStyle popStyle ' + // Structure
		' size cursor noCursor frameRate println print ' + // Environment
		' binary boolean byte char float hex int str unbinary unhex' + // Conversion
		' join match matchAll nf nfc nfp nfs split splitTokens trim equals ' + //String functions
		' append arrayCopy concat expand reverse shorten sort splice subset ' + // Array functions
		' arc ellipse line point quad rect triangle box sphere sphereDetail' + // 2D and 3D Primitives
		' ellipseMode noSmooth rectMode smooth strokeCap strokeJoin strokeWeight ' + // Attributes
		' shape createShape loadShape beginShape endShape shapeMode bezierCurve curveVertex vertex bezier bezierDetail bezierPoint bezierTangent curve curveDetail curvePoint curveTangent curveTightness beginContour bezierVertex endContour quadraticVertex' + // Shapes, vertices, curves
		' createInput createReader loadBytes loadJSONArray loadJSONObject loadStrings loadTable loadXML open parseXML selectFolder selectInput beginRaw beginRecord createOutput createWriter endRaw endRecord saveBytes saveJSONArray saveJSONObject saveStream saveStrings saveTable saveXML selectOutput saveFrame ' + // Files
		' year month day hour minute second millis ' + // Time and date
		' applyMatrix popMatrix pushMatrix printMatrix resetMatrix rotate rotateX rotateY rotateZ scale shearX shearY translate ' + // Transform
		' ambientLight directionalLight noLights camera lightFalloff lights lightSpecular normal pointLight spotLight beginCamera endCamera frustrum ortho perspective printCamera printProjection modelX modelY modelZ screenX screenY screenZ ambient emissive shininess  specular ' + // Lights and camera
		' background clear colorMode fill noFill color noStroke stroke alpha blue brightness green hue lerpColor red saturation' + // Color
		' image createImage imageMode loadImage noTint requestImage tint texture textureMode textureWrap blend copy filter get loadPixels set updatePixels' + // Images
		' blendMode createGraphics loadShader resetShader shader ' + // Rendering
		' createFont loadFont text textFont textAlign textLeading textMode textSize textWidth textAscent textDescent' + // Typography
		' abs ceil constrain dist exp floor lerp log mag map max min norm pow round sq sqrt ' + // Calculation
		' acos asin atan atan2 cos degrees radians sin tan' + // Trigonometry
		' noise noiseDetail noiseSeed random randomGaussian randomSeed ' + // Random
		' hint brightness link length PVector '; // Other
 
		var constants =	'TWO_PI PI HALF_PI QUARTER_PI TAU ' +
			'CENTER LEFT RIGHT UP DOWN  P2D P3D SHIFT CONTROL DELETE BACKSPACE ENTER RGB HSB TRIANGLE_STRIP  ' +
			'CENTER_RADIUS CORNER OPEN CLOSE TRIANGLES DISABLE_DEPTH_TEST CROSS HAND';

		this.regexList = [
			{ regex: SyntaxHighlighter.regexLib.singleLineCComments,		css: 'comments' },		// one line comments
			{ regex: /\/\*([^\*][\s\S]*)?\*\//gm,							css: 'comments' },	 	// multiline comments
			{ regex: /\/\*(?!\*\/)\*[\s\S]*?\*\//gm,						css: 'preprocessor' },	// documentation comments
			{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,			css: 'string' },		// strings	
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,			css: 'string' },		// strings
			{ regex: /\b([\d]+(\.[\d]+)?|0x[a-f0-9]+)\b/gi,					css: 'value' },			// numbers
			{ regex: /(?!\@interface\b)\@[\$\w]+\b/g,						css: 'color1' },		// annotation @anno
			{ regex: /\@interface\b/g,										css: 'color2' },		// @interface keyword
			{ regex: new RegExp(this.getKeywords(keywords), 'gm'),			css: 'keyword' },		// java keyword
			{ regex: new RegExp(this.getKeywords(constants), 'gm'),			css: 'constants' },		// processing reserved constants
			{ regex: new RegExp(getKeywordsNoPar(variables), 'gm'),			css: 'variables' },		// processing reserved variables
			{ regex: new RegExp('pixels', 'gm'),							css: 'variables' },		// processing reserved variable
			{ regex: new RegExp(getKeywordsNoPar(types), 'gm'),				css: 'types' },			// processing variable types	
			{ regex: new RegExp(this.getKeywords(structures), 'gm'),		css: 'structures' },	// processing structure (loops, conditions...)			
			{ regex: new RegExp(getKeywordsPar(functions), 'gm'),			css: 'functions' },		// processing reserved functions
			{ regex: new RegExp(getKeywordsPar(functionsBold), 'gm'),		css: 'functionsbold' }	// processing special functions
			];
 
		this.forHtmlScript({
			left	: /(&lt;|<)%[@!=]?/g, 
			right	: /%(&gt;|>)/g 
		});
 
		this.forHtmlScript(SyntaxHighlighter.regexLib.aspScriptTags);
		
	};
	
 
	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['processing', 'pjs', 'pde'];
 
	SyntaxHighlighter.brushes.Processing = Brush;
 
	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();