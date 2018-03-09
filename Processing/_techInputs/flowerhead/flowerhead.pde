import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

OpenCV opencv;
Rectangle[] faces;
Capture video;
PImage myImage;

boolean flower = false;

void setup() {
    // fullScreen();
    size(640, 480); 
    video = new Capture(this, width, height, 30);
    opencv = new OpenCV(this, width, height);

    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
    // CASCADE_CLOCK
    // CASCADE_NOSE
    // CASCADE_MOUTH
    // CASCADE_UPPERBODY
    // CASCADE_PROFILEFACE
    // CASCADE_EYE
    // CASCADE_PEDESTRIANS
    // ...‡

    video.start();
    myImage = loadImage("flower.png");
}

void draw() {
    if (video.available()) {
        video.read();
    }

    image(video, 0, 0);
    opencv.loadImage(video);
    faces = opencv.detect();

    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);

    if (flower) {
        for (int i = 0; i < faces.length; i++) {

            float w = faces[i].width * 2,
                  h = faces[i].height * 2,
                  x = faces[i].x - w / 4,
                  y = faces[i].y - h / 4;

            image(myImage, x, y, w, h);
        }
    }

}

void keyPressed() {
    if (keyCode == ENTER) {
        if (flower) {
            flower = false;
        } else {
            flower = true;
        }
    }
}