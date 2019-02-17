void setup(){
    size(640, 360);
    
    map();
}

void map(){
    String[] mapLines = loadStrings("/Users/Михаил/Documents/processing_files/project/data/map.txt");
    int change_x = 0, change_y = -50;
    int dir;
    
    translate(0, 360);
    draw_square(0, -50);
    
    for(String i: mapLines){
        dir = to_int(i);
        
        if(dir == 1){
            change_y -= 50;
        }
        if(dir == 2){
            change_x += 50;
        }
        
        if(dir == 3){
            change_y += 50;
        }
        
        if(dir == 4){
            change_x -= 50;
        }
        draw_square(change_x, change_y);
    }
}

void draw_square(int x, int y){
    rect(x, y, 50, 50);
}

int to_int(String str){
    if( str.equals("1")){
        return 1;
    }
    if( str.equals("2")){
        return 2;
    }
    if( str.equals("3")){
        return 3;
    }
    return 4;
}
