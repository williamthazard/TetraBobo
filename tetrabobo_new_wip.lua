---TetraBobo

_lfos = require 'lfo'
Tetrabobo = include('lib/Tetrabobo_engine')
engine.name = 'Tetrabobo'
sh = hid.connect(1)
if sh.device then
  shnth = include("shnth/lib/shnth")
  sh.event = shnth.event
  else shnth = {}
end

firstdoubling = false
firsthalving = false
seconddoubling = false
secondhalving = false
thirddoubling = false
thirdhalving = false
fourthdoubling = false
fourthhalving = false

function init()
  Tetrabobo.add_params() -- adds params via the `.add params()` function defined in TetraBobo_engine.lua
  print("tetrabobo")
end

function shnth.major(n, z)
  if n == 1 then 
    if z == 1 then 
      firstdoubling = true
      else firstdoubling = false
    end
  elseif n == 2 then
    if z == 1 then
      seconddoubling = true
      else seconddoubling = false
    end
  elseif n == 3 then
    if z == 1 then
      thirddoubling = true
      else thirddoubling = false
    end
  elseif n == 4 then
    if z == 1 then
      fourthdoubling = true
      else fourthdoubling = false
    end
  end
end

function shnth.minor(n, z)
  if n == 1 then
    if z == 1 then
      firsthalving = true
      else firsthalving = false
    end
  elseif n == 2 then
    if z == 1 then
      secondhalving = true
      else secondhalving = false
    end
  elseif n == 3 then
    if z == 1 then
      thirdhalving = true
      else thirdhalving = false
    end
  elseif n == 4 then
    if z == 1 then
      fourthhalving = true
      else fourthhalving = false
    end
  end
end

function shnth.bar(n, d)
  if d > 0.2 or d < -0.2 then
      if n==1 then
        if firstdoubling then 
          params:set('Tetrabobo_time_0',(params:get('Tetrabobo_time_0')*2))
          Tetrabobo.trig(util.linlin(-1,1,0.03,2,d), 1)
          params:set('Tetrabobo_time_0',(params:get('Tetrabobo_time_0')/2))
        elseif firsthalving then
          params:set('Tetrabobo_time_0',(params:get('Tetrabobo_time_0')/2))
          Tetrabobo.trig(util.linlin(-1,1,0.03,2,d), 1)
          params:set('Tetrabobo_time_0',(params:get('Tetrabobo_time_0')*2))
        else Tetrabobo.trig(util.linlin(-1,1,0.03,2,d), 1) 
          end
      elseif n==2 then
        if seconddoubling then 
          params:set('Tetrabobo_time_1',(params:get('Tetrabobo_time_1')*2))
          Tetrabobo.trig(util.linlin(-1,1,0.03,2,d), 2)
          params:set('Tetrabobo_time_1',(params:get('Tetrabobo_time_1')/2))
        elseif secondhalving then
          params:set('Tetrabobo_time_1',(params:get('Tetrabobo_time_1')/2))
          Tetrabobo.trig(util.linlin(-1,1,0.03,2,d), 2)
          params:set('Tetrabobo_time_1',(params:get('Tetrabobo_time_1')*2))
        else Tetrabobo.trig(util.linlin(-1,1,0.03,2,d), 2) 
          end
      elseif n==3 then
        if thirddoubling then 
          params:set('Tetrabobo_time_2',(params:get('Tetrabobo_time_2')*2))
          Tetrabobo.trig(util.linlin(-1,1,0.03,2,d), 3)
          params:set('Tetrabobo_time_2',(params:get('Tetrabobo_time_2')/2))
        elseif thirdhalving then
          params:set('Tetrabobo_time_2',(params:get('Tetrabobo_time_2')/2))
          Tetrabobo.trig(util.linlin(-1,1,0.03,2,d), 3)
          params:set('Tetrabobo_time_2',(params:get('Tetrabobo_time_2')*2))
        else Tetrabobo.trig(util.linlin(-1,1,0.03,2,d), 3) 
          end
      elseif n==4 then
        if fourthdoubling then 
          params:set('Tetrabobo_time_3',(params:get('Tetrabobo_time_3')*2))
          Tetrabobo.trig(util.linlin(-1,1,0.03,2,d), 4)
          params:set('Tetrabobo_time_3',(params:get('Tetrabobo_time_3')/2))
        elseif fourthhalving then
          params:set('Tetrabobo_time_3',(params:get('Tetrabobo_time_3')/2))
          Tetrabobo.trig(util.linlin(-1,1,0.03,2,d), 4)
          params:set('Tetrabobo_time_3',(params:get('Tetrabobo_time_3')*2))
        else Tetrabobo.trig(util.linlin(-1,1,0.03,2,d), 4) 
          end
    end
  end
end
