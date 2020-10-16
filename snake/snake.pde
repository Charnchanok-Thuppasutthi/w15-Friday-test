World world;

void setup() {
  size(1200, 600); 
  background(255);
  world = new World();

  world.update();
}

void draw() {
  world.update();
}


class World {
  Snake[] snakes ;
  Target target ;
  Wall[] walls ;
  int block_size, snake_length;
  InputProcessor input;

  World () {
    this(50);
  }

  World(int block_size ) {
    this.snake_length = 4;
    this.block_size = block_size;
    this.target = new Target(int(random(0, width/this.block_size)), int(random(0, height/this.block_size)), this);
    this.walls = new Wall[100];
    this.input = new InputProcessor();
    this.snakes = new Snake[snake_length];

    this.snakes[0] = new Snake(5, 5, this);
    for (int n = 1; n < this.snake_length; n+=1) {
      this.snakes[n] = new Snake(5, (this.snakes[n-1].rown)+1, this);
    }

    /*for (int x = 0; x < walls.length; x += 1) { // create object walls
     walls[x] = new Wall(int(random(0, width/this.block_size)), int(random(0, height/this.block_size)), this);
     if ((walls[x].column == snake[0].column && walls[x].rown == snake[0].rown) || (walls[x].column == target.column && walls[x].rown == target.rown)) {
     walls[x] = new Wall(int(random(0, width/this.block_size)), int(random(0, height/this.block_size)), this);
     }
     }*/
  }

  void draw () {
    this.snakes[0].draw();
    for (int n = 1; n < this.snake_length; n+=1) {
      this.snakes[n].draw();
    }
    this.target.draw();
    line(0, 0, width, 0);  // draw world
    for (int x = this.block_size; x < width; x += this.block_size) {
      line(x, 0, x, height);
      line(0, x, width, x);
    }

    //for (int i = 0; i < walls.length; i +=1) walls[i].draw(); //draw walls
    //stroke(#FF7F50);
    noFill();
    rect(width - this.block_size*2, height - this.block_size, this.block_size*2, this.block_size);
    rect(width - this.block_size*2, height - (this.block_size*2), this.block_size*2, this.block_size);
    stroke(0);
    fill(#FF7F50);
    /*text("Save", width - this.block_size * 2 + 15, height-10);
     text("Load", width - this.block_size * 2 + 15, height-60);*/
  }

  void update() {   
    //input.input();
    if (keyPressed) {  // pressed key
      delay(200);
      if (key == this.input.get_turn_left()) snakes[0].left();
      
      else if (key == this.input.get_turn_right()) snakes[0].right();
      
      else if (key == this.input.get_move_key()) {
        snakes[0].move(/*walls*/);
        for (int n = 1; n < this.snake_length; n+=1) {
          if (snakes[n-1].direction != snakes[n].direction){
            snakes[n].direction = snakes[n-1].direction ;
          }
          snakes[n].move(/*walls*/);
        }
      }
    }

    if (snakes[0].column == target.column && snakes[0].rown == target.rown) {  // robot hit target
      target = new Target(int(random(0, width/this.block_size)), int(random(0, height/this.block_size)), this);
      for (int i = 0; i < this.walls.length; i +=1) {
        if ((walls[i].column == target.column && walls[i].rown == target.rown) || snakes[0].column == target.column && snakes[0].rown == target.rown) {
          target = new Target(int(random(0, width/this.block_size)), int(random(0, height/this.block_size)), this);
        }
      }
    }
    /*if (mousePressed) {
     if (mouseX > width - this.block_size*2 && mouseX < width && mouseY > height - this.block_size && mouseY < height) {
     print("save");
     delay(300);
     this.save("my_world");
     }
     if (mouseX > width - this.block_size*2 && mouseX < width && mouseY > height - (this.block_size*2) && mouseY < height - this.block_size) {
     print("load");
     delay(300);
     this.load("my_world");
     }
     }*/

    this.draw();
  }

  /* void save(String save_file) {
   PrintWriter save;
   save = createWriter(save_file);
   save.println("block_size="+this.block_size);
   save.println("robot="+this.snake.column+","+this.snake.rown);
   save.println("target="+target.column+","+target.rown);
   save.println("input_pro="+input.move_key+","+input.turn_left+","+input.turn_right);    
   for (int i = 0; i < this.walls.length; i++) {
   save.println(walls[i].column+","+walls[i].rown);
   }
   save.flush(); // Writes the remaining data to the file
   save.close();
   }
   
   void load( String load_file ) {
   String[] all_lines = loadStrings(load_file);
   String[] line_1 = split(all_lines[0], '=');
   this.block_size = int(line_1[1]);
   
   String[] line_2 = split(all_lines[1], '=');
   String[] robot_column_rown = split(line_2[1], ',');
   this.snake = new Snake(int(robot_column_rown[0]), int(robot_column_rown[1]), this);
   
   String[] line_3 = split(all_lines[2], '=');
   String[] target_column_rown = split(line_3[1], ',');
   this.target = new Target(int(target_column_rown[0]), int(target_column_rown[1]), this);
   
   String[] line_4 = split(all_lines[3], '=');
   String[] input_data = split(line_4[1], ',');
   this.input = new InputProcessor(input_data[0].charAt(0), input_data[1].charAt(0), input_data[2].charAt(0)); 
   
   for (int i = 4; i<walls.length+4; i++) {
   String[] wall_column_rown = split(all_lines[i], ',');
   walls[i-4] = new Wall(int(wall_column_rown[0]), int (wall_column_rown[1]), this);
   }
   }
   */
}

class Snake {
  World world;
  int column, rown ;
  char direction ;
  char[] directioncollection = {'w', 'd', 's', 'a'};

  Snake(int column, int rown, World world) {
    this.column = column ;
    this.rown = rown ;
    this.direction = 'w' ;
    this.world = world;
  }

  void draw() {
    float[] point1 = new float[2];
    float[] point2 = new float[2];
    float[] point3 = new float[2];
    float[] point4 = new float[2];
    float[] point5 = new float[2];
    float[] point6 = new float[2];
    float[] point7 = new float[2];
    float[] point8 = new float[2];
    //
    point1[0] = this.column * world.block_size ;
    point1[1] = this.rown * world.block_size ;

    point2[0] = (this.column * world.block_size) + (world.block_size/2);
    point2[1] = (this.rown * world.block_size) ;

    point3[0] = (this.column * world.block_size) + (world.block_size);
    point3[1] = (this.rown * world.block_size);

    point4[0] = (this.column * world.block_size) + (world.block_size);
    point4[1] = (this.rown * world.block_size) + (world.block_size/2) ;

    point5[0] = (this.column * world.block_size) + (world.block_size);
    point5[1] = (this.rown * world.block_size) + (world.block_size);

    point6[0] = (this.column * world.block_size) + (world.block_size/2);
    point6[1] = (this.rown * world.block_size) + (world.block_size);

    point7[0] = (this.column * world.block_size);
    point7[1] = (this.rown * world.block_size) + (world.block_size);

    point8[0] = (this.column * world.block_size);
    point8[1] = (this.rown * world.block_size) + (world.block_size/2);
    if (this.direction == 'w') {
      line(point2[0], point2[1], point5[0], point5[1]);
      line(point5[0], point5[1], point7[0], point7[1]);
      line(point7[0], point7[1], point2[0], point2[1]);
    } else if (this.direction == 'd') {
      line(point1[0], point1[1], point4[0], point4[1]);
      line(point4[0], point4[1], point7[0], point7[1]);
      line(point7[0], point7[1], point1[0], point1[1]);
      //triangle(point1[0], point1[1], point4[0], point4[1], point7[0], point7[1]);
    } else if (this.direction == 's') {
      line(point1[0], point1[1], point3[0], point3[1]);
      line(point3[0], point3[1], point6[0], point6[1]);
      line(point6[0], point6[1], point1[0], point1[1]);
      //triangle(point1[0], point1[1], point3[0], point3[1], point6[0], point6[1]);
    } else if (this.direction == 'a') {
      line(point8[0], point8[1], point3[0], point3[1]);
      line(point3[0], point3[1], point5[0], point5[1]);
      line(point5[0], point5[1], point8[0], point8[1]);
      //triangle(point8[0], point8[1], point3[0], point3[1], point5[0], point5[1]);
    }
  }

  void move(/*Wall[] walls*/) {

    boolean check = true ;

    if (this.direction == 'w') {
      /*for (int i = 0; i < walls.length; i += 1) { // check wall at the font
       if (walls[i].rown == this.rown - 1 && walls[i].column == this.column) check = false;
       }*/
      if (this.rown > 0 && check) this.rown -= 1 ;
    } else if (this.direction == 'd') {
      /*for (int i = 0; i < walls.length; i += 1) { // check wall at the right
       if (walls[i].rown == this.rown && walls[i].column == this.column + 1) check = false;
       }*/
      if (this.column < width/world.block_size-1 && check) this.column += 1;
    } else if (this.direction == 's') {
      /*for (int i = 0; i < walls.length; i += 1) { // check wall at below
       if (walls[i].rown == this.rown + 1 && walls[i].column == this.column) check = false;
       }*/
      if (this.rown < height/world.block_size-1 && check) this.rown += 1;
    } else if (this.direction == 'a') {
      /*for (int i = 0; i < walls.length; i += 1) { // check wall at the left
       if (walls[i].rown == this.rown && walls[i].column == this.column - 1) check = false;
       }*/
      if (this.column > 0 && check)this.column -= 1;
    }
    background(255);
  }

  void left() {

    for (int x = 0; x < directioncollection.length; x +=1) {
      if (directioncollection[x] == this.direction) {
        if (x == 3) this.direction = directioncollection[0];
        else  this.direction = directioncollection[x+1];
        break;
      }
    }
    background(255);
  }

  void right() {

    for (int x = 0; x < directioncollection.length; x +=1) {
      if (directioncollection[x] == this.direction) {
        if (x == 0) this.direction = directioncollection[3];
        else  this.direction = directioncollection[x-1];
        break;
      }
    }
    background(255);
  }
}

class Target {
  World world ;
  float column, rown;

  Target(int column, int rown, World world) {
    this.column = column ;
    this.rown = rown;
    this.world = world;
  }

  void draw() {
    fill(0);
    this.polygon(world.block_size/2 + (world.block_size*this.column), world.block_size/2 + (world.block_size*this.rown), world.block_size/2, 6);
  }

  void polygon(float x, float y, float radius, int npoints) {
    float angle = TWO_PI / npoints;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
}

class Wall {
  World world;
  float column, rown;

  Wall(int column, int rown, World world) {
    this.column = column;
    this.rown = rown;
    this.world = world;
  }

  void draw() {
    fill(50, 50);
    rect((world.block_size*this.column), (world.block_size*this.rown), world.block_size, world.block_size);
  }
}

class InputProcessor {
  char move_key, turn_left, turn_right;

  InputProcessor(char move_key, char turn_left, char turn_right) {
    this.move_key = move_key;
    this.turn_left = turn_left;
    this.turn_right = turn_right;
  }
  InputProcessor() {
    this.move_key = 'w';
    this.turn_left = 'd';
    this.turn_right = 'a' ;
  }
  //void input() {
  //}
  char get_move_key() {
    return this.move_key;
  }

  char get_turn_left() {
    return this.turn_left;
  }

  char get_turn_right() {
    return this.turn_right;
  }
}
