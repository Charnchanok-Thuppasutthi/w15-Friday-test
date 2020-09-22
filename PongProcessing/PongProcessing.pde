Game pong;
void setup() {
  size(700, 500);
  background(0);
  pong = new Game();
}
void draw() {
  pong.start_game();
}



class Game {
  
  Ball ball = new Ball(width/2, height/2, 2);

  void start_game() {
    ball.move();
    if ( (ball.getterY() == height) && (ball.getterY() == 0) ) {
      ball.setter_spdY();
    }
  }
  
  void board() {
  }
  
  void moveracket() {
  }
  
}

class Ball {
  
  float x, y ; 
  float spd ;
  
  Ball(float x_position, float y_position, float speed) {
    x = x_position ;
    y = y_position ;
    spd = speed ;
  }
  
  void move() {
    fill(255);
    x += spd;
    circle(x, y, 80 );
  }
  
  float getterX() {
    return x ;
  }
  
  float getterY() {
    return y ;
  }
  
  void setter_spdY() {
    spd *= -1 ;
  }
  
  void print_xy() {
    println(getterY());
    println(getterX());
  }
  
}

class Player {
  
  int score ; 
  
  Player() {
  }
  
}
