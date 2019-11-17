void updateOSC(int p) {
  updateIP();
  oscP5 = new OscP5(this, p);
  cp5.getController("field_osc_port").setValue(p);
}

void updateIP() {
  ip = Server.ip();
  cp5.getController("button_ip").setLabel("ip: " + ip);
}

void oscEvent(OscMessage theOscMessage) {
  String str_in[] = split(theOscMessage.addrPattern(), '/');
  String txt = "got osc message: " + theOscMessage.addrPattern();
  if (str_in.length == 3) {
    if (str_in[1].equals(osc_address) &&
    cp5.getController(str_in[2]) != null &&
    cp5.getController(str_in[2]).getId() != -1)
    {
      Controller con = cp5.getController(str_in[2]);

      if (theOscMessage.checkTypetag("i")) {
        int value = theOscMessage.get(0).intValue();
        value = constrain(value, (int)con.getMin(), (int)con.getMax());
        con.setValue(value);
        txt += " int value: " + Integer.toString(value);
      }

      else if (theOscMessage.checkTypetag("f")) {
        float value = theOscMessage.get(0).floatValue();
        value = constrain(value, con.getMin(), con.getMax());
        con.setValue(value);
        txt += " float value: " + Float.toString(value);
      }
    }
  }
  if (log_osc) log.setText(txt);
}
