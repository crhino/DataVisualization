class Tree {
  MyNode root;
  
  public Tree () {

  }
  //Creates the tree heirarchy.
  public void createTree (MyParser c) {
    root = new MyNode(c.getValue(1, 2), new MyCircle (0, 0, 10, c.getValue(1, 2), 0));
    addChildren(root, c);
  }
  
  //Recursive function that finds and adds children of node.
  public void addChildren (MyNode node, MyParser c) {
    int row;
    Boolean leaf = true;
    MyNode temp;
    for(int i = 0; i < c.numItems; i++) {
      if (node.id == c.getValue(i, 1)) row = i;
    }
    
    for (int i = 0; i < c.getRowLength(i); i++) {
      if (c.getValue(row, i) == "1") {
        leaf = false;
        temp = new MyNode (c.getValue(1, i), new MyCircle (0, 0, 10, c.getValue(1, i), 0));
        node.add_Child(temp);
        addChildren (temp, c);
      }
    }
    if(leaf) node.isLeaf();
  }
}
