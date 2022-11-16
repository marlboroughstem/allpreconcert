class Tree{
  float x, y, w, h, a;
  int level, tempLevel, rate;
  int drawSet = 0;
  Tree(float x, float y, float w, float h, float a, int level, int rate){
    this.w = w;
    this.h = h;
    this.a = a;
    this.level = level;
    this.tempLevel = 0;
    this.rate = rate;
    this.x = x;
    this.y = y; 
  }
  void switchColor(){
    if(drawSet < 4){
      drawSet++;
    }
    else{
      drawSet = 0;
    }
  }
  void display(){
    pushMatrix();
    translate(x, y);

      scene3.drawRect(w, h, a, drawSet, tempLevel);
      if(frameCount%rate==0 && tempLevel < level){
         tempLevel+=1;
      }
    popMatrix();
  }
  

 }
