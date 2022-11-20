---TetraBobo

local extensions = "/home/we/.local/share/SuperCollider/Extensions"
engine.name = util.file_exists(extensions .. "/FormantTriPTR/FormantTriPTR.sc") and 'Tetrabobo' or nil
UI = require "ui"
Tetrabobo = include('lib/Tetrabobo_engine')
sh = hid.connect(1)
if sh.device then
  shnth = include("shnth/lib/shnth")
  sh.event = shnth.event
  else shnth = {}
end

function init()
  needs_restart = false
  local formanttri_files = {"FormantTriPTR.sc", "FormantTriPTR_scsynth.so"}
  for _,file in pairs(formanttri_files) do
    if not util.file_exists(extensions .. "/FormantTriPTR/" .. file) then
      util.os_capture("mkdir " .. extensions .. "/FormantTriPTR")
      util.os_capture("cp " .. norns.state.path .. "/ignore/" .. file .. " " .. extensions .. "/FormantTriPTR/" .. file)
      print("installed " .. file)
      needs_restart = true
    end
  end
  restart_message = UI.Message.new{"please restart norns"}
  if needs_restart then redraw() return end
  Tetrabobo.add_params() -- adds params via the `.add params()` function defined in TetraBobo_engine.lua
  params:bang()
  print("tetrabobo")
end

function shnth.bar(n, d)
  if d > 0.2 then
      if n==1 then
        params:set('Tetrabobo_firstattack',util.linlin(-1,1,0.03,4,d))
        params:set('Tetrabobo_firstrelease',util.linlin(-1,1,0.03,4,d))
        Tetrabobo.firstbartrig(params:get('Tetrabobo_firstpitch'))
      elseif n==2 then
        params:set('Tetrabobo_secondattack',util.linlin(-1,1,0.03,4,d))
        params:set('Tetrabobo_secondrelease',util.linlin(-1,1,0.03,4,d))
        Tetrabobo.secondbartrig(params:get('Tetrabobo_secondpitch'))
      elseif n==3 then
        params:set('Tetrabobo_thirdattack',util.linlin(-1,1,0.03,4,d))
        params:set('Tetrabobo_thirdrelease',util.linlin(-1,1,0.03,4,d))
        Tetrabobo.thirdbartrig(params:get('Tetrabobo_thirdpitch'))
      elseif n==4 then
        params:set('Tetrabobo_fourthattack',util.linlin(-1,1,0.03,4,d))
        params:set('Tetrabobo_fourthrelease',util.linlin(-1,1,0.03,4,d))
        Tetrabobo.fourthbartrig(params:get('Tetrabobo_fourthpitch'))
    end
  end
end
