
function TBFY_LIB:HasAdminAccess(ply)
	return TBFY_LIB.Config.AdminAccessCustomCheck(ply)
end

function TBFY_LIB:SID(ply)
	if ply:IsBot() then
		return ply:Nick()
	else
		return ply:SteamID()
	end
end

function TBFY_LIB:GetAllJobs()
	local allJobs = team.GetAllTeams()
	//Get rid off unassigned/spec/joining
	allJobs[0] = nil
	allJobs[1001] = nil
	allJobs[1002] = nil
	return allJobs
end

function TBFY_LIB:GetAllWeapons()
	return weapons.GetList()
end