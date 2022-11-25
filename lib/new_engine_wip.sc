Engine_Tetrabobo : CroneEngine {

	alloc {

var time = [0.001, 0.001, 0.001, 0.001];
var pan = [0, 0, 0, 0];
var params;

retrig = Bus.audio(numChannels:4);

SynthDef("Bar", {
  var rise = \rise.kr(0.001);
  var fall = \fall.kr(0.001);
  var i = \i.ir(0);
  var time = \time.kr(0.001 ! 4);
  var t1 = Select.kr(i, time);
  var t2 = Select.kr((i - 1) % 4, time);
  var chaos = \chaos.kr(1);

  var amp_env = Env.perc(\atk.kr(1),\rel.kr(1),1).kr(2);
  var fm = LFTri.ar((2*t2 + rise + fall).reciprocal, mul:chaos);
  var retrigger = Trig1.ar(Pulse.ar((1/(rise + fall + (2 * t1))) + fm, 0.5, 1), 4000.reciprocal);
	var shape = Env.perc(((rise + t1).reciprocal + fm).reciprocal,
		((fall + t1).reciprocal + fm).reciprocal, 1);
  var signal = SineShaper.ar(EnvGen.ar(shape, retrigger),mul:amp_env);
  signal = Pan2.ar(signal, \pan.kr(0));
  Out.ar(0, signal);
}).add;

		params = Dictionary.newFrom([
\rise, 0.001,
\fall, 0.001,
\chaos, 0
		]);

params.keysDo({ arg key;
			this.addCommand(key, "f", { arg msg;
				params[key] = msg[1];
				shapes.set(key.asSymbol, msg[1])
			});
		});

4.do({arg i;
	this.addCommand("trig_"++i, "f", { arg msg;
		Synth.new("Bar", [\time, time, \i, i, \pan, pan[i], \atk, msg[1], \rel, msg[1]] ++ params.getPairs)
		});
	this.addCommand("time_"++i, "f", { arg msg;
		time[i] = msg[1];
		shapes.set(\time, time)
	});
	this.addCommand("pan_"++i, "f", { arg msg;
		pan[i] = msg[1]
	});
})		
	}
	
	free {
	}
	
}
