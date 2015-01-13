(
SynthDef(\lrsines, {
	|buff=0, freq=440, amp=0.707, dur=1, t_trig=0|
	x = {SinOsc.ar([freq/10, (freq/10)-10] * amp, mul:1);};
	y = {SinOsc.ar([freq, freq-10] * amp, mul:1);};

	l = x+y*0.707;
	r = x+z*0.707;

	Out.ar(buff, [l,r]);
}).add;
)


a = Synth(\lrsines, [\buff, b, \freq,  \amp, 0.707/2]);

a.free;


