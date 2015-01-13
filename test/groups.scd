(
s.boot; // boot the server
s.meter; // show the mixer
s.plotTree; // show the nodes
)

(
SynthDef(\osc, {
	|freq=220, out=0, amp=0.5|
	var sine, sine2;
	sine = SinOsc.ar(freq, mul:amp/2, add:0);
	sine2 = SinOsc.ar(freq-(freq/5), mul:amp/2, add:0);
	Out.ar(out, [sine, sine2]);
}).add;
)


(
SynthDef.new(\blip, {
	|out=0, dens=2, decay=0.2, fund=300|
	var freq, trig, sig;
	freq = LFNoise0.kr(3).exprange(300, 1200).round(300);
	sig = SinOsc.ar(freq) * 0.25;
	trig = Dust.kr(2);
	sig = sig * EnvGen.kr(Env.perc(0.01, 0.2), trig);
	sig = Pan2.ar(sig, LFNoise1.kr(10));
	Out.ar(out, sig);
}).add;

SynthDef.new(\reverb, {
	|in=0, out=0|
	var sig;
	sig = In.ar(in, 1); // use 1 channel
	sig = FreeVerb.ar(sig, 0.5, 0.8, 0.2)!2;
	Out.ar(out, sig);
}).add;
)

x = Synth.new(\reverb, [\in, ~reverbBus], ~fx);


8.do{
	Synth.new(
		\blip, [
			\out, ~reverbBus,
			\fund, exprand(60, 300).round(300)
		], ~sources
	);
}

~sources.set(\dens, 0);
~sources.set(\decay, 0);
~sources.set(\, ~reverbBus);

~reverbBus = Bus.audio(s, 2);

x.free;
y.free;

g.freeAll;

// add a new group node
g = Group.new;

// create seperate groups for sources and fx
(
~sources = Group.new;
~fx = Group.after(~sources); // add all fx AFTER sources
)

// kill all
(
~sources.freeAll;
~fx.freeAll;
s.freeAll;
)