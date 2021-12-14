/*
 * @name Bezier
 * @description The first two parameters for the bezier() function specify the
 * first point in the curve and the last two parameters specify the last point.
 * The middle parameters set the control points that define the shape of the
 * curve.
 */
function setup() {
  createCanvas(720, 400);
  noFill();
}

function draw() {
  var time = second();
   strokeWeight(time%12);
  stroke(255,200,random(110));
  background(abs(400-mouseY),abs(720-(mouseX)),100);
  for (let i = 0; i < 400; i += 40) {
    bezier(
      mouseX - i / 2.0,
      mouseY + 40 + i,
      410 - mouseX/2,
      20 + mouseY/5,
      440,
      300,
      240 - i / 16.0,
      300 + i / 8.0,
      400 + i / 4.0
      
    );
  }
}
