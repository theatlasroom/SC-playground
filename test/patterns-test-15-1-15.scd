(
s.boot;
s.plotTree;
s.meter;
)

// arpeggios
(
SynthDef(\sine, {
	|freq=440, amp=0.707, dur=1|
	var env, envgen;
	env = Env([0,1,1,0]*amp, [0.01, dur-0.02, 0.01]);
	envgen = EnvGen.ar(env, doneAction:2);
	Out.ar(0, SinOsc.ar(freq, mul:envgen));
}).add;
)

// Routine based sequencing
(
var key=60, score;
j = [0,4,7,12]; // major arpeg
k = [0,3,7,12]; // minor arpeg
score = j++k++(k-3)++(k-7)++(j-7)++(j-7)++[j-5]; // ++ used to concat the arrats
// random score, mixes individual and arrays of notes
score = (key+score).midicps; // add 60 to all the intervals so 0 = midi 60 = middle C
Routine({ // start the routine
	score.do{|i| // for each
		if (i.size>0, // if the size of the element i is >0 ie, if its an array
			{i.size.do{|y| Synth(\sine, [\freq, i[y], \amp, 0.707/i.size, \dur, 0.5])};      1.wait}, // play each element of the array it with a 1 second pause
			{Synth(\sine, [\freq, i, \dur, 0.25]); 0.25.wait}); // play each note with a 0.25 s pause
}}).play;
)

{SinOsc.ar(440)}.play;

// pattern based sequencing
Pseq([(degree:3)]).play;
Pseq([(degree:0), (degree:[0,3]), (degree:[0,3,5])]).play;
Pbind(\degree, Pseq([0,3,5])).play;
Pseq([(degree:0), (degree:[0,3b]), (degree:[0,3s,5])]).play; // sharps and flats
Pbind(\note, Pseq((0..12).scramble, 4), \dur, (1/8)).play;

(
var score;
j = [0,4,7,12];
k = [0,3,7,12];
score = j++k++(k-3)++(k-3)++[j]++[j-2];
Pbind(\note, Pseq(score), \dur, Pseq((1/4!24)++(1!2)), \instrument, \sine
).play;
)
