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