/* Pitch conversions */
// all play an A4
{SinOsc.ar(440)}.play;
{SinOsc.ar(midicps(69))}.play;
{SinOsc.ar(octcps(4.75))}.play;

// Play a c major
(
var cmaj, amp;
cmaj = [60,64,67,72].midicps;
amp = 0.707/cmaj.size; // scale down the amplitude by the number of partials we will use - avoid clipping
// create an oscillator for each partial
{SinOsc.ar(cmaj[0], mul:amp)}.play;
{SinOsc.ar(cmaj[1], mul:amp)}.play;
{SinOsc.ar(cmaj[2], mul:amp)}.play;
{SinOsc.ar(cmaj[3], mul:amp)}.play;
)
