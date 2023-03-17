
TBFY_LIB = TBFY_LIB or {}
TBFY_LIB.Addons = {}

if SERVER then
	resource.AddWorkshop("1900873878")

  file.CreateDir("tbfy_lib")
  file.CreateDir("tbfy_lib/configs")
  file.CreateDir("tbfy_lib/entities")
  file.CreateDir("tbfy_lib/entities/" .. string.lower(game.GetMap()))
  file.CreateDir("tbfy_lib/imgur")

	include("tbfy_lib/sh_config.lua")
	include("tbfy_lib/sh_addons.lua")
	AddCSLuaFile("tbfy_lib/sh_config.lua")
	AddCSLuaFile("tbfy_lib/sh_addons.lua")
  AddCSLuaFile("tbfy_lib/cl_style.lua")
elseif CLIENT then
	include("tbfy_lib/sh_config.lua")
	include("tbfy_lib/sh_addons.lua")
  include("tbfy_lib/cl_style.lua")
end

local modulesFolder = "tbfy_lib/modules"
local files, directories = file.Find(modulesFolder .. "/*", "LUA")
for k,v in pairs(directories) do
  local luaFiles = file.Find(modulesFolder .. "/" .. v .. "/*.lua", "LUA")
  for index, fileName in pairs(luaFiles) do
    if string.find(fileName, "sv_") then
      include(modulesFolder .. "/" .. v .. "/" .. fileName)
    elseif string.find(fileName, "sh_") then
      if SERVER then
        AddCSLuaFile(modulesFolder .. "/" .. v .. "/" .. fileName)
      end
      include(modulesFolder .. "/" .. v .. "/" .. fileName)
    end
    print("[TBFY_LIB] Loaded: " .. fileName)
  end
end

//Loading cl files after sh due to dependencies
for k,v in pairs(directories) do
  local luaFiles = file.Find(modulesFolder .. "/" .. v .. "/*.lua", "LUA")
  for index, fileName in pairs(luaFiles) do
    if string.find(fileName, "cl_") or string.find(fileName, "vgui_") then
      if SERVER then
        AddCSLuaFile(modulesFolder .. "/" .. v .. "/" .. fileName)
      else
        include(modulesFolder .. "/" .. v .. "/" .. fileName)
      end
    end
    print("[TBFY_LIB] Loaded: " .. fileName)
  end
end
