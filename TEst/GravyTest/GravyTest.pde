Tile[][] grid = new Tile[3][3];
Tile[] grid2 = new Tile[9];

ArrayList<Tile[]> queue = new ArrayList<Tile[]>();


void setup() { 
  size(600, 600);
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

Tile[] CloneTileArray(Tile[] inputGrid) {
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

void draw() {
  for (int i = 0; i < 9; i++)
    grid2[i].Display();
}

void mousePressed() {
  for (int i = 0; i < 9; ++i)
    if (grid2[i].OnTile(mouseX, mouseY))
      if (grid2[i].player == '.')
        grid2[i].player = 'X';
        
  println( minimax(grid2, -1)); 
  
 }

//computer = -1
//human = 1
//draw = 0
Integer GetWinner(Tile[] grid) {

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

int minimaxBetter(Tile[] grid, int plr) {
  
}


int minimax(Tile[] grid, int plr) {
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
