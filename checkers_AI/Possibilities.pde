ArrayList<String> generate_poss(int[][] board, int bw) {
  //println("Generating Possibilities!");
  int[][] attacks = {{-2, -2}, {2, 2}, {-2, 2}, {2, -2}};
  int[][] moves = {{-1, -1}, {1, 1}, {-1, 1}, {1, -1}};
  ArrayList<String> poss_attacks = all_poss(board, attacks, bw);
  if (poss_attacks.size() > 0) {
    poss_attacks = generate_attacks(board, poss_attacks, bw);
    //printPosses(poss_attacks);
    return poss_attacks;
  } else { //no possible attacks
    ArrayList<String> poss_moves = all_poss(board, moves, bw);
    return poss_moves;
  }
}

ArrayList<String> generate_attacks(int[][] current_board, ArrayList<String> currentList, int bw) {
  ArrayList<String> newList = new ArrayList<String>();

  //newList = all_poss(attacks);
  for (String poss : currentList) {
    String last_step = poss.substring(poss.length() - 4);
    int[] array = convertStringToArray(last_step);
    int[][] new_board = updateBoard(current_board, array[0], array[1], array[2], array[3]);
    ArrayList<String> newPosses = new_attacks(new_board, array[2], array[3], bw);
    //printArray(newPosses);
    if (newPosses.size() == 0) {
      newList.add(poss);
    } else {
      newPosses= generate_attacks(new_board, newPosses, bw);
      for (String newP : newPosses) {
        newList.add(poss + newP);
      }
    }
  }

  return newList;
}

void printPosses(ArrayList<String> posses) {
  println();
  println("All Possibilities (col, row) for " + (bw == 1 ? "white":"black") + ":" );
  //println(bw);
  for (int i = 0; i < posses.size(); i++) {
    String poss = posses.get(i);
    int[] array = convertStringToArray(poss);
    print("("+(i+1)+") (" + array[0] + "," + array[1] + ") --> (" + array[2] + "," + array[3] + ")");
    for (int j = 4; j < array.length; j += 4) {
      print(" --> (" + array[j+2] + "," + array[j+3] + ")");
    }
    println();
  }
  println();
}

int[] convertStringToArray(String str) {
  // System.out.println(str);
  int[] result = new int[str.length()];
  for (int i = 0; i < str.length(); i++) {
    result[i] = int(str.charAt(i))-48;
  }
  return result;
}
ArrayList<String> all_poss(int[][] board, int[][] jumps_to_attempt, int bw) { //returns i_from, j_from, i_to, j_to
  ArrayList<String> poss_total = new ArrayList<String>();

  //Checking For Possible Attacks    ADD IN KINGS  needs to see all moves!!
  for (int i = 1; i <= 8; i++) { //col
    for (int j = 1; j <= 8; j++) { //row
      if (board[i][j] != 0 && board[i][j]/abs(board[i][j]) == bw) { //checks if it's turn's piece
        for (int[] move : jumps_to_attempt) {
          if (validMove(board, i, j, i+move[0], j+move[1], bw)) {
            poss_total.add(""+i+j+(i+move[0])+(j+move[1]));
          }
        }
      }
    }
  }
  return poss_total;
}

ArrayList<String> new_attacks(int[][] board, int i, int j, int bw) { //find possible attacks for specific piece on specific board
  int[][] attacks = {{-2, -2}, {2, 2}, {-2, 2}, {2, -2}};
  ArrayList<String> poss_total = new ArrayList<String>();
  boolean isKing = abs(board[i][j]) == 2;
  if (!isKing) {
    attacks = new int[2][2];
    //Black: {2, 2} && {-2, 2} //down [row, col]
    //White: {2, -2} && {-2, -2} //up [row, col]
    attacks[0][0] = 2;
    attacks[0][1] = 2 * -bw;
    attacks[1][0] = -2;
    attacks[1][1] = 2 * -bw;
  }

  for (int[] move : attacks) {
    if (i + move[0] <= 8 && i + move[0] >= 1 && j + move[1] <= 8 && j + move[1] >= 1) {
      int[] jumped_piece = {(i + (i+move[0]))/2, (j+(j+move[1]))/2};
      if (board[jumped_piece[0]][jumped_piece[1]]* -bw > 0 && board[i+move[0]][j+move[1]] == 0) { //piece adjacent to you + jumping to empty tile
        poss_total.add(""+i+j+(i+move[0])+(j+move[1]));
      }
    }
  }
  return poss_total;
}

int[][] updateBoard(int[][] old_board, int i0, int j0, int i1, int j1) {
  //copying old board to new board
  int[][] new_board = copy_2d(old_board);

  new_board[i1][j1] = new_board[i0][j0];  //move piece
  new_board[i0][j0] = 0;  //remove original piece
  if (dist(i0, j0, i1, j1) > 2) { //if it's a jump
    new_board[(i0+i1)/2][(j1+j0)/2] = 0; //remove jumped piece
  }
  return new_board;
}


void printBoard(int[][] b) {
  for (int j = 1; j <= 8; j++) { //each row
    for (int i = 1; i <= 8; i++) {
      print(b[i][j] + " ");
    }
    println();
  }
}