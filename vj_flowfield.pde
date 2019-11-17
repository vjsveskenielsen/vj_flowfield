/*
This is a

It relies on:
The Syphon library by Andres Colubri
The Midibus library by Severin Smith
oscP5 and controlP5 by Andreas Schlegel
*/
import codeanticode.syphon.*;
import controlP5.*;
import themidibus.*;
import oscP5.*;
import netP5.*;
import processing.net.*;
import java.util.*;

MidiBus midi;
String[] midi_devices;
OscP5 oscP5;
ControlP5 cp5;
CallbackListener cb;
Textfield field_cw, field_ch, field_syphon_name, field_osc_port, field_osc_address;
Button button_ip;
ScrollableList dropdown_midi, dropdown_syphon_client;
Toggle toggle_log_osc, toggle_log_midi, toggle_view_bg;
Viewport vp;
boolean viewport_show_alpha = false;
boolean log_midi = true, log_osc = true;
Knob knob_speed, knob_flow_change, knob_magnitude, knob_inc, knob_size;

int port = 9999;
String ip;

PGraphics c;
int cw = 1920, ch = 1080;

SyphonServer syphonserver;
SyphonClient[] syphon_clients;
int syphon_clients_index; //current syphon client
String syphon_name = "flowfield", osc_address = syphon_name;
Log log;

float inc = 0.2; //difference between each iteration of flowfield noise loop
int scl = 10;
float zoff = 0;

int cols;
int rows;
float flow_change;
float speed;
float magnitude;
int noOfPoints = 2000;
float particle_size;

Particle[] particles = new Particle[noOfPoints];
PVector[] flowField;

void settings() {
  size(500, 700, P3D);
}

void setup() {
  log = new Log();

  midi_devices = midi.availableInputs();
  controlSetup();
  updateOSC(port);
  c = createGraphics(cw, ch, P3D);
  vp = new Viewport(c, 400, 50, 70);
  vp.resize(c);
  syphonserver = new SyphonServer(this, syphon_name);

  newFlowField();
}

void draw() {
  background(127);
  noStroke();
  fill(100);
  rect(0, 0, width, 55);
  fill(cp5.getTab("output/syphon").getColor().getBackground());
  rect(0, 0, width, cp5.getTab("output/syphon").getHeight());


  drawGraphics();
  vp.display(c);
  syphonserver.sendImage(c);
  log.update();
}

/*
mapXYToCanvas remaps an x/y position inside a viewport to a PGraphics canvas.
E.g to map mouse position within a canvas without scaling up the whole app.
*/

PVector mapXYToCanvas(int x_in, int y_in, Viewport viewport, PGraphics pg) {
  int x_min = round(viewport.position.x + viewport.canvas_offset.x);
  int x_max = x_min + viewport.canvas_width;
  int y_min = round(viewport.position.y + viewport.canvas_offset.y);
  int y_max = y_min + viewport.canvas_height;
  PVector out = new PVector(-1, -1);
  if (x_in >= x_min && x_in <= x_max && y_in >= y_min && y_in <= y_max) {
    float x = map(x_in, x_min, x_max, 0.0, pg.width);
    float y = map(y_in, y_min, y_max, 0.0, pg.height);
    out = new PVector(x,y);
  }
  return out;
}

void drawGraphics() {
  c.beginDraw();
  c.noStroke();
  c.fill(0,7);
  c.rect(0,0,c.width,c.height);
  c.noFill();
   float yoff = 0;
   for(int y = 0; y < rows; y++) {
     float xoff = 0;
     for(int x = 0; x < cols; x++) {
       int index = (x + y * cols);

       float angle = noise(xoff, yoff, zoff) * TWO_PI;
       PVector v = PVector.fromAngle(angle);

       v.setMag(magnitude);

       flowField[index] = v;

       /*
       stroke(0, 50);

        pushMatrix();

        translate(x*scl, y*scl);
        rotate(v.heading());
        line(0, 0, scl, 0);

        popMatrix();
       */
       xoff += inc;
     }
     yoff += inc;
   }
   zoff += flow_change;

   c.stroke(255, 50);
   c.strokeWeight(particle_size);
   for(int i = 0; i < particles.length; i++) {
     particles[i].follow(flowField);
     particles[i].update();
     particles[i].edges();
     particles[i].show();
   }

  c.endDraw();
}

void newFlowField() {
  c.beginDraw();
  c.hint(DISABLE_DEPTH_MASK);
  c.endDraw();
  cols = floor(c.width/scl);
  rows = floor(c.height/scl);

  flowField = new PVector[(cols*rows)];

  for(int i = 0; i < noOfPoints; i++) {
    particles[i] = new Particle();
  }
}
