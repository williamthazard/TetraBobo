---TetraBobo

local extensions = "/home/we/.local/share/SuperCollider/Extensions"
engine.name = util.file_exists(extensions .. "/FormantTriPTR/FormantTriPTR.sc") and 'TetraBobo' or nil
TetraBobo = include('lib/TetraBobo_engine')
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
  TetraBobo.add_params() -- adds params via the `.add params()` function defined in TetraBobo_engine.lua
  print("tetrabobo")
end

function shnth.bar(n, d)
  params:set('TetraBobo_firstattack',util.linlin(-2,2,0,4,d))
  params:set('TetraBobo_secondattack',util.linlin(-2,2,0,4,d))
  params:set('TetraBobo_thirdattack',util.linlin(-2,2,0,4,d))
  params:set('TetraBobo_fourthattack',util.linlin(-2,2,0,4,d))
  params:set('TetraBobo_firstrelease',util.linlin(-2,2,0,4,d))
  params:set('TetraBobo_secondrelease',util.linlin(-2,2,0,4,d))
  params:set('TetraBobo_thirdrelease',util.linlin(-2,2,0,4,d))
  params:set('TetraBobo_fourthrelease',util.linlin(-2,2,0,4,d))
  if d > 0.2 then
      if n==1 then
        TetraBobo.firstbartrig(params:get(TetraBobo_firstpitch))
      elseif n==2 then
        TetraBobo.secondbartrig(params:get(TetraBobo_secondpitch))
      elseif n==3 then
        TetraBobo.thirdbartrig(params:get(TetraBobo_thirdpitch))
      elseif n==4 then
        TetraBobo.fourthbartrig(params:get(TetraBobo_fourthpitch))
    end
  end
end
