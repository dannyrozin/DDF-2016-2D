/*
DDF 2021
Make sure the audio input is set to the internal mic then sing into it to get nice waves
and press R to record DXF

 * Get Line In
 * by Damien Di Fede.
 *  
 * This sketch demonstrates how to use the <code>getLineIn</code> method of 
 * <code>Minim</code>. This method returns an <code>AudioInput</code> object. 
 * An <code>AudioInput</code> represents a connection to the computer's current 
 * record source (usually the line-in) and is used to monitor audio coming 
 * from an external source. There are five versions of <code>getLineIn</code>:
 * <pre>
 * getLineIn()
 * getLineIn(int type) 
 * getLineIn(int type, int bufferSize) 
 * getLineIn(int type, int bufferSize, float sampleRate) 
 * getLineIn(int type, int bufferSize, float sampleRate, int bitDepth)  
 * </pre>
 * The value you can use for <code>type</code> is either <code>Minim.MONO</code> 
 * or <code>Minim.STEREO</code>. <code>bufferSize</code> specifies how large 
 * you want the sample buffer to be, <code>sampleRate</code> specifies the 
 * sample rate you want to monitor at, and <code>bitDepth</code> specifies what 
 * bit depth you want to monitor at. <code>type</code> defaults to <code>Minim.STEREO</code>,
 * <code>bufferSize</code> defaults to 1024, <code>sampleRate</code> defaults to 
 * 44100, and <code>bitDepth</code> defaults to 16. If an <code>AudioInput</code> 
 * cannot be created with the properties you request, <code>Minim</code> will report 
 * an error and return <code>null</code>.
 * 
 * When you run your sketch as an applet you will need to sign it in order to get an input. 
 * 
 * Before you exit your sketch make sure you call the <code>close</code> method 
 * of any <code>AudioInput</code>'s you have received from <code>getLineIn</code>.
 */

import ddf.minim.*;

import processing.dxf.*;
boolean record = false;

Minim minim;
AudioInput in;

void setup()
{
  size(512, 200, P3D);        //// for me the DXF export doesn't work without specifying P3D

  minim = new Minim(this);
  minim.debugOn();
  
  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, 512);
}

void draw()
{
  background(0);
  stroke(255);
  
  if (record == true) {
    beginRaw(DXF, "output.dxf"); // Start recording to the file
  } 
  // draw the waveforms 
  for(int i = 0; i < in.bufferSize() - 2; i+=2){
    line(i, 50 + in.left.get(i)*50, i+2, 50 + in.left.get(i+2)*50);
    
    line(i, 150 + in.right.get(i)*50, i+2, 150 + in.right.get(i+2)*50);
  }  
   if (record == true) {
    endRaw();
    record = false; // Stop recording to the file
  }   
}

void keyPressed() {
  if (key == 'R' || key == 'r') { // Press R to save the file
    record = true;
    println("Exported DXF");
  }
}

void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();  
  super.stop();
}
