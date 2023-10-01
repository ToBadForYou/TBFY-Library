
function TBFY_LIB:RegisterAddon(ID, name, folder, color, version)
    if !TBFY_LIB.Addons[ID] then
        file.CreateDir(folder)

        TBFY_LIB.Addons[ID] = {
            ID = ID,
            Name = name,
            Color = color,
            Version = version,
            Outdated = false,
            Folder = folder,
            Language = {},
            Config = {},
            ClientConfig = {}
        }

        local addon = TBFY_LIB.Addons[ID]
        addon.AddConfig = function(configID, configType, desc, defaultValue, settings, updateClient)
            addon.Config[configID] = {Description = desc, Type = configType, DefaultValue = defaultValue, Settings = settings}
            if updateClient then
                addon.ClientConfig[#addon.ClientConfig + 1] = configID
            end
        end

        addon.GetConfig = function(configID)
            return addon.Config[configID].Value or addon.Config[configID].DefaultValue
        end

        addon.GetLanguage = function(langID)
            return addon.Language[langID]
        end

        addon.AddLanguage = function(langID, languageText)
            addon.Language[langID] = languageText
        end

        addon.HasAdminAccess = function(ply)
            return addon.CheckAdmin and addon.CheckAdmin(ply)
        end     
	else
		print("[TBFY_LIB] The addon " .. name .. " with ID " .. ID .. " was loaded twice.")
	end
	return TBFY_LIB.Addons[ID]
end

function TBFY_LIB:SetAdminAccess(addon, checkAdminFunc)
    addon.CheckAdmin = checkAdminFunc
end

function TBFY_LIB:LoadLanguage(addon, language)
    local folder = addon.Folder
    include(folder .. "/language/" .. language .. ".lua");
    if SERVER then
        AddCSLuaFile(folder .. "/language/" .. language .. ".lua");
    end
end

function TBFY_LIB:LoadConfig(addon)
    local configFile = addon.Folder .. "/config.txt"
    if file.Exists(configFile, "DATA") then
        local configs = util.JSONToTable(file.Read(configFile))
        for k,v in pairs(configs) do
            addon.Config[k].Value = v
        end
    end
end

function TBFY_LIB:SaveConfig(addon)
    local config = {}
    for k,v in pairs(addon.Config) do
        if v.Value != nil then
            config[k] = v.Value
        end
    end

    local configFile = addon.Folder .. "/config.txt"
    file.Write(configFile, util.TableToJSON(config))
end

TBFY_LIB.Addon = TBFY_LIB.Addon or TBFY_LIB:RegisterAddon("tbfy_lib", "TBFY Library", "tbfy_lib", color_white, "1.0.0")
TBFY_LIB:LoadLanguage(TBFY_LIB.Addon, TBFY_LIB.Config.Language)
