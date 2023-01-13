local addonName = 'Player Shoot Position Fix'
local PLAYER = FindMetaTable( 'Player' )
function PLAYER:GetRealShootPos()
	if self.m_RealShootPos then
		return self.m_RealShootPos
	end

	return self:GetShootPos()
end

hook.Add('EntityFireBullets', addonName, function( ply, data )
	if ply:IsPlayer() and ply:Alive() then
		if ply:IsBot() then return end
		if (data.Src == ply:GetShootPos()) then
			data.Src = ply:GetRealShootPos()
			return true
		end
	end
end)

hook.Add('SetupMove', addonName, function(ply)
	if ply:Alive() then
		if ply:IsBot() then return end
		ply.m_RealShootPos = ply:GetShootPos()
	end
end)