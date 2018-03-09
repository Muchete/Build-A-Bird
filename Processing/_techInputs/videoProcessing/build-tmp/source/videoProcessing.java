import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.*; 
import processing.video.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class videoProcessing extends PApplet {




ArrayList<PixelClass> pixList = new ArrayList<PixelClass>();

Capture video;

public void setup() {
  
  // fullScreen();
	
	video = new Capture(this, width, height, 30);
	video.start();
}

public void draw() {

	if (video.available()) {
  		video.read();
	}


	int[] arr = video.pixels;

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

	video.pixels = arr;

	image(video, 0, 0);

	pixList.clear();

}

class PixelClass { 

  float hue, col;

  PixelClass (int _col) {  
    col = _col; 
    hue = hue(_col);
  } 

} 
  public void settings() {  size(640, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "videoProcessing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
