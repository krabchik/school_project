int status = -1; // 1 - map, 2 - question, 3 - answer, -1 - start screen
int tmp, step = 0, wait = 0;
PFont f;
boolean first_map_draw = true;
int start_x = 50, start_y = -250;
int n;
boolean inputed_number = false;
int square_side = 60;
int player_w = square_side / 3, player_h = square_side / 2;
int current_player = 0;
int[] current_quest, answ_t, answ_f, mapLines;
int [][] player_colors;
int[][] COLORS = {{230, 25, 75}, {255, 225, 25}, {60, 180, 75}, {0, 130, 200}, {240, 50, 230}, {170, 110, 40}};
PImage img;

void setup() {
    size(1000, 700);
    f = createFont("Arial",16,true);
    String[] strings = loadStrings("/users/Михаил/Documents/processing_files/project/data/map.txt");
    println(strings.length);
    mapLines = new int[strings.length];
    for( int j = 0; j < strings.length; j++ ){
        tmp = to_int(strings[j]);
        if ( tmp > 0) {
            mapLines[j] = tmp;
        }
    }
}
 
void draw() {
    if( wait == 0 ){
        switch(status) {
        case 1:
            if( first_map_draw ){
                
                current_quest = new int [n];
                answ_t = new int [n];
                answ_f = new int [n];
                player_colors = new int[n][3];
                int i;
                for( i = 0; i < n; i++ ){
                    current_quest[i] = 0;
                    answ_t[i] = 0;
                    answ_f[i] = 0;
                    player_colors[i] = COLORS[i];
                }
            }
            draw_map(false);
            break;
        case 2:
            delay(500);
            draw_quest();
            break;
        case 3:
            draw_answer();
            current_player = (current_player + 1) % n;
            break;
        case -1:
            background(204);
            textSize(30);
            text("Input number of players", 100, 100);
            draw_input_players();
            break;
        }
        wait = 1;
    }
}

void mouseReleased() {
    int mouse_x = mouseX;
    int mouse_y = mouseY;
    switch(status){
        case 1 :
            if( width - 62 < mouse_x && mouse_y < 61 ){
                
                step =  1;  // int(random(1, 5));
                
                status = 2;
                wait = 0;
                
                current_quest[current_player] += step;
                draw_map(true);
            }
            break;
            
        case 2:
            if( width - 230 < mouse_x && mouse_x < width - 30 && height - 130 < mouse_y && mouse_y < height - 30 ){
                status = 3;
                wait = 0;
            }
            break;
            
        case 3:
            if( 500 < mouse_y && mouse_y < 650 ){
                if( width*3/5 < mouse_x && mouse_x < width*3/5 + 200 ){
                    status = 1;
                    wait = 0;
                    answ_t[current_player] += 1;
                }
                else if( width*2/5 - 200 < mouse_x && mouse_x < width*2/5 ){
                    status = 1;
                    wait = 0;
                    answ_f[current_player] += 1;
                }
            }
            break;
            
        case -1:
            if( mouse_y < 400 && mouse_y > 200 ){
                
                if( 200 < mouse_x && mouse_x < 400 ){
                    n = 1;
                    status = 1;
                    wait = 0;
                    return;
                }
                if( 400 < mouse_x && mouse_x < 600 ){
                    n = 2;
                    status = 1;
                    wait = 0;
                    return;
                }
                if( 600 < mouse_x && mouse_x < 800 ){
                    n = 3 ;
                    status = 1;
                    wait = 0;
                    return;
                }          
            }
            if( mouse_y < 600 && mouse_y > 400 ){
                
                if( 200 < mouse_x && mouse_x < 400 ){
                    n = 4;
                    status = 1;
                    wait = 0;
                    return;
                }
                if( 400 < mouse_x && mouse_x < 600 ){
                    n = 5;
                    status = 1;
                    wait = 0;
                    return;
                }
                if( 600 < mouse_x && mouse_x < 800 ){
                    n = 6;
                    status = 1;
                    wait = 0;
                    return;
                }
            }
    }
}

void draw_step(){
    
    textSize(40);
    fill(0);
    text(step, width - 41, 42);
    fill(255);
    
}

int to_int(String str) {
    switch(str) {
        case "1":
            return 1;
        case "2":
            return 2;
        case "3":
            return 3;
        case "4":
            return 4;
        case "5":
            return 5;
        case "6":
            return 6;
        case "7":
            return 7;
    }
    return -1;
}

int get_length(int l){
    if( l < 3 ){
        return l;
    }
    return l - 3;
}

int get_height(int l){
    if( l < 3 ){
        return 0;
    }
    return 1;
    
}

void draw_input_players(){
    int i, j;
    for( i = 0; i < 2; i++){
        for( j = 0; j < 3; j++){
            rect(200 + j * 200, 200 + i * 200, 200, 200);
            textSize(40);
            fill(0);
            text(j + 1 + 3 * i, 290 + j * 200, 310 + i * 200);
            fill(255);
        }
    }
}
 
void draw_map(boolean to_draw_step) {
 
    background(204);
    int change_x = start_x, change_y = start_y;
    translate(0, 360);
    fill(255);
 
    // Drawing start
    draw_square(change_x, change_y);
    
    // Drawing map
    int dir, i, j;
    for( i = -1; i < mapLines.length; i++ ){
        
        fill(255);
        if( i != -1 ){
            dir = mapLines[i];
            switch(dir) {
                case 1:
                change_y -= square_side;
                break;
                case 2:
                change_x += square_side;
                break;
                case 3:
                change_y += square_side;
                break;
                default:
                change_x -= square_side;
            }
        }
        stroke(0);
        draw_square(change_x, change_y);
        for( j = 0; j < n; j++ ){
            if( i == current_quest[j] - 1 ){
                fill(player_colors[j][0], player_colors[j][1], player_colors[j][2]);
                println(get_length(j), get_height(j));
                rect(change_x + get_length(j) * player_w, change_y + get_height(j) * player_h, player_w, player_h);
            }
        }
    }
    
    // Drawing finish
    fill(255, 255, 0);
    rect(change_x + square_side, change_y, square_side, square_side);
    
    first_map_draw = false;
    
    translate(0, -360);
    
    stroke(0);
    fill(255);
    
    // Drawing button
    rect(width - 60, -1, 60, 60);
    
    // Printing score
    rect(width - 260, -1, 200, 60);
    textSize(40);
    fill(0, 255, 0);
    text(answ_t[(current_player + 1) % n], width - 260 + 45, 37);
    fill(255, 0, 0);
    text(answ_f[(current_player + 1) % n], width - 160 + 45, 37);
    
    // Printing step
    if( to_draw_step ){
        draw_step();
    }
    
    //// Priniting "start"
    //fill(0);
    //textSize(20);
    //text("start", start_x + 3, height - 21 + start_y + 50);
    
    // Printing current player
    fill(0);
    textSize(32);
    text("Current player:", width - 330, 400);
    text(current_player + 1, width - 90, 400);
}
 
void draw_square(int x, int y) {
    rect(x, y, square_side, square_side);
    //line(x, y, x, y + square_side);
    //line(x, y + square_side, x + square_side, y + square_side);
    //line(x + square_side, y + square_side, x + square_side, y);
    //line(x + square_side, y, x, y);
}
 
void draw_quest() {
    background(204);
    
    fill(255);
    rect(width - 230, height - 130, 200, 100);
    
    fill(0);
    textSize(50);
    text("Answer", width - 217, height - 60);
    
    imageMode(CORNERS);
    img = loadImage("/users/Михаил/Documents/processing_files/project/quest/" + str(current_quest[current_player] - 1) + ".jpg");
    image(img, width/5 - 50, height/5 - 50);
}

void draw_answer(){
    background(204);
    
    imageMode(CORNERS);
    img = loadImage("/users/Михаил/Documents/processing_files/project/answ/" + str(current_quest[current_player] - 1) + ".jpg");
    image(img, width/5 - 50, height/5 - 50);
    
    // Drawing two buttons
    fill(255, 0, 0);
    rect(width*2/5 - 200, 500, 200, 150);
    
    fill(0, 255, 0);
    rect(width*3/5, 500, 200, 150);
}
