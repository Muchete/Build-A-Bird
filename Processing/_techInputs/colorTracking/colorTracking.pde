import processing.video.*;
Capture video;
PImage myImage;

color trackColor; 


void setup() {
  size(640, 480);
  
  video = new Capture(this, width, height, 15);
  video.start();

  trackColor = color(255, 0, 0);
  smooth();

  myImage = loadImage("glasses.png");

}

void draw() {
  if (video.available()) {
    video.read();
  }

  video.loadPixels();
  image(video, 0, 0);

  float worldRecord = 500; 

  int closestX = 0;
  int closestY = 0;
  
  PVector closestPoint = new PVector();
  
  for (int x=0; x < video.width; x++) {
    for (int y=0; y < video.height; y++) {
      int loc = x + y * video.width;
      color currentColor = video.pixels[loc];
      
      PVector currColorVec = new PVector(red(currentColor), green(currentColor), blue(currentColor));
      PVector trackColorVec = new PVector(red(trackColor), green(trackColor), blue(trackColor));
      float diff = currColorVec.dist(trackColorVec);
      
      if (diff < worldRecord) {
        worldRecord = diff;
        closestPoint.x = x;
        closestPoint.y = y;
      }
    }
  }

  if (worldRecord < 10) { 
    // fill(trackColor);
    // strokeWeight(4.0);
    // stroke(0);
    // ellipse(closestPoint.x, closestPoint.y, 50, 50);

    image(myImage, closestPoint.x-75, closestPoint.y-40, 150, 80);

  }
}

void mousePressed() {
  int loc = mouseX + mouseY * video.width;
  trackColor = video.pixels[loc];
}