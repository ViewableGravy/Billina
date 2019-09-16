class Tile implements Cloneable {
  int x, y, wid, hei;
  int shade = 0;
  public char player = '.';
  Tile(int x, int y, int wid, int hei) {
    this.x = x;
    this.y = y;
    this.wid = wid;
    this.hei = hei;
  }
  
  public Object clone() throws CloneNotSupportedException 
  {
   return super.clone(); 
  }

  void Display() {
    fill(shade);
    rect(x, y, wid, hei);
    stroke(100);
    fill(32);
    if (player != '.') {
      text(player, x +50, y + 50 );
    }
  }

  boolean OnTile(float mousex, float mousey) {

    if ( mousex > x && mousex < x + wid && mousey > y && mousey < y + hei ) {
      shade = 255;
      return true;
    } else {
      shade = 0;
      return false;
    }
  }
}
