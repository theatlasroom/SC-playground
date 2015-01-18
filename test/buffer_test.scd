(
s.boot; // boot the server
s.meter; // show the mixer
s.plotTree; // show the nodes
)


(
s.postln("Init the buffers");
~b0 = Buffer.read(s,"/Users/bardock/Desktop/Raw Audio/split.redux/FOLDER04/4CH000M.wav");
~b1 = Buffer.read(s,"/Users/bardock/Desktop/Raw Audio/split.redux/FOLDER04/4CH001M.wav");
)

~b0.play;


(
//var numSamples;
s.postln("Buffer b0 information");
~b0.numFrames;
~b0.numChannels;
~b0.duration;
//numSamples = numFrames * numChannels;
//s.postln(numSamples);
~b0.query;
)

(
//var numSamples;
s.postln("Buffer b1 information");
~b1.numFrames;
~b1.numChannels;
~b1.duration;
//numSamples = numFrames * numChannels;
//s.postln(numSamples);
~b1.query;
)

// sampleRate is a measure of number of samples in a second
// get 1 second starting from the 1millionth frame
~b0_part = Buffer.read(s, s1, 1000000, ~b0_part.sampleRate*1);

~b0_part.play;


~s1 = "/Users/bardock/Desktop/Raw Audio/split.redux/FOLDER04/4CH000M.wav";
// get the last second of sound,last frame is total number of frames - 1
~b0_part = Buffer.read(s, ~s1, ((~b0_part.numFrames - 1) - ~b0_part.sampleRate), (~b0_part.numFrames - 1));
