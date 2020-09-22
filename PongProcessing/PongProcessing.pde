
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
  Player right_player = new Player( width-(width/14), height/2-(height/8) );

  Ball ball = new Ball(width/2, height/2);

  void start_game() {
    ball.setter_X();
    ball.setter_Y();
    ball.move();
  }

  void update_game() { 
    ball.move();
    
    left_player.draw_racket();
    right_player.draw_racket();
    
    if ( (ball.getterX() == left_player.getterX() ) || (ball.getterX() == right_player.getterX() ) ) {
      moveracket();
      ball.setter_spdX();
    }


    if ( (ball.getterX()- ball.getter_size()/2 < -100) || (ball.getterX()+ ball.getter_size()/2  > width+100) ) {
      if ( (ball.getterX()<width/2 ) ) {
        left_player.setter_score();
        start_game();
      }
      if ( (ball.getterX() > width/2 ) ) {
        right_player.setter_score();
        start_game();
      }
    }


    if ( (ball.getterY()- ball.getter_size()/2  < 0) || (ball.getterY()+ ball.getter_size()/2  > height) ) {
      ball.setter_spdY();
      println("stuck2");
    }

  }

  void board() {
    fill(255);
    rect(width/2, 0, -10, height);
    rect(width/2, 0, 10, height);
    textSize(70);

    text( left_player.getter_score(), width/10, height/5 );
    text( right_player.getter_score(), width - (width/5), height/5 );
  }

  void moveracket() {
    if ( mousePressed == true ) {
      if (mouseX<width/2) {
        println("1");
        left_player.setterY();
        left_player.draw_racket();
      }
      if (mouseX<width/2) {
        println("2");
        right_player.setterY();
        right_player.draw_racket();
      }
    }
  }
}

class Ball {

  float x, y ; 
  float spdX = 2 ;
  float spdY = 2 ;
  float directionX = random(-1, 1);
  float directionY = random(-1, 1);
  int size = 80 ;

  Ball(float x_position, float y_position) {
    x = x_position ;
    y = y_position ;
  }

  void move() {
    background(0);
    fill(255);
    x += spdX*directionX ;
    y += spdY*directionY ;
    circle(x, y, size );
  }

  float getterX() {
    return x ;
  }

  float getterY() {
    return y ;
  }
  int getter_size() {
    return size ;
  }

  void setter_spdX() {
    spdX *= -1 ;
  }
  void setter_spdY() {
    spdY *= -1 ;
  }
  void setter_X() {
    x = width/2 ;
  }
  void setter_Y() {
    y = height/2 ;
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
  void setter_score() {
    score += 1 ;
  }
  int getter_score() {
    return score ;
  }
  float getterX() {
    return x ;
  }
  void setterY() {
    y = mouseY ;
  }
}
