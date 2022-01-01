-- Author of this server: Fineeasz#1809
-- Author of this server: Fineeasz#1809

local nameofserver = "PlaceRDM"

local ESX = nil
local disableShuffle = true

local appid = '815849247663718450' 
local asset = 'logo' 
local asset_text = "PlaceRDM"


  

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            AddTextEntry('FE_THDR_GTAO', "".. nameofserver .." ~s~| ~o~ID: ".. GetPlayerServerId(PlayerId()))
			SetPedInfiniteAmmo(PlayerPedId(), true)
            ESX = obj 
        end)

        Citizen.Wait(0)
    end
end)


		-- ANTI VDM

		SetWeaponDamageModifier(-1553120962, 0.0)



-- Dodanie broni

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 246) then
           GiveAllWeapons()
        end
	end
end)

function dajbron (bronjebana)
	SetPedInfiniteAmmo(PlayerPedId(), true)
    GiveWeaponToPed(PlayerPedId(), GetHashKey(bronjebana), 1000, false, false)
end

function GiveAllWeapons ()
            dajbron("weapon_pistol")
            dajbron("weapon_combatpistol")
			dajbron("weapon_heavypistol")
			dajbron("weapon_pistol_mk2")
			dajbron("weapon_snspistol")
			dajbron("weapon_snspistol_mk2")
			dajbron("weapon_assaultrifle")
			dajbron("weapon_pumpshotgun_mk2")
			dajbron("weapon_pumpshotgun")
			dajbron("weapon_smg_mk2")
			dajbron("weapon_microsmg")
			dajbron("weapon_compactrifle")
			dajbron("weapon_sawnoffshotgun")
			dajbron("weapon_carbinerifle")
			dajbron("weapon_smg")
			dajbron("weapon_combatpdw")
			dajbron("weapon_assaultsmg")
			dajbron("weapon_vintagepistol")
			dajbron("weapon_BULLPUPSHOTGUN")
			dajbron("weapon_DBSHOTGUN")
			dajbron("weapon_snowball")
			--dajbron("WEAPON_STUNGUN")
    notify('~g~Dodano wszystkie dostępne bronie!')
end

-- goto (Teleport do kogos)

RegisterCommand("tpa", function(source, args)
    local targetId = tonumber(args[1])
    TriggerServerEvent('EasyAdmin:TeleportAdminToPlayer', targetId)
end)

RegisterCommand("goto", function(source, args)
    local targetId = tonumber(args[1])
    TriggerServerEvent('EasyAdmin:TeleportAdminToPlayer', targetId)
end)


-- Fix (Naprawa Pojazdu)

RegisterNetEvent('PlaceRDM:fix')
AddEventHandler('PlaceRDM:fix', function()
    playerPed = GetPlayerPed( -1 )
    local vehicle = GetVehiclePedIsIn(playerPed, true)
    if IsPedInAnyVehicle(playerPed, false) then
        if not (GetPedInVehicleSeat(vehicle, -1) == PlayerPedId()) then
            notify("~r~Musisz siedziec jako kierowca aby naprawic auto")
            return
          end
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        SetVehicleEngineHealth(vehicle, 9999)
        SetVehiclePetrolTankHealth(vehicle, 9999)
        SetVehicleFixed(vehicle)
        notify("~g~Naprawiles pojazd")
    else
        notify("~r~Nie ma cie w pojezdzie")
    end
end)

-- Obrozenie auta (FLIP)

RegisterNetEvent("PlaceRDM:flip")
AddEventHandler("PlaceRDM:flip", function()
  local playerPed = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(playerPed, true)
	if IsPedInAnyVehicle(PlayerPedId(), false) and DoesEntityExist(GetVehiclePedIsIn(playerPed, true)) then
        if not (GetPedInVehicleSeat(vehicle, -1) == PlayerPedId()) then
            notify("~r~Musisz siedziec jako kierowca aby obrócić auto")
            return
          end
		SetVehicleOnGroundProperly(vehicle)
        notify("~g~Pojazd Odwrócony")
	else
        notify("~r~Nie ma cie w pojezdzie")
	end
end)

-- Usuwanie auta (DV)

RegisterNetEvent( "PlaceRDM:deleteVehicle" )
AddEventHandler( "PlaceRDM:deleteVehicle", function()
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if DoesEntityExist(vehicle) then
            local id = NetworkGetNetworkIdFromEntity(vehicle)
            SetNetworkIdCanMigrate(id, false)
            local tries = 0
            while not NetworkRequestControlOfNetworkId(id) and tries < 10 do
                tries = tries + 1
                NetworkRequestControlOfNetworkId(id)
                Citizen.Wait(100)
            end
            if not (GetPedInVehicleSeat(vehicle, -1) == PlayerPedId()) then
                notify("~r~Musisz siedziec jako kierowca aby usunac auto")
                return
              end
            SetEntityAsMissionEntity(vehicle, true, true)
            DeleteVehicle(vehicle)
            notify('~g~Usunięto pojazd!')
            else
            notify('~r~Musisz znajdować się w pojeździe!')
        end
end )

-- Wyczyszczenie auta (CLEAN)

RegisterNetEvent('PlaceRDM:clean')
AddEventHandler('PlaceRDM:clean', function()
  local playerPed = GetPlayerPed(-1)
  if IsPedInAnyVehicle(playerPed, false) then
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if not (GetPedInVehicleSeat(vehicle, -1) == PlayerPedId()) then
        TriggerEvent("FeedM:showNotification", '~w~Musisz siedziec jako kierowca aby wyczyscic auto', 4000, primary)
      return
    end
    SetVehicleDirtLevel(vehicle, 0)
    notify("~g~Pojazd wyczyszczony")
  else
    notify("~r~Nie ma cie w pojezdzie")
  end
end)



-- Leczenie (Heal)

RegisterNetEvent('PlaceRDM:heal')
AddEventHandler('PlaceRDM:heal', function()

    local playerPed = PlayerPedId()

	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))

	
    local id = GetPlayerServerId(PlayerId())
    TriggerServerEvent('PlaceRDM:HealMsg', id)
    TriggerServerEvent('PlaceRDM:heal', source)

end)


-- TPM

RegisterNetEvent('PlaceRDM:Tpm')
AddEventHandler('PlaceRDM:Tpm', function()
    local WaypointHandle = GetFirstBlipInfoId(8)
    if DoesBlipExist(WaypointHandle) then
        local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
        for height = 1, 1000 do
            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)
            if foundGround then
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                break
            end
            Citizen.Wait(5)
        end
        notify("~g~Przeteleportowano")
    else
        notify("~r~Ustaw Waypoint")
    end
end)

-- Shuff

function disableSeatShuffle(flag)

	disableShuffle = flag

end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
	if IsPedInAnyVehicle(PlayerPedId(), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), 0) == PlayerPedId() then
				if GetIsTaskActive(PlayerPedId(), 165) then
					SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), 0)
				end
			end
		end
	end
end)



RegisterNetEvent("PlaceRDM:Shuff")

AddEventHandler("PlaceRDM:Shuff", function()

	if IsPedInAnyVehicle(PlayerPedId(), false) then

		disableSeatShuffle(false)

		Citizen.Wait(5000)

		disableSeatShuffle(true)

	end

end)

Citizen.CreateThread(function()

	local ped = PlayerPedId()

	SetCanAttackFriendly(ped, true, false)

	NetworkSetFriendlyFireOption(true)

	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()

		-- ANTI VDM

		SetWeaponDamageModifier(-1553120962, 0.0)

		-- Wywalenie Pedow

		SetPedDensityMultiplierThisFrame(0.0)
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
		SetRandomVehicleDensityMultiplierThisFrame(0.0)
		SetParkedVehicleDensityMultiplierThisFrame(0.0)
		SetVehicleDensityMultiplierThisFrame(0.0)
        SetCreateRandomCops(false)
		SetCreateRandomCopsNotOnScenarios(false)
		SetCreateRandomCopsOnScenarios(false)
        DisablePlayerVehicleRewards(PlayerId())
		DisplayAmmoThisFrame(false)

       -- Inne 

       SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
       
       -- Anty Kolba

       if IsPedArmed(ped, 6) then
        DisableControlAction(1, 140, true)
        DisableControlAction(1, 141, true)
        DisableControlAction(1, 142, true)
         end

		local scenarios = {

			'WORLD_VEHICLE_ATTRACTOR',

			'WORLD_VEHICLE_AMBULANCE',

			'WORLD_VEHICLE_BOAT_IDLE',

			'WORLD_VEHICLE_BOAT_IDLE_ALAMO',

			'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',

			'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',

			'WORLD_VEHICLE_BROKEN_DOWN',

			'WORLD_VEHICLE_BUSINESSMEN',

			'WORLD_VEHICLE_HELI_LIFEGUARD',

			'WORLD_VEHICLE_CLUCKIN_BELL_TRAILER',

			'WORLD_VEHICLE_CONSTRUCTION_SOLO',

			'WORLD_VEHICLE_CONSTRUCTION_PASSENGERS',

			'WORLD_VEHICLE_DRIVE_PASSENGERS',

			'WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED',

			'WORLD_VEHICLE_DRIVE_SOLO',

			'WORLD_VEHICLE_FARM_WORKER',

			'WORLD_VEHICLE_FIRE_TRUCK',

			'WORLD_VEHICLE_EMPTY',

			'WORLD_VEHICLE_MARIACHI',

			'WORLD_VEHICLE_MECHANIC',

			'WORLD_VEHICLE_MILITARY_PLANES_BIG',

			'WORLD_VEHICLE_MILITARY_PLANES_SMALL',

			'WORLD_VEHICLE_PARK_PARALLEL',

			'WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN',

			'WORLD_VEHICLE_PASSENGER_EXIT',

			'WORLD_VEHICLE_POLICE_BIKE',

			'WORLD_VEHICLE_POLICE_CAR',

			'WORLD_VEHICLE_POLICE',

			'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',

			'WORLD_VEHICLE_QUARRY',

			'WORLD_VEHICLE_SALTON',

			'WORLD_VEHICLE_SALTON_DIRT_BIKE',

			'WORLD_VEHICLE_SECURITY_CAR',

			'WORLD_VEHICLE_STREETRACE',

			'WORLD_VEHICLE_TOURBUS',

			'WORLD_VEHICLE_TOURIST',

			'WORLD_VEHICLE_TANDL',

			'WORLD_VEHICLE_TRACTOR',

			'WORLD_VEHICLE_TRACTOR_BEACH',

			'WORLD_VEHICLE_TRUCK_LOGS',

			'WORLD_VEHICLE_TRUCKS_TRAILERS',

			'WORLD_VEHICLE_DISTANT_EMPTY_GROUND'

		}

		for i, v in ipairs(scenarios) do
			SetScenarioTypeEnabled(v, false)
		end
       end
     end)

-- Discord Rich Presence

function SetRP()
    local name = GetPlayerName(PlayerId())
    local id = GetPlayerServerId(PlayerId())
    players = {}
        for i = 0, 255 do
            if NetworkIsPlayerActive( i ) then
                table.insert( players, i )
            end
        end

    SetRichPresence(name ..' - '.. id)
    SetDiscordAppId(appid)
    SetDiscordRichPresenceAsset(asset)
    SetDiscordRichPresenceAssetText('Graczy: '.. #players)
	SetDiscordRichPresenceAction(0, "DISCORD", "https://discord.gg/BvNPZUwk")
end

Citizen.CreateThread(function()
    SetRP()
    
    while true do
        Citizen.Wait(2500)
        SetRP()
    end

end)

-- Infintiny Stamina

Citizen.CreateThread( function()
	while true do
		Citizen.Wait(500)
		ResetPlayerStamina(PlayerId())
	end
end)


local reviveWait = 1
local isDead = false
local timerCount = reviveWait

AddEventHandler('onClientMapStart', function()
	exports.spawnmanager:spawnPlayer() -- Ensure player spawns into server.
	Citizen.Wait(2500)
	exports.spawnmanager:setAutoSpawn(false)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)			
            -- Hologram No. 1
    if GetDistanceBetweenCoords(  716.36, -985.42, 24.14, GetEntityCoords(GetPlayerPed(-1))) < 10.0 then
        Draw3DText( 716.36, -985.42, 24.14  -1.400, "~w~Witamy cie na ~o~Place~o~RDM,", 4, 0.1, 0.1)
        Draw3DText( 716.36, -985.42, 24.14  -1.600, "~w~Wszystkie potrzebne informacje znajdziesz na \n~o~discord.gg/BvNPZUwk", 4, 0.1, 0.1)
 end		
end
end)

--

function revivePed(ped)
	local playerPos = GetEntityCoords(ped, true)
	isDead = false
	timerCount = reviveWait
	NetworkResurrectLocalPlayer(playerPos, true, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)
end

Citizen.CreateThread(function()
	local respawnCount = 65
	local spawnPoints = 65
	local playerIndex = NetworkGetPlayerIndex(-1) or 0
	math.randomseed(playerIndex)

	function createSpawnPoint(x1, x2, y1, y2, z, heading)
		local xValue = math.random(x1,x2) + 0.0001
		local yValue = math.random(y1,y2) + 0.0001

		local newObject = {
			x = xValue,
			y = yValue,
			z = z + 0.0001,
			heading = heading + 0.0001
		}
		table.insert(spawnPoints,newObject)
	end

		createSpawnPoint( 712.13, -982.33, 24.11)
	


    while true do
    Citizen.Wait(0)
		ped = GetPlayerPed(-1)
        if IsEntityDead(ped) then
			isDead = true
            SetPlayerInvincible(ped, true)
            SetEntityHealth(ped, 1)
            notify("~w~Kliknij ~r~E ~w~aby sie zrespic")
            if IsControlJustReleased(0, 38) and GetLastInputMethod(0) then
                if timerCount <= 0 then
                    revivePed(ped)
				else
					TriggerEvent('chat:addMessage', { args = {'^*Odczekaj ' .. timerCount .. ' sekund aby sie odrodzic.'}})
                end	
            end
        end
    end
end)

RegisterNetEvent('fineeasz:chat')
AddEventHandler('fineeasz:chat', function(id, color, message)
	local _source = PlayerId()
	local target = GetPlayerFromServerId(id)
	
	if target == _source then
		TriggerEvent('chatMessage', '' , color, message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(_source)), GetEntityCoords(GetPlayerPed(target)), true) < 60 then
		TriggerEvent('chatMessage', '' , color, message)
	end
end)

Citizen.CreateThread(function()
    while true do
        if isDead then
			timerCount = timerCount - 1
        end
        Citizen.Wait(1000)          
    end
end)

locksound = false

Citizen.CreateThread(function()
   while true do
       Citizen.Wait(0)      
            if IsEntityDead(PlayerPedId()) then 
			
					StartScreenEffect("DeathFailOut", 0, 0)
					if not locksound then
                    PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
					locksound = true
					end
					ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
					
					local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

					if HasScaleformMovieLoaded(scaleform) then
						Citizen.Wait(0)

					PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
					BeginTextComponent("STRING")
					AddTextComponentString("~r~ZGON")
					EndTextComponent()
					PopScaleformMovieFunctionVoid()

				    Citizen.Wait(500)

					PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
                    while IsEntityDead(PlayerPedId()) do
					  DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
					  Citizen.Wait(0)
                     end
					 
				  StopScreenEffect("DeathFailOut")
				  locksound = false
			end
		end
    end
end)

local show3DText = true


RegisterNetEvent("pixel_anticl")
AddEventHandler("pixel_anticl", function(id, crds, identifier, reason)
    Display(id, crds, identifier, reason)
end)

function Display(id, crds, identifier, reason)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(20*1000)
        displaying = false
    end)
	
    Citizen.CreateThread(function()
        while displaying do
            Wait(15)
            local pcoords = GetEntityCoords(PlayerPedId())
            if GetDistanceBetweenCoords(crds.x, crds.y, crds.z, pcoords.x, pcoords.y, pcoords.z, true) < 15.0 and show3DText then
                DrawText3DSecond(crds.x, crds.y, crds.z+0.15, "Gracz opuścił serwer")
                DrawText3D(crds.x, crds.y, crds.z, "ID: "..id.." ("..identifier..")\nPowód: "..reason)
            else
                Citizen.Wait(2000)
            end
        end
    end)
end

function DrawText3DSecond(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.45, 0.45)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(176, 44, 242, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov   
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(200, 200, 200, 255)		-- You can change the text color here
    SetTextDropshadow(31, 31, 31, 0.5, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
   end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.45, 0.45)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 0, 0, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end



-- Author of this server: Fineeasz#1809
-- Author of this server: Fineeasz#1809