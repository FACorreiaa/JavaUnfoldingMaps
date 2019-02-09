/*
Classe botao
*/

class Button {
  float xpos, ypos, wid, hei, l; // posicao x e y e tamanho H e V
  String label;    // texto do botao
  boolean over = false;
  boolean down = false; 
  boolean clicked = false;
  boolean on;


  Button(
    float tx, float ty, 
    float tw, float th, float li,
    String tlabel
    ) {
    xpos = tx;
    ypos = ty;
    wid = tw;
    hei = th;
    l = li;
    label = tlabel;
    on = false;
  }

  void update() {
    //it is important that this comes first
    if (down&&over&&!mousePressed) {
      clicked=true;
    } else {
      clicked=false;
    }

    //UP OVER AND DOWN STATE CONTROLS
    if (mouseX>xpos && mouseY>ypos && mouseX<xpos+wid && mouseY<ypos+hei) {
      over=true;
      if (mousePressed) {
        down=true;
      } else {
        down=false;
      }
    } else {
      over=false;
    }
    smooth();

    //box color controls // Cores mouse Over e Mouse down
    if (!over) {
      fill(170,180,190);
    } else {
      if (!down) {
        fill(120,130,140);
      } else {
        fill(200,210,220);
      }
    }
    stroke(0);
    noStroke();
    rect(xpos, ypos, wid, hei, 1);//draws the rectangle, the last param is the round corners

    //Text Color Controls
    if (down) {
      fill(0);
    } else {    
      fill(255);
    }
    text(label, xpos+wid/2-(textWidth(label)/2), ypos+hei/2+(textAscent()/2)); 
    //all of this just centers the text in the box
  }
}
