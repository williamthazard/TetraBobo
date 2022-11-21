Engine_Tetrabobo : CroneEngine {

	var params;
	var firstbar;
	var secondbar;
	var thirdbar;
	var fourthbar;
	var outBus;
	var firstfmbus;
	var secondfmbus;
	var thirdfmbus;
	var fourthfmbus;
	var endOfChain;

	alloc{
	
SynthDef("ColorLimiter",
		{arg input;
			Out.ar(
				0,
				In.ar(input).dup;
			);
		}).add;
		
Server.default.sync;

outBus = Bus.audio;

firstfmbus = Bus.audio;

secondfmbus = Bus.audio;

thirdfmbus = Bus.audio;

fourthfmbus = Bus.audio;

endOfChain = Synth.new("ColorLimiter",[\input,outBus]);

NodeWatcher.register(endOfChain);

SynthDef("barone",
		{   arg out,
			firstfmbus,
			fourthfmbus,
			firstchaos = 0,
			firstpitch = 440,
			firstwidth = 0.75,
			firstform = 440,
			firstphase = 0,
			firstattack = 0.3,
			firstrelease = 1,
			panone = 0;

			var firstbar_env = Env.perc(
					attackTime: firstattack,
					releaseTime: firstrelease,
					level: 0.01
				).kr(doneAction:2);

			var first_signal = Pan2.ar(
					SineShaper.ar(
						FormantTriPTR.ar(firstpitch + (
							firstchaos * In.ar(fourthfmbus)),
						firstform,
						firstwidth,
						firstphase),
						mul: firstbar_env),
					panone);

				Out.ar(
					out,
					first_signal;
				);

				Out.ar(
					firstfmbus,
					first_signal;
				)

		}).add;

SynthDef("bartwo",
		{   arg out,
			firstfmbus,
			secondfmbus,
			secondchaos = 0,
			secondpitch = 440,
			secondwidth = 0.75,
			secondform = 440,
			secondphase = 0,
			secondattack = 0.3,
			secondrelease = 1,
			pantwo = 0;

			var secondbar_env = Env.perc(
					attackTime: secondattack,
					releaseTime: secondrelease,
					level: 0.01
				).kr(doneAction:2);

			var second_signal = Pan2.ar(
					SineShaper.ar(
						FormantTriPTR.ar(secondpitch + (
							secondchaos * In.ar(firstfmbus)),
						secondform,
						secondwidth,
						secondphase),
						mul: secondbar_env),
					pantwo);

				Out.ar(
					out,
					second_signal;
				);

				Out.ar(
					secondfmbus,
					second_signal;
				)

		}).add;

SynthDef("barthree",
		{   arg out,
			secondfmbus,
			thirdfmbus,
			thirdchaos = 0,
			thirdpitch = 440,
			thirdwidth = 0.75,
			thirdform = 440,
			thirdphase = 0,
			thirdattack = 0.3,
			thirdrelease = 1,
			panthree = 0;

			var thirdbar_env = Env.perc(
					attackTime: thirdattack,
					releaseTime: thirdrelease,
					level: 0.01
				).kr(doneAction:2);

			var third_signal = Pan2.ar(
					SineShaper.ar(
						FormantTriPTR.ar(thirdpitch + (
							thirdchaos * In.ar(secondfmbus)),
						thirdform,
						thirdwidth,
						thirdphase),
						mul: thirdbar_env),
					panthree);

				Out.ar(
					out,
					third_signal;
				);

				Out.ar(
					thirdfmbus,
					third_signal;
				)

		}).add;

SynthDef("barfour",
		{   arg out,
			thirdfmbus,
			fourthfmbus,
			fourthchaos = 0,
			fourthpitch = 440,
			fourthwidth = 0.75,
			fourthform = 440,
			fourthphase = 0,
			fourthattack = 0.3,
			fourthrelease = 1,
			panfour = 0;

			var fourthbar_env = Env.perc(
					attackTime: fourthattack,
					releaseTime: fourthrelease,
					level: 0.01
				).kr(doneAction:2);

			var fourth_signal = Pan2.ar(
					SineShaper.ar(
						FormantTriPTR.ar(fourthpitch + (
							fourthchaos * In.ar(thirdfmbus)),
						fourthform,
						fourthwidth,
						fourthphase),
						mul: fourthbar_env),
					panfour);

				Out.ar(
					out,
					fourth_signal;
				);

				Out.ar(
					fourthfmbus,
					fourth_signal;
				)

		}).add;

		params = Dictionary.newFrom([
			\firstpitch, 440,
			\firstform, 440,
			\firstwidth, 0.75,
			\firstphase, 0,
			\panone, 0,
			\firstattack, 0.3,
			\firstrelease, 1,
			\secondpitch, 440,
			\secondform, 440,
			\secondwidth, 0.75,
			\secondphase, 0,
			\pantwo, 0,
			\secondattack, 0.3,
			\secondrelease, 1,
			\thirdpitch, 440,
			\thirdform, 440,
			\thirdwidth, 0.75,
			\thirdphase, 0,
			\panthree, 0,
			\thirdattack, 0.3,
			\thirdrelease, 1,
			\fourthpitch, 440,
			\fourthform, 440,
			\fourthwidth, 0.75,
			\fourthphase, 0,
			\panfour, 0,
			\fourthattack, 0.3,
			\fourthrelease, 1,
			\firstchaos, 0,
			\secondchaos, 0,
			\thirdchaos, 0,
			\fourthchaos, 0
		]);

		params.keysDo({ arg key;
			this.addCommand(key, "f", { arg msg;
				params[key] = msg[1];
			});
		});

		this.addCommand("firstbartrig", "f", { arg msg;
			firstbar = Synth.before(
				endOfChain,
				"barone",
				[\out,outBus,
				\firstfmbus,firstfmbus,
				\fourthfmbus,fourthfmbus,
				\firstpitch,msg[1]]
				++ params.getPairs)
		});

		this.addCommand("secondbartrig", "f", { arg msg;
			secondbar = Synth.before(
				endOfChain,
				"bartwo",
				[\out,outBus,
				\firstfmbus,firstfmbus,
				\secondfmbus,secondfmbus,
				\secondpitch, msg[1]]
				++ params.getPairs)
		});

		this.addCommand("thirdbartrig", "f", { arg msg;
			thirdbar = Synth.before(
				endOfChain,
				"barthree",
				[\out,outBus,
				\secondfmbus,secondfmbus,
				\thirdfmbus,thirdfmbus,
				\thirdpitch, msg[1]]
				++ params.getPairs)
		});

		this.addCommand("fourthbartrig", "f", { arg msg;
			fourthbar = Synth.before(
				endOfChain,
				"barfour",
				[\out,outBus,
				\thirdfmbus,thirdfmbus,
				\fourthfmbus,fourthfmbus,
				\fourthpitch, msg[1]]
				++ params.getPairs)
		});
	}
			free {
			endOfChain.free;
			outBus.free;
		    firstfmbus.free;
		    secondfmbus.free;
		    thirdfmbus.free;
		    fourthfmbus.free;
		}
}
