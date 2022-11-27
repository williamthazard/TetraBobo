---TetraBobo

Tetrabobo = include('lib/Tetrabobo_engine')
engine.name = 'Tetrabobo'
sh = hid.connect(1)
if sh.device then
  shnth = include("shnth/lib/shnth")
  sh.event = shnth.event
  else shnth = {}
end

doubling = {}
halving = {}
going = {}

for i=1,4 do
  doubling[i] = false
  halving[i] = false
  going[i] = false
end

function init()
  Tetrabobo.add_params() -- adds params via the `.add params()` function defined in TetraBobo_engine.lua
  print("tetrabobo")
end

function shnth.major(n, z)
  for i=1,4 do
    if n==i then
      if z==1 then
        doubling[i] = true
        else doubling[i] = false
      end
    end
  end
end

function shnth.minor(n, z)
  for i=1,4 do
    if n==i then
      if z==1 then
        halving[i] = true
        else halving[i] = false
      end
    end
  end
end

function shnth.bar(n, d)
  if d > 0.2 or d < -0.2 then
    for i=1,4 do
      if n==i then
        if going[i]==false then
        if doubling[i] then
          params:set('Tetrabobo_time_' .. (i - 1),(params:get('Tetrabobo_time_' .. (i - 1))*2))
          Tetrabobo.trig(util.linlin(-1,1,0.03,1,d),i)
          params:set('Tetrabobo_time_' .. (i - 1),(params:get('Tetrabobo_time_' .. (i - 1))/2))
          going[i] = true
          clock.sleep(util.linlin(-1,1,0.03,1,d)*2)
          going[i] = false
        elseif halving[i] then
          params:set('Tetrabobo_time_' .. (i - 1),(params:get('Tetrabobo_time_' .. (i - 1))/2))
          Tetrabobo.trig(util.linlin(-1,1,0.03,1,d),i)
          params:set('Tetrabobo_time_' .. (i - 1),(params:get('Tetrabobo_time_' .. (i - 1))*2))
          going[i] = true
          clock.sleep(util.linlin(-1,1,0.03,1,d)*2)
          going[i] = false
          else Tetrabobo.trig(util.linlin(-1,1,0.03,1,d),i)
          going[i] = true
          clock.sleep(util.linlin(-1,1,0.03,1,d)*2)
          going[i] = false
        end
      end
    end
  end
end
end
