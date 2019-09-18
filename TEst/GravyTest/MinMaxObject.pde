public class MinMax {
 private Tile[] board;
 private int player;
 // -1 = player
 public MinMax(Tile[] _board, int _player) {
   board = _board;
   player = _player;
 }
 public int GetPlayer() {
   return player;
 }
 public Tile[] GetBoard() {
  return CloneTileArray(board); 
 }
  
}
