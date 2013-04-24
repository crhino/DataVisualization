//Based heavily on the Circle class seen in the Bouncing balls example.
class MyCircle {
  int x, y, radius;
  int r, g, b, value;
  int defaultRed, defaultGreen, defaultBlue;
  String label;
  boolean isFaded;
  
  public MyCircle(int _x, int _y, int _radius, String _label, int _value) {
      setPosition (_x, _y, _radius);
      setDefaultColor(250,250,250);
      setLabel (_label);
      value = _value;
      isFaded = false;
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
  
  public void setDefaultColor (int _r, int _g, int _b) {
      defaultRed = _r;
      defaultGreen = _g; 
      defaultBlue = _b;
      setColor(_r, _g, _b);
  }

  public void setColorV (int _r, int _g, int _b, int _v) {
      r = _r;
      g = _g; 
      b = _b;
      value = _v;
  }
  
  public void fadeOut(){
    isFaded = true;
  }
  
  public void fadeIn(){
    isFaded = false;
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
    noStroke();
    fill(r, g, b, value);
    ellipse(x, y, radius*2, radius*2);
    fill(0);
    strokeWeight(1);
  }
}
