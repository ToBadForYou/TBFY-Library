
TBFY_LIB.NPC = TBFY_LIB.NPC or {}

function TBFY_LIB:RegisterNPC(npcData)
    if TBFY_LIB.NPC[npcData.id] then
        print("[TBFY_LIB] NPC ID collision for ID: " .. npcData.id)
    else
        TBFY_LIB.NPC[npcData.id] = {
            name = npcData.name, 
            model = npcData.model, 
            sequence = npcData.sequence || 3,
            dialogues = {}
        }
        print("[TBFY_LIB] Loaded NPC with ID: " .. npcData.id)
    end
end

function TBFY_LIB:RegisterDialogue(npcId, dialogueData)
    if TBFY_LIB.NPC[npcId] then
        TBFY_LIB.NPC[npcId].dialogues[dialogueData.id] = {
            text = dialogueData.text,
            options = dialogueData.options,
        }
        print("           - Registered dialogue with id " .. dialogueData.id)
    else
        print("[TBFY_LIB] Unable to register dialogue for NPC ID: " .. npcId .. " (no NPC with that ID)")
    end
end

function TBFY_LIB:GetDialogue(npcId, dialogueId)
    local dialgoueData = TBFY_LIB.NPC[npcId].dialogues[dialogueId]
    if dialgoueData then
        return dialgoueData
    else
        return {text = "Seems there were no dialogue with ID " .. dialogueId .. " found for NPC with ID " .. npcId .. ", please contact the server owner", options = {}}
    end
end