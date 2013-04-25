class Tree {
  MyNode root;
  MyNode current;
  int circledist = 50;

  public Tree () {
  }
  //Creates the tree heirarchy.
  public void createTree(MyParser c) {
    root = new MyNode(c.getValue(1, 2), null, new MyCircle (0, 0, 15, c.getValue(1, 2), 500));
    addChildren(root, c);
    current = root;
  }



  ///////
  public void setCenter(MyNode newCenter) {
    this.current = newCenter;
  }
  //////





  //Recursive function that finds and adds children of node.
  public void addChildren (MyNode node, MyParser c) {
    int row = -1;
    Boolean leaf = true;
    MyNode temp;
    for (int i = 0; i < c.numItems; i++) {
      if (node.id.equals(c.getValue(i, 1))) row = i;
    }

    for (int i = 0; i < c.getRowLength(0); i++) {
      if (c.getValue(row, i).equals("1")) {
        leaf = false;
        temp = new MyNode (c.getValue(1, i), node, new MyCircle (0, 0, 15, c.getValue(1, i), 500));
        node.add_Child(temp);
        addChildren (temp, c);
      }
    }
    if (leaf) node.isLeaf();
  }

  public void drawConCircles() {
    MyCircle temp;
    for (int i = 0; i < 10; i++) {
      temp = new MyCircle (width/2, height/2, circledist*(10-i), "", 200);
      stroke(0);
      strokeWeight(1);
      temp.render();
    }
  }

  public void setCurrent() {
    setCurrentR (root);
  }

  private void setCurrentR (MyNode node) {
    if (node.isBounded ()) {
      current = node;
      return;
    }
    if (node.leaf) return;
    ArrayList temp = node.children;
    MyNode temp1;
    for (int i = 0; i < temp.size(); i++) {
      temp1 = (MyNode) temp.get(i);
      setCurrentR(temp1);
    }
  }

  public Boolean NodesBounded () {
    return checkNodes(root);
  }

  private Boolean checkNodes(MyNode node) {
    if (node.isBounded()) return true;
    if (node.leaf) return false;
    ArrayList temp = node.children;
    MyNode temp1;
    for (int i = 0; i < temp.size(); i++) {
      temp1 = (MyNode) temp.get(i);
      if (checkNodes(temp1)) return true;
    }
    return false;
  }

  //Takes origin (x,y), and returns a Point at dist units away and radians angle in relation.
  public Point makeRay (int x, int y, float dist, float radians) {
    return new Point((int)(x+dist*cos(radians)), (int)(y+dist*sin(radians)));
  }

  public void resetVisited(MyNode node) {
    if (node.leaf) {
      node.setVisited(false);
      return;
    }
    node.setVisited(false);
    ArrayList temp = node.children;
    for (int i = 0; i < temp.size(); i++) {
      resetVisited((MyNode) temp.get(i));
    }
  }

  public void render () {
    stroke(0);
    current.setPos(width/2, height/2);
    root.setColor(0, 0, 200);
    renderTree(current, 0, 2*PI, circledist);
    resetVisited(root);
    stroke(255);
  }

  private void renderTree (MyNode node, float radianstart, float radianend, int nodedist) {
    if (node.leaf && node.visited) return;
    node.setVisited(true);
    MyNode temp = null;
    Point point;
    int count = 0;
    Boolean remove = false;
    ArrayList children = node.children;
    if (node.parent != null) {
      if (node.parent.visited == false) {
        remove = true;
        children.add(node.parent);
      }
    }
    for (int i = 0; i < children.size(); i++) {
      temp = (MyNode) children.get(i);
      if (temp.visited) count++;
    }
    float radianspace = (radianend - radianstart)/(children.size()-count);
    float theta = radianstart + radianspace/2;

    if (node.collapse) {
      if (node.parent != null && node.parent.visited != true) {
        radianspace = radianend - radianstart;
        theta = radianspace + radianspace/2;
        point = makeRay (width/2, height/2, nodedist, theta);
        node.parent.setPos(point.x, point.y);
        stroke(0);
        line(node.getX(), node.getY(), temp.getX(), temp.getY());
        node.parent.render();
        renderTree(node.parent, radianstart, radianend, nodedist);
      }
      return;
    }



    count = 0;
    for (int i = 0; i < children.size(); i++) {
      temp = (MyNode) children.get(i);
      if (temp.visited) {
        count++;
        continue;
      }
      point = makeRay (width/2, height/2, nodedist, theta);
      temp.setPos(point.x, point.y);
      stroke(0);
      line(node.getX(), node.getY(), temp.getX(), temp.getY());
      temp.render();
      fill(255);
      textSize(10);
      textAlign(CENTER);
      text(temp.id, temp.circle.x, temp.circle.y);
      renderTree (temp, radianstart+((i-count)*radianspace), radianstart + ((i-count+1)*radianspace), nodedist+circledist);
      theta = theta + radianspace;
    }
    if (remove) {
      children.remove(node.parent);
    }
    node.render();
    fill(255);
    textSize(10);
    textAlign(CENTER);
    text(node.id, node.circle.x, node.circle.y);
  }
}
