m = SynthDef("mathy",
	{
	arg risetime = 0.001135,
	falltime = 0.001135,
	attack = 1,
	release = 1;

	var amp_env = Env.perc(
					attackTime: attack,
					releaseTime: release,
					level: 1
				).kr(doneAction:2);

	var retrigger = Trig1.ar(Pulse.ar((1/(risetime + falltime)), 0.5, 1), 4000.reciprocal);

	var shape = Env.perc(risetime, falltime, 1);

	var signal = Pan2.ar(SineShaper.ar(EnvGen.ar(shape, retrigger),mul:amp_env));

	Out.ar(
		0,
		signal;
	)
}).add;

m.play;
