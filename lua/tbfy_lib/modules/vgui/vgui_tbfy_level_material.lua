local PANEL = {}

function PANEL:Init()
  self.level = 1
  self.maxLevel = 5
  self.padding = 2
end

function PANEL:SetMaterial(mat)
  self.mat = mat
end

function PANEL:SetLevel(level)
  self.level = level
end

function PANEL:SetMaxLevel(maxLevel)
  self.maxLevel = maxLevel
end

function PANEL:SetPadding(padding)
  self.padding = padding
end

function PANEL:GetWSize()
  local W, H = self:GetSize()
  local sizeW = math.Clamp(W/self.maxLevel, 0, H)
  sizeW = math.Clamp(sizeW, 0, W)
  return sizeW * self.maxLevel + self.padding * (self.maxLevel - 2)
end

function PANEL:Paint(W, H)
  if self.mat then
    W = W - self.padding*(self.maxLevel-1)
    local sizeW = math.Clamp(W/self.maxLevel, 0, H)
    sizeW = math.Clamp(sizeW, 0, W)
    for i = 1, self.maxLevel do
      local alpha = 255
      if i > self.level then
        alpha = 25
      end
      surface.SetDrawColor(255, 255, 255, alpha)
      surface.SetMaterial(self.mat)
      surface.DrawTexturedRect(sizeW*(i-1) + self.padding*(i-1), 0, sizeW, sizeW)
    end
  end
end
vgui.Register("tbfy_level_material", PANEL)
