local przycisk2 = 168


ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local blips = {

       {title="Arena 1", colour=59, id=442, x = 1419.49, y = 3015.45, z = 40.53},
	    {title="Arena 2", colour=59, id=442, x = 355.84, y = -2581.32, z = 9.86},
		{title="Arena 3", colour=59, id=442, x = 326.16, y = -210.42, z = 54.09},
		{title="Arena 4", colour=59, id=442, x = 953.97, y = -3182.86, z = 5.91},

  }
      
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.00)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(1)
		if IsControlJustReleased(0, przycisk2) then 
			TeleportMenu()
		end
	end
end)


function TeleportMenu()


	ESX.UI.Menu.Open(

	'default', GetCurrentResourceName(), 'Menu',
	{
	  title    = 'ARENY',
	  align    = 'right',
	  elements = {
		{label = 'Arena Lotnisko Sandy', value = 'Arena1'},
		{label = 'Arena Silos doki', value = 'Arena2'},
		{label = 'Arena Urzednicza', value = 'Arena3'},
		{label = 'Arena Lotinsko', value = 'Arena4'},

	  }
	},

	function(data, menu)

		  if data.current.value == 'Arena1' then

			if IsPedInAnyVehicle(PlayerPedId(), true) then

				SetEntityCoords(GetVehiclePedIsUsing(PlayerPedId()), vector3(1419.49, 3015.45, 40.53)) -- kordy

				SetEntityHeading(GetVehiclePedIsUsing(PlayerPedId()), 86.94)

			else

				SetEntityCoords(PlayerPedId(), vector3(1419.49, 3015.45, 40.53))  -- kordy

				SetEntityHeading(PlayerPedId(), 86.94)

			end

			menu.close()

		elseif data.current.value == 'Arena2' then

			if IsPedInAnyVehicle(PlayerPedId(), true) then

				SetEntityCoords(GetVehiclePedIsUsing(PlayerPedId()), vector3(355.84, -2581.32, 9.86)) -- kordy

				SetEntityHeading(GetVehiclePedIsUsing(PlayerPedId()), 180.01)

			else

				SetEntityCoords(PlayerPedId(), vector3(355.84, -2581.32, 9.86))  -- kordy

				SetEntityHeading(PlayerPedId(), 180.01)

			end

			menu.close()

		elseif data.current.value == 'Arena3' then

			if IsPedInAnyVehicle(PlayerPedId(), true) then

				SetEntityCoords(GetVehiclePedIsUsing(PlayerPedId()), vector3(326.16, -210.42, 54.09)) -- kordy

				SetEntityHeading(GetVehiclePedIsUsing(PlayerPedId()), 180.01)

			else

				SetEntityCoords(PlayerPedId(), vector3(326.16, -210.42, 54.09))  -- kordy

				SetEntityHeading(PlayerPedId(), 180.01)

			end

			menu.close()		

		elseif data.current.value == 'Arena4' then

			if IsPedInAnyVehicle(PlayerPedId(), true) then

				SetEntityCoords(GetVehiclePedIsUsing(PlayerPedId()), vector3(953.97, -3182.86, 5.91)) -- kordy

				SetEntityHeading(GetVehiclePedIsUsing(PlayerPedId()), 180.01)

			else

				SetEntityCoords(PlayerPedId(), vector3(953.97, -3182.86, 5.91))  -- kordy

				SetEntityHeading(PlayerPedId(), 180.01)

			end

			menu.close()		


		end

	end,

	function(data, menu)
	  menu.close()
	end)
end	