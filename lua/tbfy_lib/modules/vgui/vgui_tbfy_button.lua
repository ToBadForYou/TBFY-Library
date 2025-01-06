
local PANEL = {}

function PANEL:Init()
	local buttonStyle = TBFY_LIB:GetComponentStyle("button")
	self.ButtonText = ""
	self.ButtonTextColor = Color(255,255,255,255)
	self.BColor = buttonStyle.color
	self:SetText("")
	self.Font = buttonStyle.font
	self.DButtonC = buttonStyle.color
	self.DHoverC = buttonStyle.buttonHovering
	self.DClickC = buttonStyle.buttonPressed
	self.Picture = nil
	self.PicPadding = 0
	self.DrawText = true
	self.DrawBox = true
	self.AdjustTextColor = false
	self.Multiline = false
end

function PANEL:UpdateColours()
	if self:IsDown() or self.m_bSelected then self.BColor = self.DClickC return end
	if self.Hovered and !self:GetDisabled() then self.BColor = self.DHoverC return end

	self.BColor = self.DButtonC
	return
end

function PANEL:SetMultiline(enable)
	self.Multiline = enable
end

function PANEL:SetBText(Text)
	self.ButtonText = Text
end

function PANEL:SetBoxColor(BC, BHC, BPC)
	self.DButtonC = BC
	self.DHoverC = BHC
	self.DClickC = BPC
end

function PANEL:SetBTextColor(Color)
	self.ButtonTextColor = Color
end

function PANEL:SetTextColorAdjust()
	self.AdjustTextColor = true
	self.DrawBox = false
end

function PANEL:SetBFont(Font)
	self.Font = Font
end

function PANEL:SetPicture(Mat, DrawText, DrawBox, Padding)
	self.Picture = Mat
	self.DrawText = DrawText
	self.DrawBox = DrawBox
	self.PicPadding = Padding
end

function PANEL:SetBColors(Press,Hover,Normal)
	self.DClickC = Press
	self.DHoverC = Hover
	self.DButtonC = Normal
end

function PANEL:SetCIcon()
	self.CIcon = true
end

function PANEL:Paint(W, H)
	local TWPos, THPos = W/2, H/2
	local IWPos, IHPos, ISize = W/2, 0, {W,H}
	surface.SetFont(self.Font)
	local TW, TH = surface.GetTextSize("A")
	if self.CIcon then
		THPos = H-TH
		local CSize = W*0.66
		IWPos, IHPos = W/2, H*0.1
		ISize = {CSize, CSize}
	end
	if self.DrawBox then
		draw.RoundedBox(4, 0, 0, W, H, self.BColor)
	end
	if self.DrawText then
		local TextColor = self.ButtonTextColor
		if self.AdjustTextColor then
			TextColor = self.BColor
		end
		if self.Multiline then
			for k, lineText in ipairs(self.ButtonText) do
				draw.SimpleText(lineText, "default", TWPos, TH/4 + TH * (k-1), TextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end	
		else
			draw.SimpleText(self.ButtonText, self.Font, TWPos, THPos, TextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
	if self.Picture then
		local PicPad = self.PicPadding
		surface.SetMaterial(self.Picture)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(IWPos-ISize[1]/2+PicPad,IHPos+PicPad,ISize[1]-PicPad*2,ISize[2]-PicPad*2)
	end
end
vgui.Register("tbfy_button", PANEL, "DButton")

local PANEL = {}

local gradient_down = surface.GetTextureID("vgui/gradient_down")
function PANEL:Paint(W,H)
	draw.RoundedBox(4, 0, 0, W, H, self.BColor)
	surface.SetTexture(gradient_down)
	surface.SetDrawColor(0, 142, 203, 200)
	surface.DrawTexturedRect(1,1,W-2,H-2)
	local TextColor = self.ButtonTextColor
	if self.AdjustTextColor then
		TextColor = self.BColor
	end
	draw.SimpleText(self.ButtonText, self.Font, W/2, H/2, TextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end
vgui.Register("tbfy_button_starwars", PANEL, "tbfy_button")
