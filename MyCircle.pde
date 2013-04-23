

//more details may be addes later, homogeneity index, cycles, if it gets a red line?, etc.
class MyDetails {
  ArrayList labels;  //this is a list of strings
  float[] proportions;  //this is a list of numbers
 color[] colors;

  float numReactions;
  float avgShred;
  float textBoxWidth;
  boolean oneType;
  String oneClass;
  
  String nodeID; 


  //for ndoes
  public MyDetails() {
  }


  //for functioning
  public MyDetails(MyParser colormap) {
    int rows = colormap.getNumItems();

    this.labels = new ArrayList(rows);

    for (int i = 1; i < rows; i++) {
      this.labels.add(colormap.getValue(i, 0));
    }
    
    this.colors = new color[rows];
    for(int i = 1; i < rows; i++){
      this.colors[i-1] = color(int(colormap.getValue(i, 1)), int(colormap.getValue(i, 2)), int(colormap.getValue(i, 3)));
    }
    
    this.textBoxWidth = 0; 
    for(int i = 0; i < this.labels.size(); i++){
      if(this.textBoxWidth  < textWidth((String) this.labels.get(i)) + textWidth(": 123.4567")){
        this.textBoxWidth = textWidth((String) this.labels.get(i)) + textWidth(": 123.4567");
      }
    }
    
    println(this.textBoxWidth);
 
 
 
  }
  
  

  

  public void initializeNode(MyNode node, MyParser moduleReport, MyParser moduleComp) {
    moduleReportInit(node, moduleReport);  //so far only sets module report
    moduleCompInit(node, moduleComp);
    check1reaction(node);

    if (node.leaf) {
      return;
    }
    for (int i = 0; i < node.children.size(); i++) {
      MyNode child = (MyNode) node.children.get(i);
      initializeNode(child, moduleReport, moduleComp);
    }
  }


  private void moduleReportInit(MyNode node, MyParser moduleReport) {
    node.details.nodeID = node.id;
    for (int i = 1; i < moduleReport.numItems; i++) {
      if (node.id.equals(moduleReport.getValue(i, 0))) {
        node.details.numReactions = float(moduleReport.getValue(i, 1));
        node.details.avgShred = float(moduleReport.getValue(i, 8));
        break;
      }
    }
  }


  private void moduleCompInit(MyNode node, MyParser moduleComp) {
    node.details.proportions = new float[this.labels.size()];
    for (int i = 0; i < this.labels.size(); i++) {
      node.details.proportions[i] = 0;
    }

    for (int i = 0; i < moduleComp.getRowLength(0); i++) {
      if (node.id.equals(moduleComp.getValue(0, i))) {
        for (int j = 1; j < node.details.numReactions + 1; j++) {
          String type = moduleComp.getValue(j, i+1);          
          for (int k = 0; k < this.labels.size(); k++) {
            if (type.equals((String) this.labels.get(k))) {
              node.details.proportions[k]++;
            }
          }
        }
      }
    }

    for (int i = 0; i < this.labels.size(); i++) {
      node.details.proportions[i] = (node.details.proportions[i]/node.details.numReactions)*100;
    }
  }

  private void check1reaction(MyNode node) {
    node.setColor(170, 170, 170);
    for (int i = 0; i < this.labels.size(); i++) {
      if (node.details.proportions[i] == 100.0) {
        node.details.oneType = true;
        node.details.oneClass = (String) this.labels.get(i);
        node.details.textBoxWidth = textWidth(node.details.oneClass + ": 123.4567");
        node.setColor(int(red(int(this.colors[i]))), int(green(int(this.colors[i]))), int(blue(int(this.colors[i]))));
        return;
      }
    }
  }
  
  
  

  
  
  
}
