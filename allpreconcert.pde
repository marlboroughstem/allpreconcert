import processing.sound.*;
import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import peasy.*;


ArrayList<scene> scenes = new ArrayList<scene>();
b3Dlandscape scene1 = new b3Dlandscape();
SoundSpirals scene2 = new SoundSpirals(this);
blueTree scene3 = new blueTree(this);
multipleLayers scene4 = new multipleLayers();
FlyingShadow scene5 = new FlyingShadow(this);
Cubes scene6 = new Cubes(this);
Stars scene7 = new Stars();
DepthFilter scene8 = new DepthFilter(this);
aurora scene9 = new aurora(this);

int place = 0;


void setup() {
  fullScreen(P3D);
  noCursor();
  scenes.add(scene1);
  scenes.add(scene2);
  scenes.add(scene3);
  scenes.add(scene4);
  scenes.add(scene5);
  scenes.add(scene6);
  scenes.add(scene7);
  scenes.add(scene8);
  scenes.add(scene9);
  for (int i=0; i<scenes.size()-1; i++) {
    scenes.get(i).mesetup();
  }
}
void draw() {
  scenes.get(place).medraw();
}

void keyPressed() {
  scenes.get(place).mekeyPressed();
}

void mouseClicked() {
  if (mouseX>width/2) {
    place ++;
  } else {
    place--;
  }
  if (place == 8) {
    scene9.mesetup();
  }
  background(0);
  if (place>=scenes.size()) {
    place = 1;
  }
  if (place<0) {
    place = 0;
  }
}
