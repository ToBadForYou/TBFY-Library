include('shared.lua')

function ENT:Initialize ()
	self.aps = 50
	self.lastRot = CurTime()
	self.curRot = 0
	
	self.Font = "di_npc_text"
	self.Text = "Test NPC"
	self.TextColor = color_white
	self.TextBGColor = color_black
end

surface.CreateFont("di_npc_text", {
	font = "Verdana",
	size = 50,
	weight = 500,
	antialias = true,
})

function ENT:Draw()
	self:DrawModel()	

	if LocalPlayer():GetPos():DistToSqr(self:GetPos()) >= 100000 then
		return
   end

    local curTime = CurTime()
	self.curRot = self.curRot + (self.aps * (curTime - self.lastRot))
	if (self.curRot > 360) then self.curRot = self.curRot - 360 end
	self.lastRot = curTime
	
	local obbMaxs = self:LocalToWorld(self:OBBMaxs())
	local entPos = self:GetPos()
	local camPos = Vector(entPos.x, entPos.y, obbMaxs.z+5)
    local camAngle = Angle(180, self.curRot, -90)

	cam.Start3D2D(camPos, camAngle, .1)
		draw.SimpleTextOutlined(self.Text, self.Font, 0, 0, self.TextColor, TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, color_black)
	cam.End3D2D()

    camAngle.y = camAngle.y + 180
	cam.Start3D2D(camPos, camAngle, .1)
		draw.SimpleTextOutlined(self.Text, self.Font, 0, 0, self.TextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
	cam.End3D2D()
end