// Smplrrns
// Mix patterns with a sampler
(
// create a buffer for the song we will sample
~song = "/Users/bardock/Music/atlas/disquiet-junto/0154 Project/export/The Atlas Room - above as below [disquiet0154-groove-unlocked].wav";
b = Buffer.read(s, ~song);

b.query;

// define the mono looper
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


// define the stereo looper

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
	output = BufRd.ar(2, bufnum, pointer, 1, 4);
	Out.ar(0, output!2);
}).add;

SynthDef(\test, {
	|freq=440, amp=1|
	var sine;
	SinOsc.ar(freq, mul:amp);
	Out.ar(1,
}).add;
)

(
// create the new stereo looper
if (b.numChannels > 1,
	{y = Synth(\stereolooper, [\bufnum, b.bufnum])}, // new stereo looper
	{y = Synth(\monolooper, [\bufnum, b.bufnum])}); // new mono looper
y.set(\start, 0, \end, 10, \tpose, 0, \mode, 1);
)

(
y.set(\tpose, -12);
)


(
var score;
j = [1, 2, 3, 4, 5, 6, 7, 8];
k = [0,3,7,12];
//score = j++k++(k-3)++(k-3)++[j]++[j-2];
Pbind(\tpose, Pseq(j), \instrument, \test
).play;
)

y.free;

(
// let's end this
y.free;b.close;b.free;
)