# vj_flowfield

This is an application for live visual performance.
It is based on this flowfield Processing sketch:
https://github.com/daneden/processing-flow-field

The app is built on top of vj_boilerplate and includes
a JSON layout for a VDMX control surface that can control
parameters through OSC.
Default OSC address is /flowfield/ @ port 9999

You control parameters by appending their names to the OSC address
and sending normalized floats 0.0-1.0
e.g. /flowfield/magnitude

It relies on:
The Syphon library by Andres Colubri
The Midibus library by Severin Smith
oscP5 and controlP5 by Andreas Schlegel

Do whatever you please with it.
Marius Juul Nielsen // Sveskenielsen
