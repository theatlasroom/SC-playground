(
SynthDef.new(\longsine, {
	|freq=220,out=0, amp=0.5, frac=1, gate=1|
	var sine, sine2, env, gen;
	env = Env.new([0.1, 0.3, 0.7, 1, 0.4, 0.1], [1/frac, 2/frac, 3/frac, 4/frac, 5/frac], \lin);
	gen = EnvGen.kr(env,gate, doneAction:2);

	sine = SinOsc.ar([freq], mul:amp) * gen;
	sine2 = SinOsc.ar([freq-freq/10], mul:amp) * gen;

	Out.ar(out, [sine, sine2]);
}).add;

SynthDef.new(\reverb, {
	|in=0, out=0|
	var sig;
	sig = In.ar(in, 1); // use 1 channel
	sig = FreeVerb.ar(sig, 0.5, 0.8, 0.2)!2;
	Out.ar(out, sig);
}).add;

SynthDef.new(\white, {
	|out=0, amp=0.5, pan_rate=10|
	var sig;
	sig = WhiteNoise.ar(mul:amp/2);
	sig = Pan2.ar(sig,LFNoise1.kr(pan_rate/2));
	Out.ar(out, sig);
}).add;

SynthDef.new(\pink, {
	|out=0, amp=0.5, pan_rate=10|
	var sig;
	sig = PinkNoise.ar(mul:amp);
	sig = Pan2.ar(sig,LFNoise1.kr(pan_rate));
	Out.ar(out, sig);
}).add;

~sources = Group.new;
~noise = Group.after(~sources);
~fx = Group.after(~noise);

~fxBus = Bus.audio(s, 2);
Synth.new(\reverb, [\in, ~fxBus], ~fx); // reverb listens to the fxBus and outputs to the fx group
~size=24;
)

// noise chain
(
var amp = 0.5;
s.prepareForRecord;
s.record;
Synth.new(\white, [\out:~fxBus,\amp:amp], ~noise);
Synth.new(\pink, [\out:~fxBus,\amp:amp], ~noise);
)

~noise.set(\pan_rate,1);
~noise.set(\amp,0.1);

// sines
(
~size.do{|item, count|

	Synth.new(
		\longsine,
		[
			\freq:880/count,
			\frac:count,
			\amp:0.1,
			\gate:1,
			\out:~fxBus
		],
		~sources
	);
}
)

(
~size.do{|item, count|

	Synth.new(
		\longsine,
		[
			\freq:880/(~size-count),
			\frac:count,
			\amp:0.1,
			\gate:1,
			\out:~fxBus
		],
		~sources
	);
}
)

(
~sources.set(\gate, 0);
~sources.set(\gate, 1);
)

(
s.stopRecording;
~sources.freeAll;
~noise.freeAll;
)


