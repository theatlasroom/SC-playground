// Resampling: sample rate conversion
~path = Platform.resourceDir +/+ "sounds/a11wlk01.wav";
b =  Buffer.read(s, ~path); // create the buffer
x = {PlayBuf.ar(b.numChannels, b.bufnum, BufRateScale.ir(b.bufnum))}.play;

// free the resources
x.release;b.close;b.free;



