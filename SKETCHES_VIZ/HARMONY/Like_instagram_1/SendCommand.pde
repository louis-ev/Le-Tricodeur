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
  exit();
}

