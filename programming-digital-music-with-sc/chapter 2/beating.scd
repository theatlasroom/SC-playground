/* produce beating effects by generating waves of nearly the same frequency */

// use the line function to generate frequencies between 400 and 440 Hz
(
var freq = {XLine.kr(400,440,10)};
{SinOsc.ar([440, freq], mul:-3.dbamp)}.play; // fundamental freq 440, second freq from 400-440 hz
)


({
	var freq, sine1, sine2, output;
	freq = SinOsc.ar(EnvGen.ar(Env.circle([200, 219], [1,1]*1, \sine)), mul:20);
	sine1 = SinOsc.ar([220, 220], mul:-3.dbamp);
	sine2 = SinOsc.ar([freq, freq], mul:-3.dbamp);
	output = sine1+sine2;
}.play;
)