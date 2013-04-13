class MyNode {
  
  ArrayList children = new ArrayList();
  ArrayList edges = new ArrayList();
  String id;
  MyCircle circle;
  Boolean leaf;
  
  public MyNode (String ID, MyCircle circ) {
    id = ID;
    circle = circ;
    leaf = false;
  }
  
  public String getID () {return id;}

  public void isLeaf() {leaf = true;}
  
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
  
  public ArrayList get_Children() {return children;}
  
  public ArrayList getEdges() {return edges;}
  public Boolean isBounded() {
    return circle.isBounded();
  }
}
