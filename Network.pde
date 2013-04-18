class Network{
  MyNode nodes[];
  MyNode treeNodes[];////////////////////////////////
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
    nodeID = "7221";
    
    reactions = new String[rxns.values.length - 1];
    
    nodes = new MyNode[reactions.length];
    for(int i = 0; i < nodes.length; i++){
      MyCircle c = new MyCircle(int(random(width*.9)+int(width*.05)),
                                int(random(height*.7) + int(width * .05)),10,"",-1);
      int red, green, blue;
      String rxnType;
      nodes[i] = new MyNode(rxns.getValue(i + 1, 0), c);
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
        nodes[i].circle.setColor(min(255, red+100), min(255, green+100), 
                                 min(255, blue+100));
        if(nodes[i].circle.isGray){
          nodes[i].circle.setColor(200, 200, 200);          
        }
        nodes[i].render();
      }
      else{
        nodes[i].circle.setColor(red, green, blue);
        if(nodes[i].circle.isGray){
          nodes[i].circle.setColor(150, 150, 150);          
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
