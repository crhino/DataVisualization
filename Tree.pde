class Tree {
  MyNode root;
  
  public Tree () {

  }
  //Creates the tree heirarchy.
  public createTree (MyParser c) {
    root = new MyNode(c.getValue(1, 2), new MyCircle (//Add this later.));
    addChildren(root, c);
  }
  
  //Recursive function that finds and adds children of node.
  public addChildren (MyNode node, MyParser c) {
    int row;
    Boolean leaf = true;
    MyNode temp;
    for(int i = 0; i < c.numItems; i++) {
      if (node.id == c.getValue(i, 1)) row = i;
    }
    
    for (int i = 0; i < c.getRowLength(); i++) {
      if (c.getValue(row, i) == "1") {
        leaf = false;
        temp = new MyNode (c.getValue(1, i), new MyCircle (//Add this later));
        node.add_Child(temp);
        addChildren (temp, c);
      }
    }
    if(leaf) node.isLeaf();
  }
}
