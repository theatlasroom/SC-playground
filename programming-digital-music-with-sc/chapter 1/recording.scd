/*
Playing a synth
*/

// define a synth
// synthdef has 2 mandatory args, name and a function
// the function is only evaluated once, it is a UGen graph function
// synthdef needs an Out class to produce output

/*
Custom stereo synth
- left channel is the frequency
- right channel is the freq - 1/10 of the freq
*/
(
SynthDef(\sinewave, {
	|freq=440,phase=0,amp=1,add=0|
	var lsinewave, rsinewave;
	lsinewave = SinOsc.ar(freq, phase, amp, add);
	rsinewave = SinOsc.ar(freq-(freq/10), phase, amp, add);
	// out takes 2 params (bus, channelsArray)
	// bus - index number of the bus to send output to
	// channelsArray - channels to write to, 1 = mono, 2 = stereo
	Out.ar(0,[lsinewave, rsinewave]);
}).add; // add stores the synthdef in memory - store is used to save to disk
)

// create a synth instance
y = Synth(\sinewave);

// change the default frequency while it is running
y.set(\freq, 550);

// create a synth and change the arguments at the same time
y = Synth(\sinewave, [\freq,150]);

// show the server
Server.default.makeGui; // can manually record from here

// Recording from the client
// start recording

s.prepareForRecord;
s.record

(
y = Synth(\sinewave, [\freq,5505]);
x = Synth(\sinewave, [\freq,90]);
)

x.free;y.free;

(
s.stopRecording;
x.free;y.free;
)
