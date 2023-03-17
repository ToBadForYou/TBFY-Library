util.AddNetworkString("tbfy_save_entity")

TBFY_LIB.CustomEntitySpawn = TBFY_LIB.CustomEntitySpawn or {}
function TBFY_LIB:RegisterCustomEntitySpawn(entClass, func)
    TBFY_LIB.CustomEntitySpawn[entClass] = func
end

net.Receive("tbfy_save_entity", function(len, ply)
    if !TBFY_LIB:HasAdminAccess(ply) then return end
    
    local entClass = net.ReadString()

    local data = {}
    for k, ent in ipairs(ents.FindByClass(entClass)) do
        table.insert(data, {pos = ent:GetPos(), ang = ent:GetAngles(), data = ent.tbfyData})
    end

    local filePath = "tbfy_lib/entities/" .. currentMap .. "/" .. entClass .. ".txt"
    if #data > 0 then
        local currentMap = string.lower(game.GetMap())
        file.Write(filePath, util.TableToJSON(data))
    elseif file.Exists(filePath) then
        file.Delete(filePath)
    end 
end)

function TBFY_LIB:SpawnEntities()
    local currentMap = string.lower(game.GetMap())

    local entFolder = "tbfy_lib/entities/" .. currentMap .. "/"
    local entFiles = file.Find(entFolder .. "*.txt", "DATA")
    for k, entFile in ipairs(entFiles) do
        local entClass = string.Split(entFile, ".")[1]
        local entData = util.JSONToTable(file.Read(entFolder .. entFile))
        local customSpawnFunc = TBFY_LIB.CustomEntitySpawn[entClass]
        for k, ent in ipairs(entData) do
            if customFunc then
                customSpawnFunc(ent)
            else
                local newEnt = ents.Create(entClass)
                newEnt:SetPos(ent.pos)
                newEnt:SetAngles(ent.ang)
                newEnt:Spawn()
                if newEnt.PostInit then
                    newEnt:PostInit(ent.data)
                end

                local physObj = newEnt:GetPhysicsObject()
                if physObj then
                    physObj:EnableMotion(false)
                end
            end
        end
    end
end

hook.Add("InitPostEntity", "tbfy_lib_init_entities", function()
    TBFY_LIB:SpawnEntities()
end)