class MyNode {

  boolean collapse;
  MyDetails details;
  boolean selected;
  boolean compare = false;
  boolean filterOut = false;

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
    details = new MyDetails();
  }

  public String getID () {
    return id;
  }

  public void isLeaf() {
    leaf = true;
  }

  public void setVisited(Boolean b) {
    visited = b;
  }

  public void add_Child (MyNode node) {
    children.add(node);
  }

  public void setPos(int x, int y) {
    circle.setPosition(x, y);
  }
  
  public void setColor(int r, int g, int b) {
    circle.setColor(r, g, b);
  }

  public void render() {
    stroke(255);
    strokeWeight(1);
    if(this.selected){
      stroke(255, 0, 255);
      strokeWeight(3);
    }
    if(this.filterOut) {
      circle.value = 20;
    }
    else circle.value = 500;
    circle.render();
  }

  public int getX() {
    return circle.getX();
  }

  public int getY() {
    return circle.getY();
  }

  public ArrayList get_Children() {
    return children;
  }

  public Boolean isBounded() {
    return circle.isBounded();
  }
}
