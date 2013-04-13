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
    int row = -1;
    Boolean leaf = true;
    MyNode temp;
    for(int i = 0; i < c.numItems; i++) {
      if (node.id.equals(c.getValue(i, 1))) row = i;
    }
    
    for (int i = 0; i < c.getRowLength(0); i++) {
      if (c.getValue(row, i).equals("1")) {
        leaf = false;
        temp = new MyNode (c.getValue(1, i), new MyCircle (0, 0, 10, c.getValue(1, i), 0));
        node.add_Child(temp);
        addChildren (temp, c);
      }
    }
    if(leaf) node.isLeaf();
  }




//traverses the tree to add details to each node
//called after tree parent chilren nodes have been laid out and leaf nodes have information

  public initializeNodesDetails(MyNode node){
    moduleReport(moduleReport, node);  //so far only sets module report

    if(node.leaf){
      return;
    }
    for(int i = 0; i < node.children.size(); i++){
       MyNode child = (MyNode) node.children.get(i);
       intializeNodeDetails(child);
    }
  }

  //gets composition called by intialization details
  //public moduleComposition(MyParser composition, MyNode node){
  //}
  
  //traverse module report, places number of reactions into given node 
  public moduleReport(MyParser moduleReport, myNode node){
    string id = node.id;
    for(int i = 0; i < moduleReport.numItems; i++){
      if(id.equals(moduleReport.getValues(i, 0))){
        int num = int(moduleReport.getValues(i, 0));
        node.details.numReactions = num;///size in module report
        break; 
      }
    }
  }
}
