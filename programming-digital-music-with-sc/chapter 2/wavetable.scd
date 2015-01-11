/* Create a wavetable */
// use ~ for global variables
~buffer = Buffer.alloc(s, 2**16); // buffer, with size (2 to the power of 16)
~fund = 110; // fundamental frequency
~nyquistfreq = s.sampleRate/2;
~harmN = ((~nyquistfreq)/~fund).floor; // max number of harmonics to avoid aliasing
~norm = -3.dbamp; // normalised amplitude level
(
var sine;
sine = ~buffer.sine1([1]);
{Osc.ar(sine, ~fund, mul:~norm)}.play;
)

(
var harm, saw;
harm = Harmonics(~harmN);
saw = ~buffer.sine1(harm.decay);
{Osc.ar(saw, ~fund)}.play;
)

(
var freqs, amps, square;
freqs = (1, 3..~harmN);
amps = 1/freqs;
square = ~buffer.sine2(freqs, amps);
{Osc.ar(square, ~fund, mul:~norm)}.play;
)

(
var freqs, amps, triangle;
freqs = (1, 3..~harmN);
amps = 1/freqs.pow(2);
triangle = ~buffer.sine2(freqs, amps);
{Osc.ar(triangle, ~fund, mul:~norm)}.play;
)

(
var freqs, amps, pulse;
freqs = (1!~harmN);
amps = 1/freqs;
pulse = ~buffer.sine1(amps, asWavetable:false);
{Osc.ar(pulse, ~fund, mul:~norm)}.play;
)

~buffer.free;