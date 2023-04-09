
function TBFY_LIB:GetComponentStyle(ID)
	return TBFY_LIB.style[ID]
end

function TBFY_LIB:InRenderRange(ply, obj)
	return ply:GetPos():DistToSqr(obj:GetPos()) < 50000
end

local color_red, color_whitish = Color(255, 20, 20, 255), Color(200, 200, 200, 255)
net.Receive("tbfy_notify_player", function()
    local txt = net.ReadString()
    GAMEMODE:AddNotify(txt, net.ReadFloat(), net.ReadFloat())
    surface.PlaySound("buttons/lightswitch2.wav")

    MsgC(color_red, "[TBFY_LIB] ", color_whitish, txt, "\n")
end)

//Credits to Bobblehead for creating ScissorCircle function
//Modified by ToBadForYou
function TBFY_LIB:SetScissorCirclePercent(x, y, radius, percent, cachedVal)
	if x then
		render.ClearStencil()
		render.SetStencilTestMask(255)
		render.SetStencilWriteMask(255)
		render.SetStencilEnable(true)
		render.SetStencilReferenceValue(1)

		render.SetStencilCompareFunction(STENCIL_NEVER)
		render.SetStencilPassOperation(STENCIL_KEEP)
		render.SetStencilFailOperation(STENCIL_REPLACE)
		render.SetStencilZFailOperation(STENCIL_REPLACE)

		draw.NoTexture()
		surface.SetDrawColor(255, 255, 255, 255)

		local poly = {}
		if cachedVal then
			poly = cachedVal
		else
			local v = 360
			poly[1] = {x = x, y = y}
			for i = 0, v*percent do
				poly[i+2] = {x = math.sin(-math.rad(i/v*360)) * (-radius) + x, y = math.cos(-math.rad(i/v*360)) * (-radius) + y}
			end
		end

		surface.DrawPoly(poly)

		render.SetStencilCompareFunction(STENCIL_EQUAL)
		render.SetStencilPassOperation(STENCIL_REPLACE)
		render.SetStencilFailOperation(STENCIL_KEEP)
		render.SetStencilZFailOperation(STENCIL_KEEP)

		return poly
	else
		render.SetStencilEnable(false)
	end
end

//END

function TBFY_LIB:DrawCornerRect(x, y, w, h, length, size)
	surface.SetDrawColor(0, 0, 0, 150)
	surface.DrawRect(x, y, w, h)

	surface.SetDrawColor(255, 255, 255, 255)

	//top left
	surface.DrawRect(x, y, length, size)
	surface.DrawRect(x, y, size, length)

	//top right
	surface.DrawRect(x + w - length, y, length, size)
	surface.DrawRect(x + w - size, y, size, length)

	//bot left
	surface.DrawRect(x, y + h - size, length, size)
	surface.DrawRect(x, y + h - length, size, length)

	//bot right
	surface.DrawRect(x + w - length, y + h - size, length, size)
	surface.DrawRect(x + w - size, y + h - length, size, length)
end

function TBFY_LIB:CutLength(str, pW, font)
	surface.SetFont(font);

	local sW = pW - 40;

	for i = 1, string.len(str) do
		local sStr = string.sub(str, 1, i);
		local w, h = surface.GetTextSize(sStr);

		if (w > pW || (w > sW && string.sub(str, i, i) == " ")) then
			local cutRet = TBFY_LIB:CutLength(string.sub(str, i + 1), pW, font);

			local returnTable = {sStr};

			for k, v in pairs(cutRet) do
				table.insert(returnTable, v);
			end

			return returnTable;
		end
	end

	return {str};
end

function TBFY_LIB:DrawCircularText(text, font, x, y, color, radius)
    local charAmount = #text
    surface.SetFont(font)
    surface.SetDrawColor(255, 255, 255, 255)
    local totalWidth, height = surface.GetTextSize(text)
    local offsetDegree = (360*totalWidth/(2*math.pi*radius))/2
    for i = 1, charAmount do
        local char = text:sub(i,i)
        local charWidth, h = surface.GetTextSize(char)
        local m = Matrix()
        m:Translate(Vector(x, y, 0))
        m:Rotate(Angle(0, offsetDegree + 90, 0))
        
        cam.PushModelMatrix(m, true)
            draw.DrawText(char, font, 0, radius, color)
        cam.PopModelMatrix()
        offsetDegree = offsetDegree - (360*charWidth/(2*math.pi*radius))
    end
end
