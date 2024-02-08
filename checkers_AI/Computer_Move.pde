String choose_move() { //<>//
  //add statement before if gameNotOver = true 
  return minmax(board, bw);
  //return all_posses.get((int) random(0, all_posses.size())); // gets error at end of game
}

void computer_move(String move) { //[(from) (to)], [(from) (to)]
  //println(move);
  minmax(board, bw);
  int[] arr = convertStringToArray(move);
  if (move.length() == 4) {
    movePiece(arr[0], arr[1], arr[2], arr[3]);
  } else { //multi jump
    //println("here");
    int i = 0;
    while (i < move.length()) {
      movePiece(arr[i], arr[i+1], arr[i+2], arr[i+3]);
      i += 4;
    }
  }  
  bw *= -1;
 // println(eval(board));
}