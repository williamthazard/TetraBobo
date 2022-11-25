Engine_Tetrabobo : CroneEngine {

	alloc {
	
var retrig = Bus.audio(numChannels:4);
var time = [0.001, 0.001, 0.001, 0.001];
var pan = [0, 0, 0, 0];

SynthDef("Retrig", {
  arg rise=0.001, fall=0.001, chaos=1, retrigBus;
  // isn't this neat? it creates an argument which is an array!
  var time = \time.kr(0.001 ! 4);
  var etim = Array.fill(4, {arg i;
    time[(i-1) % 4];
  });
  var retrig = Trig.ar(Pulse.ar((2*time + rise + fall 
      + LFTri.ar((2*etim + rise + fall).reciprocal, mul:chaos)).reciprocal, 
      0.5, 1), 4000.reciprocal);
  Out.ar(retrigBus, retrig);
}).add;

SynthDef("Bar", {
  arg i_i, atk=1, rel=1, pan=0, rise=0.001, fall=0.001, chaos=1, retrig;
  var time = \time.kr(0.001 ! 4);
  var etim = Array.fill(4, {arg i;
    time[(i-1) % 4];
  });
  var amp_env = Env.perc(attackTime:atk, releaseTime:rel, level:1).kr(doneAction:2);
  var sig = EnvGen.ar(Env.perc(time + rise + LFTri.ar((2*etim + rise + fall).reciprocal, mul:chaos)), In.ar(retrig, 4));
  sig = Select.kr(sig, i_i);
  sig = Pan2.ar(SineShaper.ar(sig, mul:amp_env), pan);
  Out.ar(0, sig);
}).add;

var shapes = Synth.new("Retrig", [\retrigBus, retrig]);

Synth.after(shapes, "Bar", [\i, 0, \retrig, retrig]);

		params = Dictionary.newFrom([
\rise, 0.001,
\fall, 0.001,
\chaos, 0
		]);

params.keysDo({ arg key;
			this.addCommand(key, "f", { arg msg;
				params[key] = msg[1];
			});
		});

4.do({arg i;
	this.addCommand("trig_"++i, "f", { arg msg;
		Synth.after("Bar", [\time, time, \i, i, \pan, pan[i], \atk, msg[1], \rel, msg[1]] ++ params.getPairs)
		});
	this.addCommand("time_"++i, "f", { arg msg;
		time[i] = msg[1]
	});
	this.addCommand("pan_"++i, "f", { arg msg;
		pan[i] = msg[1]
	});
})		
	}
}
