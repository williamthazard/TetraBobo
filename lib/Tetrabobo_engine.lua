local Tetrabobo = {}
local Formatters = require 'formatters'

-- first, we'll collect all of our commands into norns-friendly ranges
local specs = {
  ["firstpitch"] = controlspec.FREQ,
  ["firstform"] = controlspec.FREQ,
  ["firstwidth"] = controlspec.AMP,
  ["firstphase"] = controlspec.PHASE,
  ["firstamp"] = controlspec.AMP,
  ["panone"] = controlspec.PAN,
  ["secondpitch"] = controlspec.FREQ,
  ["secondform"] = controlspec.FREQ,
  ["secondwidth"] = controlspec.AMP,
  ["secondphase"] = controlspec.PHASE,
  ["secondamp"] = controlspec.AMP,
  ["pantwo"] = controlspec.PAN,
  ["thirdpitch"] = controlspec.FREQ,
  ["thirdform"] = controlspec.FREQ,
  ["thirdwidth"] = controlspec.AMP,
  ["thirdphase"] = controlspec.PHASE,
  ["thirdamp"] = controlspec.AMP,
  ["panthree"] = controlspec.PAN,
  ["fourthpitch"] = controlspec.FREQ,
  ["fourthform"] = controlspec.FREQ,
  ["fourthwidth"] = controlspec.AMP,
  ["fourthphase"] = controlspec.PHASE,
  ["fourthamp"] = controlspec.AMP,
  ["panfour"] = controlspec.PAN,
  ["chaos"] = controlspec.new(-24, 24, "lin", 0, 0, ""),
  ["firstattack"] = controlspec.new(0.003, 3, "exp", 0, 0.003, "s"),
  ["secondattack"] = controlspec.new(0.003, 3, "exp", 0, 0.003, "s"),
  ["thirdattack"] = controlspec.new(0.003, 3, "exp", 0, 0.003, "s"),
  ["fourthattack"] = controlspec.new(0.003, 3, "exp", 0, 0.003, "s"),
  ["firstrelease"] = controlspec.new(0.003, 3, "exp", 0, 0.003, "s"),
  ["secondrelease"] = controlspec.new(0.003, 3, "exp", 0, 0.003, "s"),
  ["thirdrelease"] = controlspec.new(0.003, 3, "exp", 0, 0.003, "s"),
  ["fourthrelease"] = controlspec.new(0.003, 3, "exp", 0, 0.003, "s")
}

-- this table establishes an order for parameter initialization:
local param_names = {"firstpitch","firstform","firstwidth","firstphase","firstamp","panone","secondpitch","secondform","secondwidth","secondphase","secondamp","pantwo","thirdpitch","thirdform","thirdwidth","thirdphase","thirdamp","panthree","fourthpitch","fourthform","fourthwidth","fourthphase","fourthamp","panfour","chaos","firstattack","secondattack","thirdattack","fourthattack","firstrelease","secondrelease","thirdrelease","fourthrelease"}

-- initialize parameters:
function Tetrabobo.add_params()
  params:add_group("Tetrabobo",#param_names)

  for i = 1,#param_names do
    local p_name = param_names[i]
    params:add{
      type = "control",
      id = "Tetrabobo_"..p_name,
      name = p_name,
      controlspec = specs[p_name],
      formatter = p_name == "pan" and Formatters.bipolar_as_pan_widget or nil,
      -- every time a parameter changes, we'll send it to the SuperCollider engine:
      action = function(x) engine[p_name](x) end
    }
  end
  
  params:bang()
end

-- a single-purpose triggering command fire a note
function Tetrabobo.firstbartrig(hz)
  if hz ~= nil then
    engine.firstbartrig(hz)
  end
end

function Tetrabobo.secondbartrig(hz)
  if hz ~= nil then
    engine.secondbartrig(hz)
  end
end

function Tetrabobo.thirdbartrig(hz)
  if hz ~= nil then
    engine.thirdbartrig(hz)
  end
end

function Tetrabobo.fourthbartrig(hz)
  if hz ~= nil then
    engine.fourthbartrig(hz)
  end
end

 -- we return these engine-specific Lua functions back to the host script:
return Tetrabobo