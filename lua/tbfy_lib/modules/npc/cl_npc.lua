
net.Receive("tbfy_start_dialogue", function()
    local npcId = net.ReadUInt(10)
    local dialogue = vgui.Create("tbfy_dialogue")
    dialogue:SetNPC(npcId)
    dialogue:SetDialogue(1)
end)