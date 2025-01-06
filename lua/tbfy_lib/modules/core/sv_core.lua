util.AddNetworkString("tbfy_notify_player")

function TBFY_LIB:Notify(ply, msgtype, len, msg)
    net.Start("tbfy_notify_player")
        net.WriteString(msg)
        net.WriteFloat(msgtype)
        net.WriteFloat(len)
    net.Send(ply)
end

hook.Add("PlayerSay", "tbfy_lib_playersay", function(ply, text)
    if TBFY_LIB:HasAdminAccess(ply) and TBFY_LIB.Config.ConfigChatCommands[text] then
        net.Start("tbfy_config_open")
        net.Send(ply)
        return ""
    end
end)

hook.Add("PlayerConnect", "tbfy_lib_check_version", function()
    local gitlink = "https://raw.githubusercontent.com/ToBadForYou/tbfy_lib/master/version.txt"
    http.Fetch(gitlink, function(contents, size)
        for ID, addon in pairs(TBFY_LIB.Addons) do
            local foundAddon = string.match(contents, ID .. "%s=%s%d.%d.%d" ) or ""
            local latestVersion = string.match(foundAddon, "%d.%d.%d") or 0
            if latestVersion == 0 then
                print("[TBFY_LIB] Latest version for " .. addon.Name .. " could not be detected")
            elseif latestVersion == addon.Version then
                print("[TBFY_LIB] " .. addon.Name .. " up to date: v" .. addon.Version)
            else
                print("[TBFY_LIB] " .. addon.Name .. " outdated: v" .. latestVersion .. " available, current version in use: v" .. addon.Version)
                addon.Outdated = true
            end
        end
        end,
        function(message)
            print("[TBFY_LIB] Failed to check for new update for " .. addon.Name .. ": " .. message)
        end)
    hook.Remove("plyConnect", "tbfy_lib_check_version")
end)

hook.Add("PlayerInitialSpawn", "tbfy_lib_initialspawn", function(ply)
    ply.tbfyLastInteraction = 0
    for k,v in pairs(TBFY_LIB.Addons) do
        local clientConfigs = TBFY_LIB:GetClientConfigs(v)
        TBFY_LIB:SendConfigs(k, clientConfigs, ply)
    end
end)

hook.Add("InitPostEntity", "tbfy_lib_initpostentity", function()
    TBFY_LIB:SpawnEntities()
end)

hook.Add("PostCleanupMap", "tbfy_lib_postcleanup", function()
    TBFY_LIB:SpawnEntities()
end)