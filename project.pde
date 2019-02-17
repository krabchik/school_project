void setup(){
    size(640, 360);
    map();
}

void map(){
    String[] mapLines = loadStrings("/Users/Михаил/Documents/processing_files/project/data/map.txt");
    translate(0, 360);
    rect(0, -50, 50, 50);
    int change_x = 0, change_y = -50;
    int dir;
    
    for(String i: mapLines){
        dir = to_int(i);
        println(dir);
        if(dir == 1){
            change_y -= 50;
        }
        else{
            change_x += 50;
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
    return 2;
}
