class Network{
  MyNode nodes[];
  Tree treeNodes;
  ArrayList clusters;
  
  int r,g,b;

  MyParser s;
  
  MyParser t;
  
  String nodeID;
  
  MyParser rxns;
  MyParser colors;

  String reactions[];

  public Network(){
    s = new MyParser("stoich_matrix.csv");
    rxns = new MyParser("module_composition2.csv");
    colors = new MyParser("colormap.csv");
    t = new MyParser("module_connectivity.csv");
    nodeID = "7202";
    clusters = new ArrayList();
    treeNodes = new Tree();
    treeNodes.createTree(t);
    
    reactions = new String[rxns.values.length - 1];
    
    nodes = new MyNode[reactions.length];
    for(int i = 0; i < nodes.length; i++){
      MyCircle c = new MyCircle(int(random(width*.9)+int(width*.05)),
                                int(random(height*.7) + int(width * .05)),10,"",-1);
      int red, green, blue;
      String rxnType;
      nodes[i] = new MyNode(rxns.getValue(i + 1, 0), null, c);
      rxnType = rxns.getValue(i + 1, 1);
      for(int j = 1; j < colors.getNumItems(); j++){
        if(colors.getValue(j,0).equals(rxnType)){
          red = int(colors.getValue(j,1));
          green = int(colors.getValue(j,2));
          blue = int(colors.getValue(j,3));
          nodes[i].circle.setDefaultColor(red, green, blue);
        }
      }
    }
    
    for(int i = 0; i < nodes.length; i++){
      String reactionName = nodes[i].getID();
      for(int j = 2; j < s.getRowLength(1); j++){
        if(s.getValue(1,j).equals(reactionName)){
          for(int k = 2; k < s.getNumItems(); k++){
            if(Float.parseFloat(s.getValue(k,j)) != 0.0){
              for(int l = 2; l < s.getRowLength(1); l++){
                if(l != j){
                  if(Float.parseFloat(s.getValue(k,l)) < 0.0 && Float.parseFloat(s.getValue(k,j)) > 0.0 ||
                     Float.parseFloat(s.getValue(k,l)) > 0.0 && Float.parseFloat(s.getValue(k,j)) < 0.0){
                    for(int m = 0; m < nodes.length; m++){
                      if(s.getValue(1,l).equals(nodes[m].getID())){
                        nodes[i].add_Child(nodes[m]);
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    
    for(int i = 1; i < reactions.length; i++){
      reactions[i] = rxns.getValue(i,0);
    }
    
    for(int i = 0; i < nodes.length; i++){
      nodes[i].circle.grayOut();
    }
    
    for(int i = 0; i < rxns.getRowLength(0); i++){
      if(rxns.getValue(0,i).equals(nodeID)){
        for(int j = 1; j < rxns.getNumItems(); j++){
          String rxn = rxns.getValue(j,i);
          for(int k = 0; k < nodes.length; k++){
            if(nodes[k].getID().equals(rxn)){
              nodes[k].circle.addColor();
            }
          }
        }
      }
    }    
    findClusters(treeNodes.root);
    placeNodes();
  }
  
  void findClusters(MyNode currentNode){
    int moduleSize = 0;
    int column = 0;
    for(int i = 0; i < rxns.getRowLength(0); i++){
      if(rxns.getValue(0,i).equals(currentNode.getID())){
        for(int j = 1; j < rxns.getNumItems(); j++){
          if(!rxns.getValue(j,i).equals("")){
            moduleSize++;
          }
        }
        column = i;
      }
    }
    if(currentNode.leaf || moduleSize <= 10){
      ArrayList cluster = new ArrayList();
      for(int j = 1; j < moduleSize; j++){
        String currentRxn = rxns.getValue(j,column);
        for(int i = 0; i < nodes.length; i++){
          if(nodes[i].getID().equals(currentRxn)){
            cluster.add(nodes[i]);
          }
        }
      }
      clusters.add(cluster);
    }
    else{
      for(int i = 0; i < currentNode.children.size(); i++){
        findClusters((MyNode)(currentNode.children.get(i)));
      }
    }
  }
  
  void placeNodes(){
    for(int i = 0; i < clusters.size(); i++){
      ArrayList currentCluster = (ArrayList)clusters.get(i);
      int centerX = int(random(width*.9)+int(width*.05));
      int centerY = int(random(height*.7) + int(width * .05));
      if(((ArrayList)clusters.get(i)).size() == 1){
        ((MyNode)(currentCluster.get(0))).setPos(centerX,centerY,10);
      }
      else{
        for(int j = 0; j < currentCluster.size(); j++){
          MyNode currentNode = (MyNode)currentCluster.get(j);
          ((MyNode)(currentCluster.get(j))).setPos(centerX +
                    int(random(20 * currentCluster.size())),
                    centerY + int(random(20 * currentCluster.size())),10);
        }
      }
    }
  }

  void drawEdges(){
    stroke(0,0,0);
    for(int i = 0; i < nodes.length; i++){
      for(int j = 0; j < nodes[i].children.size(); j++){
        if(nodes[i].circle.isBounded() || ((MyNode)nodes[i].children.get(j)).circle.isBounded()){
          stroke(0,200,0);
        }
        if(nodes[i].circle.isGray || ((MyNode)nodes[i].children.get(j)).circle.isGray){
          stroke(180,180,180);
          if(nodes[i].circle.isBounded() || ((MyNode)nodes[i].children.get(j)).circle.isBounded()){
            stroke(180,255,180);
          }
        }
        line(nodes[i].circle.x, nodes[i].circle.y,
             ((MyNode)nodes[i].children.get(j)).circle.x, ((MyNode)nodes[i].children.get(j)).circle.y);
        stroke(0,0,0);
      }
    }
    stroke(0,0,0);
  }

  void render(){
    background(255, 255, 255);
    drawEdges();
    fill(200,0,0);
    boolean mouseover = false;
    for(int i = 0; i < nodes.length; i++){
      int red = nodes[i].circle.defaultRed;
      int green = nodes[i].circle.defaultGreen;
      int blue = nodes[i].circle.defaultBlue;
      
      if(nodes[i].isBounded() && !mouseover)
      {
        mouseover = true;
        nodes[i].circle.setColorV(min(255, red+100), min(255, green+100), 
                                 min(255, blue+100), 255);
        if(nodes[i].circle.isGray){
          nodes[i].circle.setColorV(200, 200, 200, 200);          
        }
        nodes[i].render();
      }
      else{
        nodes[i].circle.setColorV(red, green, blue, 255);
        if(nodes[i].circle.isGray){
          nodes[i].circle.setColorV(150, 150, 150, 150);          
        }
        nodes[i].render();
      }
    }
    mouseover = false;
    for(int i = 0; i < nodes.length; i++){
      if(nodes[i].isBounded() && !mouseover)
      {
        mouseover = true;
        fill(255, 255, 255);
        rect(mouseX, mouseY - 20, textWidth(nodes[i].getID()), 20);
        fill(0, 0, 0);
        text(nodes[i].getID(), mouseX, mouseY);
      }
    }
  }
}
