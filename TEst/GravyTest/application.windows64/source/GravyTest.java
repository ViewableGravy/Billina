import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class GravyTest extends PApplet {

Tile[][] grid = new Tile[3][3];
Tile[] grid2 = new Tile[9];
public void setup() { 
  

  int x = 0;
  int y = 0;
  for (int i = 0; i < 9; ++i) {
    grid2[i] = new Tile(x, y, width/3, height/3);
    x+=width/3;
    if ((i + 1) % 3 == 0) {
      y+=height/3;
      x = 0;
    }
  }

  

  
}

public Tile[] CloneTileArray(Tile[] inputGrid) {
  Tile[] test = new Tile[inputGrid.length];
  for (int i = 0; i < test.length; i++) {
    try {
      test[i] = (Tile)grid2[i].clone();
    }
    catch(Exception e) {
    }
  }
  return test;
}

public void draw() {
  for (int i = 0; i < 9; i++)
    grid2[i].Display();
  //GetWinner(grid2);
}

public void mousePressed() {
  for (int i = 0; i < 9; ++i)
    if (grid2[i].OnTile(mouseX, mouseY))
      if (grid2[i].player == '.')
        grid2[i].player = 'X';


  println( minimax(grid2, -1)); 
  
 }/*
  int remaining = 0;
   for (int i = 0; i < 9; ++i)
   if (grid2[i].player =='.')
   remaining++;
   
   int random = ceil(random(remaining));
   for (int i = 0; i < 9; ++i)
   if (grid2[i].player == '.')
   if (--random == 0)
   grid2[i].player = 'O';
   */

//computer = -1
//human = 1
//draw = 0
public Integer GetWinner(Tile[] grid) {

  if ((""+grid[0].player + grid[1].player+grid[2].player).equals("XXX") ||
    (""+grid[3].player + grid[4].player+grid[5].player).equals("XXX") ||
    (""+grid[6].player + grid[6].player+grid[7].player).equals("XXX") ||
    (""+grid[0].player + grid[3].player+grid[6].player).equals("XXX") ||
    (""+grid[1].player + grid[4].player+grid[7].player).equals("XXX") ||
    (""+grid[2].player + grid[5].player+grid[8].player).equals("XXX") ||
    (""+grid[6].player + grid[4].player+grid[2].player).equals("XXX") ||
    (""+grid[0].player + grid[4].player+grid[8].player).equals("XXX")) return 1; //human wins
  if ((""+grid[0].player + grid[1].player+grid[2].player).equals("OOO") ||
    (""+grid[3].player + grid[4].player+grid[5].player).equals("OOO") ||
    (""+grid[6].player + grid[6].player+grid[7].player).equals("OOO") ||
    (""+grid[0].player + grid[3].player+grid[6].player).equals("OOO") ||
    (""+grid[1].player + grid[4].player+grid[7].player).equals("OOO") ||
    (""+grid[2].player + grid[5].player+grid[8].player).equals("OOO") ||
    (""+grid[6].player + grid[4].player+grid[2].player).equals("OOO") ||
    (""+grid[0].player + grid[4].player+grid[8].player).equals("OOO")) return -1; //computer wins
  int remaining = 0;
  for (int i = 0; i < 9; ++i)
    if (grid2[i].player =='.')
      remaining++;
  if (remaining==0)
    return 0; 
  return null;
}
int recursage = 0;
public int minimax(Tile[] grid, int plr) {
  println(recursage++);
  Integer winningPlayer = GetWinner(grid);
  if (winningPlayer != null) {
    return winningPlayer * plr;
  }

  char currentplr;
  if (plr == -1) {
    currentplr = 'O';
  } else {
    currentplr = 'X';
  }

  int score = -2;
  int move = -1;

  for (int i = 0; i < 9; i++) {
    if (grid[i].player == '.') {
      Tile[] gridCopy = CloneTileArray(grid);
      gridCopy[i].player = currentplr;
      int scoreForTheMove = minimax(gridCopy, currentplr * -1);
      if (scoreForTheMove > score) {
        score = scoreForTheMove;
        move = i;
      }
    }
  }
  if (move == -1) {
    return 0;
  }
  return score;
}
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

  public void Display() {
    fill(shade);
    rect(x, y, wid, hei);
    stroke(100);
    fill(32);
    if (player != '.') {
      text(player, x +50, y + 50 );
    }
  }

  public boolean OnTile(float mousex, float mousey) {

    if ( mousex > x && mousex < x + wid && mousey > y && mousey < y + hei ) {
      shade = 255;
      return true;
    } else {
      shade = 0;
      return false;
    }
  }
}
  public void settings() {  size(600, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "GravyTest" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
