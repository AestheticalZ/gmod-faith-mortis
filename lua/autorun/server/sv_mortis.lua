
print("[SERVER] Faith - Mortis Death Screen has been loaded!")

util.AddNetworkString("AestheticalZ_MortisSendDeath")
util.AddNetworkString("AestheticalZ_MortisRemoveDeath")

hook.Add("PlayerDeathThink", "AestheticalZ_MortisHandleDeathThink", function(ply)
	if not timer.Exists(ply:SteamID() .. "respawn_time") then
		return
	else
		return false
	end
end)

hook.Add("PlayerDeath", "AestheticalZ_MortisHandleDeath", function(victim, inflictor, attacker)
	net.Start("AestheticalZ_MortisSendDeath", false)
	net.Send(victim)

	timer.Create(victim:SteamID() .. "respawn_time", 3.5, 1, function() end)
end)

hook.Add("PlayerSpawn", "AestheticalZ_MortisClearScreen", function(ply)
	net.Start("AestheticalZ_MortisRemoveDeath", false)
	net.Send(ply)
end)

hook.Add("PlayerDeathSound", "AestheticalZ_MortisDisableDeathSound", function()
	return true
end)