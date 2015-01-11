/*
Using a frequency envelope for a glissando effect
use the line class and draw a straight line for the effect
could be made more complex by using the same style of envelopes in the amplitude envelope section
*/

// creates a 1 second glissando effect
{SinOsc.ar(XLine.ar(330, 440, 1), mul:-3.dbamp)}.play;

// create 2 * 1 second glissandos, slide up an octave then down a perfect fourth
(
{SinOsc.ar(EnvGen.ar(Env.circle([400, 439], [1,1]*0.707, \sine)))}.play;
)