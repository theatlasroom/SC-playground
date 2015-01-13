s.boot;
s.plotTree;

(
{
	var sig, env, freq;
	env = XLine.kr(1, 0.01, 1, doneAction: 2);
	freq = XLine.kr(220, 110, 1, doneAction:2);
	sig = SinOsc.ar(freq)*env;
}.play;
)

(
x = {
	|gate=0|
	var sig, env;
	y = Env.new([0,1,0.3,0], [0.5,1,5], [\sine, \lin, \sine]);
	env = EnvGen.kr(y, gate, doneAction:2);
	sig = Pulse.ar(ExpRand(30,110)) * env;
}.play;
)

x.set(\gate, 1);

Env.new([0,1,0.2,0], [0.5,1,2], [\sine, \lin, \sine]).plot;