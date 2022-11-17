class DepthFilter extends scene {
  Kinect kinect;

  // Depth image
  PImage depthImg;

  // Which pixels do we care about?
  int minDepth =  30;
  int maxDepth = 1000;
  int index;
  int d;

  int count;
  color b;

  // What is the kinect's angle
  float angle;

  PApplet p;

  DepthFilter(PApplet p) {
    this.p = p;
  }
  void mesetup() {
    b = (0);

    kinect = new Kinect(p);
    kinect.initDepth();
    angle = kinect.getTilt();

    // Blank image
    depthImg = new PImage(kinect.width, kinect.height);
  }
  void medraw() {
    // Threshold the depth image
    int[] rawDepth = kinect.getRawDepth();
    for (int i=0; i < kinect.height; i++) {
      for (int j=0; j<kinect.width; j++) {
        int index = i*kinect.width+j;
        int d = rawDepth[index];
        if (d>=minDepth && d<=maxDepth) {//checks to see if there is something in the frame/changes depth color
          if (j>kinect.width/2) {//if it passes the line change color to red
            depthImg.pixels[index] = color(150, 0, 0);
            count++;
          } else {//if the object/photo is on the other side of line, keep it white
            depthImg.pixels[index] = color(255, 255, 255);
          }
        }//if the pixel is not a color aka if the pixel has no depth
        else {

          if (j>width/2) {
            depthImg.pixels[index] = color(b);
          } else {
            depthImg.pixels[index] = color(0);
          }
        }
      }
    }
    // Draw the thresholded image
    depthImg.updatePixels();
    image(depthImg, 0, 0);

    fill(0);
    text("TILT: " + angle, 10, 20);
    text("THRESHOLD: [" + minDepth + ", " + maxDepth + "]", 10, 36);
    if (count>5) {
      b = color(0, 150, 0);
    } else {
      b = color(0);
    }
    count =0;
  }
}
