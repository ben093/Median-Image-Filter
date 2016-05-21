/* test 1
   Ben Borgstede
   //borgstede09
   3/3/2016
*/

PImage img, origImage, filtImage;
String fname = "Test1_img1.png";
int matrixSize = 3;

void setup() {
  size(400, 400);
  surface.setResizable(true);
  
  origImage = loadImage(fname);
  filtImage = filterImage(origImage, matrixSize);
  img = origImage;
  
  surface.setSize(img.width, img.height);
}

void draw() {
  background(0);
  image(img, 0, 0);
}

PImage filterImage(PImage source, int matrixSize){
	PImage target = createImage(source.width, source.height, RGB);
  
  // Copy image over to target so we can leave the border of unprocessed pixels.
  for(int m = 0; m < target.width; m++){
    for(int n = 0; n < target.height; n++){
      // Get color from source
      color c = color(source.get(m,n));
      
      // Set color in target
      target.set(m,n,c);
    }
  }
  // Instead of above, could resize target and surface to seeminly just remove unprocessed pixels on border.
  
  // Get distance from current target point to setup for loop
  int distance = matrixSize/2;
  
  //Median filter code below
  for(int x = distance; x < target.width-distance; x++){
    for(int y = distance; y < target.height-distance; y++){        
      
      // Create buckets for each color of matrix length.
      float[] reds = new float[matrixSize * matrixSize];
      float[] greens = new float[matrixSize * matrixSize];
      float[] blues = new float[matrixSize * matrixSize];
      
      int q = 0;
      for(int i = 0; i < matrixSize; i++){
        for(int j = 0; j < matrixSize; j++){
          float r = 0, g = 0, b = 0;
          
          // Get pixel at this position.
          r = red(source.get(x-i, y-j));
          g = green(source.get(x-i, y-j));
          b = blue(source.get(x-i, y-j));
         
          // Place in buckets.
          reds[q] = r;
          greens[q] = g;
          blues[q] = b;
          
          // Increment to next index in bucket
          q++;
        }
      }
      // Sort arrays with lengths of matrixSize*matrixSize
      reds = sort(reds);
      greens = sort(greens);
      blues = sort(blues);           
      
      // Get median of each array
      float r = reds[(reds.length/2)+1];
      float g = greens[(greens.length/2)+1];
      float b = blues[(blues.length/2)+1];
      
      target.set(x, y, color(r,g,b));               
    }
  }
  
  return target;
}


void keyPressed() {
  //Take action according to key
  if(key == '1') img = origImage;
  else if(key == '2') img = filtImage;

}