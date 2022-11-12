local PANEL = {}

function PANEL:Init()
	self.text = ""
	self.font = "default"
	self.alignX = TEXT_ALIGN_CENTER
	self.alignY = TEXT_ALIGN_CENTER
	self.hoverText = false
	self.hovering = false

	self.textColor = Color(255, 255, 255, 255)
	self.hoverColor = Color(255, 255, 255, 120)
	self.clickColor = Color(255, 255, 255, 50)
end

function PANEL:SetText(text)
	self.text = text
end

function PANEL:SetAlignX(align)
	self.alignX = align
end

function PANEL:SetAlignY(align)
	self.alignY = align
end

function PANEL:SetFont(font)
	self.font = font
end

function PANEL:SetHoverText(bool)
	self.hoverText = bool
end

function PANEL:OnCursorEntered()
	self.hovering = true
end

function PANEL:OnCursorExited()
	self.hovering = false
	self.clicked = false
end

function PANEL:OnMousePressed(keyCode)
	self.clicked = true
end

function PANEL:OnMouseReleased(keyCode)
	self.clicked = false
end

function PANEL:SizeToContents()
	surface.SetFont(self.font)
	local W, H = surface.GetTextSize(self.text)
	self:SetSize(W, H)
end

function PANEL:Paint(W,H)
	local X = 0
	if self.alignX == TEXT_ALIGN_RIGHT then
		X = W
	elseif self.alignX == TEXT_ALIGN_CENTER then
		X = W/2
	end

	local Y = 0
	if self.alignY == TEXT_ALIGN_BOTTOM then
		Y = H
	elseif self.alignY == TEXT_ALIGN_CENTER then
		Y = H/2
	end

	if self.hovering and self.hoverText then
		surface.SetFont(self.font)
		local textW, textH = surface.GetTextSize(self.text)
		textW = textW + 10
		textH = textH + 1
		DisableClipping(true)
		draw.RoundedBox(4, W/2-textW/2, -textH, textW, textH, Color(0,0,0,255))
		draw.SimpleText(self.text, self.font, W/2, -1, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		DisableClipping(false)
	end

	local textColor = self.textColor
	if self.clicked then
		textColor = self.clickColor
	elseif self.hovering then
		textColor = self.hoverColor
	end

	draw.SimpleText(self.text, self.font, X, Y, textColor, self.alignX, self.alignY)
end
vgui.Register("tbfy_label", PANEL)
