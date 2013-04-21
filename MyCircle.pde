//Based heavily on the Circle class seen in the Bouncing balls example.
class MyCircle {
  int x, y, radius;
  int r, g, b, value;
  String label;
  
  public MyCircle(int _x, int _y, int _radius, String _label, int _value) {
      setPosition (_x, _y);
      radius = _radius;
      setColor (250, 250, 250);
      setLabel (_label);
      value = _value;
      r = 255;
      g = 255;
      b = 255;
  }
  
  public int getX() {
    return x;
  }
  
  public int getY() {
    return y;
  }
  
  public void setPosition (int _x, int _y) {
      x = _x;
      y = _y;
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
    float dist = sqrt((mouseX - x) * (mouseX - x) + (mouseY - y) * (mouseY - y));
    
    if (dist > radius) {
      return false;
    }
    else {
      return true;
    }      
  }
  
  public void render() {
    fill(r, g, b);
    ellipse(x, y, radius*2, radius*2);  
    fill(0);
  } 
}
