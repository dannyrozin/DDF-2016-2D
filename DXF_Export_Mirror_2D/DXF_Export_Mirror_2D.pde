/*
DDF 2017
 pose to the camera and press R to export DXF
 */

import processing.dxf.*;
import processing.video.*;

// Size of each cell in the grid
int cellSize = 18;
// Number of columns and rows in our system

// Variable for capture device
Capture video;
boolean record = false;

void setup() {
  size(640, 480, P3D);           // DXF like P3D
  //set up columns and rows

  colorMode(RGB, 255, 255, 255, 100);
  rectMode(CENTER);

  // Uses the default video input, see the reference if this causes an error
  video = new Capture(this, width, height);
  video.start();
}


void draw() { 

  if (video.available()) {
    video.read();
    video.loadPixels();
    background(255);
    fill(0);

    if (record == true) {
      beginRaw(DXF, "output.dxf");                                            // Start recording to the file
      noFill();                                                                 // we only want the outline
    }
    // Begin loop for columns
    for (int x = 0; x < width; x+= cellSize) {                                // Begin loop for rows
      for (int y = 0; y < height; y+=cellSize) { 
        color c= video.get(x, y );                                             // get pixel color for each x, y
        float CircleSize = ((255-brightness(c)) / 255.0) * cellSize;              // get the brightness and invert , the ovals are black
        ellipse(x + cellSize/2, y + cellSize/2, CircleSize, CircleSize);
      }
    }

    if (record == true) {
      endRaw();
      println("recorded DXF");
      record = false; // Stop recording to the file
    }
  }
}
void keyPressed() {
  if (key == 'R' || key == 'r') { // Press R to save the file
    record = true;
  }
}