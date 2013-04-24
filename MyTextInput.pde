class MyTextInput {
  int x, y, _width, _height;
  int r, g, b;
  String label;
  int value;
  Boolean selected;
  
  public MyTextInput(int _x, int _y, int __width, int __height, String _label, int _value) {
    x = _x;
    y = _y;
    _width = __width;
    _height = __height;
    label = _label;
    value = _value;
    r = 255;
    g = 255;
    b = 255;
    selected = false;
  }
  
  public void setColor(int _r, int _g, int _b) {
    r = _r;
    g = _g;
    b = _b; 
  }
  
  public void setPos(int _x, int _y) {
    x = _x;
    y = _y;
  }
  public void setSelected(Boolean b) {selected = b;}
  
  public Boolean isSelected() {return selected;}
  
  public String getLabel() {return label;}
  
  public int getValue() {return value;}
  
  public int getX() {return x;}
  
  public int getY() {return y;}
  
  public int getW() {return _width;}
  
  public int getH() {return _height;}
  
  public boolean isBounded (int _x, int _y) {
    if(_x >= x && _y >= y && _x <= (_width + x) && _y <= (_height + y))
      return true;
    return false; 
  }
  
  public void render () {
    fill(r, g, b);
    strokeWeight(2);
    rect(x, y, _width, _height);
    fill(0, 0, 0);
    if(selected)
      text(label+(frameCount/10 % 2 == 0 ? "_" : ""), x +2, y + _height/1.5);
    else text(label, x + 2, y +_height/1.5);
  }
  
  void mouseClicked() {
    if(isBounded(mouseX, mouseY)) textInput.setSelected(true);
    else setSelected(false);
  }
  
  void keyReleased() {
    if (isSelected()) {
    if (key != CODED) {
      switch(key) {
        case BACKSPACE:
          label = label.substring(0,max(0,label.length()-1));
          break;
        case TAB:
          label += "    ";
          break;
        case ENTER:
        case RETURN:
          // put call to filter function here.
          break;
        case ESC:
        case DELETE:
          break;
        default:
          label += key;
      }
    }
    }
  }
}
