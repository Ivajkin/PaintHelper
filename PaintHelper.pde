/*
  void shuffleArray(int[] a) {
    int n = a.length;
    Random random = new Random();
    random.nextInt();
    for (int i = 0; i < n; i++) {
      int change = i + random.nextInt(n - i);
      swap(a, i, change);
    }
  }

  void swap(int[] a, int i, int change) {
    int helper = a[i];
    a[i] = a[change];
    a[change] = helper;
  }


PImage bg;

void setup() {
  size(715,1000);
  fill(0);
  bg = requestImage("photo.jpg");
  
  
  
  
  for(int i = 0; i < combinationsCount*combinationsCount; ++i) {
    int mask1 = i%combinationsCount,
        mask2 = (i-mask1)/combinationsCount;
  }
  shuffleArray(mask_order);
}

final int partitionDepth = 4;
final long yCount = Math.round(Math.pow(2,Math.floor(partitionDepth/2.0)));
final long xCount =  Math.round(yCount*Math.pow(2,partitionDepth%2));
final int combinationsCount = (int)Math.round(Math.pow(2,xCount*yCount));

void hideSquare(int i, boolean secondScreen) {
  float squareWidth = bg.width/xCount;
  float squareHeight = bg.height/yCount;
  long xi = i%xCount;
  long yi = (i-xi)/yCount;
  rect(xi*squareWidth, yi*squareHeight + (secondScreen?bg.height:0), squareWidth, squareHeight);
  
  //println(xi*squareWidth + "," + yi*squareHeight);
}
void hideMask(long mask1, boolean secondScreen) {
  
  for(int i = 0; i < xCount*yCount; ++i) {
    //println("i: " + i + " 1 << i:" + (1 << i));
    if((mask1 & (1 << i)) != 0)
     hideSquare(i,secondScreen);
  }
}
void drawPart(long mask1, long mask2) {
  float scaleY = height/2.0/bg.height;
  scale(scaleY);
  image(bg,0,0);
  image(bg,0,bg.height);
  hideMask(mask1, false);
  hideMask(mask2, true);
  scale(1.0/scaleY);
}

int iteration = 0;
int[] mask_scores = new int[combinationsCount];
int[][] mask_order = new int[][combinationsCount];

void draw() {
  background(0, 0, 0);
  if(iteration < combinationsCount) {
    
    int mask1 = mask_order[iteration]%combinationsCount,
        mask2 = mask_order[(iteration-mask1)/combinationsCount];
    drawPart(mask2,mask1);
    
    ++iteration;
  }
}*/

PImage bg;

final int xCount = 4;
final int yCount = 3;
float squareWidth;
float squareHeight;

int[][] score; 

void setup() {
  size(1600,1000);
  fill(0);
  bg = loadImage("photo.JPG");
  squareWidth = bg.width/(float)xCount;
  squareHeight = bg.height/(float)yCount;
  
  score = new int[xCount][];
  for(int i = 0; i < xCount; ++i) {
    score[i] = new int[yCount];
    for(int j = 0; j < yCount; ++j) {
      score[i][j] = 0; 
    }
  }
}

  
void showSquare(int i, int j, boolean secondScreen) {
  float sx = i*squareWidth,
      sy = j*squareHeight,
      sw = squareWidth,
      sh = squareHeight,
      dx = 0,
      dy = 0,
      dw = squareWidth*height/squareHeight/2,
      dh = height/2;
  copy(bg, Math.round(sx), Math.round(sy), Math.round(sw), Math.round(sh), Math.round(dx), Math.round(dy)+(secondScreen?height/2:0), Math.round(dw), Math.round(dh));
  //copy(bg, 0, 0, 100, 100, 0, 0, 100, 100);
}

int iteration1 = 1,
    iteration2 = 0,
    
    i1,j1,i2,j2; 
void draw() {
  background(0, 0, 0);
  i1 = iteration1%xCount;
  j1 = (iteration1 - i1)/xCount;
  i2 = iteration2%xCount;
  j2 = (iteration2 - i2)/xCount;
  //println("i: " + i1 + ", j: " + j1);
  //println("i: " + i2 + ", j: " + j2);
  showSquare(i1,j1,false);
  showSquare(i2,j2,true);
  
  
    if(iteration2 >= xCount*yCount) {
      for(int j = 0; j < yCount; ++j) {
        for(int i = 0; i < xCount; ++i) {
          print("(" + i + ", " + j + ") score: " + score[i][j] + " |    ");
        }
        println();
      }
        println();
        println();
        println();
    }
}

void mousePressed() {
  
    if(iteration2 >= xCount*yCount) return;
    
    ++iteration1;
    if(iteration1 >= xCount*yCount) {
      iteration1 = 0;
      ++iteration2;
    }
    
    if(mouseY < height/2) {
      ++score[i1][j1];
    } else {
      ++score[i2][j2];
    }
    
    if(iteration1 == iteration2) mousePressed();
}


