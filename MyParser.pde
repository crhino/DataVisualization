//Based heavily on the Parser example given in the Bouncing
//Balls example on the website.

class MyParser {
  String[][] values;
  int numItems;
  
  public MyParser(String filename) {
    String[] lines = loadStrings(filename);
    
    numItems = lines.length;
    values = new String[numItems][];
    
    for(int i = 0; i < lines.length; i++) {
        values[i] = split(lines[i], ',');
    }
  }
  
  public String getValue(int row, int col) {
    return values[row][col];
  }
  
  public int getNumItems() {return numItems;}
}
