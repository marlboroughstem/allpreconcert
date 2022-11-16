import processing.sound.*;
import org.openkinect.freenect.*;
import org.openkinect.processing.*;

ArrayList<scene> scenes = new ArrayList<scene>();
b3Dlandscape scene1 = new b3Dlandscape();
SoundSpirals scene2 = new SoundSpirals(this);
blueTree scene3 = new blueTree(this);
multipleLayers scene4 = new multipleLayers();
FlyingShadow scene5 = new FlyingShadow(this);
Cubes scene6 = new Cubes(this);
Stars scene7 = new Stars();

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
  for (scene s : scenes) {
    s.mesetup();
  }
}
void draw() {
  scenes.get(place).medraw();
}

void keyPressed() {
  scenes.get(place).mekeyPressed();
}

void mouseClicked() {
  place ++;
  background(0);
  if (place>=scenes.size()) {
    place = 0;
  }
}
