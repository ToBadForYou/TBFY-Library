
local function drawCircle(x, y, radius, seg)
	local cir = {}
	table.insert(cir, {x = x, y = y})
	for i = 0, seg do
		local a = math.rad( (i / seg) * -360)
		table.insert(cir, {x = x + math.sin(a) * radius, y = y + math.cos(a) * radius})
	end
	local a = math.rad(0)
	table.insert(cir, {x = x + math.sin(a) * radius, y = y + math.cos(a) * radius})
	surface.DrawPoly(cir)
end

local PANEL = {}

function PANEL:Init()
	self.Avatar = vgui.Create("tbfy_image", self)
	self.Avatar:SetPaintedManually(true)
	self.Avatar:SetZPos(-1)
end

function PANEL:PerformLayout(W, H)
	self.Avatar:SetSize(W,H)
end

function PANEL:SetImgurID(ImgurID)
	self.Avatar:SetImgurID(ImgurID)
end

function PANEL:Paint(w, h)
	local SizeW,SizeH = w,h
	surface.SetDrawColor(Color(0, 0, 0, 255))
	drawCircle(w/2, h/2, SizeH/2, math.max(SizeW,SizeH)/2)

	render.ClearStencil()
	render.SetStencilEnable(true)

	render.SetStencilWriteMask(1)
	render.SetStencilTestMask(1)

	render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_ZERO)
	render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
	render.SetStencilReferenceValue(1)

	draw.NoTexture()
	surface.SetDrawColor(Color(0, 0, 0, 255))
	drawCircle(w/2, h/2, SizeH/2, math.max(SizeW,SizeH)/2)

	render.SetStencilFailOperation(STENCILOPERATION_ZERO)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
	render.SetStencilReferenceValue(1)

	self.Avatar:PaintManual()

	render.SetStencilEnable(false)
	render.ClearStencil()

	surface.DrawCircle(w/2, h/2, SizeH/2, Color(0,0,0,155))
end
vgui.Register("tbfy_image_circle", PANEL)
