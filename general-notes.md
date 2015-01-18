# General notes

## Envelopes
* custom signal shape to control paramters, such as Line
* doneAction can be used to free the envelope once it is used
** doneAction will use the shortest time available, so if you used it for both freq and amplitude, it would use whichever Envelope finishes first to trigger the free event
* dbamp -> decibels to amplitude

### EnvGen
* used to create an envelope
* has a gate argument so it can be sustained and can also be retriggered
* Takes the following arguments:
** levels -> array of levels, ordered values EnvGen will output ie [0,1,0] start at 0, rise to 1, return to 0
** times -> the time to take between each level (should usually have 1 less element than the levels array)
** curve -> how to interpolate between values, can be either a symbol ie \exp or a array the same size as times
* gate can be used to repeat the envelope fixed-length (non-sustaining) envelopes
** default value 0
** to retrigger gate must change from a non-positive value to a positive value, ie 0, then 1

## Channels
* Mix can be used to boil down an array of signals into 1 mono signal
* Splay is like mix but spreads over stereo
* for output ugens simply provide the 2 (or more signals) and assign it to bus 0

## Nodes, Busses and order of execution
* Node - abstract class representing modules, we usually deal with it through Synth and Group
* Busses pass signals between synths
** By default there are 128 busses (0-127)
** 0-7 hardware output
** 8-15 hardware input
** 16 - 127 private busses (for the user)
** avoid hardware busses or you might get feedback
** use the bus object so supercollider will pick the best choice bus to start from
* Order of execution deals with the order of nodes on the server
** use groups to control ordering
** set messages can be sent to Groups, which apply to all members of the group