//The Visual component of the audiovisual work : Rain Why are you Here??

import com.hamoid.*;
VideoExport videoExport;

import oscP5.*; //libraries required
import netP5.*;

OscP5 oscP5;
NetAddress sonicPi;

float mx;
float my;
float easing = 1; //change to 1 to get immediate following
int radius = 24;
int edge = 100;
int inner = edge + radius;

// Rain Elements and/or random scale elements

class Drop {
  float x;
  float y;
  float z;
  float len;
  float yspeed;

  Drop() {
    x  = random(width);
    y  = random(-500, -50);
    z  = random(0, 20);
    len = map(z, 0, 20, 10, 20);
    yspeed  = map(z, 0, 20, 1, 20);
  }


  void fall() {
    y = y + yspeed;
    float grav = map(z, 0, 20, 0, 0.2);
    yspeed = yspeed + grav;

    if (y > height) {
      y = random(-200, -100);
      yspeed = map(z, 0, 20, 4, 10);
    }
  }

  void wild() {
    y = y + yspeed;
    float grav = map(z, 0, 20, 0, 0.2);
    yspeed = yspeed + grav;

    if (y > height) {
      y = random(-200, -100);
      yspeed = map(z, 0, 20, 4, 10);
    }
  }

  void show() {
    pushMatrix();
    stroke(random(138), noise(43), random(226), random(80));
    strokeWeight(random(4));
    rotate(random(25));
    line(x, y, x, y+len);
    popMatrix();
  }

  void RainShower() {
    pushMatrix();
    stroke(noise(138), noise(43), noise(226), random(85, 95));
    strokeWeight(random(4));
    line(x, y, x, y+len);
    popMatrix();
  }

  void redShow() {
    float thick = map(z, 0, random(20, 25), 3, 4);
    strokeWeight(random(thick, 11));
    if (second() % 6  > 4)
    {
      stroke(138, noise(43), noise(226), random(75, 130));
    }
    stroke(138, noise(43), noise(226), random(75, 100));
    line(x, y, x, y+len);
  }

  void BlueShow() {
    pushMatrix();
    strokeWeight(random(9, 13));
    stroke(0, random(0, 15), 255, random(60, 100));
    line(x, y, x, y+len);
    popMatrix();
  }
}

//Rain Elements
Drop[] drops = new Drop[2500];




void setup() {
  size(800, 660);
  noStroke();
  ellipseMode(RADIUS);
  rectMode(CORNERS);
  oscP5 = new OscP5(this, 8000);
  sonicPi = new NetAddress("127.0.0.1", 4559);

  for (int i = 0; i < drops.length; i++) {
    drops[i] = new Drop();
  }
//turns it into the animated piece
  videoExport = new VideoExport(this);
  videoExport.startMovie();
}

// Communicates with the OSC that sent to Sonic Pi
void sendOscNote(float mx, float my) {
  OscMessage toSend = new OscMessage("/notesend");
  toSend.add(mx); //add mx and my values as floating numbers
  toSend.add(my);
  oscP5.send(toSend, sonicPi);
  println(toSend);
}
void draw() {
  frameRate(30);
  background(51);


  for (int i = 0; i < drops.length; i++) {
    drops[i].fall();
    drops[i].RainShower();
    drops[i].redShow();
  }
//This variables are what is being communicated to Sonic Pi to make the sounds thatare heard

  if (abs(mouseX - mx) > 0.1) {
    mx = mx + (mouseX - mx) * easing;
  }
  if (abs(mouseY - my) > 0.1) {
    my = my + (mouseY- my) * easing;
  }

  mx = constrain(mx, inner, width - inner);
  my = constrain(my, inner, height - inner);
  if (mx > width/2) {
    fill(76, 100, 210, 5);
    pushMatrix();
    for (int i = 0; i < drops.length; i++) {
      drops[i].BlueShow();
    }
    if (mousePressed)
    {
      background(random(45));
      stroke(220, 170, 190);
    }
    popMatrix();
  } else 
  fill(200, 210, 199, 3);
  rect(edge + second()% 30, edge + second()%30, width-edge, height-edge, 50);
  if (my > height/2){
    fill(255, 200, 155);
   
  if (mousePressed)
  {
    background(random(223, 255));
    strokeWeight(24+ second()%30);
    stroke(170, 190, 220);
  }
  }else
    fill(110, 170, 210);
  line(mx, my, radius + second()%4, radius + second()%4);
  line(width/2 +mx, height/2 + my, radius + second()%4, radius + second()%4);
  line(radius, radius, width/2 + mx, height/2 + my);
  sendOscNote(mx, my); //send the mx and my values to SP

  videoExport.saveFrame();
}
