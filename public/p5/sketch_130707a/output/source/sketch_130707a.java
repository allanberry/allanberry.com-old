import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_130707a extends PApplet {

public void setup() {
  background(0xffFFBBBB);
}

public void draw() {
  line(0, 0, mouseX, mouseY);  
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_130707a" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
