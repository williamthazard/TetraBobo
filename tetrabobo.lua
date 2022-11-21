---TetraBobo

engine.name = 'Tetrabobo'
Tetrabobo = include('lib/Tetrabobo_engine')
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
  params:add_control('master chaos','master chaos',controlspec.new(-24,24,'lin',1,0,''))
  params:set_action('master chaos',function(x) params:set('Tetrabobo_firstchaos',x) params:set('Tetrabobo_secondchaos',x) params:set('Tetrabobo_thirdchaos',x) params:set('Tetrabobo_fourthchaos',x) end)
  params:bang()
  print("tetrabobo")
end

function shnth.minor(n, z)
  if n == 1 then 
    if z == 1 then 
      firstdoubling = true
      else firstdoubling = false
    end
  end
  if n == 2 then
    if z == 1 then
      seconddoubling = true
      else seconddoubling = false
    end
  end
  if n == 3 then
    if z == 1 then
      thirddoubling = true
      else thirddoubling = false
    end
  end
  if n == 4 then
    if z == 1 then
      fourthdoubling = true
      else fourthdoubling = false
    end
  end
end

function shnth.major(n, z)
  if n == 1 then
    if z == 1 then
      firsthalving = true
      else firsthalving = false
    end
  end
  if n == 2 then
    if z == 1 then
      secondhalving = true
      else secondhalving = false
    end
  end
  if n == 3 then
    if z == 1 then
      thirdhalving = true
      else thirdhalving = false
    end
  end
  if n == 4 then
    if z == 1 then
      fourthhalving = true
      else fourthhalving = false
    end
  end
end

function shnth.bar(n, d)
  if d > 0.2 or d < -0.2 then
      if n==1 then
        params:set('Tetrabobo_firstattack',util.linlin(-1,1,0.03,2,d))
        params:set('Tetrabobo_firstrelease',util.linlin(-1,1,0.03,2,d))
        if firstdoubling then 
          params:set('Tetrabobo_firstpitch',(params:get('Tetrabobo_firstpitch')*2))
          Tetrabobo.firstbartrig(params:get('Tetrabobo_firstpitch'))
          params:set('Tetrabobo_firstpitch',(params:get('Tetrabobo_firstpitch')/2))
        elseif firsthalving then
          params:set('Tetrabobo_firstpitch',(params:get('Tetrabobo_firstpitch')/2))
          Tetrabobo.firstbartrig(params:get('Tetrabobo_firstpitch'))
          params:set('Tetrabobo_firstpitch',(params:get('Tetrabobo_firstpitch')*2))
        else Tetrabobo.firstbartrig(params:get('Tetrabobo_firstpitch')) 
          end
      elseif n==2 then
        params:set('Tetrabobo_secondattack',util.linlin(-1,1,0.03,2,d))
        params:set('Tetrabobo_secondrelease',util.linlin(-1,1,0.03,2,d))
        if seconddoubling then 
          params:set('Tetrabobo_secondpitch',(params:get('Tetrabobo_secondpitch')*2))
          Tetrabobo.secondbartrig(params:get('Tetrabobo_secondpitch'))
          params:set('Tetrabobo_secondpitch',(params:get('Tetrabobo_secondpitch')/2))
        elseif secondhalving then
          params:set('Tetrabobo_secondpitch',(params:get('Tetrabobo_secondpitch')/2))
          Tetrabobo.secondbartrig(params:get('Tetrabobo_secondpitch'))
          params:set('Tetrabobo_secondpitch',(params:get('Tetrabobo_secondpitch')*2))
        else Tetrabobo.secondbartrig(params:get('Tetrabobo_secondpitch')) 
          end
      elseif n==3 then
        params:set('Tetrabobo_thirdattack',util.linlin(-1,1,0.03,2,d))
        params:set('Tetrabobo_thirdrelease',util.linlin(-1,1,0.03,2,d))
        if thirddoubling then 
          params:set('Tetrabobo_thirdpitch',(params:get('Tetrabobo_thirdpitch')*2))
          Tetrabobo.thirdbartrig(params:get('Tetrabobo_thirdpitch'))
          params:set('Tetrabobo_thirdpitch',(params:get('Tetrabobo_thirdpitch')/2))
        elseif thirdhalving then
          params:set('Tetrabobo_thirdpitch',(params:get('Tetrabobo_thirdpitch')/2))
          Tetrabobo.thirdbartrig(params:get('Tetrabobo_thirdpitch'))
          params:set('Tetrabobo_thirdpitch',(params:get('Tetrabobo_thirdpitch')*2))
        else Tetrabobo.thirdbartrig(params:get('Tetrabobo_thirdpitch')) 
          end
      elseif n==4 then
        params:set('Tetrabobo_fourthattack',util.linlin(-1,1,0.03,2,d))
        params:set('Tetrabobo_fourthrelease',util.linlin(-1,1,0.03,2,d))
        if fourthdoubling then 
          params:set('Tetrabobo_fourthpitch',(params:get('Tetrabobo_fourthpitch')*2))
          Tetrabobo.fourthbartrig(params:get('Tetrabobo_fourthpitch'))
          params:set('Tetrabobo_fourthpitch',(params:get('Tetrabobo_fourthpitch')/2))
        elseif fourthhalving then
          params:set('Tetrabobo_fourthpitch',(params:get('Tetrabobo_fourthpitch')/2))
          Tetrabobo.fourthbartrig(params:get('Tetrabobo_fourthpitch'))
          params:set('Tetrabobo_fourthpitch',(params:get('Tetrabobo_fourthpitch')*2))
        else Tetrabobo.fourthbartrig(params:get('Tetrabobo_fourthpitch')) 
          end
    end
  end
end
