
print("[CLIENT] Faith - Mortis Death Screen has been loaded!")

local mortisMaterial = Material("mortis.png", "noclamp")

local timeOfDeath = nil
local timeOfMortis = 3
local playedMortisSound = false

net.Receive("AestheticalZ_MortisSendDeath", function()
	timeOfDeath = CurTime()
end)

net.Receive("AestheticalZ_MortisRemoveDeath", function()
	timeOfDeath = nil
	playedMortisSound = false
end)

hook.Add("HUDPaintBackground", "AestheticalZ_MortisDrawDeathScreenBackground", function()
	local ply = LocalPlayer()

	if ply:Alive() then return end
	if not timeOfDeath then return end

	if timeOfDeath + timeOfMortis < CurTime() then
		local screenWidth = ScrW()
		local screenHeight = ScrH()

		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawRect(0, 0, screenWidth, screenHeight)
	end
end)

hook.Add("HUDPaint", "AestheticalZ_MortisDrawDeathScreen", function()
	local ply = LocalPlayer()

	if ply:Alive() then return end
	if not timeOfDeath then return end

	if timeOfDeath + timeOfMortis < CurTime() then
		local screenWidth = ScrW()
		local screenHeight = ScrH()

		local imageWidth = mortisMaterial:GetInt("$realwidth")
		local imageHeight = mortisMaterial:GetInt("$realheight")

		surface.SetMaterial(mortisMaterial)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect((screenWidth - imageWidth) / 2, (screenHeight - imageHeight) / 2, imageWidth, imageHeight)

		if not playedMortisSound then
			surface.PlaySound("mortis.wav")
			playedMortisSound = true
		end
	end
end)

hook.Add("HUDShouldDraw", "AestheticalZ_MortisRemoveDeathTint", function(name)
	local ply = LocalPlayer()

	if not ply:IsValid() then return end
	if ply:Alive() then return end

	if name == "CHudDamageIndicator" then
		return false
	end
end)