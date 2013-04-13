class MyNode {
  
  ArrayList children = new ArrayList();
  ArrayList edges = new ArrayList();
  String id;
  MyCircle circle;
  
  public MyNode (String ID, MyCircle circ) {
    id = ID;
    circle = circ;
  }
  
  public String getID () {return id;}
  
  public void add_Child (MyNode node, int edge) {
    children.add(node);
    edges.add(edge);
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
