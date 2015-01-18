// Resampling: sample rate conversion
~path = Platform.resourceDir +/+ "sounds/a11wlk01.wav";
b =  Buffer.read(s, ~path);
BufRateScale.ir(b.bufnum);
x = {PlayBuf.ar(b.numChannels, b.bufnum, BufRateScale.ir(b.bufnum))}.play;



