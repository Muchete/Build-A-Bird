import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress arena;

void setup() {
  size(400, 400);
  frameRate(25);

  // processing receives OSC messages on port 12000
  osc = new OscP5(this, 12000);

  // arena receives OSC messages on port 7000
  arena = new NetAddress("127.0.0.1", 7000);
}

void draw() {
  background(0);
}

void keyPressed() {
  if (key == '1') {
    setClip(3, 1, true);
  } else if (key == '2') {
    setClip(3, 2, true);
  } else {
    println("unhandled: " + key);
  }
}

void setClip(int layer, int clip, boolean state) {
  OscMessage msg = new OscMessage("/composition/layers/"+layer+"/clips/"+clip+"/connect");
  msg.add(state ? 1 : 0);
  osc.send(msg, arena);
} 

