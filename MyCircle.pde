//Based heavily on the Circle class seen in the Bouncing balls example.
class MyCircle {
  int x, y, radius;
  int r, g, b, value;
  
  boolean isGray;
  
  int defaultRed, defaultGreen, defaultBlue;/////////////////////////////////
  
  String label;
  
  public MyCircle(int _x, int _y, int _radius, String _label, int _value) {
      setPosition (_x, _y, _radius);
      setDefaultColor (255, 255, 255);
      setLabel (_label);
      value = _value;
      isGray = false;
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
  
  public void grayOut(){
    isGray = true;
  }
  
  public void addColor(){
    isGray = false;
  }
  
  public void setDefaultColor (int _r, int _g, int _b) {
      defaultRed = _r;
      defaultGreen = _g; 
      defaultBlue = _b;
      setColor(_r, _g, _b);
  }
  
  public void setColor (int _r, int _g, int _b) {
      r = _r;
      g = _g; 
      b = _b;
  }
  
  public void setColorV (int _r, int _g, int _b, int _v) {
      r = _r;
      g = _g; 
      b = _b;
      value = _v;
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
    noStroke();
    fill(r, g, b, value);
    ellipse(x, y, radius*2, radius*2);  
    fill(0);
    stroke(0);
  } 
}
