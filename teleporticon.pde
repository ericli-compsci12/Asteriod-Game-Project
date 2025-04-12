 void teleicon() {stroke(255);
  strokeWeight(20);
  noFill();
  ellipse(300, 300, 400, 400);  
  ellipse(300, 300, 320, 320); 
  ellipse(300, 300, 240, 240); 

  noStroke();
  fill(255);
  rectMode(CENTER);
  pushMatrix();
    translate(300, 300);
    for (int i = 0; i < 12; i++) {
      pushMatrix();
        rotate(TWO_PI * i / 12);
        rect(0, -160, 20, 80);
      popMatrix();
    }
  popMatrix();

  stroke(255);
  strokeWeight(20);
  fill(255);
  beginShape();
    vertex(220, 420);  
    vertex(380, 420);  
    vertex(450, 500);  
    vertex(150, 500);  
  endShape(CLOSE);
  
  noStroke();
  fill(255);
  rectMode(CENTER);
  rect(260, 452, 20, 64, 10);
  rect(300, 452, 20, 64, 10);
  rect(340, 452, 20, 64, 10);
 }
