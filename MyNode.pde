class MyNode {
  
  ArrayList children = new ArrayList();
  MyNode parent;
  String id;
  MyCircle circle;
  Boolean leaf;
  Boolean visited;
  
  public MyNode (String ID, MyNode p, MyCircle circ) {
    parent = p;
    id = ID;
    circle = circ;
    leaf = false;
    visited = false;
  }
  
  public String getID () {return id;}

  public void isLeaf() {leaf = true;}
  
  public void setVisited(Boolean b) {visited = b;}
  
  public void add_Child (MyNode node) {
    children.add(node);
  }
  
  public void setPos(int x, int y, int r) {
    circle.setPosition(x, y, r);
  }
  
  public void setColor(int r, int g, int b) {
    circle.setColor(r, g, b);
  }
  
  public void render() {
    circle.render();
  }
  
  public int getX() {return circle.getX();}
  
  public int getY() {return circle.getY();}
  
  public ArrayList get_Children() {return children;}
  
  public Boolean isBounded() {
    return circle.isBounded();
  }
}
