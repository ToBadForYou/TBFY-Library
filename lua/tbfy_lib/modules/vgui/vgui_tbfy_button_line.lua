local PANEL = {}

function PANEL:Init()
	local buttonStyle = TBFY_LIB:GetComponentStyle("button")
	self.text = ""
    self:SetText("")
	self.font = buttonStyle.font

	self.textColor = buttonStyle.textColor
	self.currentColor = buttonStyle.color
    self.color = buttonStyle.color
	self.hoveringColor = buttonStyle.buttonHovering
	self.pressedColor = buttonStyle.buttonPressed
    self.selected = false

    self.lineColor = color_white
end

function PANEL:UpdateColours()
	if self:IsDown() or self.m_bSelected then 
        self.currentColor = self.pressedColor 
    elseif self.Hovered and !self:GetDisabled() then 
        self.currentColor = self.hoveringColor 
    else
        self.currentColor = self.color
    end
	return
end

function PANEL:SetColor(color)
    self.color = color
end

function PANEL:SetLineColor(lineColor)
    self.lineColor = lineColor
    self.gradientColor = Color(lineColor.r, lineColor.g, lineColor.b, 175)
end

function PANEL:SetButtonText(text)
    self.text = text
end

function PANEL:SetFont(font)
    self.font = font
end

local gradientTexture = surface.GetTextureID("vgui/gradient-l")
function PANEL:Paint(w, h)
    surface.SetDrawColor(self.currentColor)
    surface.DrawRect(2, 0, w - 2, h)

    if self.selected then
        surface.SetDrawColor(self.gradientColor)
        surface.SetTexture(gradientTexture)
		surface.DrawTexturedRect(2, 0, w - 2, h) 
    end

    draw.SimpleText(self.text, self.font, 5, h/2, self.textColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    surface.SetDrawColor(self.lineColor)
    surface.DrawRect(0, 0, 2, h)
end
vgui.Register("tbfy_button_line", PANEL, "DButton")
