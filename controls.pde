void controlSetup() {
  cp5 = new ControlP5(this);
  int xoff = 10;
  int yoff = 20;

  cb = new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_ENTER):
        cursor(HAND);
        break;
        case(ControlP5.ACTION_LEAVE):
        case(ControlP5.ACTION_RELEASEDOUTSIDE):
        cursor(ARROW);
        break;
      }
    }
  };

  cp5.getTab("default")
  .setAlwaysActive(true)
  .hideBar()
  .setWidth(-3)
  ;
  //hide default bar
  cp5.addTab("output/syphon").setActive(true);

  cp5.addTab("osc/midi")
  ;

  field_cw = cp5.addTextfield("field_cw")
  .setPosition(xoff, yoff)
  .setSize(30, 20)
  .setAutoClear(false)
  .setText(Integer.toString(cw))
  .setLabel("width")
  .setId(-1)
  .moveTo("output/syphon")
  ;

  xoff += field_cw.getWidth() + 10;
  field_ch = cp5.addTextfield("field_ch")
  .setPosition(xoff, yoff)
  .setSize(30, 20)
  .setAutoClear(false)
  .setText(Integer.toString(ch))
  .setLabel("height")
  .setId(-1)
  .moveTo("output/syphon")
  ;

  xoff += field_ch.getWidth() + 10;
  /*
  dropdown_syphon_client = cp5.addScrollableList("dropdown_syphon_client")
  .setPosition(xoff, yoff)
  .setSize(60, 100)
  .setBarHeight(20)
  .setItemHeight(20)
  .moveTo("output/syphon")
  .setOpen(false)
  .setLabel("syphon input")
  .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
  ;
  dropdown_syphon_client.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {

      if (theEvent.getAction()==ControlP5.ACTION_RELEASE && !dropdown_syphon_client.isOpen()) {
        updateSyphonClients();
      }
      else

      if (theEvent.getAction() == ControlP5.ACTION_RELEASEDOUTSIDE) {
        dropdown_syphon_client.close();
      }
    }
  }
  );
  */
  xoff += cp5.getController("field_ch").getWidth() + 10;
  field_syphon_name = cp5.addTextfield("field_syphon_name")
  .setPosition(xoff, yoff)
  .setSize(60, 20)
  .setAutoClear(false)
  .setText(syphon_name)
  .setLabel("syphon name")
  .setId(-1)
  .moveTo("output/syphon")
  ;

  xoff += field_syphon_name.getWidth() + 10;
  toggle_view_bg = cp5.addToggle("viewport_show_alpha")
  .setPosition(xoff, yoff)
  .setSize(50, 20)
  .setValue(viewport_show_alpha)
  .setLabel("alpha / none")
  .setMode(ControlP5.SWITCH)
  .setId(-1)
  .moveTo("output/syphon")
  ;

  xoff = 10; //reset position for tab "osc/midi"
  button_ip = cp5.addButton("button_ip")
  .setPosition(xoff, yoff)
  .setSize(70, 20)
  .setLabel("ip: " + ip)
  .setSwitch(false)
  .setId(-1)
  .moveTo("osc/midi")
  ;

  xoff += button_ip.getWidth() + 10;
  field_osc_port = cp5.addTextfield("field_osc_port")
  .setPosition(xoff, yoff)
  .setSize(30, 20)
  .setAutoClear(false)
  .setText(Integer.toString(port))
  .setLabel("osc port")
  .setId(-1)
  .moveTo("osc/midi")
  ;

  xoff += field_osc_port.getWidth() + 10;
  field_osc_address = cp5.addTextfield("field_osc_address")
  .setPosition(xoff, yoff)
  .setSize(50, 20)
  .setAutoClear(false)
  .setText(syphon_name)
  .setLabel("osc address")
  .setId(-1)
  .moveTo("osc/midi")
  ;

  xoff += field_osc_address.getWidth() + 10;
  toggle_log_osc = cp5.addToggle("log_osc")
  .setPosition(xoff, yoff)
  .setSize(30, 20)
  .setLabel("log osc")
  .setValue(true)
  .setId(-1)
  .moveTo("osc/midi")
  ;

  xoff += toggle_log_osc.getWidth() + 10;
  dropdown_midi = cp5.addScrollableList("dropdown_midi")
  .setPosition(xoff, yoff)
  .setSize(200, 100)
  .setOpen(false)
  .setBarHeight(20)
  .setItemHeight(20)
  .addItems(Arrays.asList(midi_devices))
  .setLabel("MIDI INPUT")
  .setId(-1)
  .moveTo("osc/midi")
  .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
  ;

  xoff += dropdown_midi.getWidth() + 10;
  toggle_log_midi = cp5.addToggle("log_midi")
  .setPosition(xoff, yoff)
  .setSize(30, 20)
  .setLabel("log midi")
  .setValue(true)
  .setId(-1)
  .moveTo("osc/midi")
  ;

  /*  CUSTOM CONTROLS
  Add your own controls below. Use .setId(-1) to make controller
  unreachable by OSC.
  */
  xoff = 50;
  yoff = 510;
  knob_speed = cp5.addKnob("speed")
  .setPosition(xoff, yoff)
  .setSize(50, 50)
  .setLabel("speed")
  .setRange(0., 3.)
  .setValue(0.001)
  .setId(0)
  ;

  xoff += knob_speed.getWidth() + 10;
  knob_flow_change = cp5.addKnob("flow_change")
  .setPosition(xoff, yoff)
  .setSize(50, 50)
  .setLabel("flow change")
  .setRange(0, 3.)
  .setValue(0.)
  .setId(0)
  ;

  xoff += knob_flow_change.getWidth() + 10;
  knob_magnitude = cp5.addKnob("magnitude")
  .setPosition(xoff, yoff)
  .setSize(50, 50)
  .setLabel("magnitude")
  .setRange(-1., 1.)
  .setValue(0.)
  .setId(0)
  ;

  xoff += knob_magnitude.getWidth() + 10;
  knob_inc = cp5.addKnob("inc")
  .setPosition(xoff, yoff)
  .setSize(50, 50)
  .setLabel("difference")
  .setValue(0.1)
  .setRange(0., 1.)
  .setValue(magnitude)
  .setId(0)
  ;

  xoff += knob_inc.getWidth() + 10;
  knob_size = cp5.addKnob("particle_size")
  .setPosition(xoff, yoff)
  .setSize(50, 50)
  .setLabel("particle size")
  .setValue(inc)
  .setRange(0., 1.)
  .setValue(magnitude)
  .setId(0)
  ;


}

// checks if input is 4 digits
int evalFieldInput1(String in, int current, Controller con) {
  String name = con.getLabel();
  int out = -1;
  char[] ints = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
  char[] input = in.toCharArray();

  String txt = "value not int between 1 and 9999";
  if (input.length < 5) {
    int check = 0;
    for (char ch : input) {
      for (char i : ints) {
        if (ch == i) check++;
      }
    }

    if (input.length == check) {
      int verified_int = Integer.parseInt(in);
      txt = name + " changed from " + current + " to " + verified_int;
      if (verified_int < 1) {
        verified_int = 1;
        txt = name + " was lower than 0 and defaults to " + verified_int;
      }
      if (verified_int == current) txt = "value is not different from " + current;
      else {
        out = verified_int;
      }
    }
  }
  log.setText(txt);

  return out;
}

// checks if input is valid string for osc path
boolean evalFieldInput2(String in, String current, Controller con) {
  String name = con.getLabel();
  String txt = "input to " + name + " is unchanged";
  boolean out = true;
  char[] illegal_chars = {'/', ',', '.', '(', ')', '[', ']',
  '{', '}', ' '};
  char[] input = in.toCharArray();
  if (!in.equals(current)) {
    if (input.length > 0) {
      for (char ch : input) {
        for (char i : illegal_chars) {
          if (ch == i) {
            txt = "input to " + name + " contained illegal character and was reset";
            out = false;
          }
        }
      }
    }
  }

  log.setText(txt);

  return out;
}

public void field_cw(String theText) {
  int value = evalFieldInput1(theText, cw, cp5.getController("field_cw"));
  if (value > 0) {
    cw = value;
    updateCanvas();
  }
}
public void field_ch(String theText) {
  int value = evalFieldInput1(theText, ch, cp5.getController("field_ch"));
  if (value > 0) {
    ch = value;
    updateCanvas();
  }
}

public void field_syphon_name(String input) {
  if (evalFieldInput2(input, syphon_name, field_syphon_name)) {
    syphon_name = input;
    field_osc_address.setText(input);
    osc_address = input;
    log.setText("syphon name and osc address set to " + input);
  }
  else field_syphon_name.setText(syphon_name);
}

public void field_osc_address(String input) {
  if (evalFieldInput2(input, osc_address, field_osc_address)) {
    syphon_name = input;
    log.setText("osc address set to " + input);
  }
  else field_osc_address.setText(osc_address);
}

void dropdown_midi(int n) {
  updateMIDI(n);
  println("added " + midi_devices[n], n);
}

void log_midi(boolean state) {
  log_midi = state;
  if (state) log.setText("started logging midi input");
  else log.setText("stopped logging midi input");
}

void field_osc_port(String theText) {
  int value = evalFieldInput1(theText, port, field_osc_port);
  if (value > 0) {
    port = value;
    updateOSC(port);
  }
}

public void button_ip() {
  updateIP();
  log.setText("ip adress has been updated to " + ip);
}

public void particle_size (float theValue) {
  particle_size = max(c.width,c.height)/200.*theValue;
}
