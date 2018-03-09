import java.util.*;

PImage myImage;

ArrayList<PixelClass> pixList = new ArrayList<PixelClass>();

void setup() {
  // size(1000, 1000);
  fullScreen();
  myImage = loadImage("col.jpg");
  myImage.loadPixels();

  

  noLoop();
}

void draw() {

	color[] arr = myImage.pixels;

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

	myImage.pixels = arr;
	myImage.updatePixels();

	image(myImage, 0, 0, width, height);

}

class PixelClass { 

  float hue, col;

  PixelClass (color _col) {  
    col = _col; 
    hue = hue(_col);
  } 

} 
