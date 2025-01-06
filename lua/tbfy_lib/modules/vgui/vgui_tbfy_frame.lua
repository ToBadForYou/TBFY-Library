local PANEL = {}

function PANEL:Init()
    self.title = ""

	local mainPanel = TBFY_LIB:GetComponentStyle("mainPanel")
	surface.SetFont(mainPanel.font)
	local fontW, fontH = surface.GetTextSize("A")
    self.headerHeight = fontH + 10

	self.closeButton = vgui.Create("tbfy_button", self)
	self.closeButton:SetBText("X")
	self.closeButton.DoClick = function()
        if IsValid(self.child) then
            self.child:Remove()
        end
		self:Remove()
	end
end

function PANEL:SetTitle(title)
    self.title = title
end

function PANEL:Paint(w, h)
	local mainPanel = TBFY_LIB:GetComponentStyle("mainPanel")
	surface.SetFont(mainPanel.font)
	local fontW, fontH = surface.GetTextSize("A")
	draw.RoundedBox(4, 0, 0, w, h, mainPanel.color)
	draw.RoundedBox(4, 0, 0, w, self.headerHeight, mainPanel.headerColor)
	draw.SimpleText(self.title, mainPanel.font, 5, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
end

function PANEL:PerformLayout(w, h)
	self:SetPos(ScrW()/2 - w/2, ScrH()/2 - h/2)

	self.closeButton:SetPos(w - 25, 3)
	self.closeButton:SetSize(20, 20)
end

vgui.Register("tbfy_frame", PANEL)