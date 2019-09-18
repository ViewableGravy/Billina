Tile[] grid2 = new Tile[9];

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

void draw() {
  for (int i = 0; i < 9; i++)
    grid2[i].Display();
}

void mousePressed() {
  for (int i = 0; i < 9; ++i)
    if (grid2[i].OnTile(mouseX, mouseY))
      if (grid2[i].player == '.')
        grid2[i].player = 'X';

  Tile[][] newBoards = NewGrids(grid2, -1); //-1 for computer
  //creates the correct new boards

  int highest = 0;
  Tile[] move = grid2;
  int score;

  for (int i = 0; i < newBoards.length; i++) {
    score = minimaxBetter(newBoards[i]);
    if (i == 0)
      highest = score;
    else if (score > highest) {
      highest = score;
      move = newBoards[i];
    }
  }
  println(highest);
  for (Tile tile : move) {
    println(tile.player);
  }
  grid2 = move;
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
    if (grid[i].player =='.')
      remaining++;
  if (remaining==0)
    return 0; 
  return null;
}


int minimaxBetter(Tile[] grid) {
  Stack<MinMax> stack = new Stack<MinMax>();
  int Score = 0;
  stack.push(new MinMax(CloneTileArray(grid), -1)); //1 for human
  while (stack.size() > 0) {
    MinMax current = stack.pop(); 

    Integer winner = GetWinner(current.board);
    if (winner != null) {
      Score += winner;
    } else {
      Tile[][] newBoards = NewGrids(current.board, current.player); //-1 for computer
      //creates the correct new boards

      for (Tile[] Board : newBoards) {
        stack.push(new MinMax(Board, current.player * -1)); //swap
      }
    }
  }
  return Score;
}


Tile[][] NewGrids(Tile[] grid_New, int plr) {
  ArrayList<Tile[]> newArrays = new ArrayList<Tile[]>(); 
  for (int i = 0; i < grid_New.length; i++) {
    if (grid_New[i].player == '.') {
      Tile[] temp = CloneTileArray(grid_New); 
      if (plr == 1)
        temp[i].player = 'X';
      else
        temp[i].player = 'O';
      newArrays.add(temp);
    }
  }
  Tile[][] temp = new Tile[newArrays.size()][9];
  for (int i = 0; i < newArrays.size(); i++) {
    temp[i] = newArrays.get(i);
  }
  return temp;
}

Tile[] CloneTileArray(Tile[] inputGrid) {
  Tile[] test = new Tile[inputGrid.length];
  for (int i = 0; i < test.length; i++) {
    try {
      test[i] = (Tile)inputGrid[i].clone();
    }
    catch(Exception e) {
    }
  }
  return test;
}
