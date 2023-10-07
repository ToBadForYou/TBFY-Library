
local PANEL = {}

function PANEL:Init()
	self:ShowCloseButton(false)
	self:SetTitle("")
	self:MakePopup()

	self.currentAddon = nil

	self.frame = vgui.Create("tbfy_frame", self)
	self.frame:SetSize(900, 600)
	self.frame:SetTitle("TBFY Configs")
	self.frame.child = self

	local dScrollPanelStyle = TBFY_LIB:GetComponentStyle("dScrollPanel")
	self.addons = vgui.Create("DScrollPanel", self)
	self.addons:SetBackgroundColor(dScrollPanelStyle.color)
	self.addons.buttonList = {}

	local sbar = self.addons:GetVBar()
	sbar:SetHideButtons(true)
	function sbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, dScrollPanelStyle.barColor)
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, dScrollPanelStyle.barGripColor)
	end

	local index = 1
	local lastButton
	for k,v in pairs(TBFY_LIB.Addons) do
		local button = vgui.Create("tbfy_button_line", self.addons)
		button:SetIsToggle(true)
		button:SetButtonText(v.Name)
		button:SetLineColor(v.Color)
		button:SetFont("tbfy_config_addons")
		button.DoClick = function()
			if lastButton then
				lastButton.selected = false
			end
			button.selected = true
			lastButton = button
			self:UpdateConfig()
			self.currentAddon = k
			self:FetchConfigValues(k)
		end

		self.addons.buttonList[index] = button
		index = index + 1
	end

	self.config = vgui.Create("DScrollPanel", self)
	self.config:SetVisible(false)
	self.config:SetBackgroundColor(dScrollPanelStyle.color)
	self.config.configs = {}

	local sbar = self.config:GetVBar()
	sbar:SetHideButtons(true)
	function sbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, dScrollPanelStyle.barColor)
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, dScrollPanelStyle.barGripColor)
	end
end

function PANEL:FetchConfigValues(addonID)
	net.Start("tbfy_config_fetch")
		net.WriteString(addonID)
	net.SendToServer()
end

function PANEL:SetUpConfigs(configKeys, configs)
	for index, key in ipairs(configKeys) do
		local config = vgui.Create("tbfy_addon_config", self.config)
		config:SetConfig(key, configs[key], index % 2 == 0)
		self.config.configs[index] = config
	end
	self.config:SetVisible(true)
end

function PANEL:UpdateConfig()
	if self.currentAddon then
		local updatedConfigs = {}
		for k,v in ipairs(self.config.configs) do
			if v.newValue != nil then
				updatedConfigs[#updatedConfigs + 1] = {ID = v.ID, value = v.newValue, type = v.type}
			end
		end
		if #updatedConfigs > 0 then
			net.Start("tbfy_config_update")
				net.WriteString(self.currentAddon)
				net.WriteUInt(#updatedConfigs, 8)
				for k,v in ipairs(updatedConfigs) do
					net.WriteString(v.ID)
					TBFY_LIB.DataTypes[v.type].send(v.value)
				end
			net.SendToServer()
		end
	end
end

function PANEL:OnRemove()
	self:UpdateConfig()
end

function PANEL:Paint(w,h)
end

function PANEL:PerformLayout(w,h)
	local frameWidth, frameHeight = self.frame:GetWide(), self.frame:GetTall()
	self:SetSize(self.frame:GetWide(), self.frame:GetTall())
	self:SetPos(ScrW()/2 - frameWidth/2, ScrH()/2 - frameHeight/2)
	self.frame:SetPos(0, 0)

	local addonsWidth = w*0.2
	self.addons:SetPos(0, self.frame.headerHeight)
	self.addons:SetSize(addonsWidth, h - self.frame.headerHeight)

	for k,v in ipairs(self.addons.buttonList) do
		v:SetSize(self.addons:InnerWidth(), 35)
		v:SetPos(0, (k-1)*35)
	end

	local configWidth = w - addonsWidth - 10
	self.config:SetPos(addonsWidth + 5, self.frame.headerHeight + 5)
	self.config:SetSize(configWidth, h- self.frame.headerHeight - 10)

	for k,v in ipairs(self.config.configs) do
		v:SetSize(self.config:InnerWidth(), 40)
		v:SetPos(0, (k-1)*40)
	end
end

vgui.Register("tbfy_config_menu", PANEL, "DFrame")
