-- RedLeaks discord.gg/49263TE8g8
-- RedLeaks discord.gg/49263TE8g8

local recoils = {
	[`WEAPON_STUNGUN`] = {0.1, 1.1}, -- STUN GUN
	[`WEAPON_FLAREGUN`] = {0.9, 1.9}, -- FLARE GUN

	[`WEAPON_SNSPISTOL`] = {3.2, 4.2}, -- SNS PISTOL
	[`WEAPON_SNSPISTOL_MK2`] = {2.7, 3.7}, -- SNS PISTOL MK2
	[`WEAPON_VINTAGEPISTOL`] = {3.0, 4.0}, -- VINTAGE PISTOL
	[`WEAPON_PISTOL`] = {4.2, 5.2}, -- PISTOL
	[`WEAPON_PISTOL_MK2`] = {4.2, 5.2}, -- PISTOL MK2
	[`WEAPON_DOUBLEACTION`] = {3.0, 3.5}, -- DOUBLE ACTION REVOLVER
	[`WEAPON_COMBATPISTOL`] = {3.5, 4.0}, -- COMBAT PISTOL
	[`WEAPON_PISTOL50`] = {2.6, 3.1}, -- PISTOL 50
	[`WEAPON_HEAVYPISTOL`] = {2.6, 3.1}, -- HEAVY PISTOL

	[`WEAPON_DBSHOTGUN`] = {0.1, 0.6}, -- DOUBLE BARREL SHOTGUN
	[`WEAPON_SAWNOFFSHOTGUN`] = {2.1, 2.6}, -- SAWNOFF SHOTGUN
	[`WEAPON_PUMPSHOTGUN`] = {1.7, 2.2}, -- PUMP SHOTGUN
	[`WEAPON_PUMPSHOTGUN_MK2`] = {1.7, 2.2}, -- PUMP SHOTGUN MK2
	[`WEAPON_BULLPUPSHOTGUN`] = {1.5, 2.0}, -- BULLPUP SHOTGUN

	[`WEAPON_MICROSMG`] = {0.07, 0.57}, -- MICRO SMG (UZI)
	[`WEAPON_SMG`] = {0.05, 0.55}, -- SMG
	[`WEAPON_SMG_MK2`] = {0.05, 0.55}, -- SMG MK2
	[`WEAPON_ASSAULTSMG`] = {0.04, 0.54}, -- ASSAULT SMG
	[`WEAPON_COMBATPDW`] = {0.04, 0.54}, -- COMBAT PDW
	[`WEAPON_GUSENBERG`] = {0.075, 0.575}, -- GUSENBERG

	[`WEAPON_COMPACTRIFLE`] = {0.05, 0.55}, -- COMPACT RIFLE
	[`WEAPON_ASSAULTRIFLE`] = {0.04, 0.54}, -- ASSAULT RIFLE
	[`WEAPON_CARBINERIFLE`] = {0.04, 0.54}, -- CARBINE RIFLE

	[`WEAPON_MARKSMANRIFLE`] = {0.5, 1.0}, -- MARKSMAN RIFLE
	[`WEAPON_SNIPERRIFLE`] = {0.5, 1.0}, -- SNIPER RIFLE

	[`WEAPON_1911PISTOL`] = {4.0, 4.5}, -- 1911 PISTOL
	[`weapon_revolver`] = {0.07, 0.57},
}

local effects = {
	[`WEAPON_STUNGUN`] = {0.01, 0.02}, -- STUN GUN
	[`WEAPON_FLAREGUN`] = {0.01, 0.02}, -- FLARE GUN

	[`WEAPON_SNSPISTOL`] = {0.08, 0.16}, -- SNS PISTOL
	[`WEAPON_SNSPISTOL_MK2`] = {0.07, 0.14}, -- SNS PISTOL MK2
	[`WEAPON_VINTAGEPISTOL`] = {0.08, 0.16}, -- VINTAGE PISTOL
	[`WEAPON_PISTOL`] = {0.10, 0.20}, -- PISTOL
	[`WEAPON_PISTOL_MK2`] = {0.11, 0.22}, -- PISTOL MK2
	[`WEAPON_DOUBLEACTION`] = {0.1, 0.2}, -- DOUBLE ACTION REVOLVER
	[`WEAPON_COMBATPISTOL`] = {0.1, 0.2}, -- COMBAT PISTOL
	[`WEAPON_PISTOL50`] = {0.1, 0.2}, -- PISTOL 50
	[`WEAPON_HEAVYPISTOL`] = {0.1, 0.2}, -- HEAVY PISTOL

	[`WEAPON_DBSHOTGUN`] = {0.1, 0.2}, -- DOUBLE BARREL SHOTGUN
	[`WEAPON_SAWNOFFSHOTGUN`] = {0.095, 0.19}, -- SAWNOFF SHOTGUN
	[`WEAPON_PUMPSHOTGUN`] = {0.09, 0.18}, -- PUMP SHOTGUN
	[`WEAPON_PUMPSHOTGUN_MK2`] = {0.09, 0.18}, -- PUMP SHOTGUN MK2
	[`WEAPON_BULLPUPSHOTGUN`] = {0.085, 0.19}, -- BULLPUP SHOTGUN

	[`WEAPON_MICROSMG`] = {0.05, 0.1}, -- MICRO SMG (UZI)
	[`WEAPON_SMG`] = {0.04, 0.08}, -- SMG
	[`WEAPON_SMG_MK2`] = {0.04, 0.08}, -- SMG MK2
	[`WEAPON_ASSAULTSMG`] = {0.035, 0.07}, -- ASSAULT SMG
	[`WEAPON_COMBATPDW`] = {0.03, 0.06}, -- COMBAT PDW
	[`WEAPON_GUSENBERG`] = {0.035, 0.07}, -- GUSENBERG

	[`WEAPON_COMPACTRIFLE`] = {0.04, 0.08}, -- COMPACT RIFLE
	[`WEAPON_ASSAULTRIFLE`] = {0.032, 0.064}, -- ASSAULT RIFLE
	[`WEAPON_CARBINERIFLE`] = {0.03, 0.06}, -- CARBINE RIFLE

	[`WEAPON_MARKSMANRIFLE`] = {0.025, 0.05}, -- MARKSMAN RIFLE
	[`WEAPON_SNIPERRIFLE`] = {0.025, 0.05}, -- SNIPER RIFLE	

	[`WEAPON_1911PISTOL`] = {0.1, 0.2}, -- 1911 PISTOL
	[`WEAPON_FIREWORK`] = {0.5, 1.0}, -- FIREWORKS
	[`weapon_revolver`] = {0.04, 0.08},

}

-- RedLeaks discord.gg/49263TE8g8
-- RedLeaks discord.gg/49263TE8g8

local recoil = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		if DoesEntityExist(ped) then
			local status, weapon = GetCurrentPedWeapon(ped, true)
			if status == 1 then
				if weapon == `WEAPON_FIREEXTINGUISHER` then
					SetPedInfiniteAmmo(ped, true, `WEAPON_FIREEXTINGUISHER`)
				elseif IsPedShooting(ped) then
					local inVehicle = IsPedInAnyVehicle(ped, false)

					local recoil = recoils[weapon]
					if recoil and #recoil > 0 then
						local i, tv = (inVehicle and 2 or 1), 0
						if GetFollowPedCamViewMode() ~= 4 then
							repeat
								SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + 0.1, 0.2)
								tv = tv + 0.1
								Citizen.Wait(0)
							until tv >= recoil[i]
						else
							repeat
								local t = GetRandomFloatInRange(0.1, recoil[i])
								SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + t, (recoil[i] > 0.1 and 1.2 or 0.333))
								tv = tv + t
								Citizen.Wait(0)
							until tv >= recoil[i]
						end
					end

					local effect = effects[weapon]
					if effect and #effect > 0 then
						ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', (inVehicle and (effect[1] * 3) or effect[2]))
					end
				end
			end
		end
	end
end)

-- RECOIL

local simples = {
	`WEAPON_STUNGUN`,
	`WEAPON_FLAREGUN`,

	`WEAPON_SNSPISTOL`,
	`WEAPON_SNSPISTOL_MK2`,
	`WEAPON_VINTAGEPISTOL`,
	`WEAPON_PISTOL`,
	`WEAPON_PISTOL_MK2`,
	`WEAPON_DOUBLEACTION`,
	`WEAPON_COMBATPISTOL`,
	`WEAPON_HEAVYPISTOL`,

	`WEAPON_SNOWBALL`,
	`WEAPON_BALL`,
	`WEAPON_FLARE`,
	`WEAPON_FLASHLIGHT`,
	`WEAPON_KNUCKLE`,
	`WEAPON_SWITCHBLADE`,
	`WEAPON_NIGHTSTICK`,
	`WEAPON_KNIFE`,
	`WEAPON_DAGGER`,
	`WEAPON_MACHETE`,
	`WEAPON_HAMMER`,
	`WEAPON_WRENCH`,
	`WEAPON_CROWBAR`,

	`WEAPON_STICKYBOMB`,
	`WEAPON_MOLOTOV`,

	`WEAPON_DBSHOTGUN`,
	`WEAPON_SAWNOFFSHOTGUN`,
	`WEAPON_MICROSMG`,
	`WEAPON_SMG_MK2`,

	`WEAPON_1911PISTOL`
}

local types = {
	[2] = true,
	[3] = true,
	[5] = true,
	[6] = true,
	[10] = true,
	[12] = true
}

local holstered = 0
local isDead = false

Citizen.CreateThread(function()
	RequestAnimDict("rcmjosh4")
	while not HasAnimDictLoaded("rcmjosh4") do
		Citizen.Wait(10)
	end

	RequestAnimDict("reaction@intimidation@1h")
	while not HasAnimDictLoaded("reaction@intimidation@1h") do
		Citizen.Wait(10)
	end

	RequestAnimDict("weapons@pistol@")
	while not HasAnimDictLoaded("weapons@pistol@") do
		Citizen.Wait(10)
	end

	while true do
		Citizen.Wait(5)
		DisablePlayerVehicleRewards(PlayerId())

		local ped = PlayerPedId()
		if ped and ped ~= 0 and not isDead and not IsPedInAnyVehicle(ped, false) then
			local weapon = GetSelectedPedWeapon(ped)
			if weapon ~= `WEAPON_UNARMED` then
				if holstered == 0 then
					local t = 0
					if `WEAPON_SWITCHBLADE` == weapon then
						t = 1
					elseif CheckSimple(weapon) then
						TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 5, 0, 0, 0)
						t = 1
					elseif types[GetWeaponDamageType(weapon)] then
						TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 3.0,1.0, -1, 48, 0, 0, 0, 0)
						SetCurrentPedWeapon(ped, `WEAPON_UNARMED` , true)
						t = 2
					end

					holstered = weapon
					if t > 0 then
						if t == 1 then
							Citizen.Wait(300)
						elseif t == 2 then
							Citizen.Wait(500)
							SetCurrentPedWeapon(ped, weapon, true)
							Citizen.Wait(750)
						end

						ClearPedTasks(ped)
					end
				elseif holstered ~= weapon then
					local t, h = 0, false
					if `WEAPON_SWITCHBLADE` == holstered then
						Citizen.Wait(750)
						ClearPedTasks(ped)

						if CheckSimple(weapon) then
							TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 5, 0, 0, 0)
							t = 600
						elseif types[GetWeaponDamageType(weapon)] then
							TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 3.0,1.0, -1, 48, 0, 0, 0, 0)
							SetCurrentPedWeapon(ped, `WEAPON_UNARMED` , true)
							h = true
							t = 1000
						end
					elseif `WEAPON_SWITCHBLADE` == weapon then
						t = 600
					elseif CheckSimple(holstered) and CheckSimple(weapon) then
						TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 5, 0, 0, 0)
						t = 600
					elseif types[GetWeaponDamageType(holstered)] and types[GetWeaponDamageType(weapon)] then
						TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 3.0,1.0, -1, 48, 0, 0, 0, 0)
						SetCurrentPedWeapon(ped, holstered, true)
						h = true
						t = 1000
					end

					holstered = weapon
					if t > 0 then
						Citizen.Wait(t)
						if h then
							SetCurrentPedWeapon(ped, weapon, true)
							Citizen.Wait(750)
						end

						ClearPedTasks(ped)
					end
				end
			elseif holstered ~= 0 then
				local t, h = 0, false
				if `WEAPON_DOUBLEACTION` == holstered or `WEAPON_SWITCHBLADE` == holstered then
					t = 1500
				elseif CheckSimple(holstered) then
					TaskPlayAnim(ped, "weapons@pistol@", "aim_2_holster", 8.0, 2.0, -1, 48, 5, 0, 0, 0)
					t = 600
				elseif types[GetWeaponDamageType(holstered)] then
					TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0,2.0, -1, 48, 1, 0, 0, 0)
					SetCurrentPedWeapon(ped, holstered, true)
					h = true
					t = 1500
				end

				holstered = 0
				if t > 0 then
					Citizen.Wait(t)
					if h then
						SetCurrentPedWeapon(ped, `WEAPON_UNARMED` , true)
					end

					ClearPedTasks(ped)
				end
			end
		end
	end
end)

function CheckSimple(weapon)
	for _, simple in ipairs(simples) do
		if simple == weapon then
			return true
		end
	end

	return false
end

AddEventHandler('playerSpawned', function()
	isDead = false
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)




-- Pierwsza Osoba

Citizen.CreateThread(function()
	local isSniper = false
	while true do
		Citizen.Wait(0)

    	local ped = GetPlayerPed(-1)
		local currentWeaponHash = GetSelectedPedWeapon(ped)

		if currentWeaponHash == 100416529 then
			isSniper = true
		elseif currentWeaponHash == 205991906 then
			isSniper = true
		elseif currentWeaponHash == -952879014 then
			isSniper = true
		elseif currentWeaponHash == GetHashKey('WEAPON_HEAVYSNIPER_MK2') then
			isSniper = true
		else
			isSniper = false
		end

		if not isSniper then
			HideHudComponentThisFrame(14)
		end
	end
end)


local isDotAllowed = false

DotManager = function()
	while true do
		if not isDotAllowed then
			HideHudComponentThisFrame(14)
		end

		Citizen.Wait(0)
	end
end

Citizen.SetTimeout(0, DotManager)

local check = false
local forceTo = 4

ViewmodeTick = function()
	local check = nil
	while true do
		pid = PlayerId()
        weapon = GetSelectedPedWeapon(PlayerPedId())		
		
		if weapon == `WEAPON_STUNGUN` then
			SetPlayerCanDoDriveBy(pid, true)
		else
			SetPlayerCanDoDriveBy(pid, false)
        end

		if IsPedArmed(GetPlayerPed(-1), 6) then
        	DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
		end

		DisplayAmmoThisFrame(false)
		SetPlayerTargetingMode(2)

		if forceTo == 1 and not IsPlayerFreeAiming(PlayerId()) then 
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 257, true)
			DisableControlAction(0, 0, true)
		end

		if GetFollowPedCamViewMode() ~= forceTo then 
			DisableControlAction(0, 140, true) 
			DisablePlayerFiring(PlayerPedId(), true) 
		end 

		if IsPlayerFreeAiming(PlayerId()) or IsControlPressed(1, 25) then
            if GetFollowPedCamViewMode() == forceTo and check == false then
                check = false
            else
                SetFollowPedCamViewMode(forceTo)
                check = true
            end
        else
            if check == true then
                SetFollowPedCamViewMode(1)
                check = false
			end
		end
	
        Citizen.Wait(0)
    end
end

Citizen.SetTimeout(0, ViewmodeTick)


Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		local playerPed = GetPlayerPed(-1)
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		for i = 1, #zones, 1 do
			dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
		Citizen.Wait(15000)
	end
end)

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(0)
		local player = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)
	
		if dist <= 50.0 then  ------------------------------------------------------------------------------ Here you can change the RADIUS of the Safe Zone. Remember, whatever you put here will DOUBLE because 
			isInNoZone = true
			ClearPlayerWantedLevel(PlayerId())
			SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
			if IsPedInAnyVehicle(player, false) then
				TriggerEvent("PlaceRDM:deleteVehicle",-1)				
			end
			if notifOut then
				notify("~g~Wchodzisz do bezpiecznej strefy")
				notifOut = false
			end
		else
			isInNoZone = false
			if not notifOut then
				notify("~r~Opuszczasz bezpieczną strefe")
				notifOut = true
			end
		end
		if notifIn then
		DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
		DisablePlayerFiring(player,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			if IsDisabledControlJustPressed(2, 37) then --if Tab is pressed, send error message
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) 
				if IsPedInAnyVehicle(player, false) then
					TriggerEvent("PlaceRDM:deleteVehicle",-1)
					notify("~r~Nie możesz atakować innych graczy")
				end
			end
			if IsDisabledControlJustPressed(0, 106) then --if LeftClick is pressed, send error message
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) 
				if IsPedInAnyVehicle(player, false) then
					TriggerEvent("PlaceRDM:deleteVehicle",-1)-- If they click it will set them to unarmed
					notify("~r~Nie możesz atakować innych graczy")
				end
			end
		end
		-- Comment out lines 142 - 145 if you dont want a marker.
	 	if DoesEntityExist(player) then	      --The -1.0001 will place it on the ground flush		-- SIZING CIRCLE |  x    y    z | R   G    B   alpha| *more alpha more transparent*
	 		DrawMarker(1, zones[closestZone].x, zones[closestZone].y, zones[closestZone].z-1.0001, 0, 0, 0, 0, 0, 0, 100.0, 100.0, 50.0, 234, 90, 30, 155, 0, 0, 2, 0, 0, 0, 0) -- heres what all these numbers are. Honestly you dont really need to mess with any other than what isnt 0.
	 	end
	end
end)


Citizen.CreateThread(function()
	Citizen.Wait(1)
	
	while true do
		Citizen.Wait(1)
		NetworkSetFriendlyFireOption(not isInNoZone)
		if (notifIn==true) then
			Citizen.Wait(1)
			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
				TriggerEvent("PlaceRDM:deleteVehicle",-1)
			end
		end
	end
end
)

