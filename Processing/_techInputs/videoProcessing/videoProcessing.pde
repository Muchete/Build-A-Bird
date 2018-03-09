import java.util.*;
import processing.video.*;

ArrayList<PixelClass> pixList = new ArrayList<PixelClass>();

Capture video;

void setup() {
  size(640, 480);
  // fullScreen();
	
	video = new Capture(this, width, height, 30);
	video.start();
}

void draw() {

	if (video.available()) {
  		video.read();
	}


	color[] arr = video.pixels;

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
		arr[i] = int(pixList.get(i).col);
	}

	video.pixels = arr;

	image(video, 0, 0);

	pixList.clear();

}

class PixelClass { 

  float hue, col;

  PixelClass (color _col) {  
    col = _col; 
    hue = hue(_col);
  } 

} 
