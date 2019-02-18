int status = 1; // 1 - map, 2 - question, 3 - answer
int tmp, current_quest = 0, step = 0;
int tile_height = 50, tile_width = 50;

void setup() {
    size(640, 360);
}

void draw() {

    String[] strings = loadStrings("/users/Михаил/Documents/processing_files/project/data/map.txt");
    int[] mapLines;
    mapLines = new int[strings.length];
    for (int j = 0; j < strings.length; j++) {
        tmp = to_int(strings[j]);
        if ( tmp > 0) {
            mapLines[j] = tmp;
        }
    }

    switch(status) {
    case 1:
        map(mapLines);
        break;
    case 2:
    }
}


void mouseReleased() {
    if (status == 1) {
        if (width - 62 < mouseX & mouseY < 61) {
            step = int(random(1, 6));
            textSize(40);
            fill(0);
            text(step, width - 41, 42);
            fill(255);
            
            status = 0;
        }
    }
}

void draw_square(int x, int y) {
    rect(x, y, 50, 50);
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

void map(int[] mapLines) {
    background(204);
    int change_x = 0, change_y = -51;

    // Drawing map
    translate(0, 360);
    draw_square(change_x, change_y);
    for (int dir : mapLines) {

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
    fill(255);
    rect(width - 60, -1, 60, 60);
}
