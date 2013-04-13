//Based heavily on the Parser example given in the Bouncing
//Balls example on the website.

class MyParser {
  String[] titles;
  String[][] values;
  int numItems;
  
  public MyParser(String filename) {
    String[] lines = loadStrings(filename);
    
    numItems = lines.length-1;
    values = new String[numItems][];
    
    for(int i = 0; i < lines.length; i++) {
      if(i == 0) {
        titles = split(lines[i], ',');
      }
      else {
        values[i-1] = split(lines[i], ',');
      }  
    }
  }
  
  public String getValue(int row, int col) {
    return values[row][col];
  }
  
  public String getTitle(int col) {
    return titles[col];
  }
  
  public int getNumTimeSteps() { return titles.length - 1;}
  
  public int getNumItems() {return numItems;}
}
