//int maximizingPlayer;
//boolean gameStatusisOver;
//int depth, bestMoveVal, depthReached;
//boolean outOfTime = false;
//int mDepth=5; 
//String bestMove;
//long startTime, currentTime;
//String move; 
//int BP, WP;
//int d=0; 



//import java.util.Date;
//import java.util.Random;

////time constarints
//// Date date = new Date();
//// startTime = date.getTime();
//// if ((currentTime - startTime) >= timeLimit * 990) {
////            outOfTime = true;
////            return 0;
////        }
////if (outOfTime) break;

//// list of moves 

//boolean cutoffTest(int numMoves, int depth) {
//  if (numMoves == 0 || depth == mDepth) {
//    return true;
//  }
//  return false;
//} 

//String alphaBetaSearch(int [][] board) {
//  d=0;
//  //get time stuff in 

//  //declaration
//  bestMoveVal = 0; 
//  depthReached = 0 ;
//  bestMove = "NULL"; 
//  Random rand = new Random();

//  ArrayList<String> listBestMovesCurrentDepth; //for best moves 
//  ArrayList<String> legalMovesList = generate_poss(board); //FIX!!!!!
//  // print(legalMovesList.get(1));
//  //edge case of only one move available 
//  if (legalMovesList.size() == 1) {
//    System.out.println("Searched to depth 0 in 0 seconds.");
//    return legalMovesList.get(0);
//  }

//  //for (int maxDepth = 0; maxDepth < 2 && !outOfTime; maxDepth++) {
//    //check for end of game
//    listBestMovesCurrentDepth = new ArrayList<String>();
//    //listBestMovesCurrentDepth = new ArrayList<String>();
//    int bestVal = Integer.MAX_VALUE;

//    for (String a : legalMovesList) {
//      // System.out.println(all_posses);
//      // copy over the board / game
//      // apply all moves to the board copy
//      int[][] new_board = board;
//      for (int i = 0; i < a.length(); i += 4) {
//        String step_i = a.substring(i, i+4); 
//        int[] array = convertStringToArray(step_i);
//        new_board = updateBoard(new_board, array[0], array[1], array[2], array[3]);
//      }
//      int min = MinValue(new_board, Integer.MIN_VALUE, Integer.MAX_VALUE, false, 0);

//      if (outOfTime) {
//        print("broke the loop");
//        break;
//      }

//      if (min == bestVal) {
//        //        println("we adding a move!");
//        //        print("here is the move"+a);
//        listBestMovesCurrentDepth.add(a);
//      }
//      if (min < bestVal) {
//        //  print("we adding a move!");
//        listBestMovesCurrentDepth.clear();
//        listBestMovesCurrentDepth.add(a);
//        bestVal = min;
//      }
//      if (bestVal == Integer.MAX_VALUE) {
//        break;
//      }
//    }
//    // legalMovesList = all_poss(board); // of current board

//    if (!outOfTime) {
//      print("no more time");
//      int chosenMove = rand.nextInt(listBestMovesCurrentDepth.size()); 
//      //   println("here is the chosen move" + chosenMove);
//      //  println("the BEST move " + listBestMovesCurrentDepth.get(0));
//      bestMove = listBestMovesCurrentDepth.get(chosenMove); //listBestMoves is empty!!!
//     // depthReached = maxDepth;
//      bestMoveVal = bestVal;
//    }

//    //if (bestMoveVal == Integer.MAX_VALUE){
//    //  break;
//    //}
//  //}
//  // System.out.println("Best move value " + bestMoveVal);
//  System.out.println("Searched to depth " + depthReached + " in " + ((currentTime-startTime)/1000) + " seconds.");
//  //   println("here"+bestMove);

//  return bestMove; //this was null
//}

//int MaxValue(int[][] bo, int alpha, int beta, boolean isMaximizing, int depth) {
//  //legal moves
//  ArrayList<String> listLegalMoves = generate_poss(bo);
//  if (cutoffTest(listLegalMoves.size(), depth)) {
//    return evalFcn(bo, isMaximizing);
//  }
//  int v = Integer.MIN_VALUE;

//  if (cutoffTest(listLegalMoves.size(), depth)) {
//    print("just eval for max" );
//    return evalFcn(bo, isMaximizing);
//  }
//  //for each subgame of game   - child of position
//  for (String a : listLegalMoves) {
//    // copy over the board / game
//    // apply all moves to the board copy
//    int[][] new_board = bo;
//    for (int i = 0; i < a.length(); i += 4) {
//      String step_i = a.substring(i, i+4); 
//      int[] array = convertStringToArray(step_i);
//      new_board = updateBoard(new_board, array[0], array[1], array[2], array[3]);
//    }
//    v = Math.max(v, MinValue(new_board, alpha, beta, isMaximizing, depth + 1));

//    if (v >= beta) {
//      return v;
//    }
//    alpha = Math.max(alpha, v);
//  }
//  return v;
//}

//int MinValue(int[][] boa, int alpha, int beta, boolean isMaximizing, int depth) {
//  ArrayList<String> listLegalMoves = generate_poss(boa);
//  //  List<Move> listLegalMoves = bo.getLegalMoves(game.board);
//  if (cutoffTest(listLegalMoves.size(), depth)) {
//    //print("took " + depth + " calls" + " to access");
//    return evalFcn(boa, isMaximizing);
//  }
//  int v = Integer.MAX_VALUE;

//  for (String a : listLegalMoves) {
//    // copy over the board / game
//    // apply all moves to the board copy
//    int[][] new_board = boa;
//    for (int i = 0; i < a.length(); i += 4) {
//      String step_i = a.substring(i, i+4); 
//      int[] array = convertStringToArray(step_i);
//      new_board = updateBoard(new_board, array[0], array[1], array[2], array[3]);
//    }
//    v = Math.min(v, MaxValue(new_board, alpha, beta, true, depth + 1));
//    if (v <= alpha) {
//      return v;
//    }
//    beta = Math.min(beta, v);
//  }
//  return v;
//}

//int evalFcn(int[][] b, boolean isMaximizing) {
//  WP = BP = 0;
//  //put the heuersitics in here 
//  // peices minus peicesO
//  for (int i=1; i<=8; i++) {
//    for (int j=1; j<=8; j++) {

//      if (b[j][i] >= 1) {  //white piece
//        WP++;
//      }
//      if (b[j][i]<=-1) {  //black piece
//        BP++;
//      }
//    }
//  }
//  //print(BP + "is BP");
//  //print(WP + "is WP");
////  return WP - BP;
//  if (isMaximizing) {
//    //println("TRUE value returning is?" + int(BP - WP) );
//    return int(BP - WP);
//  } else {
//    // println("FALSE value returning is?" + int(WP-BP) );
//    return (WP-BP);
//  }
//}