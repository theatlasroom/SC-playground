/*
General notes and tests on things for chapter 3
*/

/*
Control structures
- do: (collection).do(function{|value,index|...})
- if: if(expression, trueFunction, falseFunction); // false can be left out which will return nil
- select: ie Select.ar(index, array)

Sequencing
- Tempoclock measured in bps (beats per second)

Streams
- a sequence of values
- any object that responds to the next a reset methods
- every object is a stream

Routine
- interruptible function ie Routine(func, stackSize:512)
- first argument is a function, normal function that can return its value part way through execution
- used for sequencing by using the wait or yield methods
-- both return the value of the Routine at that stage of execution
- A routine is started with the nxt method
-- each call to next returns the value of the yield method
-- when it reaches its end (if it has one) it returns nil
- reset is used to restart the Routine
- play a routine with .play, Routine.play(clock:TempoClock.default, quant:nil)
-- clock argument uses the wait method to schedule the Routine to play an event
-- quant returns a Quant object, calculates the start time when the Routine will start playing on the specified clock

Events
- represents an action, denoted with a set of parentheses ()
- Events consist of one or more pairs of eys and values, some keys with defaults include
-- instrument: name of instrument to be used
-- freq / midinote / note / degree: note in different formats defaults to middle c | (60) | 440Hz
-- dur: duration in beats, default 1
-- amp: 0.1 amplitude
-- delta: 1 time delay in beats before the next note starts
-- timingOffset: 0.0 delay in beats relative to the current time

Pattern
- an abstract class for all the pattern classes
- pattern classes start wth P
- use the same key-value pairing as Event, but the value is treated as a stream
- a pattern is an object that responds to the asStream method
- two important methods
-- Pseq(list (array or list etc), repeats:1, offset:0): create a sequence
-- Pbind: bind a key to a value to create a value stream and combines one or more value streams into a single stream of events
- a pattern is played with with the play(clock:TempoClock.default, protoEvent:Event.default, quant) method

*/