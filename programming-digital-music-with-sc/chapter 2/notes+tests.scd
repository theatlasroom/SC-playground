/*
General notes and tests on things for chapter 2
*/

// ARRAYS
/*
Can be defined in a few ways
- x = [1, 2, 3, 4, 5];
- Array.fill(size, function): function takes the array index and returns a value
ie Array.fill(4, {|i| i * 2}) => [0,2,4,6]
- x!n, creates an array of size n, where each item has value x: 1!5 => [1,1,1,1,1]
- (a..b) => creates a range from a to b
- (a,b..c) creates a range from a to c, with step size (b-a)
ie (1,3..10) => [1,3,5,7,9]
 */

/*
Envelopes
- Created with the Env class
- sustaining envelopes have a variable duration, non-sustaining have a fixed duration
- plot: displays an evenloper in a window so you can check its shape
- test: plays back an envelope using a SinOsc so you can check how it sounds
- amplitude envelopes help to protect speakers from damage and add dynamics to a sound

Custom envelopes
- envelopes can be generated using EnvGen once they have been created
*/

EnvGen.ar(envelope, gate:1, levelScale:1, levelBias:0, timeScale:1, doneAction:0);

// Arithmetic
// No order of precedence - use parenthesis to signify order

/*
Frequency

can be stored in 3 ways
- cps / Hz: natively stored in cps (cycles per second aka Hz)
- oct: octave decimal, aka 4.75 => 4th octave + 3/4 of an octave
- midi: midi note ie A4 => 69

conversions can be made
- octcps, midicps, cpsoct, cpsmidi (cps => midi)
*/

/*
Phase
- the fraction of a wave cycle that has elapsed relative to its start
- measured in radians or degrees
- the phase argument in UGens specifies where the wave should start from
*/

/*
Waveforms
- SinOsc (Sine wave): just the fundamental
- Saw (Sawtooth wave): all the partials, each partial has an amplitude of 1/n, where n is the partial number ie, 2nd partial has amplitude 1/2, 3rd partial => 1/3
- LFTri (Triangle wave): contains odd numbered partials only, the amplitude is inversely proportional to the square of its number ie 3rd partial => amplitude 1/9, fifth => 1/25
- Pulse (pulse wave): used for square and pulse (rectangular waves)
-- can also be defined by specifying the number of harmonics with the Blip class
-- Pulse (default settings): gives a square wave, odd numbered partials only, the amplitude of each is inversely proportional to its number, ie 3rd partial -> amplitude of 1/3
-- rectangular waves is deteremined by the duration of the pulse compared to its wavelength (aka the duty cycle 1:n where n is an integer). Every nth partial is missing
-- sawtooth has a duty cycle of 1:2 => every 2nd partial is missing ie, has partials 1, 3, 5, 7...
-- duty cycle 1:3 => every 3rd partial is missing, ie 1, 2, 4, 5, 7, 8, 10
*/

/*
Buffers (aka table, or function table)
- used to store data in memory
- you can store a waveform in one or samples etc
- Buffer.create creates a buffer
- Buffer.alloc both creates a buffer and allocates its memory
-- takes params:
--- server: the server to allocate the buffer, normally just the default
--- numFrames: number of samples (frames) per channel
--- numChannels: number of output channels, 1=mono (default), 2=stereo etc
--- completionMessage: optional completion message or function
--- bufnum: buffer id number
- size should usually be set to a power of 2
- sine1 and sine2 methods both fill a buffer with sine wave partials with specific amplitudes, sine2 adds specific frequencies
-- Buffer.sine1(amps, nomarlize:true, asWavetable:true, clearFirst:true)
--- amps: array of amplitudes for the partials
--- normalize: normalize the buffer to a peak value of 1.0, false -> you can set your own target amplitude
--- asWavetable: write data in wavetable format so it can be read by Osc, false for OscN
--- clearFirst: clear the buffer before writing to it

Wavetable format
- requires a buffer size that is a power of 2 AND twice the size of the wavetable
- if you want to put 50 pieces of data, then the buffer should be 128




