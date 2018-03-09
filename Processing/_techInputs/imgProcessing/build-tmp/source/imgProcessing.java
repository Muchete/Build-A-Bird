import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class imgProcessing extends PApplet {



PImage myImage;

ArrayList<PixelClass> pixList = new ArrayList<PixelClass>();

public void setup() {
  // size(1000, 1000);
  
  myImage = loadImage("col.jpg");
  myImage.loadPixels();

  

  noLoop();
}

public void draw() {

	int[] arr = myImage.pixels;

	for (int i = 0; i < arr.length; ++i) {
		pixList.add(new PixelClass(arr[i]));
	}

    // Sorting
	Collections.sort(pixList, new Comparator<PixelClass>() {
	    @Override
	    public int compare(PixelClass pix1, PixelClass pix2) {
	        if (pix1.hue > pix2.hue)
	            return 1;
	        if (pix1.hue < pix2.hue)
	            return -1;
	        return 0;
	    }
	});


	for (int i = 0; i < arr.length; ++i) {
		arr[i] = PApplet.parseInt(pixList.get(i).col);
	}

	myImage.pixels = arr;
	myImage.updatePixels();

	image(myImage, 0, 0, width, height);

}

class PixelClass { 

  float hue, col;

  PixelClass (int _col) {  
    col = _col; 
    hue = hue(_col);
  } 

} 
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "imgProcessing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
