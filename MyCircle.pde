//Based heavily on the Circle class seen in the Bouncing balls example.
class MyCircle {
  int x, y, radius;
  int r, g, b, value;
  String label;
  
  public MyCircle(int _x, int _y, int _radius, String _label, int _value) {
      setPosition (_x, _y, _radius);
      setColor (255, 255, 255);
      setLabel (_label);
      value = _value;
  }
  
  public int getX() {
    return x;
  }
  
  public int getY() {
    return y;
  }
  
  public void setPosition (int _x, int _y, int _radius) {
      x = _x;
      y = _y;
      radius = _radius;
  }
  
  public void setColor (int _r, int _g, int _b) {
      r = _r;
      g = _g; 
      b = _b;
  }
 
  public void setLabel (String _label) {
     label = _label;
  } 
  
  public String getLabel() {return label;}
  
  public int getValue() {return value;}
  
  public int getRadius() {return radius;}
  
  public boolean isBounded () {
    return dist(mouseX, mouseY, x, y) <= radius;     
  }
  
  public void render() {
    fill(r, g, b);
    ellipse(x, y, radius*2, radius*2);  
    fill(0);
  } 
}
