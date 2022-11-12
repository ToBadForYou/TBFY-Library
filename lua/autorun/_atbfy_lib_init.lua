print("/////////////////////////////////////////////////")
print("//                                             //")
print("//             TBFY Library Loaded             //")
print("//  www.gmodstore.com/users/76561197989708503  //")
print("//                                             //")
print("/////////////////////////////////////////////////")
if SERVER then
	include("tbfy_lib/sh_init.lua")
	AddCSLuaFile("tbfy_lib/sh_init.lua")
elseif CLIENT then
	include("tbfy_lib/sh_init.lua")
end
