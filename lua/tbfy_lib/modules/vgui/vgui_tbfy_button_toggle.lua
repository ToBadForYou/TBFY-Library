local PANEL = {}

function PANEL:Init()
	self:SetText("")
	self.sliderPos = 0
	self.sliderWidth = 0
	self.toggle = false
end

function PANEL:SetToggle(toggle)
	self.toggle = toggle
	self.pressedTime = 0
end

function PANEL:SetSliderInfo(sliderWidth, movingTime)
	self.sliderWidth = sliderWidth
	self.movingTime = movingTime
end

function PANEL:ToggleButton()
	self.toggle = !self.toggle
	self.pressedTime = CurTime()

	if self.OnValueChanged then
		self:OnValueChanged(self.toggle)
	end
end

function PANEL:DoClick()
	self:ToggleButton()
end

function PANEL:Think()
	if self.pressedTime then
		local totalTime = self.pressedTime + self.movingTime
		local width = self:GetWide()

		if self.toggle then
			self.sliderPos = math.Remap(math.Min(CurTime(), totalTime), self.pressedTime, totalTime, 0, width - self.sliderWidth)
		else
			self.sliderPos = math.Remap(math.Min(CurTime(), totalTime), self.pressedTime, totalTime, width - self.sliderWidth, 0)
		end
	end
end

function PANEL:Paint(W, H)
	local toggleButtonStyle = TBFY_LIB:GetComponentStyle("toggleButton")

	draw.RoundedBox(4, 0, 0, W, H, color_black)

	currentColor = self.toggle and toggleButtonStyle.colorON or toggleButtonStyle.colorOFF
	currentText = self.toggle and toggleButtonStyle.textON or toggleButtonStyle.textOFF
	draw.RoundedBox(4, 1, 1, W-2, H-2, currentColor)

	draw.RoundedBox(4, self.sliderPos, 0, self.sliderWidth, H, color_black)
	draw.RoundedBox(4, self.sliderPos + 1, 1, self.sliderWidth - 2, H-2, toggleButtonStyle.color)

	draw.SimpleText(currentText, toggleButtonStyle.font, W/2, H/2, toggleButtonStyle.textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end
vgui.Register("tbfy_button_toggle", PANEL, "DButton")
