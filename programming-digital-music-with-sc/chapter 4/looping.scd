// Looping a sample
// automatically handles resampling, looping forwards and backwards for both mono and stereo sources

// you can set 4 parameters for the sampler
// start, end, tpose -> 1 = 1 semitone, mode (+ve/-ve -> forwards/backwards)

(
~path = Platform.resourceDir +/+ "sounds/a11wlk01.wav";
b = Buffer.read(s, ~path);
)

// MONO LOOPER
(
SynthDef(\monolooper, {
	|bufnum=0, start=0, end=0, tpose=0, mode=1|
	var srBuffer, srSample, dir, rate, dur, startPos, endPos, pointer, output;
	srBuffer = BufSampleRate.ir(bufnum);
	srSample = SampleRate.ir;
	dir = Select.kr(mode.sign < 0, [1, -1]); // if sign is < 0, set it to 1, otherwise -1
	rate = (srBuffer/srSample)*(2**(tpose/12))*dir; // set the rate and direction of transposition
	dur = abs(end-start)/2**(tpose/12); // scale the duration by the new rate
	startPos = Select.kr(dir.sign < 0, [start*srBuffer, end*srBuffer]); // set the start position based on the direction we are transposing
	endPos = Select.kr(dir.sign < 0, [end*srBuffer, start*srBuffer]); // set the start position based on the direction we are transposing

	pointer = Phasor.ar(1/dur, rate, startPos, endPos);
	output = BufRd.ar(1, bufnum, pointer, 1, 4);
	Out.ar(0, output);
}).add;
)

// STEREO LOOPER
(
SynthDef(\stereolooper, {
	|bufnum=0, start=0, end=0, tpose=0, mode=1|
	var srBuffer, srSample, dir, rate, dur, startPos, endPos, pointer, output;
	srBuffer = BufSampleRate.ir(bufnum);
	srSample = SampleRate.ir;
	dir = Select.kr(mode.sign < 0, [1, -1]); // if sign is < 0, set it to 1, otherwise -1
	rate = (srBuffer/srSample)*(2**(tpose/12))*dir; // set the rate and direction of transposition
	dur = abs(end-start)/2**(tpose/12); // scale the duration by the new rate
	startPos = Select.kr(dir.sign < 0, [start*srBuffer, end*srBuffer]); // set the start position based on the direction we are transposing
	endPos = Select.kr(dir.sign < 0, [end*srBuffer, start*srBuffer]); // set the start position based on the direction we are transposing

	pointer = Phasor.ar(1/dur, rate, startPos, endPos);
	output = BufRd.ar(22, bufnum, pointer, 1, 4);
	Out.ar(0, output!2);
}).add;
)

// create the appropriate looper based on the number of channels in the sound source
(
if (b.numChannels > 1,
	{y = Synth(\stereolooper, [\bufnum, b.bufnum])}, // new stereo looper
	{y = Synth(\monolooper, [\bufnum, b.bufnum])}); // new mono looper
)

y.set(\start, 0, \end, 2, \tpose, 0, \mode, 1);
y.free;b.close;b.free;






















