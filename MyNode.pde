class MyNode {
  
  ArrayList children = new ArrayList();
  ArrayList edges = new ArrayList();
  int id;
  MyCircle circle;
  float dx, dy, Fx, Fy;
  
  public MyNode (int ID, MyCircle circ) {
    id = ID;
    circle = circ;
    dx = 0;
    dy = 0;
    Fx = 0;
    Fy = 0;
  }
  
  public int getID () {return id;}
  
  public void add_Child (MyNode node, int edge) {
    children.add(node);
    edges.add(edge);
  }
  
  public void setPos(int x, int y, int r) {
    circle.setPosition(x, y, r);
  }
  
  public int getX() {return circle.getX();}
  
  public int getY() {return circle.getY();}
  
  public float getVX() {return dx;}
  
  public float getVY() {return dy;}
  
  public void setVX(float x) { dx = x;}
  
  public void setVY(float y) { dy = y;}
  
  public void addFx(float x) {Fx += x;}
  
  public void addFy(float y) {Fy += y;}
  
  public float getFx() {
    float x = Fx;
    Fx = 0;
    return x;}
  
  public float getFy() {
    float y = Fy;
    Fy = 0;
    return y;}
  
  public void setColor(int r, int g, int b) {
    circle.setColor(r, g, b);
  }
  
  public void render() {
    circle.render();
  }
  
  public ArrayList get_Children() {return children;}
  
  public ArrayList getEdges() {return edges;}
  public Boolean isBounded() {
    return circle.isBounded();
  }
}
