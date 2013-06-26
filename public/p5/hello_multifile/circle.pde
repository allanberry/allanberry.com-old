public class Circle {
  float x, y, size;
  
  public Circle(float x_, float y_, float d_) {
   x = x_;
   y = y_;
   d = d_;
  }
  
  void render() {
    ellipse(x, y, d, d);
  }
}
