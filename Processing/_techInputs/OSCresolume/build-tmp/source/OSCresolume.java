import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import oscP5.*; 
import netP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class OSCresolume extends PApplet {




OscP5 osc;
NetAddress arena;

public void setup() {
  
  frameRate(25);

  // processing receives OSC messages on port 12000
  osc = new OscP5(this, 12000);

  // arena receives OSC messages on port 7000
  arena = new NetAddress("127.0.0.1", 7000);
}

public void draw() {
  background(0);
}

public void keyPressed() {
  if (key == '1') {
    setClip(3, 1, true);
  } else if (key == '2') {
    setClip(3, 2, true);
  } else {
    println("unhandled: " + key);
  }
}

public void setClip(int layer, int clip, boolean state) {
  OscMessage msg = new OscMessage("/composition/layers/"+layer+"/clips/"+clip+"/connect");
  msg.add(state ? 1 : 0);
  osc.send(msg, arena);
}
  public void settings() {  size(400, 400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "OSCresolume" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
