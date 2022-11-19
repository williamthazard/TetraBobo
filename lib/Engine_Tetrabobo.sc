Engine_Tetrabobo : CroneEngine {

	var params;
	var firstbar;
	var secondbar;
	var thirdbar;
	var fourthbar;

	alloc{

SynthDef("barone",
		{   arg firstpitch = 440,
			fourthpitch = 440,
			firstwidth = 0.75,
			fourthwidth = 0.75,
			firstform = 440,
			fourthform = 440,
			firstphase = 0,
			fourthphase = 0,
			chaos = 0,
			firstattack = 0,
			firstrelease = 0,
			firstamp = 0.2,
			firstpan = 0;

			var firstbar_env = Env.perc(attackTime: firstattack, releaseTime: firstrelease, level: firstamp).kr(doneAction:2);
			var first_signal = Pan2.ar(
					SineShaper.ar(
						FormantTriPTR(firstpitch + (
							chaos * FormantTriPTR(
							fourthpitch,
							fourthform,
							fourthwidth,
							fourthphase)),
						firstform,
						firstwidth,
						firstphase),mul: firstbar_env),
					firstpan);

				Out.ar(
					0,
					first_signal;
				)
		}).add;

SynthDef("bartwo",
		{   arg secondpitch = 440,
			firstpitch = 440,
			secondwidth = 0.75,
			firstwidth = 0.75,
			secondform = 440,
			firstform = 440,
			secondphase = 0,
			firstphase = 0,
			chaos = 0,
			secondattack = 0,
			secondrelease = 0,
			secondamp = 0.2,
			secondpan = 0;

			var secondbar_env = Env.perc(attackTime: secondattack, releaseTime: secondrelease, level: secondamp).kr(doneAction:2);
			var second_signal = Pan2.ar(
					SineShaper.ar(
						FormantTriPTR(secondpitch + (
							chaos * FormantTriPTR(
							firstpitch,
							firstform,
							firstwidth,
							firstphase)),
						secondform,
						secondwidth,
						secondphase),mul: secondbar_env),
					secondpan);

				Out.ar(
					0,
					second_signal;
				)
		}).add;

SynthDef("barthree",
		{   arg thirdpitch = 440,
			secondpitch = 440,
			thirdwidth = 0.75,
			secondwidth = 0.75,
			thirdform = 440,
			secondform = 440,
			thirdphase = 0,
			secondphase = 0,
			chaos = 0,
			thirdattack = 0,
			thirdrelease = 0,
			thirdamp = 0.2,
			thirdpan = 0;

			var thirdbar_env = Env.perc(attackTime: thirdattack, releaseTime: thirdrelease, level: thirdamp).kr(doneAction:2);
			var third_signal = Pan2.ar(
					SineShaper.ar(
						FormantTriPTR(thirdpitch + (
							chaos * FormantTriPTR(
							secondpitch,
							secondform,
							secondwidth,
							secondphase)),
						thirdform,
						thirdwidth,
						thirdphase),mul: thirdbar_env),
					thirdpan);

				Out.ar(
					0,
					third_signal;
				)
		}).add;

SynthDef("barfour",
		{   arg fourthpitch = 440,
			thirdpitch = 440,
			fourthwidth = 0.75,
			thirdwidth = 0.75,
			fourthform = 440,
			thirdform = 440,
			fourthphase = 0,
			thirdphase = 0,
			chaos = 0,
			fourthattack = 0,
			fourthrelease = 0,
			fourthamp = 0.2,
			fourthpan = 0;

			var fourthbar_env = Env.perc(attackTime: fourthattack, releaseTime: fourthrelease, level: fourthamp).kr(doneAction:2);
			var fourth_signal = Pan2.ar(
					SineShaper.ar(
						FormantTriPTR(fourthpitch + (
							chaos * FormantTriPTR(
							thirdpitch,
							thirdform,
							thirdwidth,
							thirdphase)),
						fourthform,
						fourthwidth,
						fourthphase),mul: fourthbar_env),
					fourthpan);

				Out.ar(
					0,
					fourth_signal;
				)
		}).add;

		params = Dictionary.newFrom([
			\firstpitch, 440,
			\firstform, 440,
			\firstwidth, 0.75,
			\firstphase, 0,
			\firstamp, 0.2,
			\firstpan, 0,
			\firstattack, 0,
			\firstrelease, 0.5,
			\secondpitch, 440,
			\secondform, 440,
			\secondwidth, 0.75,
			\secondphase, 0,
			\secondamp, 0.2,
			\secondpan, 0,
			\secondattack, 0,
			\secondrelease, 0.5,
			\thirdpitch, 440,
			\thirdform, 440,
			\thirdwidth, 0.75,
			\thirdphase, 0,
			\thirdamp, 0.2,
			\thirdpan, 0,
			\thirdattack, 0,
			\thirdrelease, 0.5,
			\fourthpitch, 440,
			\fourthform, 440,
			\fourthwidth, 0.75,
			\fourthphase, 0,
			\fourthamp, 0.2,
			\fourthpan, 0,
			\fourthattack, 0,
			\fourthrelease, 0.5,
			\chaos, 0
		]);

		params.keysDo({ arg key;
			this.addCommand(key, "f", { arg msg;
				params[key] = msg[1];
			});
		});

		this.addCommand("firstbartrig", "f", { arg msg;
			firstbar = Synth.new("barone", [\firstpitch, msg[1]] ++ params.getPairs)
		});

		this.addCommand("secondbartrig", "f", { arg msg;
			secondbar = Synth.new("bartwo", [\secondpitch, msg[1]] ++ params.getPairs)
		});

		this.addCommand("thirdbartrig", "f", { arg msg;
			thirdbar = Synth.new("barthree", [\thirdpitch, msg[1]] ++ params.getPairs)
		});

		this.addCommand("fourthbartrig", "f", { arg msg;
			fourthbar = Synth.new("barfour", [\fourthpitch, msg[1]] ++ params.getPairs)
		});
	}
}
