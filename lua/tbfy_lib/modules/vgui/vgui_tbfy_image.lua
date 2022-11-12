
local NoPic = Material("vgui/avatar_default")

local PANEL = {}

function PANEL:Init()
	self.ImgurID = nil
	self.Mat = nil
end

function PANEL:SetImgurID(ID)
	if !ID or ID == "" then
		self.Mat = NoPic
	elseif type(ID) != "string" then
		self.Mat = ID
	elseif type(ID) == "string" then
		self.ImgurID = ID
		local Mat = TBFY_SH.GetImgurImage(self.ImgurID)
		if Mat then
			self.Loading = false
			self.Mat = Mat
		else
			self.Mat = NoPic
			self.Loading = true
		end
	end
end

function PANEL:Think()
	if self.Loading then
		local Mat = TBFY_SH.GetImgurImage(self.ImgurID)
		if Mat then
			self.Loading = false
			self.Mat = Mat
		end
	end
end

function PANEL:Paint(W,H)
	if self.Mat then
		surface.SetDrawColor(255,255,255, 255)
		surface.SetMaterial(self.Mat)
		surface.DrawTexturedRect(0,0,W,H)
		surface.SetDrawColor(0,0,0, 155)
		surface.DrawOutlinedRect(0,0,W,H)
	end
end
vgui.Register("tbfy_image", PANEL)
