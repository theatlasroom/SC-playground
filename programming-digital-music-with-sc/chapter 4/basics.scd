// check if the file exists
(
~path = Platform.resourceDir +/+ "sounds/a11wlk01.wav";
File.exists(~path);
// use the SoundFile class to get information about the sound file
SoundFile.use(~path, {|f| f.sampleRate});
SoundFile.use(~path, {|f| f.numChannels});
SoundFile.use(~path, {|f| f.numFrames});
)

// DiskIn
// Use the DiskIn class to stream audio and playback sound files
// DiskIn.ar(numChannels - mono, stereo etc, bufNum, loop: 0)
// Buffer.cueSoundFile - shortcut to create a buffer and read a soundfile ready for streaming
// Buffer.cueSoundFile(server, path, startFrame, numChannels, bufferSize)
// bufferSize must be a power of 2


// Sample buffers
// Buffer.read can be used to allocate and read a buffer
// Buffer.read(server, path, startFrame, numFrames:-1, action, bufNum);
// numFrames default value -1 means read the whole file
// action is a function to be evaluated once the file has been read, the function is passed this buffer as an argument

// Resampling
// Default sample rate of SC is 44.1kHz
// To ensure proper playback a sample should be played back at a a rate of bufferSampleRate / serverSampleRate ie 48kHz -> 48000/44100
// use BufRateScale.ir(b.bufNum) to calculate the sample rate conversion

// PlayBuf
// used to play back a sample in a buffer at its correct sample rate
// PLayBuf.ar(numChannels, bufnum:0, rate:1, trigger:1, startPos:0, loop:0, doneAction:0)
// rate -> sample rate 1 = normal,
// trigger -> when a signal changes from -ve to +ve, jumps to startPos
// can be used as a function or a synthdef
// PLayBuf - function - can handle multiple channels
// PLayBuf - SynthDef - Requires multiple SynthDefs for each number of channesl ie 1 channel synthdef, 2 channel etc

// Transposition
// use a buffer and a pointer
// a pointer is an index to a location in a buffer
// achieved with BuffRd - create the buffer and Phasor - act as a pointer
// BuffRd.ar(numChannels, bufnum:0, phase:0, loop:1, interpolation:2)
// Phasor.ar(trig:0, rate:1, start:0, end:1, resetPos:0)
// trig - occurs when a signal changes from -ve to +ve, jump to resetPos
// rate - rate of change per sample
// When looping a sample, the phasor determines if it loops or not








