class Network{
  MyNode nodes[];
  Tree treeNodes;
  ArrayList clusters;
  int clusterRankings[];
  Point points[];
  int clusterIDs[];
  
  int r,g,b;

  MyParser stoich;
  
  MyParser connectivity;
  
  String nodeID;
  
  MyParser rxns;
  MyParser colors;
  

  String reactions[];

  public Network(String s, String r, String rgb, String links, Tree treeNodes){
    stoich = new MyParser(s);
    rxns = new MyParser(r);
    colors = new MyParser(rgb);
    connectivity = new MyParser(links);
    nodeID = "7200";
    clusters = new ArrayList();
    
    reactions = new String[rxns.getNumItems() - 1];
    
    nodes = new MyNode[reactions.length];
    for(int i = 0; i < nodes.length; i++){
      MyCircle c = new MyCircle(0,0,10,"",-1);
      reactions[i] = rxns.getValue(i+1,0);
      int red, green, blue;
      String rxnType;
      nodes[i] = new MyNode(rxns.getValue(i + 1, 2), null, c);
      rxnType = rxns.getValue(i + 1, 3);
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
      for(int j = 2; j < stoich.getRowLength(1); j++){
        if(stoich.getValue(1,j).equals(reactionName)){
          for(int k = 2; k < stoich.getNumItems(); k++){
            if(Float.parseFloat(stoich.getValue(k,j)) != 0.0){
              for(int l = 2; l < stoich.getRowLength(1); l++){
                if(l != j){
                  if(Float.parseFloat(stoich.getValue(k,l)) < 0.0 && Float.parseFloat(stoich.getValue(k,j)) > 0.0 ||
                     Float.parseFloat(stoich.getValue(k,l)) > 0.0 && Float.parseFloat(stoich.getValue(k,j)) < 0.0){
                    for(int m = 0; m < nodes.length; m++){
                      if(stoich.getValue(1,l).equals(nodes[m].getID())){
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

    highlightNodes();
    makeClusters(treeNodes.root);
    pickClusterCenters();
    placeNodes();
  }
  
  void makeClusters(MyNode currentNode){
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
      for(int j = 1; j <= moduleSize; j++){
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
        makeClusters((MyNode)(currentNode.children.get(i)));
      }
    }
    points = new Point[clusters.size()];
  }
  
  boolean checkOverlap(MyNode n, int index, ArrayList otherNodes){
    boolean intersected = false;
    for(int i = 0; i < otherNodes.size(); i++){
      if(i != index){
        MyNode n2 = (MyNode)otherNodes.get(i);
        if(dist(n.circle.x, n.circle.y, n2.circle.x, n2.circle.y) < 20){
          intersected = true;
        }
      }
    }
    return intersected;
  }
  
  void highlightNodes(){
    for(int i = 0; i < nodes.length; i++){
      nodes[i].circle.fadeOut();
    }
    for(int i = 0; i < rxns.getRowLength(0); i++){
      if(rxns.getValue(0,i).equals(nodeID)){
        for(int j = 1; j < rxns.getNumItems(); j++){
          for(int k = 0; k < nodes.length; k++){
            if(nodes[k].id.equals(rxns.getValue(j,i))){
              nodes[k].circle.fadeIn();
            }
          }
        }
      }
    }
  }
  
  void pickClusterCenters(){
    Point bestPoints[] = new Point[clusters.size()];
    Point currentPoints[] = new Point[clusters.size()];
    for(int i = 0; i < 200000; i++){
      for(int j = 0; j < clusters.size(); j++){
        ArrayList currentCluster = (ArrayList)clusters.get(j);
        int centerX = int(random(width));
        int centerY = int(random(height));
        while(centerX < 10 * currentCluster.size() + 10 || centerY < 10 * currentCluster.size() + 10 ||
              centerX > width - (10 * currentCluster.size() - 10) || centerY > height - (10 * currentCluster.size()) - 10){
          centerX = int(random(width));
          centerY = int(random(height));
        }
        currentPoints[j] = new Point(centerX, centerY);
      }
      float bestDistance = 0;
      float currentDistance = 0;
      for(int j = 0; j < clusters.size(); j++){
        for(int k = j+1; k < clusters.size(); k++){
          currentDistance += dist(currentPoints[j].x, currentPoints[j].y,
                                  currentPoints[k].x, currentPoints[k].y);
          if(i > 0){
            bestDistance += dist(bestPoints[j].x, bestPoints[j].y,
                                 bestPoints[k].x, bestPoints[k].y);
          }
        }
      }
      boolean noClustersAreTouching = true;
      for(int j = 0; j < clusters.size(); j++){
        for(int k = j + 1; k < clusters.size(); k++){
          int radiusA = ((ArrayList)clusters.get(j)).size();
          int radiusB = ((ArrayList)clusters.get(j)).size();
          if(dist(currentPoints[j].x, currentPoints[j].y, currentPoints[k].x, currentPoints[k].y) < radiusA + radiusB){
            noClustersAreTouching = false;
          }
        }
      }
      if(noClustersAreTouching){
        for(int j = 0; j < clusters.size(); j++){
          points[j] = currentPoints[j];
        }
        return;
      }
      if(i == 0 || currentDistance > bestDistance){
        for(int j = 0; j < clusters.size(); j++){
          bestPoints[j] = currentPoints[j];
        }
      }
    }
    for(int i = 0; i < bestPoints.length; i++){
      points[i] = bestPoints[i];
    }
  }
  
  void placeNodes(){
    for(int i = 0; i < clusters.size(); i++){
      ArrayList currentCluster = (ArrayList)clusters.get(i);
      if(currentCluster.size() == 1){
        MyNode currentNode = (MyNode)(currentCluster.get(0));
        currentNode.setPos(points[i].x,points[i].y);
      }
      else{
        for(int j = 0; j < currentCluster.size(); j++){
          MyNode currentNode = (MyNode)currentCluster.get(j);
          float radians = random(2 * PI);
          int radius = int(random(10 * currentCluster.size()));
          int x = int(points[i].x+radius*cos(radians));
          int y = int(points[i].y+radius*sin(radians));
          currentNode.setPos(x,y);
          while(checkOverlap(currentNode, j, currentCluster)){
              radians = random(2 * PI);
              radius = int(random(10 * currentCluster.size()));
              x = int(points[i].x+radius*cos(radians));
              y = int(points[i].y+radius*sin(radians));
              currentNode.setPos(x,y);
          }
        }
      }
    }
  }

  void drawEdges(){
    strokeWeight(2);
    stroke(0,0,0);
    for(int i = 0; i < nodes.length; i++){
      nodes[i].visited = false;
    }
    for(int i = 0; i < nodes.length; i++){
      for(int j = 0; j < nodes[i].children.size(); j++){
        MyNode otherNode = (MyNode)nodes[i].children.get(j);
        if(!otherNode.visited && (otherNode.circle.isFaded || nodes[i].circle.isFaded)){
          stroke(210,210,210);
          if(nodes[i].circle.isBounded() || otherNode.circle.isBounded()){
            stroke(255,210,255);
          }
          line(nodes[i].circle.x, nodes[i].circle.y, otherNode.circle.x, otherNode.circle.y);
        }
      }
    }
    for(int i = 0; i < nodes.length; i++){
      nodes[i].visited = false;
    }
    for(int i = 0; i < nodes.length; i++){
      for(int j = 0; j < nodes[i].children.size(); j++){
        MyNode otherNode = (MyNode)nodes[i].children.get(j);
        if(!otherNode.visited && !otherNode.circle.isFaded && !nodes[i].circle.isFaded &&
           !nodes[i].circle.isBounded() && !otherNode.circle.isBounded()){
          stroke(100,100,100);
          line(nodes[i].circle.x, nodes[i].circle.y, otherNode.circle.x, otherNode.circle.y);
        }
      }
    }
    for(int i = 0; i < nodes.length; i++){
      nodes[i].visited = false;
    }
    for(int i = 0; i < nodes.length; i++){
      for(int j = 0; j < nodes[i].children.size(); j++){
        MyNode otherNode = (MyNode)nodes[i].children.get(j);
        if(!otherNode.visited && !otherNode.circle.isFaded && !nodes[i].circle.isFaded &&
           (nodes[i].circle.isBounded() || otherNode.circle.isBounded())){
          stroke(255,0,255);
          line(nodes[i].circle.x, nodes[i].circle.y, otherNode.circle.x, otherNode.circle.y);
        }
      }
    }
    stroke(0,0,0);
    strokeWeight(1);
  }

  void render(){
    textAlign(LEFT);
    highlightNodes();
    background(255, 255, 255);
    drawEdges();
    fill(200,0,0);
    boolean mouseover = false;
    for(int i = 0; i < nodes.length; i++){
      MyCircle white = new MyCircle(nodes[i].circle.x, nodes[i].circle.y,
                                    10,"",255);
      white.render();
    }
    for(int i = 0; i < nodes.length; i++){
      int red = nodes[i].circle.defaultRed;
      int green = nodes[i].circle.defaultGreen;
      int blue = nodes[i].circle.defaultBlue;

      if(nodes[i].isBounded() && !mouseover)
      {
        mouseover = true;
        nodes[i].circle.setColorV(min(255, red+100), min(255, green+100),
                                 min(255, blue+100), 255);
        if(nodes[i].circle.isFaded){
          nodes[i].circle.setColorV(min(255, red+100), min(255, green+100),
                                 min(255, blue+100), 200);
        }
        nodes[i].render();
      }
      else{
        nodes[i].circle.setColorV(red, green, blue, 255);
        if(nodes[i].circle.isFaded){
          nodes[i].circle.setColorV(red, green, blue, 50);
        }
        nodes[i].render();
      }
    }
    mouseover = false;
    for(int i = 0; i < nodes.length; i++){
      if(nodes[i].isBounded() && !mouseover)
      {
        mouseover = true;
        fill(120, 120, 120, 150);
        if(mouseX > width - (textWidth(nodes[i].getID()) + 10)){
          rect(mouseX - textWidth(nodes[i].getID()), mouseY - 20, textWidth(nodes[i].getID()) + 10, 30, 9);
          fill(255, 255, 255);
          text(nodes[i].getID(), (mouseX - textWidth(nodes[i].getID())) + 5, mouseY);
        }
        else{
          rect(mouseX, mouseY - 20, textWidth(nodes[i].getID()) + 10, 30, 9);
          fill(255, 255, 255);
          text(nodes[i].getID(), mouseX + 5, mouseY);
        }
      }
    }
  }
}
