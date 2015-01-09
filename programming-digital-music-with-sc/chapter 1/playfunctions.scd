/*
Play audio using functions
*/

// sine wave using just default parameters
{SinOsc.ar}.play;

// saw wave with default params
{Saw.ar}.play;

// define a function with an argument called chaos
{
	|chaos=1.5|
	Crackle.ar(chaos)
}.play(args:[\chaos, 2]);

// Resonant high pass filter
// pass white noise through a resonant high pass filter
// RHPF is a sound processor and does not produce sound, insteads processes audio input
{RHPF.ar(WhiteNoise.ar)}.play;

// create a custom function that uses 2 sine osc for additive synthesis
// assign the function to the global variable f, then play f with different params
(
f = {
	|freq1=440,freq2=440,amp1=0.5,amp2=0.5|
	var sine1, sine2, output;
	sine1 = SinOsc.ar(freq1, mul: amp1);
	sine2 = SinOsc.ar(freq2, mul: amp2);
	output = sine1+sine2;
};
)

f.play;
f.play(args: [\freq2, 550, \amp1, 0.25]);

// Batunan Bozkurt track for the wire songs as tweets
//f={|t|Pbind(\note,Pseq([-1,1,6,8,9,-1,8,6,1,9,8]+5,319),\dur,t)};Ptpar([0,f.(1/6),12,f.(0.1672)],1).play