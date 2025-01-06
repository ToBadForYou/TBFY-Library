
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/player/Group01/female_01.mdl")
	self:SetSolid(SOLID_BBOX);
	self:PhysicsInit(SOLID_BBOX);
	self:SetMoveType(MOVETYPE_NONE);
	self:SetUseType(SIMPLE_USE);
	
	self:SetFlexWeight(10, 0)
	self:ResetSequence(3)
end

function ENT:Use(activator, caller)
    local curTime = CurTime()
    if self.Touched and self.Touched > curTime then return end
	self.Touched = curTime + 2

    net.Start("tbfy_start_dialogue")
		net.WriteInt(1, 10)
    net.Send(activator)
end

function ENT:Think()
end