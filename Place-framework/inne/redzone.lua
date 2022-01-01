
local zones = {
    { ['x'] = -2273.76, ['y'] = 3253.75, ['z'] = 32.98, ['radius'] = 110.0, ['r'] = 235, ['g'] = 64, ['b'] = 52, ['height'] = 50.0, ['name'] = 'Strefa broni długiej 1' },
     { ['x'] = 66.74, ['y'] = 3706.02, ['z'] = 39.75, ['radius'] = 110.0, ['r'] = 235, ['g'] = 64, ['b'] = 52, ['height'] = 50.0, ['name'] = 'Strefa broni długiej 2' },
     { ['x'] = 2388.03, ['y'] = 3079.49, ['z'] = 48.16, ['radius'] = 110.0, ['r'] = 235, ['g'] = 64, ['b'] = 52, ['height'] = 50.0, ['name'] = 'Strefa broni długiej 3' },
     { ['x'] = -374.06, ['y'] = 6230.34, ['z'] = 31.49, ['radius'] = 110.0, ['r'] = 235, ['g'] = 64, ['b'] = 52, ['height'] = 50.0, ['name'] = 'Strefa broni długiej 4' },
 }
 local dluga = false
 local notifIn = true
 local notifOut = true
 local closestZone = 4
 local block = {
     "weapon_microsmg",
     "weapon_smg",
     "weapon_smg_mk2",
     "weapon_assaultsmg",
     "weapon_combatpdw",
     "weapon_machinepistol",
     "weapon_minismg",
     "weapon_raycarbine",
     "weapon_pumpshotgun",
     "weapon_pumpshotgun_mk2",
     "weapon_sawnoffshotgun",
     "weapon_assaultshotgun",
     "weapon_bullpupshotgun",
     "weapon_musket",
     "weapon_heavyshotgun",
     "weapon_dbshotgun",
     "weapon_autoshotgun",
     "weapon_combatshotgun",
     "weapon_assaultrifle",
     "weapon_assaultrifle_mk2",
     "weapon_carbinerifle",
     "weapon_carbinerifle_mk2",
     "weapon_advancedrifle",
     "weapon_specialcarbine",
     "weapon_specialcarbine_mk2",
     "weapon_bullpuprifle",
     "weapon_bullpuprifle_mk2",
     "weapon_compactrifle",
     "weapon_militaryrifle",
     "weapon_mg",
     "weapon_combatmg",
     "weapon_combatmg_mk2",
     "weapon_gusenberg",
 
 }
 
 
 function has(object, thing) do
   for i = 0, #object do
     if GetHashKey(object[i]) == thing then
       return true
     end
   end
   return false
 end
 end
 
 
 RegisterNetEvent("globaldluga")
 AddEventHandler('globaldluga', function()
     dluga = not dluga
 end) 

 Citizen.CreateThread(function()
     while not NetworkIsPlayerActive(PlayerId()) do
         Citizen.Wait(0)
     end
 
     for i = 1, #zones, 1 do
         local szBlip = AddBlipForCoord(zones[i].x, zones[i].y, zones[i].z)
         SetBlipAsShortRange(szBlip, true)
         SetBlipColour(szBlip, 80)  --Change the blip color: https://wiki.gtanet.work/index.php?title=File:blip_150.png
         SetBlipSprite(szBlip, 437) -- Change the blip itself: https://wiki.gtanet.work/index.php?title=File:blip_150.png
         BeginTextCommandSetBlipName("STRING")
         AddTextComponentString(zones[i].name) -- What it will say when you hover over the blip on your map.
         EndTextCommandSetBlipName(szBlip)
     end
 end)
 
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
         if dluga == false then
             if dist <= zones[closestZone].radius/2 then  ------------------------------------------------------------------------------ Here you can change the RADIUS of the Safe Zone. Remember, whatever you put here will DOUBLE because 
                 if not notifIn then
                    end
             else
                 local _,wep = GetCurrentPedWeapon(PlayerPedId())
                 if has(block, wep) then
                     SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
                     if not notifOut then
                         notifOut = true
                         notifIn = false
                     end
 
                 end
             end
         end
 
          if DoesEntityExist(player) then          --The -1.0001 will place it on the ground flush        -- SIZING CIRCLE |  x    y    z | R   G    B   alpha| more alpha more transparent
              DrawMarker(1, zones[closestZone].x, zones[closestZone].y, zones[closestZone].z-1.0001, 0, 0, 0, 0, 0, 0, zones[closestZone].radius, zones[closestZone].radius, zones[closestZone].height, zones[closestZone].r, zones[closestZone].g, zones[closestZone].b, 155, 0, 0, 2, 0, 0, 0, 0) -- heres what all these numbers are. Honestly you dont really need to mess with any other than what isnt 0.
          end
      end
     end
 )