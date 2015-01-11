/* Sequencing using control structures */
(
~score = {
	var freqs, size=32, selector, output;
	freqs = Array.fill(size, {rrand(36, 84).midicps}); //  choose from notes +ve and -ve 2 octaves from middle c (60)
	selector = LFSaw.ar(1.0, mul:size/2, add:size/2);
	output = Select.kr(selector, freqs);
}
)

// select some synths to be used
~synths = [SinOsc, Saw, Pulse, LFTri, Blip];
(
var choice, amp, output;
choice = [0,4]; // choose the synths from the global array we want to use
amp = 0.707/(choice.size); // scale the amplitude basde on the number ofsynths
output = Array.newClear(choice.size); // create a new output array
choice.size.do{|i| // for each choice
	// make sure it is within th range of options for synths ie if we have 5 synths, then the value has to be between 0 and 4
	choice[i] = if (choice[i]>0, choice[i], 0);
	choice[i] = if (choice[i]<(~synths.size), choice[i], (~synths.size-1));
	output[i] = {~synths[choice[i]].ar(~score, mul:amp)}.play; // play the chosen synth
}
)