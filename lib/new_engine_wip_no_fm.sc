Engine_Tetrabobo : CroneEngine {

	var params;
	var firstbar;
	var secondbar;
	var thirdbar;
	var fourthbar;

	alloc{

  var masterrise = 0.001;
  var masterfall = 0.002;
	var firsttime = 0.001;
	var secondtime = 0.001;
	var thirdtime = 0.001;
	var fourthtime = 0.001;

SynthDef("barone",
	{
	arg firstattack = 1,
	firstrelease = 1,
	panone = 0;

	var firstamp_env = Env.perc(
					attackTime: firstattack,
					releaseTime: firstrelease,
					level: 1
				).kr(doneAction:2);

	var firstretrigger = Trig1.ar(Pulse.ar((1/((firsttime + masterrise) + (firsttime + masterfall))), 0.5, 1), 4000.reciprocal);

	var firstshape = Env.perc((firsttime + masterrise), (firsttime + masterfall), 1);

	var firstsignal = Pan2.ar(SineShaper.ar(EnvGen.ar(firstshape, firstretrigger),mul:firstamp_env),panone);

	Out.ar(
		0,
		firstsignal;
	)
}).add;

SynthDef("bartwo",
	{
	arg secondattack = 1,
	secondrelease = 1,
	pantwo = 0;

	var secondamp_env = Env.perc(
					attackTime: secondattack,
					releaseTime: secondrelease,
					level: 1
				).kr(doneAction:2);

	var secondretrigger = Trig1.ar(Pulse.ar((1/((secondtime + masterrise) + (secondtime + masterfall))), 0.5, 1), 4000.reciprocal);

	var secondshape = Env.perc((secondtime + masterrise), (secondtime + masterfall), 1);

	var secondsignal = Pan2.ar(SineShaper.ar(EnvGen.ar(secondshape, secondretrigger),mul:secondamp_env),pantwo);

	Out.ar(
		0,
		secondsignal;
	)
}).add;

SynthDef("barthree",
	{
	arg thirdattack = 1,
	thirdrelease = 1,
	panthree = 0;

	var thirdamp_env = Env.perc(
					attackTime: thirdattack,
					releaseTime: thirdrelease,
					level: 1
				).kr(doneAction:2);

	var thirdretrigger = Trig1.ar(Pulse.ar((1/((thirdtime + masterrise) + (thirdtime + masterfall))), 0.5, 1), 4000.reciprocal);

	var thirdshape = Env.perc((thirdtime + masterrise), (thirdtime + masterfall), 1);

	var thirdsignal = Pan2.ar(SineShaper.ar(EnvGen.ar(thirdshape, thirdretrigger),mul:thirdamp_env),panthree);

	Out.ar(
		0,
		thirdsignal;
	)
}).add;

SynthDef("barfour",
	{
	arg fourthattack = 1,
	fourthrelease = 1,
	panfour = 0;

	var fourthamp_env = Env.perc(
					attackTime: fourthattack,
					releaseTime: fourthrelease,
					level: 1
				).kr(doneAction:2);

	var fourthretrigger = Trig1.ar(Pulse.ar((1/((fourthtime + masterrise) + (fourthtime + masterfall))), 0.5, 1), 4000.reciprocal);

	var fourthshape = Env.perc((fourthtime + masterrise), (fourthtime + masterfall), 1);

	var fourthsignal = Pan2.ar(SineShaper.ar(EnvGen.ar(fourthshape, fourthretrigger),mul:fourthamp_env),panfour);

	Out.ar(
		0,
		fourthsignal;
	)
}).add;

		params = Dictionary.newFrom([
			\masterrise, 0.001,
			\masterfall, 0.002,
			\firsttime, 0.001,
			\firstattack, 1,
			\firstrelease, 1,
			\panone, 0,
			\secondtime, 0.002,
			\secondattack, 1,
			\secondrelease, 1,
			\pantwo, 0,
			\thirdtime, 0.003,
			\thirdattack, 1,
			\thirdrelease, 1,
			\panthree, 0,
			\fourthtime, 0.004,
			\fourthattack, 1,
			\fourthrelease, 1,
			\panfour, 0
		]);

		params.keysDo({ arg key;
			this.addCommand(key, "f", { arg msg;
				params[key] = msg[1];
			});
		});

		this.addCommand("firstbartrig", "f", { arg msg;
			firstbar = Synth.new("barone", [\firsttime, msg[1]] ++ params.getPairs)
		});

		this.addCommand("secondbartrig", "f", { arg msg;
			secondbar = Synth.new("bartwo", [\secondtime, msg[1]] ++ params.getPairs)
		});

		this.addCommand("thirdbartrig", "f", { arg msg;
			thirdbar = Synth.new("barthree", [\thirdtime, msg[1]] ++ params.getPairs)
		});

		this.addCommand("fourthbartrig", "f", { arg msg;
			fourthbar = Synth.new("barfour", [\fourthtime, msg[1]] ++ params.getPairs)
		});
	}
}
