
--[[
Configs added:
]]

TBFY_LIB.Config = TBFY_LIB.Config or {}

//Admincheck for TBFY_Shared admin stuff
TBFY_LIB.Config.AdminAccessCustomCheck = function(ply) return ply:IsAdmin() end
--PARTLY IMPLEMENTED
--[[
english
french
chinese
]]
TBFY_LIB.Config.Language = "english"
TBFY_LIB.Config.ConfigChatCommands = {
    ["!tbfyconfig"] = true,
    ["!config"] = true
}