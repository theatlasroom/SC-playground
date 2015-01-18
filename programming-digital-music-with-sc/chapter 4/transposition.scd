// transposition
(
~path = Platform.resourceDir +/+ "sounds/a11wlk01.wav";
b = Buffer.read(s, ~path); // read the buffer in
)

// create the mono sample transposr
(
SynthDef(\monoSampleTransposer, {
	|bufnum=0, tpose=0| // tpose is the amount of transposition in semitones
	var rate, ptr, output;
	s.postln(BufRateScale.ir(bufnum));
	s.postln(pow(2, tpose/12));
	rate = BufRateScale.ir(bufnum)*pow(2, tpose/12); // scale the rate by s to the power of 1/12th of the tpose amount
	ptr = Phasor.ar(0, rate, 0, BufFrames.ir(bufnum)); // create the phasor
	output  = BufRd.ar(1, bufnum, ptr, 1, 4); // read the buffer at the point specified
	Out.ar(0, output);
}).add;
)

// create the synth
y = Synth(\monoSampleTransposer, [\bufnum, b.bufnum]);

(
var tpose = 1;
y.set(\tpose, tpose);
)

y.free;b.close;b.free;