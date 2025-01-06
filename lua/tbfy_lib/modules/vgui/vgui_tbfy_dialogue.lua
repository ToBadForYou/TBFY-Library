local PANEL = {}

local frameWidth, frameHeight = 450, 200
function PANEL:Init()
	self:MakePopup()
	self.npcText = {}

	local mainPanel = TBFY_LIB:GetComponentStyle("mainPanel")

	self.textPanel = vgui.Create("DPanel", self)
	self.textPanel.Paint = function(selfp, w, h)
		draw.RoundedBox(4, 0, 0, w, h, mainPanel.headerColor)
		for k, lineText in ipairs(self.npcText) do
			draw.SimpleText(lineText, "default", 5, 5 + 10 * (k-1), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end
	end
	self.textPanel:Dock(TOP)

	self.optionsPanel = vgui.Create("DPanel", self)
	self.optionsPanel:SetBackgroundColor(mainPanel.color)

	self.optionsPanel:Dock(FILL)
	self.optionsPanel:DockMargin(5, 5, 5, 5)
end

function PANEL:SetNPC(npcId)
	self.npcId = npcId
end

function PANEL:SetDialogue(dialogueId)
	local dialogueData = TBFY_LIB:GetDialogue(self.npcId, dialogueId)
	self.npcText = TBFY_LIB:CutTextLength(dialogueData.text, frameWidth, "default")
	self.textPanel:SetSize(frameWidth, 10 + #self.npcText * 10)
	for k, v in ipairs(dialogueData.options) do
		if v.displayCondition() then
			local option = vgui.Create("tbfy_button", self.optionsPanel)
			local cutText = TBFY_LIB:CutTextLength(v.text, frameWidth - 5, "default")
			option:SetSize(frameWidth, 10 + #cutText * 10)
			option:SetBText(cutText)
			option:SetMultiline(true)
			option:Dock(TOP)
			option:DockMargin(0, 0, 0, 1)
			option.DoClick = function()
				if v.onSelected then
					v.onSelected()
				end
				if v.nextDialogue then
					self:SetDialogue(v.NextDialogue)
				else
					self:Remove()
				end
			end
		end
	end

	local endDialogue = vgui.Create("tbfy_button", self.optionsPanel)
	endDialogue:SetBText("End dialogue")
	endDialogue:Dock(TOP)
	endDialogue:DockMargin(0, 0, 0, 1)
	endDialogue.DoClick = function()
		self:Remove()
	end
end

function PANEL:Paint(w, h)
	local mainPanel = TBFY_LIB:GetComponentStyle("mainPanel")
	surface.SetFont(mainPanel.font)
	local fontW, fontH = surface.GetTextSize("A")
	draw.RoundedBox(4, 0, 0, w, h, mainPanel.color)
end

function PANEL:PerformLayout(w, h)
	self:SetSize(frameWidth, frameHeight)
	self:SetPos(ScrW()/2 - frameWidth/2, ScrH()/1.5 - frameHeight)
end
vgui.Register("tbfy_dialogue", PANEL)