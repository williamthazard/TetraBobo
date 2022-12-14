---TetraBobo
---
---triangle wave organ
---with variable slope
---for norns & shbobo shnth
---
---E1: master chaos (circular FM)
---E2: master rise time
---E3: master fall time
---
---K1: hold for fine tuning
---K2: alt behavior for E2 & E3
---K3: alt behavior for E2 & E3
---
---K2 + E2: bar 0 time (pitch)
---K2 + E3: bar 1 time (pitch)
---K3 + E2: bar 2 time (pitch)
---K3 + E3: bar 3 time (pitch)
---
---shnth minors halve the time
---of their corresponding bars
---
---shnth majors double the time
---of their corresponding bars
---
---version 1.0.0

Tetrabobo = include('lib/Tetrabobo_engine')
engine.name = 'Tetrabobo'
sh = hid.connect(1)
if sh.device then
  shnth = include("shnth/lib/shnth")
  sh.event = shnth.event
  else shnth = {}
end
_lfos = require 'lfo'

doubling = {}
halving = {}
going = {}
times_lfo = {}

for i=1,4 do
  doubling[i] = false
  halving[i] = false
  going[i] = nil
end

function init()
  Tetrabobo.add_params() -- adds params via the `.add params()` function defined in TetraBobo_engine.lua
  rise_lfo = _lfos:add{min = 0.00005, max = 0.03125}
  fall_lfo = _lfos:add{min = 0.00005, max = 0.03125}
  chaos_lfo = _lfos:add{min = -100, max = 100}
  for i=0,3 do
    params:hide('Tetrabobo_pan_'..i)
    times_lfo[i] = _lfos:add{min = 0.00005, max = 0.03125}
  end
  params:add_group('LFOs',105)
  rise_lfo:add_params('rise_lfo', 'rise')
  rise_lfo:set('action', function(scaled, raw) params:set('Tetrabobo_rise',scaled) end)
  fall_lfo:add_params('fall_lfo', 'fall')
  fall_lfo:set('action', function(scaled, raw) params:set('Tetrabobo_fall',scaled) end)
  chaos_lfo:add_params('chaos_lfo', 'chaos')
  chaos_lfo:set('action', function(scaled, raw) params:set('Tetrabobo_chaos',scaled) end)
  for i=0,3 do
    times_lfo[i]:add_params('times['..i..']_lfo', 'time '..i)
    times_lfo[i]:set('action', function(scaled, raw) params:set('Tetrabobo_time_'..i,scaled) end)
  end
  print("tetrabobo")
end

function key(n,z)
  if n==1 then
    if z==1 then
      fine = true
      else fine = false
    end
  elseif n==2 then
    if z==1 then
      bars_1 = true
      redraw()
      else bars_1 = false
      redraw()
    end
  elseif n==3 then
    if z==1 then
      bars_2 = true
      redraw()
      else bars_2 = false
      redraw()
    end
  end
end

function enc(n,d)
  if n==1 then
    if fine then
      params:delta('Tetrabobo_chaos',d/200)
      else params:delta('Tetrabobo_chaos',d/20)
      redraw()
    end
  elseif n==2 then
    if bars_1 then
      if fine then
        params:delta('Tetrabobo_time_0',d/10)
        else params:delta('Tetrabobo_time_0',d)
        redraw()
      end
    elseif bars_2 then
      if fine then
        params:delta('Tetrabobo_time_2',d/10)
        else params:delta('Tetrabobo_time_2',d)
        redraw()
      end
    elseif fine then 
      params:delta('Tetrabobo_rise',d/10)
      else params:delta('Tetrabobo_rise',d)
      redraw()
    end
  elseif n==3 then
    if bars_1 then
      if fine then
        params:delta('Tetrabobo_time_1',d/10)
        else params:delta('Tetrabobo_time_1',d)
        redraw()
      end
    elseif bars_2 then
      if fine then
        params:delta('Tetrabobo_time_3',d/10)
        else params:delta('Tetrabobo_time_3',d)
        redraw()
      end
    elseif fine then 
      params:delta('Tetrabobo_fall',d/10)
      else params:delta('Tetrabobo_fall',d)
      redraw()
    end
  end
end

function shnth.major(n, z)
  for i=1,4 do
    if n==i then
      if z==1 then
        doubling[i] = true
        redraw()
        else doubling[i] = false
        redraw()
      end
    end
  end
end

function shnth.minor(n, z)
  for i=1,4 do
    if n==i then
      if z==1 then
        halving[i] = true
        redraw()
        else halving[i] = false
        redraw()
      end
    end
  end
end

function shnth.bar(n, d)
  if math.abs(d) > 0.2 then
    for i=1,4 do
      if n==i then
        if going[i]==nil then
          if doubling[i] then
            if d > 0.2 then
              params:set('Tetrabobo_pan_' .. (i-1), 1)
            elseif d < -0.2 then 
              params:set('Tetrabobo_pan_' .. (i-1), -1)
            end
            params:set('Tetrabobo_time_' .. (i - 1),(params:get('Tetrabobo_time_' .. (i - 1))*2))
            Tetrabobo.trig(util.linlin(-1,1,0.03,1,d),i)
            params:set('Tetrabobo_time_' .. (i - 1),(params:get('Tetrabobo_time_' .. (i - 1))/2))
            going[i] = clock.run(function()
              clock.sleep(util.linlin(-1,1,0.03,1,d)*2)
              clock.cancel(going[i])
              going[i] = nil
            end)
          elseif halving[i] then
            if d > 0.2 then
              params:set('Tetrabobo_pan_' .. (i-1), 1)
            elseif d < -0.2 then 
              params:set('Tetrabobo_pan_' .. (i-1), -1)
            end
            params:set('Tetrabobo_time_' .. (i - 1),(params:get('Tetrabobo_time_' .. (i - 1))/2))
            Tetrabobo.trig(util.linlin(-1,1,0.03,1,d),i)
            params:set('Tetrabobo_time_' .. (i - 1),(params:get('Tetrabobo_time_' .. (i - 1))*2))
            going[i] = clock.run(function()
              clock.sleep(util.linlin(-1,1,0.03,1,d)*2)
              clock.cancel(going[i])
              going[i] = nil
            end)
            else 
              if d > 0.2 then
              params:set('Tetrabobo_pan_' .. (i-1), 1)
              elseif d < -0.2 then 
              params:set('Tetrabobo_pan_' .. (i-1), -1)
            end
            Tetrabobo.trig(util.linlin(-1,1,0.03,1,d),i)
            going[i] = clock.run(function()
              clock.sleep(util.linlin(-1,1,0.03,1,d)*2)
              clock.cancel(going[i])
              going[i] = nil
            end)
          end
        end
      end
    end
  end
end

function redraw()
  screen.clear()
  screen.level(10)
  screen.move(44,15)
  screen.text("chaos: " .. params:get('Tetrabobo_chaos'))
  if not bars_1 and not bars_2 then
    screen.level(10)
    else screen.level(1)
  end
  screen.move(0,5)
  screen.text("rise: " .. params:get('Tetrabobo_rise'))
  screen.move(64,5)
  screen.text("fall: " .. params:get('Tetrabobo_fall'))
  if bars_1 then 
    screen.level(10)
    else screen.level(1)
  end
  screen.move(0,30)
  if doubling[1] then
    screen.text("bar 0 time: " .. params:get('Tetrabobo_time_0')*2)
  elseif halving[1] then
    screen.text("bar 0 time: " .. params:get('Tetrabobo_time_0')/2)
    else screen.text("bar 0 time: " .. params:get('Tetrabobo_time_0'))
  end
  screen.move(0,40)
  if doubling[2] then
    screen.text("bar 1 time: " .. params:get('Tetrabobo_time_1')*2)
  elseif halving[2] then
    screen.text("bar 1 time: " .. params:get('Tetrabobo_time_1')/2)
    else screen.text("bar 1 time: " .. params:get('Tetrabobo_time_1'))
  end
  if bars_2 then
    screen.level(10)
    else screen.level(1)
  end
  screen.move(0,50)
  if doubling[3] then
    screen.text("bar 2 time: " .. params:get('Tetrabobo_time_2')*2)
  elseif halving[3] then
    screen.text("bar 2 time: " .. params:get('Tetrabobo_time_2')/2)
    else screen.text("bar 2 time: " .. params:get('Tetrabobo_time_2'))
  end
  screen.move(0,60)
  if doubling[4] then
    screen.text("bar 3 time: " .. params:get('Tetrabobo_time_3')*2)
  elseif halving[4] then
    screen.text("bar 3 time: " .. params:get('Tetrabobo_time_3')/2)
    else screen.text("bar 3 time: " .. params:get('Tetrabobo_time_3'))
  end
  screen.update()
end
