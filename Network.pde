class Network{
  MyNode nodes[];
  int r,g,b;

  Parser s;

  public Network(){
    s = new MyParser("stoich_matrix.pde");
    nodes = new Node[s.getRowLength(1)-2];
    for(int i = 0; i < nodes.length; i++){
      MyCircle c = new MyCircle(0,0,25,"",-1);
      nodes[i] = new Node(s.getValue(1, i+2));
    }
    for(int i = 0; i < nodes.length; i++){
      for(int j = 0; j < s.getNumItems; j++){
        if(Float.parseFloat(s.getValue(j,i)) != 0.0){
          for(int k = 0; k < nodes.length; k++){
            if(k != j){
              if((Float.parseFloat(s.getValue(j,i)) < 0 && Float.parseFloat(s.getValue(j,k)) > 0) || 
                 (Float.parseFloat(s.getValue(j,i)) > 0 && Float.parseFloat(s.getValue(j,k)) < 0)){
                nodes[i].add_child(nodes[k]);
              }
            }
          }
        }
      }
    }
    r = 0;
    g = 255;
    b = 0;
  }

  void drawEdges(){
    stroke(r,g,b);
    for(int i = 0; i < nodes.length; i++){
      ArrayList edges = 
      for(){
      }
    }
  }

  void render(){

  }
}
