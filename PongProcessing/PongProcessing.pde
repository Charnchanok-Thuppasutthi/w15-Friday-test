Game pong;
void setup() {
  size(700, 500);
  background(0);
  rectMode(CENTER);
  pong = new Game();
}
void draw() {
  pong.board();
  pong.update_game();
}

class Game {
  Player right_player = new Player( width-25, height/2 );
  Player wall1 = new Player(0+50, height/4 );
  Player wall2 = new Player(0+200, height/1.5 );
  Ball ball = new Ball(width/2, height/2);

  void serve_ball(char side) {
    ball.setter_X();
    ball.setter_Y();
    ball.reset_speed(side);
    delay(1500);
  }

  void update_game() { 
    ball.move();
    moveracket();

    if ( (ball.getterX()- ball.getter_size()/2 < -10) || (ball.getterY()- ball.getter_size()/2 < -10) ) { //bounce X left
      ball.setter_spdX();
    }    
    if ( (ball.getterY()- ball.getter_size()/2  < 0) || (ball.getterY()+ ball.getter_size()/2  > height) ) { //bounch Y axis
      ball.setter_spdY();
    }
    if ( (ball.getterX()+ ball.getter_size()/2 > right_player.getterX()+10 ) && (ball.getterX()+ ball.getter_size()/2 >= right_player.getterX()-10) && (( ball.getterY()+ ball.getter_size()/2 > right_player.getterY()-50 ) && ( ball.getterY() - ball.getter_size()/2 < right_player.getterY()+50) )) {
      ball.setter_spdX();
    } 
    if ( (ball.getterX()- ball.getter_size()/2 < wall1.getterX()+10 ) && (ball.getterX()- ball.getter_size()/2 >= wall1.getterX()-10) && (( ball.getterY()+ ball.getter_size()/2 > wall1.getterY()-50 ) && ( ball.getterY() - ball.getter_size()/2 < wall1.getterY()+50) )) {
      ball.setter_spdX();
    } 
    if ( (ball.getterX()- ball.getter_size()/2 < wall2.getterX()+10 ) && (ball.getterX()- ball.getter_size()/2 >= wall2.getterX()-10) && (( ball.getterY()+ ball.getter_size()/2 > wall2.getterY()-50 ) && ( ball.getterY() - ball.getter_size()/2 < wall2.getterY()+50) )) {
      ball.setter_spdX();
    } 
    get_score();
  }

  void board() {    //draw board and score
    background(0);
    fill(255);
    rect( (width/2), height/2, 20, height);
    textSize(70);
  }

  void moveracket() {    //input mouseX and Y to check that's left or right player and move racket to middle of mouseY clicked
    if ( mousePressed == true ) {    //clicked ?
      if ( (mouseY < 0-50 )||( mouseY>height-50 ) ) {  //range of click
      }
      right_player.setterY();
      right_player.draw_racket();
    }
    wall1.draw_racket();
    wall2.draw_racket();
    right_player.draw_racket();
  }

  void get_score() {
    if ( (ball.getterX()- ball.getter_size()/2 < -100) || (ball.getterX()+ ball.getter_size()/2  > width+100) ) {
      if ( (ball.getterX() > width/2 ) ) {
        serve_ball('0');
      }
    }
  }
}
class Ball {
  float x, y ; 
  float spdX = 3 ;
  float spdY = 3 ;
  float directionX = 2 ;
  float directionY = random(-1, 1) ;
  int size = 80 ; 

  Ball(float x_position, float y_position) {
    x = x_position ;
    y = y_position ;
  }

  void move() {
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
    if ( (spdX > 10) || (spdX <-10) ) {
      spdX *= -1 ;
    } else {
      spdX *= -1.2 ;
    }
  }

  void setter_spdY() {
    if ( (spdY > 10) || (spdY <-10) ) {
      spdY *= -1 ;
    } else {
      spdY *= -1.2 ;
    }
  }

  void setter_X() {
    x = width/2 ;
  }
  void setter_Y() {
    y = height/2 ;
  }
  void reset_speed(char player) {
    if ( player == '0') {
      spdX = 3 ;
      spdY = 3 ;
    } else {
      spdX = -3;
      spdY = -3;
    }
    directionY = random(-1, 1) ;
  }
  float getter_spdX() {
    return spdX;
  }
  float getter_spdY() {
    return spdY;
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

    rect(x, y, 25, 100);
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
  float getterY() {
    return y ;
  }
  void setterY() { // if when click rect'll draw on middle of that y (which is size y of rect) 
    y = mouseY ;
  }
}
