// Streaming audio
(
b = Buffer.cueSoundFile(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav", 0, 1, pow(2,16));
p = {DiskIn.ar(1,b,1)}.play; // buffers can be passed in place of the buffer number
)

// clean up the mess
p.release;b.close;b.free;