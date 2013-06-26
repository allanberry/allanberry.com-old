ArrayList<Square> squares = new ArrayList<Square>();
ArrayList<Circle> circles = new ArrayList<Circle>();

void setup() {
  size(300, 300);
  
  for (int i = 1; i<25; i++) {
    squares.add(new Square(i * 10, i * 10, 50));
  }

  for (int i = 1; i<25; i++) {
    circles.add(new Circle(width - 25 - (i * 10), 25 + (i * 10), 50));
  }
}

void draw() {
  Square square;
  Circle circle;

  // background
  pushStyle();
    fill(200);
    noStroke();
    rect(0, 0, width, height);
  popStyle();

  // shapes
  for (int i = 0; i<squares.size(); i++) {
    square = squares.get(i);
    square.render();

    circle = circles.get(i);
    circle.render();
  }
}