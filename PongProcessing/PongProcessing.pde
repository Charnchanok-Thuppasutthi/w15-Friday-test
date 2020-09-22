Game pong;
void setup() {
  size(700, 500);
  background(0);
  pong = new Game();
}
void draw() {
  pong.update_game();
  pong.board();
}



class Game {
  Player left_player = new Player( 0, height/2-(height/8) );
  Player right_player = new Player( width-(width/13), height/2-(height/8) );

  Ball ball = new Ball(width/2, height/2, random(-3, 3), random(-3, 3));

  void start_game() {
  }

  void update_game() { 
    ball.move();
    //ball.print_xy();
    if ( (ball.getterX() < 0) || (ball.getterX() > width) ) {
      ball.setter_spdX();
      println("stuck1");
    }

    if ( (ball.getterY() < 0) || (ball.getterY() > height) ) {
      ball.setter_spdY();
      println("stuck2");
    }

    left_player.draw_racket();
    right_player.draw_racket();
  }

  void board() {
    fill(255);
    rect(width/2, 0, -10, height);
    rect(width/2, 0, 10, height);
  }

  void moveracket() {
  }
}

class Ball {

  float x, y ; 
  float spdX,spdY ;

  Ball(float x_position, float y_position, float speedX, float speedY) {
    x = x_position ;
    y = y_position ;
    spdX = speedX ;
    spdY = speedY ;
  }

  void move() {
    background(0);
    fill(255);
    x += spdX ;
    y += spdY ;
    circle(x, y, 80 );
  }

  float getterX() {
    return x ;
  }

  float getterY() {
    return y ;
  }

  void setter_spdX() {
    spdX *= -1 ;
  }
  void setter_spdY() {
    spdY *= -1 ;
  }

  void print_xy() {
    println(getterY());
    println(getterX());
  }
}

class Player {

  int score ;
  float x, y ;

  Player(float x_position, float y_position) {
    x = x_position ;
    y = y_position ;
  }
  void draw_racket() {
    fill(255);
    rect(x, y, 50, 100);
  }
}
