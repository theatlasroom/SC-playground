/* Sample patterns */
Pseq([(degree:3)]).play; // a single event outputs F above C
Pseq([(degree:0), (degree:[0,3]), (degree:[0,3,5])]).play; // multiple events output a single note (middle C) an interval of a Fourth and the triad C, F, A
Pbind(\degree, Pseq([0,3,5])).play; // single note outpus an arpeggio 1 beat apart
Pbind(\degree, Pseq([[0,3,5],[0,3b,5],[0,3,5s]])).play; // chords played a beat apart
Pbind(\note, Pseq((0..12).scramble, 4), \dur, (1/8)).play; // play a random sequence 4 times