/* Generating amplitude envelopes */
// non sustaining exponential triangle envelope
// triggered by an impulse oscillator
({
var dur=2, envtri, trig, envgen, output;
	envtri = Env([0.01, 0.707, 0.01], [dur/2, dur/2], \exp);
	trig = Impulse.kr(1/dur);
	envgen = EnvGen.ar(envtri, trig);
	output = SinOsc.ar(mul:envgen);
}.play
)

// sustaining ADSR evenelope, with a sine wave oscillator for the gate
({
var dur=2, envadsr, gate, envgen, output;
	envadsr = Env.adsr(sustainLevel:0.707);
	gate = SinOsc.ar(1/dur, mul:1/2);
	envgen = EnvGen.ar(envadsr, gate);
	output = SinOsc.ar*envgen;
}.play
)


// custom envelope that cycles from 400 - 440 - 400 etc
// create the envelope
(
{
	var envelope, trigger, envgen, output;
	envelope = Env(levels:[0,1], times:[1,1], curve:\sine);
	// generate the envelope
	trigger = Impulse.kr(1);
	envgen = EnvGen.ar(envelope,trigger);
	output = SinOsc.ar(440,mul:envgen);
}.play
)

{ SinOsc.ar(EnvGen.kr(Env.circle([0, 1], [0.01, 0.5, 0.2], curve:\sine)) * 55 + 5) * 0.1 }.play;