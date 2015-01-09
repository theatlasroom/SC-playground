/* Play a sine wave */
(
	/*
	ar - audio rate, used for any class that produces audio output
	a class that generates a control signal can use either ar or kr (control rate)
	a class that does not change its value should use ir (initialisation rate)
	*/
	var sinewave;
	sinewave = {SinOsc.ar(freq:440, phase:0, mul:1, add:0)};
	sinewave.play;

)
