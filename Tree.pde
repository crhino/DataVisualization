class Tree {
  MyNode root;
  
  public Tree () {

  }
  //Creates the tree heirarchy.
  public createTree (MyParser c) {
    root = new MyNode(c.getValue(1, 2), new MyCircle (//Add this later.));
  }
  
  //Recursive function that finds and adds children of node.
  public addChildren (MyNode node, MyParser c) {
    int row;
    for(int i = 0; i < c.numItems; i++) {
      if (
    }
  }
}
