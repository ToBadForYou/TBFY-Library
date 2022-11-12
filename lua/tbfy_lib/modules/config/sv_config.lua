util.AddNetworkString("tbfy_config_fetch")
util.AddNetworkString("tbfy_config_open")
util.AddNetworkString("tbfy_config_update")

TBFY_LIB.CachedConfigs = {}

function TBFY_LIB:GetClientConfigs(addon)
    local clientConfigs = {}
    for k,v in ipairs(addon.ClientConfig) do
        local config = addon.Config[v]
        if config.Value != nil then
            clientConfigs[#clientConfigs + 1] = {ID = v, value = config.Value, type = config.Type}
        end           
    end
    return clientConfigs
end

function TBFY_LIB:SendConfigs(addonID, configs, ply)
    print(addonID)
    PrintTable(configs)
    net.Start("tbfy_config_update")
    net.WriteString(addonID)
    net.WriteUInt(#configs, 8)
    for k,v in ipairs(configs) do
        net.WriteString(v.ID)
        TBFY_LIB.DataTypes[v.type].send(v.value)
    end
    net.Send(ply) 
end

net.Receive("tbfy_config_update", function(len, ply)
    if TBFY_LIB:HasAdminAccess(ply) then
        local addonID = net.ReadString()
        local configAmount = net.ReadUInt(8)
        local addon = TBFY_LIB.Addons[addonID]
        for i = 1, configAmount do
            local configID = net.ReadString()
            local config = addon.Config[configID]
            addon.Config[configID].Value = TBFY_LIB.DataTypes[config.Type].receive()
        end

        TBFY_LIB:SaveConfig(addon)
        TBFY_LIB.CachedConfigs[addonID] = {}

        local clientConfigs = TBFY_LIB:GetClientConfigs(addon)
        for k,v in ipairs(player.GetAll()) do
            TBFY_LIB:SendConfigs(addonID, clientConfigs, v)
        end     
    end
end)

net.Receive("tbfy_config_fetch", function(len, ply)
    local SID = TBFY_LIB:SID(ply)
    if !TBFY_LIB.CachedConfigs[addonID] or !TBFY_LIB.CachedConfigs[addonID][SID] then
        local addonID = net.ReadString()
        local addon = TBFY_LIB.Addons[addonID]

        local changedConfigs = {}
        for k,v in pairs(addon.Config) do
            if v.Value != nil then
                changedConfigs[#changedConfigs + 1] = {ID = k, value = v.Value, type = v.Type}
            end
        end

        TBFY_LIB:SendConfigs(addonID, changedConfigs, ply)

        TBFY_LIB.CachedConfigs[addonID] = TBFY_LIB.CachedConfigs[addonID] or {}
        TBFY_LIB.CachedConfigs[addonID][SID] = true
    else
        net.Start("tbfy_config_update")
            net.WriteString(addonID)
            net.WriteUInt(0, 8)
        net.Send(ply)          
    end
end)