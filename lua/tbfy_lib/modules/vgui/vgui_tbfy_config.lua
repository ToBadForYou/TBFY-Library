local PANEL = {}

function PANEL:Init()
	self.ID = ""
	self.desc = ""
    self.configElement = nil
    self.configWidth = 95
end

function PANEL:SetConfig(ID, config, nth)
    self.ID = ID
    self.desc = config.Description
    self.nth = nth
    self.type = config.Type

    self.value = config.Value
    if self.value == nil then
        self.value = config.DefaultValue
    end
    if config.Type == "bool" then
        self.configElement = vgui.Create("tbfy_button_toggle", self)
        self.configElement:SetSliderInfo(12, 0.17)
        self.configElement:SetToggle(self.value)
        self.configWidth = 80
    elseif config.Type == "number" then
        self.configElement = vgui.Create("DNumSlider", self)
        self.configElement.PerformLayout = function() self.configElement.Label:SetSize(0,0) end
        self.configElement:SetMin(config.Settings.Min)
		self.configElement:SetMax(config.Settings.Max)
		self.configElement:SetDecimals(config.Settings.Decimals)
		self.configElement:SetValue(self.value)
        self.configWidth = 125
    elseif config.Type == "jobs" then
		self.configElement = vgui.Create("tbfy_button", self)
		self.configElement:SetBText("Setup Jobs")
		self.configElement.DoClick = function()
			local configSelection = vgui.Create("tbfy_config_select_multiple")
            configSelection:SetUpColumns({TBFY_LIB.Addon.GetLanguage("Job"), TBFY_LIB.Addon.GetLanguage("Allowed")})
            configSelection:SetUpValues(ID, TBFY_LIB:GetAllJobs(), "Name", self.value, self.configElement)      
		end
    elseif config.Type == "job" then
        self.configElement = vgui.Create("tbfy_config_combobox", self)
        self.configElement:SetUpChoices(TBFY_LIB:GetAllJobs(), "Name", false, self.value)
    elseif config.Type == "weapon" then
        self.configElement = vgui.Create("tbfy_config_combobox", self)
        self.configElement:SetUpChoices(TBFY_LIB:GetAllWeapons(), "ClassName", false, self.value)
    elseif config.Type == "options" then
        self.configElement = vgui.Create("tbfy_config_combobox", self)
        self.configElement:SetUpChoices(config.Settings, "Name", "ID", self.value)
    end
    self.configElement.OnValueChanged = function(selfp, value)
        self.newValue = value
    end
end

function PANEL:PerformLayout(w,h)
    if IsValid(self.configElement) then
        self.configElement:SetSize(self.configWidth, self:GetTall() - 14)
        self.configElement:SetPos(w - self.configElement:GetWide() - 7, 7)
    end
end

function PANEL:Paint(w, h) 
    local configStyle = TBFY_LIB:GetComponentStyle("config")
	surface.SetFont(configStyle.fontID)
	local fontW, fontH = surface.GetTextSize("* ")

    backgroundColor = self.nth and configStyle.nthColor or configStyle.color
    surface.SetDrawColor(backgroundColor)
    surface.DrawRect(0, 0, w, h)
    
	draw.SimpleText("* " .. self.ID, configStyle.fontID, 1, 5, configStyle.textColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	draw.SimpleText(self.desc, configStyle.fontDesc, 5 + fontW, 5 + fontH, configStyle.textColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
end
vgui.Register("tbfy_config", PANEL)

/* Component "helpers" to reduce renudant code */
local PANEL = {}

function PANEL:SetUpChoices(choices, nameKey, valueKey, setValue)
    for k,v in ipairs(choices) do
        local value = valueKey and v[valueKey] or k
        self:AddChoice(v[nameKey], value, value == setValue)
    end
    self.OnSelect = function(self, index, value, data)
        self.selectedItem = data
        self.adjusted = true
        self:OnValueChanged(data)
    end
end
vgui.Register("tbfy_config_combobox", PANEL, "DComboBox")

local PANEL = {}

function PANEL:Init()
	self.frame = vgui.Create("tbfy_frame", self)
	self.frame:SetSize(400, 300)
	self.frame:SetTitle("")
	self.frame.child = self

    self.valueColumn = 2
    self.allowed = {}

    self.listView = vgui.Create("DListView", self)
	self.listView:SetMultiSelect(false)
    self.listView.OnRowSelected = function(selfp, index, line)
        local selectedValue = line:GetValue(self.valueColumn)
        local allowed = selectedValue == TBFY_LIB.Addon.GetLanguage("Yes")
        local key = line.key
        if allowed then
            self.allowed[key] = nil
        else
            self.allowed[key] = true
        end
        local allowedText = !allowed and TBFY_LIB.Addon.GetLanguage("Yes") or TBFY_LIB.Addon.GetLanguage("No")
        line:SetColumnText(self.valueColumn, allowedText)
        if IsValid(self.parent) then
            self.parent:OnValueChanged(self.allowed)
        end
    end
end

function PANEL:SetUpColumns(columns)
    for k,v in ipairs(columns) do
        self.listView:AddColumn(v)
    end
end

function PANEL:OnRemove()
    self.parent.value = self.allowed
end

function PANEL:SetUpValues(configID, values, nameKey, setValues, parent)
    self.parent = parent
    self.frame:SetTitle(configID)
    self.allowed = setValues
    for k, v in ipairs(values) do
        local allowedText = self.allowed[k] and TBFY_LIB.Addon.GetLanguage("Yes") or TBFY_LIB.Addon.GetLanguage("No")
        local line = self.listView:AddLine(v[nameKey], allowedText)
        line.key = k
    end
end

function PANEL:PerformLayout(w,h)
	local frameWidth, frameHeight = self.frame:GetWide(), self.frame:GetTall()
	self:SetSize(self.frame:GetWide(), self.frame:GetTall())
	self:SetPos(ScrW()/2 - frameWidth/2, ScrH()/2 - frameHeight/2)
	self.frame:SetPos(0, 0)

	self.listView:SetPos(5, self.frame.headerHeight + 5)
	self.listView:SetSize(w - 10, h - self.frame.headerHeight - 10)
end
vgui.Register("tbfy_config_select_multiple", PANEL)