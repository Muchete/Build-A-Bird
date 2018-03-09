import gab.opencv.*;
import processing.video.*;

OpenCV opencv;
Capture video;

int roiWidth = 630;
int roiHeight = 470;

boolean useROI = true;

void setup() {
  size(640, 480);
  video = new Capture(this, width, height, 30);
  opencv = new OpenCV(this, width, height);
  
  video.start(); 
}

void draw() {
  if (video.available()) {
    video.read();
  }
  
  // image(video, 0, 0); 
  opencv.loadImage(video);
  
  opencv.setROI(mouseX, mouseY, roiWidth, roiHeight);
  
  opencv.findCannyEdges(20,75);
  image(opencv.getOutput(), 0, 0);
}