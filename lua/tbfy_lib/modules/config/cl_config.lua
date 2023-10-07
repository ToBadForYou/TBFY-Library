
list.Set("DesktopWindows", "TBFY Configs", {
    title = "TBFY Configs",
    icon = "tobadforyou/tbfy_lib/settings.png",
    init = function(icon, window)
        if TBFY_LIB:HasAdminAccess(LocalPlayer()) then
            TBFY_LIB:OpenConfig()
        end
    end
})

function TBFY_LIB:OpenConfig()
    if IsValid(TBFY_LIB.ConfigMenu) then
        TBFY_LIB.ConfigMenu:Close()
    end
    TBFY_LIB.ConfigMenu = vgui.Create("tbfy_config_menu")
end

net.Receive("tbfy_config_open", function(ply, len)
    TBFY_LIB:OpenConfig()
end)

net.Receive("tbfy_config_update", function(ply, len)
    local addonID = net.ReadString()
    local configAmount = net.ReadUInt(8)
    local addon = TBFY_LIB.Addons[addonID]
    for i = 1, configAmount do
        local configID = net.ReadString()
        local config = addon.Config[configID]
        addon.Config[configID].Value = TBFY_LIB.DataTypes[config.Type].receive()
    end

    if IsValid(TBFY_LIB.ConfigMenu) then
        TBFY_LIB.ConfigMenu:SetUpConfigs(addon.ConfigKeys, addon.Config)
    end
end)