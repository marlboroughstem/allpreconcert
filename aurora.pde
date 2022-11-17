
class aurora extends scene {
  PApplet p;

  PeasyCam cam;

  int cols, rows;
  int scl = 50;
  int w = 2000;
  int h = 2000;

  float flying = 0; // flying offset
  float[][] terrain; // where to store the current terrain coordinates
  PShape aurora; // represent the aurora shape to draw

  PVector[] stars;
  //static int MAX_STARS = 100;

  float camRZ = 2.7; // camera rotation variable
  // different camera positions
  PVector[] camRots = { new PVector(-1.60, 0.0, 1),
    new PVector(-2.2, -0.5, 3.1),
    new PVector(-1.78, -0.4, -2.4) };
  PVector[] camLooks= { new PVector(0, 0, 0),
    new PVector(-2.2, 238.8, 335.3),
    new PVector(-238, 47, 89) };
  int[] camDistances = {1000, 1100, 1243};
  int camIndex=0;


  aurora(PApplet p) {
    this.p = p;
  }
  void mesetup() {
    cam = new PeasyCam(p, 1000);
    camRZ=camRots[camIndex].z;
    setCameraPosition();
    cam.setMouseControlled(false);

    cols = w / scl;
    rows = h/ scl;
    terrain = new float[cols][rows];

    stars = new PVector[100];
    for (int i=0; i<100; i++) {
      stars[i] = newStar();
    }

    background(0, 29, 121);
    colorMode(HSB, 255);
    noStroke();
  }
  void medraw() {
    flying -= 0.001; // flying offset
    updateTerrain(flying);
    updateAurora();

    cam.beginHUD();
    fill(163, 157, 73, 13);
    rect(0, 0, width, height); //
    drawStars();
    cam.endHUD();

    translate(-w/2, -h/2);
    shape(aurora);
    translate(-50, 300, -100);
    shape(aurora);

    lights();
    if (!cam.isActive()) setCameraPosition();
  }
  PVector newStar() {
    return new PVector(random(width), random(height), random(250));
  }

  void updateTerrain(float yoff) {
    for (int y = 0; y < rows; y++) {
      float xoff = 0;
      for (int x = 0; x < cols; x++) {
        terrain[x][y] = map(noise(xoff, yoff), 0, 1, -200, 200);
        xoff += 0.05;
      }
      yoff += 0.05;
    }
  }

  void drawStars() {
    for (int i=0; i<100; i++) {
      fill(0, 0, 250, stars[i].z);
      rect(stars[i].x, stars[i].y, 1, 1);

      stars[i].z -= 0.1;
      if (stars[i].z <0) stars[i] = newStar();
    }
  }

  // creates a new shape with the updated terrain values
  void updateAurora() {
    aurora = createShape();
    aurora.beginShape(TRIANGLE_STRIP);
    for (int y = 0; y < rows-1; y++) {
      //createShape();
      //beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < cols-1; x++) {
        aurora.fill ( map(y, 0, rows-1, -10, 240), //hue
          103, 200, //saturation & brightness
          map(y, 0, rows-1, 7, 0));  //alpha transparency

        aurora.vertex(x*scl, y*scl, terrain[x][y]);
        aurora.vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      }
      //endShape();
    }
    aurora.endShape();
  }

  void setCameraPosition() {
    camRZ+=0.0001;
    cam.setRotations(camRots[camIndex].x, camRots[camIndex].y, camRZ);
    cam.setMinimumDistance(camDistances[camIndex]);
    cam.lookAt(camLooks[camIndex].x, camLooks[camIndex].y, camLooks[camIndex].z);
  }

  void mekeyPressed() {
    if (key=='m') {
      cam.setMouseControlled( !cam.isActive() );
      println("-----\nIt is " + cam.isActive() + " that the mouse controls the camera");
    }
    if (key=='c') {
      camIndex++;
      if (camIndex>=camRots.length) camIndex=0;
      camRZ=camRots[camIndex].z;
      println("-----\nchanging to camera" + camIndex);
      setCameraPosition();
    }
    if (key == 'i') {
      println("-----\nInfo");
      println("rotations: ");
      println(cam.getRotations());
      println("lookAt: ");
      println(cam.getLookAt());
      println("distance: "+cam.getDistance()+"");
    }
  }
}
