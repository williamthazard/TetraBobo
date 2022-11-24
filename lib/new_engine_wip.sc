	var masterrise = 0.0001;
	var masterfall = 0.0002;
	var chaos = 1;
	var firsttime = 0.001;
	var secondtime = 0.001;
	var thirdtime = 0.001;
	var fourthtime = 0.001;

	var firstretrigger = Trig1.ar(
					Pulse.ar(
				(1/(((firsttime + masterrise) + (Pulse.ar((1/((fourthtime + masterrise) + (fourthtime + masterfall))),0.5,mul:chaos)))
					+ ((firsttime + masterfall) + (Pulse.ar((1/((fourthtime + masterrise) + (fourthtime + masterfall))),0.5,mul:chaos))))),
						0.5,
						1),
					4000.reciprocal);

	var secondretrigger = Trig1.ar(
					Pulse.ar(
						(1/(((secondtime + masterrise) + (Pulse.ar((1/((firsttime + masterrise) + (firsttime + masterfall))),0.5,mul:chaos)))
							+ ((secondtime + masterfall) + (Pulse.ar((1/((firsttime + masterrise) + (firsttime + masterfall))),0.5,mul:chaos))))),
						0.5,
						1),
					4000.reciprocal);

	var thirdretrigger = Trig1.ar(
					Pulse.ar(
						(1/(((thirdtime + masterrise) + (Pulse.ar((1/((secondtime + masterrise) + (secondtime + masterfall))),0.5,mul:chaos)))
							+ ((thirdtime + masterfall) + (Pulse.ar((1/((secondtime + masterrise) + (secondtime + masterfall))),0.5,mul:chaos))))),
						0.5,
						1),
					4000.reciprocal);

	var fourthretrigger = Trig1.ar(
					Pulse.ar(
						(1/(((fourthtime + masterrise) + (Pulse.ar((1/((thirdtime + masterrise) + (thirdtime + masterfall))),0.5,mul:chaos)))
							+ ((fourthtime + masterfall) + (Pulse.ar((1/((thirdtime + masterrise) + (thirdtime + masterfall))),0.5,mul:chaos))))),
						0.5,
						1),
					4000.reciprocal);

	var firstshape = Env.perc(
			(firsttime + masterrise) + (LFTri.ar((1/((fourthtime + masterrise) + (fourthtime + masterfall))),mul:chaos)),
			(firsttime + masterfall) + (LFTri.ar((1/((fourthtime + masterrise) + (fourthtime + masterfall))),mul:chaos)));

	var secondshape = Env.perc(
			(secondtime + masterrise) + (LFTri.ar((1/((firsttime + masterrise) + (firsttime + masterfall))),mul:chaos)),
			(secondtime + masterfall) + (LFTri.ar((1/((firsttime + masterrise) + (firsttime + masterfall))),mul:chaos)));

	var thirdshape = Env.perc(
			(thirdtime + masterrise) + (LFTri.ar((1/((secondtime + masterrise) + (secondtime + masterfall))),mul:chaos)),
			(thirdtime + masterfall) + (LFTri.ar((1/((secondtime + masterrise) + (secondtime + masterfall))),mul:chaos)));

	var fourthshape = Env.perc(
			(fourthtime + masterrise) + (LFTri.ar((1/((thirdtime + masterrise) + (thirdtime + masterfall))),mul:chaos)),
			(fourthtime + masterfall) + (LFTri.ar((1/((thirdtime + masterrise) + (thirdtime + masterfall))),mul:chaos)));

a = SynthDef("barone",
	{arg firstattack = 1,
	firstrelease = 1,
	firstpan = 0;

	var firstamp_env = Env.perc(
					attackTime: firstattack,
					releaseTime: firstrelease,
					level: 1
				).kr(doneAction:2);

	var firstsignal = Pan2.ar(SineShaper.ar(EnvGen.ar(firstshape, firstretrigger),mul:firstamp_env),firstpan);

	Out.ar(
		0,
		firstsignal;
	)
}).add;

b = SynthDef("bartwo",
	{arg secondattack = 1,
	secondrelease = 1,
	secondpan = 0;

	var secondamp_env = Env.perc(
					attackTime: secondattack,
					releaseTime: secondrelease,
					level: 1
				).kr(doneAction:2);

	var secondsignal = Pan2.ar(SineShaper.ar(EnvGen.ar(secondshape, secondretrigger),mul:secondamp_env),secondpan);

	Out.ar(
		0,
		secondsignal;
	)
}).add;

c = SynthDef("barthree",
	{arg thirdattack = 1,
	thirdrelease = 1,
	thirdpan = 0;

	var thirdamp_env = Env.perc(
					attackTime: thirdattack,
					releaseTime: thirdrelease,
					level: 1
				).kr(doneAction:2);

	var thirdsignal = Pan2.ar(SineShaper.ar(EnvGen.ar(thirdshape, thirdretrigger),mul:thirdamp_env),thirdpan);

	Out.ar(
		0,
		thirdsignal;
	)
}).add;

d = SynthDef("barfour",
	{arg fourthattack = 1,
	fourthrelease = 1,
	fourthpan = 0;

	var fourthamp_env = Env.perc(
					attackTime: fourthattack,
					releaseTime: fourthrelease,
					level: 1
				).kr(doneAction:2);

	var fourthsignal = Pan2.ar(SineShaper.ar(EnvGen.ar(fourthshape, fourthretrigger),mul:fourthamp_env),fourthpan);

	Out.ar(
		0,
		fourthsignal;
	)
}).add;
		
		a.play;
