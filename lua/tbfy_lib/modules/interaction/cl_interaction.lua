
net.Receive("tbfy_interaction", function()
    local actionTime, actionText = net.ReadUInt(7), net.ReadString()

    if actionTime == 0 then
        LocalPlayer().tbfyInteraction = nil
    else
        LocalPlayer().tbfyInteraction = LocalPlayer().tbfyInteraction or {}
        LocalPlayer().tbfyInteraction = {startTime = CurTime(), actionTime = actionTime, actionText = actionText}
    end
end)

local actionCircleSize = 100
function TBFY_LIB:DrawInteractionHUD()
    local activeInteraction = LocalPlayer().tbfyInteraction
    if activeInteraction then
        local curTime = CurTime()
        local startTime = activeInteraction.startTime
        local actionTime = activeInteraction.actionTime
        local timeElapsed = curTime - startTime

        local percent = math.Clamp(timeElapsed / actionTime, 0, 1)
        local timeLeft = math.Clamp((timeElapsed - actionTime) * -1, 0, actionTime)

        local xMiddleScreen, yMiddleScreen = ScrW() / 2, ScrH() / 2 // TODO: Cache ScrW, ScrH and update on screen size change hook

        TBFY_LIB:SetScissorCirclePercent(xMiddleScreen, yMiddleScreen, actionCircleSize / 2, percent)

        surface.SetMaterial(TBFY_LIB.style.materials.interactionCircle)
		surface.SetDrawColor(color_white.r, color_white.g, color_white.b, color_white.a)
        surface.DrawTexturedRect(xMiddleScreen - actionCircleSize / 2, yMiddleScreen - actionCircleSize / 2, actionCircleSize, actionCircleSize)

        TBFY_LIB:SetScissorCirclePercent()
        draw.SimpleTextOutlined(math.Round(timeLeft, 1), "tbfy_interaction_hud", xMiddleScreen, yMiddleScreen, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black)

        local actionText = activeInteraction.actionText
        if actionText then
            draw.SimpleTextOutlined(actionText, "tbfy_interaction_hud", xMiddleScreen, yMiddleScreen + actionCircleSize / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, color_black)
        end
    end
end