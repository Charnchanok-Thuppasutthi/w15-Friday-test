Game pong;
void setup() {
  size(700, 500);
  background(0);
  pong = new Game();
}
void draw() {
  pong.board();
  pong.update_game();
}

class Game {
  Player left_player = new Player( 0, height/2-(height/8) );
  Player right_player = new Player( width-(width/14), height/2-(height/8) );

  Ball ball = new Ball(width/2, height/2);

  void serve_ball() {
    delay(1000);
    ball.setter_X();
    ball.setter_Y();
    ball.reset_speed();
  }

  void update_game() { 
    ball.move();
    moveracket();

    if ( (ball.getterX() <= left_player.getterX()+75 ) && (( ball.getterY()+ ball.getter_size()/2 > left_player.getterY() ) && ( ball.getterY() - ball.getter_size()/2 < left_player.getterY()+100) )) {
      ball.setter_spdX();
    }

    if ( (ball.getterX() >= right_player.getterX()-25 ) && (( ball.getterY()+ ball.getter_size()/2 > right_player.getterY() ) && ( ball.getterY() - ball.getter_size()/2 < right_player.getterY()+100) )) {
      ball.setter_spdX();
    } 

    get_score(); 

    if ( (ball.getterY()- ball.getter_size()/2  < 0) || (ball.getterY()+ ball.getter_size()/2  > height) ) { //bounch Y axis
      ball.setter_spdY();
    }
  }

  void board() {    //draw board and score
    background(0);
    fill(255);
    rect( (width/2), 0, -10, height);
    rect(width/2, 0, 10, height);
    textSize(70);

    text( left_player.getter_score(), width/10, height/5 );
    text( right_player.getter_score(), width - (width/5), height/5 );
  }

  void moveracket() {    //input mouseX and Y to check that's left or right player and move racket to middle of mouseY clicked
    if ( mousePressed == true ) {    //clicked ?
      if (mouseX<width/2) {          //left side
        if ( (mouseY < 0-50 ) || (mouseY > height -50 ) ) {  //range of clicked
        }
        left_player.setterY();
        left_player.draw_racket();
      }
      if (mouseX>width/2) {      //right side
        if ( (mouseY < 0-50 )||( mouseY>height-50 ) ) {  //range of click
        }
        right_player.setterY();
        right_player.draw_racket();
      }
    }
    left_player.draw_racket();
    right_player.draw_racket();
  }

  void get_score() {
    if ( (ball.getterX()- ball.getter_size()/2 < -100) || (ball.getterX()+ ball.getter_size()/2  > width+100) ) {
      if ( (ball.getterX()<width/2 ) ) {
        right_player.setter_score();
        serve_ball();
      }
      if ( (ball.getterX() > width/2 ) ) {
        left_player.setter_score();
        serve_ball();
      }
    }
  }
}

class Ball {
  float x, y ; 
  float spdX = 2 ;
  float spdY = 2 ;
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
      spdX *= -1.1 ;
    }
  }

  void setter_spdY() {
    if ( (spdY > 10) || (spdY <-10) ) {
      spdY *= -1 ;
    } else {
      spdY *= -1.1 ;
    }
  }

  void setter_X() {
    x = width/2 ;
  }
  void setter_Y() {
    y = height/2 ;
  }
  void reset_speed() {
    spdX = 2 ;
    spdY = 2 ;
    directionY = random(-1,1) ;
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
  float getterY() {
    return y ;
  }
  void setterY() { // if when click rect'll draw on middle of that y (which is size y of rect) 
    y = mouseY-50 ;
  }
}
