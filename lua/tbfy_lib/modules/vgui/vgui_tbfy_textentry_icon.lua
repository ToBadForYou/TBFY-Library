local PANEL = {}

function PANEL:Init()
	self.textEntry = vgui.Create("DTextEntry", self)
	self.iconPadding = 0
end

function PANEL:SetIcon(mat, iconPadding, bgColor)
	self.icon = mat
	self.iconPadding = iconPadding
	self.iconBG = bgColor

	self.textEntry:SetDrawBackground(false)
	self.textEntry.Paint = function(self, w, h)
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawOutlinedRect(0,0,w,h)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawRect(0,1,w-1,h-2)
		derma.SkinHook("Paint", "TextEntry", self, w, h)
		return false
	end
end

function PANEL:GetInput()
	return self.textEntry:GetValue()
end

function PANEL:SetPlaceholderText(text)
	self.textEntry:SetPlaceholderText(text)
end

function PANEL:Paint(W,H)
	if self.icon then
		local scaleW, scaleH = ScrW()/1920, ScrH()/1080
		local iconPad = self.iconPadding*scaleW
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawOutlinedRect(0, 0, H, H)
		surface.SetDrawColor(self.iconBG)
		surface.DrawRect(1, 1, H-2, H-2)
		surface.SetMaterial(self.icon)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(iconPad/2, iconPad/2, H-iconPad, H-iconPad)
	end
end

function PANEL:PerformLayout(W,H)
	self.textEntry:SetPos(H,0)
	self.textEntry:SetSize(W-H, H)
end
vgui.Register("tbfy_textentry_icon", PANEL)
