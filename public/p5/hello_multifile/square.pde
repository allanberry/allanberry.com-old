public class Square {
  float x, y, size;
  
  public Square(float x_, float y_, float size_) {
   x = x_;
   y = y_;
   size = size_;
  }
  
  void render() {
    rect(x, y, size, size);
  }
}
