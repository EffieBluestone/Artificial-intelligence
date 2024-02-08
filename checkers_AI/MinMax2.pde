int maxDepth = 8;

String minmax(int[][] board, int bw) {
  ArrayList<String> first_move = generate_poss(board, bw); 
  if(first_move.size() == 1){
    return first_move.get(0);
  }
  IntString min_value = min_value(board, bw, 0);
  //println("Value: " + min_value.getInt());
  //println("Move: " + min_value.getString());
  return min_value.getString();
}

IntString max_value(int[][] board, int bw, int depth) {
  if (depth > maxDepth) {
    return new IntString(eval(board), null); 
  }
  
  int max = Integer.MIN_VALUE;
  String best_move = "";
  
  ArrayList<String> all_p = generate_poss(board, bw);
  int cnt = 0;
  
  
  for (String poss : all_p) {
    int[][] new_board = copy_2d(board);
    for (int i = 0; i < poss.length(); i += 4) {
      String step_i = poss.substring(i, i+4); 
      int[] array = convertStringToArray(step_i);
      new_board = updateBoard(new_board, array[0], array[1], array[2], array[3]);
    }
    IntString val = min_value(new_board, bw*-1, depth+1);
    int intVal = val.getInt();
    //String strVal = val.getString();
    if (intVal > max) {
       max = intVal;
       best_move = poss;
    }
    cnt++;
  }
  return new IntString(max, best_move);
}

IntString min_value(int[][] board, int bw, int depth) {
  if (depth > maxDepth) {
    return new IntString(eval(board), null); 
  }
  
  
  int min = Integer.MAX_VALUE;
  String best_move = "";
  
  ArrayList<String> all_p = generate_poss(board, bw);
  int cnt = 0;
  
  for (String poss : all_p) {
    int[][] new_board = copy_2d(board);
    for (int i = 0; i < poss.length(); i += 4) {
      String step_i = poss.substring(i, i+4); 
      int[] array = convertStringToArray(step_i);
      new_board = updateBoard(new_board, array[0], array[1], array[2], array[3]);
    }
    IntString val = max_value(new_board, bw*-1, depth+1);
    int intVal = val.getInt();
    //String strVal = val.getString();
    if (intVal < min) {
       min = intVal;
       best_move = poss;
    }
    cnt++;
  }
  return new IntString(min, best_move);
}

int eval(int[][] board) {
  int total = 0;
  for (int i = 1; i <= 8; i++) {
    for (int j = 1; j <= 8; j++) {
      total += board[i][j];
    }
  }
  return total; //more white if > 0; more black if < 0
}

int[][] copy_2d(int[][] matrix) {
  int[][] n = new int[matrix.length][matrix[0].length];
  for (int i = 0; i < n.length; i++) {
    for (int j = 0; j < n[i].length; j++) {
      n[i][j] = matrix[i][j];
    }
  }
  return n;
}