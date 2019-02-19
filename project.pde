int status = 1; // 1 - map, 2 - question, 3 - answer
int tmp, current_quest = 0, step = 0, wait = 0;
int tile_height = 50, tile_width = 50;
int answ_t = 0, answ_f = 0;
PFont f;
int curr_x = 0, curr_y = -51;

void setup() {
    size(640, 360);
    f = createFont("Arial",16,true);
}

void draw() {
    
    if (wait != 1) {
        switch(status) {
        case 1:
            draw_map();
            break;
        case 2:
            delay(1000);
            draw_quest();
            break;
        case 3:
            draw_answer();
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
                step = int(random(1, 5));
                textSize(40);
                fill(0);
                text(step, width - 41, 42);
                fill(255);
                
                status = 2;
                wait = 0;
                current_quest += step;
                
            }
            break;
            
        case 2:
            if( 500 < mouse_x && mouse_x < 630 && 260 < mouse_y && mouse_y < 350 ){
                status = 3;
                wait = 0;
            }
            break;
            
        case 3:
            if( 210 < mouse_y && mouse_y < 310 ){
                if( width/2 + 30 < mouse_x && mouse_x < width/2 + 180 ){
                    status = 1;
                    wait = 0;
                    answ_t += 1;
                }
                else if( width/2 - 180 < mouse_x && mouse_x < width/2 - 30 ){
                    status = 1;
                    wait = 0;
                    answ_f += 1;
                }
            }
            break;
    }
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
    }
    return -1;
}

int[] get_map() {
    String[] strings = loadStrings("/users/Михаил/Documents/processing_files/project/data/map.txt");
    int[] mapLines;
    mapLines = new int[strings.length];
    for (int j = 0; j < strings.length; j++) {
        tmp = to_int(strings[j]);
        if ( tmp > 0) {
            mapLines[j] = tmp;
        }
    }
    return mapLines;
}

void draw_map() {
    int[] mapLines = get_map();

    background(204);
    int change_x = 0, change_y = -51;
    translate(0, 360);
    fill(255);

    // Drawing start
    draw_square(change_x, change_y);
    int dir, i;
    // Drawing map
    for( i = 0; i < mapLines.length; i++ ){
       
        dir = mapLines[i];
        switch(dir) {
        case 1:
            change_y -= tile_height;
            break;
        case 2:
            change_x += tile_width;
            break;
        case 3:
            change_y += tile_height;
            break;
        default:
            change_x -= tile_width;
        }
        draw_square(change_x, change_y);
    }
    translate(0, -360);

    // Drawing button
    rect(width - 60, -1, 60, 60);
    
    // Printing score
    rect(width - 260, -1, 200, 60);
    textSize(25);
    fill(0, 255, 0);
    text(answ_t, width - 260 + 45, 37);
    fill(255, 0, 0);
    text(answ_f, width - 160 + 45, 37);
    
    // Priniting "start"
    fill(0);
    textSize(20);
    text("start", 3, height - 21);
}

void draw_square(int x, int y) {
    rect(x, y, 50, 50);
}

void draw_quest() {
    background(204);
    String s = loadStrings("/users/Михаил/Documents/processing_files/project/data/questions.txt")[current_quest - 1];
    fill(0);
    text(s, width/10, height/5, width * 4/5, height* 4/5);
    fill(255);
    rect(500, 260, 130, 90);
}

void draw_answer(){
    background(204);
    String s = loadStrings("/users/Михаил/Documents/processing_files/project/data/answers.txt")[current_quest - 1];
    textFont(f,16);
    fill(0);
    text(s, width/10, height/5, width * 4/5, height* 4/5);
    
    // Drawing two buttons
    fill(255, 0, 0);
    rect(width/2 - 180, 210, 150, 100);
    
    fill(0, 255, 0);
    rect(width/2 + 30, 210, 150, 100);
}
