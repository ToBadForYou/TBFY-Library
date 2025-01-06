
util.AddNetworkString("tbfy_interaction")

local activeActions = {}
local function toggleAction(ply, actionTime, actionTable, actionString)
	activeActions[TBFY_LIB:SID(ply)] = actionTable
	net.Start("tbfy_interaction")
		net.WriteUInt(actionTime, 7)
		if actionString then
			net.WriteString(actionString)
		end
	net.Send(ply)
end

local function withinInteractionRange(ent1, ent2)
	return ent1:GetPos():DistToSqr(ent2:GetPos()) < TBFY_LIB:GetConfig("INTERACTION_Range")^2
end

function TBFY_LIB:StartAction(ply, ent, startPos)
	if ent.CanInteract and !ent:CanInteract(ply) then return end
	local actionTime = ent.GetActionTime and ent:GetActionTime() or 1
	local actionTable = {ply = ply, ent = ent, actionFinish = CurTime() + actionTime, startPos = startPos,}
	toggleAction(ply, actionTime, actionTable, ent.GetActionString and ent:GetActionString() or nil)
end

hook.Add("KeyRelease", "tbfyInteractionKeyRelease", function(ply, Key)
	if Key == IN_USE and activeActions[TBFY_LIB:SID(ply)] then
		toggleAction(ply, 0, nil)
	end
end)

hook.Add("KeyPress", "tbfyInteractionKeyPress", function(ply, key)
	local curTime = CurTime()
	if ply.tbfyLastInteraction < curTime then
		ply.tbfyLastInteraction = curTime + .5
		if key == IN_USE then
			local Trace = {}
			Trace.start = ply:GetShootPos();
			Trace.endpos = Trace.start + ply:GetAimVector() * 100;
			Trace.filter = ply;

			local Tr = util.TraceLine(Trace);
			local traceEnt = Tr.Entity

			if IsValid(traceEnt) and traceEnt.tbfyInteractable and withinInteractionRange(ply, traceEnt) then
				TBFY_LIB:StartAction(ply, traceEnt, Tr.HitPos)
			end
		end
	end
end)

hook.Add("Think", "tbfyInteractionActionMonitor", function()
	for k,v in pairs(activeActions) do
		local ply, ent, actionFinish = v.ply, v.ent, v.actionFinish
		if IsValid(ent) and ply:Alive() and withinInteractionRange(ply, ent) then
			ply:SetEyeAngles((v.startPos - ply:GetShootPos()):Angle())
			if CurTime() > actionFinish then
				ent:OnAction(ply)
				toggleAction(ply, 0, nil)
			end
		else
			toggleAction(ply, 0, nil)
		end
	end
end)
