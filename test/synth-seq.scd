s.boot;

(
z = {
	arg noiseHz=8;
	var freq, amp, sig;
	freq = LFNoise0.kr(noiseHz).exprange(200,1000);
	amp = LFNoise1.kr(12).exprange(0.02,1);
	sig = SinOsc.ar(freq) * amp;
}.play;
)

SynthDef.new(\sineTest, {
	arg noiseHz=8;
	var freq, amp, sig;
	freq = LFNoise0.kr(noiseHz).exprange(200,1000);
	amp = LFNoise1.kr(12).exprange(0.02,1);
	sig = SinOsc.ar(freq) * amp;
	Out.ar(0, sig); // set the output bus index
}).add;
// add sends the synthdef to the audio unit

x = Synth.new(\sineTest, [\noiseHz, 32]);

x.set(\noiseHz, 12);
x.set(\noiseHz, 15);
x.set(\noiseHz, 1);
x.set(\noiseHz, 0.25);
x.free;


// Pulse test
(
SynthDef.new(\pulseTest, {
	arg ampHz=4, fund=40, maxPartial=4, width=0.5; // fundamental frequency and max partials
	var amp1, amp2, freq1, freq2, sig1, sig2;
	amp1 = LFPulse.kr(ampHz,0,0.12) * 0.75;
	amp2 = LFPulse.kr(ampHz,0.5,0.12) * 0.75;

	freq1 = LFNoise0.kr(4).exprange(fund, fund*maxPartial);
	freq2 = LFNoise0.kr(4).exprange(fund, fund*maxPartial);

	// use LFPulse to add octave jumps
	freq1 = freq1 * LFPulse.kr(8, add:1);
	freq2 = freq2 * LFPulse.kr(6, add:1);

	sig1 = Pulse.ar(freq1, width, amp1);
	sig2 = Pulse.ar(freq2, width, amp2);
	sig1 = FreeVerb.ar(sig1,0.7,0.8,0.25);
	sig2 = FreeVerb.ar(sig1,0.7,0.8,0.25);
	// send the signal to channels 0 and 1 (L and R)
	Out.ar(0, sig1);
	Out.ar(1, sig2);
}).add;
)

x = Synth.new(\pulseTest);
x.set(\width,0.25);
x.free;

// EnvGens - Envelope generators
// view a env using plot
// levels - array of numbers, ordered values envgen will output, the array [0,1,0] will go from 0, to 1 to 0
// times - 1 smaller than the levels array, dictates the time between segments of th env
// curve - default lin for linear interpolation of values
Env.new.plot;
(
{
	var sig, env;
	env = EnvGen.kr(Env.new, doneAction:2);
	sig = Pulse.ar(ExpRand(20, 80)) * env;
}.play;
)

// Gated env
// for fixed length envelopes, gate can be used to trigger (reset the envelope)
// to trigger, gate must go from 0 to 1
// t_ is used to set a as a trigger, use by setting an argument to t_argument ie t_gate
// by setting gate to 1 by default, it will trigger when the synth is made
(
{
	arg t_gate=0;
	var sig, env;
	env = EnvGen.kr(
		Env.new(
			[0.01,1,0.2,0.01],
			[0.5, 1, 2],
			[1, 1, 0]), t_gate, doneAction:2);
	sig = Pulse.ar(LFPulse.kr(8).range(20, 80)) * env;
}.play;
)

x.set(\t_gate, 1);

// ADSR gate
// sustains as long as the gate is +ve
// use a normal gate not t gate
// use a 2nd one to control the freq
(
{
	arg gate=1;
	var sig, env, freq;
	freq = EnvGen.kr(Env.adsr(1),gate,200, 0.1);
	env = EnvGen.kr(Env.adsr, gate);
	sig = Pulse.ar(LFPulse.kr(freq).range(20, 80)) * env;
}.play;
)

x.set(\gate,0);


// Envelopes and done actions
// doneAction:0 do nothing
// doneAction:2 used to automatically free the synth

// amplitude of a pulse wave with control rate line from 1 to 0 over 1 second
Server.local.plotTree;
(
x = {
	var sig1, env;
	env = Line.kr(1,0,1);
	sig1 = Pulse.ar(ExpRand(20,50)) * env;
}.play;
)

// XLine for a more natural sound
//
(
x = {
	var sig1, freq, env;
	env = XLine.kr(1,0.01,5, doneAction:2);
	freq = XLine.kr(20, 80, 1, doneAction:0);
	sig1 = Pulse.ar(freq) * env;
}.play;
)

// stereo sine pulse
(
x = {
	var sig1, env;
	env = Line.kr(1,0,1, doneAction:2);
	sig1 = SinOsc.ar(ExpRand(20,50)) * env;
	Out.ar(0,sig1);
	Out.ar(1,sig1);
}.play;
)

// binaural sine pulse
(
x = {
	var sig1, sig2, env;
	env = Line.kr(1,0,1);
	sig1 = SinOsc.ar(ExpRand(20,50)) * env;
	sig2 = SinOsc.ar(ExpRand(10,60)) * env;
	Out.ar(0,sig1);
	Out.ar(1,sig2);
}.play;
)

	