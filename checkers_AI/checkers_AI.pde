//load extra baord //<>// //<>// //<>//
int[][] myArray = {  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, //<>// //<>//
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
};         
int turn, N1, N2, N3, N4;
int time;
int row;



int x0, y0, x1, y1;
int board[][] = new int[10][10];
int bw;
boolean setPos;
boolean mustJump;
boolean multiJump;
int jpos[] = new int[2];
int side;
int numW, numB;
int player1, player2;
int x=1;
int y=1;
ArrayList<String> all_posses;
int compVal = -1; //1 if computer is white, -1 if black

void setup() { //<>// //<>//
  long startTime = System.currentTimeMillis();


  size(600, 400);
  noStroke();
  side=height/8;
  System.out.println("player1 is comp or Human? (hit the Key q/a) ");

  System.out.println("player2 is comp or Human? (hit the Key p/l) ");

  text("BACK", 9*side, 4*side);

  startPosition();
  //inputPos();

  showBoard();

  long endTime = System.currentTimeMillis();

  System.out.println("That took " + (endTime - startTime) + " milliseconds");

  all_posses = generate_poss(board, bw); // out of bound after game ends
  printPosses(all_posses);
}

void draw() {
  // if (bw == compVal) {
  //delay(500);
  //String move = choose_move();
  // computer_move(move);
  //showBoard();
  //println("d after" + d);
  //all_posses = generate_poss(board);
  // }


  if (finish()) {
    fill(255, 0, 0);
    textSize(1.0*side);
    textAlign(CENTER);
    if (bw==-1) {
      text("White win", width/2, height/2);
    } else if (bw==1) {
      text("Black win", width/2, height/2);
    }
  } else {
   // if (bw == compVal) {
      //  delay(100);
      String move = choose_move();
      computer_move(move);
      showBoard();
      all_posses = generate_poss(board, bw);
      printPosses(all_posses);
    //}
  }
}

void mousePressed() {
  // if (bw != compVal) {
  man();
  // }
}
void keyPressed() {
  if (key=='r') {
    //startPosition();
    inputPos();
    showBoard();
  }
  if (x!=0) {
    if (key == 'q') {
      player1 = 1; // computer
      System.out.println("player1: "  + player1);
      x=0;
    }
    if (key == 'a') {
      player1 = 0; //human
      System.out.println("player1: "  + player1);
      x=0;
    }
  }
  if (y!=0 ) {
    if (key == 'p') {
      player2 = 1; //computer
      System.out.println("player2: "  + player2);
      y=0;
    }

    if (key == 'l') {
      player2 = 0; //human
      System.out.println("player2: "  + player2);
      y=0;
    }
  }

  //if (key == ' ') {
  //  generate_poss(board);
  //}
}

void man() {
  x1 = floor(mouseX/side +1);
  y1 = floor(mouseY/side +1);

  if (x0 + y0  == 0) { //this is first press
    x0 = x1;
    y0 = y1;
    showBoard();
  } else { //press 2
    String attempted_move = ""+x1+y1;
    boolean made_a_move = false;
    boolean is_multi_jump = false;
    for (String p : all_posses) {
      if (p.indexOf(attempted_move) == 2 && p.indexOf(""+x0+y0) == 0) { //this is a valid next move
        movePiece(x0, y0, x1, y1);
        made_a_move = true;
        if (p.length() > 4) {
          is_multi_jump = true;
        }
        break;
      }
    }
    if (made_a_move) {
      if (!is_multi_jump) {
        bw = -bw;
        x0 = 0;
        y0 = 0;
      } else {
        x0 = x1;
        y0 = y1;
      }
      all_posses = generate_poss(board, bw);
      printPosses(all_posses);
    } else {
      x0 = 0;
      y0 = 0;
    }
    x1 = 0;
    y1 = 0;
    showBoard();
  }
}


void showMoves(int C) {
  // for
  if (C == 1) {
    for (int i=1; i<=9; i++) {
      for (int j=1; j<=9; j++) {
        //check peices;
        if ( board[i][j] == 1 || board[i][j] == -1 ||board[i][j] == 2 || board[i][j] == -2 ) {
          //check all moves
          if ( validMove(board, i, j, i-1, j-1, bw) || validMove(board, i, j, i+1, j-1, bw) || validMove(board, i, j, i+1, j+1, bw)|| validMove(board, i, j, i-1, j+1, bw)) {
          }
        }
      }
    }
  }
  //for black
  if (C == 2) {
    for (int i=1; i<=9; i++) {
      for (int j=1; j<=9; j++) {
        //check peices;
        if ( board[i][j] == 1 || board[i][j] == -1 ||board[i][j] == 2 || board[i][j] == -2 ) {
          //check all moves
          if ( validMove(board, i, j, i-1, j-1, bw) || validMove(board, i, j, i+1, j-1, bw) || validMove(board, i, j, i+1, j+1, bw)|| validMove(board, i, j, i-1, j+1, bw)) {
          }
        }
      }
    }
  }
}

void startPosition() {
  x0=y0=x1=y1=0;
  bw=1;
  mustJump = multiJump = false;
  jpos[0] = jpos[1] = 0;

  for (int i=0; i<=9; i++) {
    for (int j=0; j<=9; j++) {
      if (i==0||j==0||i==9||j==9) {
        board[i][j]=3;
      } else if (6<=j && (i+j)%2==1) {
        board[i][j]=1;
      }  //white peice
      else if (j<=3 && (i+j)%2==1) {
        board[i][j]=-1;
      }  //black peice
      else {
        board[i][j]=0;
      }
    }
  }
}

void inputPos() {
  x0=y0=x1=y1=0;
  bw=1;
  mustJump = multiJump = false;
  jpos[0] = jpos[1] = 0;

  //board[4][2] = -1;
  //// board[2][2] = -1;
  //board[6][2] = -1;
  //board[6][4] = -1;
  //board[7][5] = 1;
  // for (int i=0; i<=9; i++){
  // for (int j=0; j<=9; j++) {
  // if (i==0||j==0||i==9||j==9) {board[i][j]=3;}
  //else if (6<=j && (i+j)%2==1){board[i][j]=1;}
  // else if (j<=3 && (i+j)%2==1){board[i][j]=-1;}
  // {board[i][j]=0;}


  String[] lines = loadStrings("C7.txt");

  for ( int i =0; i < 9; i++) {
    lines[i] = lines[i].replace(" ", "");
  }
  println(int(lines[1]));

  turn = int(lines[8]) ; 
  print(" turn is " + turn); 
  time = int(lines[9]) ; 
  println(" time limit" + time); 

  for (int j = 1; j < 9; j+=2) {
    if (j==10) {
      print("j is ten!!");
    }
    row = int(lines[j]);
    N1 = row/1000;
    N2 = (row/100) % 10;
    N3 = (row/10)%10;
    N4 = (row) % 10; 
    //N1
    if (N1 == 4) {
      N1 = -2;
    } else if (N1 == 3) {
      N1 = 2;
    } else if (N1 == 2) {
      N1 = -1;
    }
    // N2
    if (N2 == 4) {
      N2 = -2;
    } else if (N2 == 3) {
      N2 = 2;
    } else if (N2 == 2) {
      N2 = -1;
    }
    // N3
    if (N3 == 4) {
      N3 = -2;
    } else if (N3 == 3) {
      N3 = 2;
    } else if (N3 == 2) {
      N3 = -1;
    }
    //N4
    if (N4 == 4) {
      N4 = -2;
    } else if (N4 == 3) {
      N4 = 2;
    } else  if (N4 == 2) {
      N4 = -1;
    }
    print(" num1: " + N1);
    myArray[1][j+1] = N1; 
    print(" num2: " + N2);
    myArray[3][j+1] = N2; 
    print(" num3: " + N3) ;
    myArray[5][j+1] = N3; 
    println(" num4: " + N4);
    myArray[7][j+1] = N4;
  }

  for (int j = 0; j < 9; j+=2) {
    if (j==10) {
      print("j is ten!!");
    }
    row = int(lines[j]);
    N1 = row/1000;
    N2 = (row/100) % 10;
    N3 = (row/10)%10;
    N4 = (row) % 10; 
    if (N1 == 4) {
      N1 = -2;
    } else if (N1 == 3) {
      N1 = 2;
    } else if (N1 == 2) {
      N1 = -1;
    }
    // N2
    if (N2 == 4) {
      N2 = -2;
    } else if (N2 == 3) {
      N2 = 2;
    } else if (N2 == 2) {
      N2 = -1;
    }
    // N3
    if (N3 == 4) {
      N3 = -2;
    } else if (N3 == 3) {
      N3 = 2;
    } else if (N3 == 2) {
      N3 = -1;
    }
    //N4
    if (N4 == 4) {
      N4 = -2;
    } else if (N4 == 3) {
      N4 = 2;
    } else if (N4 == 2) {
      N4 = -1;
    }
    print(" num1: " + N1);
    myArray[2][j+1] = N1; 
    print(" num2: " + N2);
    myArray[4][j+1] = N2; 
    print(" num3: " + N3) ;
    myArray[6][j+1] = N3; 
    println(" num4: " + N4);
    myArray[8][j+1] = N4;
  }

  for (int i = 0; i < 9; i++) {
    for ( int j = 0; j < 9; j++) {
      print(myArray[i][j]);
      //board[8][8] = 0;
      board[i][j] = myArray[i][j];
      if (j==8) {
        println();
      }
    }
    //  board[8][8] = 0;
  }
  println();
  for (int i = 0; i < 9; i++) {
    for ( int j = 0; j < 9; j++) {
      print(board[i][j]);
    }
    println();
  }
  println("turn is " + turn);
  println("time limit is" + time);
}




void showBoard() {

  background(230, 170, 120);
  noStroke();
  rectMode(CORNER);
  for (int i=1; i<=8; i++) {
    for (int j=1; j<=8; j++) {
      if ((i+j)%2 == 0) fill(240, 190, 150);
      else {
        fill(210, 130, 70);
      }
      rect((i-1)*side, (j-1)*side, side, side);
    }
  }

  numW=numB=0;
  for (int i=1; i<=8; i++) {
    for (int j=1; j<=8; j++) {

      if (board[i][j]>=1) {  //white piece
        noStroke();
        fill(255);
        ellipse(i*side -side/2, j*side -side/2, 0.9*side, 0.9*side);
        numW++;
        if (board[i][j]==2) {  //king
          fill(0);
          noStroke();
          ellipse(i*side -side/2, j*side -side/2, side/2, side/2);
        }
      } else if (board[i][j]<=-1) {  //black piece
        noStroke();
        fill(0);
        ellipse(i*side -side/2, j*side -side/2, 0.9*side, 0.9*side);
        numB++;
        if (board[i][j]==-2) {  //king
          fill(255);
          ellipse(i*side -side/2, j*side -side/2, side/2, side/2);
        }
      }

      if (i==x0 && j==y0 && board[i][j]!=0) {
        fill(255, 0, 0, 100);
        rect((i-1)*side, (j-1)*side, side, side);
      }
    }
  }

  if (all_posses != null) { //displaying little circles for poss moves
    for (String poss : all_posses) {
      int[] array = convertStringToArray(poss);
      if (x0 == array[0] && y0 == array[1]) {
        for (int j = 0; j < poss.length(); j += 4) {
          //int[] array = convertStringToArray(poss.substring(j, j+4));
          if (bw==-1) {
            fill(0, 0, 0, 200);
          } else if (bw==1) {
            fill(255, 255, 255, 200);
          }
          ellipse((array[j+2]-1)*side +side/2, (array[j+3]-1)*side +side/2, side/3, side/3);
        }
      }
    }
  }
}


boolean validMove(int[][] board, int i0, int j0, int i1, int j1, int bw) {
  if (i0<1||8<i0 || j0<1||8<j0 || i1<1||8<i1 || j1<1||8<j1) {
    return false;
  }
  if (board[i0][j0]==0 || board[i1][j1]!=0) {
    return false;
  }
  //if (multiJump && (i0!=jpos[0] || j0!=jpos[1])) {
  //  println("hereB");
  //  return false;
  //}
  //if (mustJump && (abs(i1-i0)!=2 || abs(j1-j0)!=2)) {
  //  println("hereC");
  //  return false;
  //}

  if (board[i0][j0] == bw) {  //pawn
    //println(i0, j0, i1, j1);
    if (abs(i1-i0)==1 && j1-j0==-bw && board[i1][j1]==0) {
      return true;
    }

    if (abs(i1-i0)==2 && j1-j0==-2*bw && board[i1][j1]==0 &&
      (board[int((i0+i1)/2)][j0-bw]==-bw || board[int((i0+i1)/2)][j0-bw]==-2*bw)) {
      return true;
    }
  } else if (board[i0][j0] == 2*bw) {  //king
    if (abs(i1-i0)==1 && abs(j1-j0)==1 && board[i1][j1]==0) {
      return true;
    }

    if (abs(i1-i0)==2 && abs(j1-j0)==2 && board[i1][j1]==0 &&
      (board[int((i0+i1)/2)][int((j0+j1)/2)]==-bw || board[int((i0+i1)/2)][int((j0+j1)/2)]==-2*bw)) {
      return true;
    }
  }

  return false;
}


void movePiece(int i0, int j0, int i1, int j1) {
  boolean promote = false;
  mustJump = false;
  multiJump = false;

  //promote
  if ((board[i0][j0]==1 && j1==1) || (board[i0][j0]==-1 && j1==8)) {
    board[i0][j0] = 2*bw;
    promote = true;
  }

  board[i1][j1] = board[i0][j0];  //move piece
  board[i0][j0] = 0;  //remove original piece


  if (abs(i0-i1)==2 && abs(j0-j1)==2) {
    board[(i0+i1)/2][(j0+j1)/2] = 0;
    jpos[0]=i1;
    jpos[1]=j1;

    if (abs(board[i1][j1]) == 2) {
      if (validMove(board, i1, j1, i1+2, j1+2, bw) || validMove(board, i1, j1, i1+2, j1-2, bw) ||
        validMove(board, i1, j1, i1-2, j1+2, bw) || validMove(board, i1, j1, i1-2, j1-2, bw)) {
        multiJump = true;
      }
    } else {
      if (validMove(board, i1, j1, i1+2, j1-2, bw) || validMove(board, i1, j1, i1-2, j1-2, bw)) {
        multiJump = true;
      }
    }
  }


  if (multiJump==false) {
    bw = -bw;
  }
  for (int k=1; k<=8; k++) {
    for (int l=1; l<=8; l++) {
      if (validMove(board, k, l, k+2, l+2, bw)) {
        mustJump = true;
      }
      if (validMove(board, k, l, k+2, l-2, bw)) {
        mustJump = true;
      }
      if (validMove(board, k, l, k-2, l+2, bw)) {
        mustJump = true;
      }
      if (validMove(board, k, l, k-2, l-2, bw)) {
        mustJump = true;
      }
    }
  }
  if (multiJump==false) {
    bw = -bw;
  }
}


boolean finish() {
  for (int k=1; k<=8; k++) {
    for (int l=1; l<=8; l++) {
      if (board[k][l]!=0) {
        if (validMove(board, k, l, k+1, l+1, bw)) {
          return false;
        }
        if (validMove(board, k, l, k+1, l-1, bw)) {
          return false;
        }
        if (validMove(board, k, l, k-1, l+1, bw)) {
          return false;
        }
        if (validMove(board, k, l, k-1, l-1, bw)) {
          return false;
        }
        if (validMove(board, k, l, k+2, l+2, bw)) {
          return false;
        }
        if (validMove(board, k, l, k+2, l-2, bw)) {
          return false;
        }
        if (validMove(board, k, l, k-2, l+2, bw)) {
          return false;
        }
        if (validMove(board, k, l, k-2, l-2, bw)) {
          return false;
        }
      }
    }
  }
  return true;
}