local przycisk1 = 288

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(1)
            if IsControlJustPressed(1, przycisk1) then
			MenuAutek()
		end
	end
end)


function MenuAutek()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'PlaceRDM',
	{
	  title    = 'POJAZDY',
	  align    = 'center',
	  elements = {
		{label = 'kamacho', value = 'kamacho'},
		{label = 'P1', value = '720s18'},
		{label = 'nic', value = ''},
		{label = 'nic', value = ''},
		{label = 'nic', value = ''},
		{label = 'nic', value = ''},
		{label = 'nic', value = ''},
		{label = 'nic', value = ''},
		{label = 'nic', value = ''},
		{label = 'nic', value = ''},
		{label = 'nic', value = ''},
		{label = 'nic', value = ''},
		{label = 'nic', value = ''},
		{label = 'nic', value = ''},
	  }
	},
	function(data, menu)
		  if data.current.value == data.current.value then
			menu.close()
            spawnCar(data.current.value)
		elseif data.current.value == data.current.value then
			menu.close()		
            spawnCar(data.current.value)
		end
	end,
	function(data, menu)
	  menu.close()
	end)
end

function spawnCar(pojazd)
    local pojazd = GetHashKey(pojazd)
    TriggerEvent("FeedM:showNotification", '~g~Zrespiono pojazd', 4000, primary)
    if IsModelValid(pojazd) then
        if IsPedInAnyVehicle(PlayerPedId(), true) then
            SetEntityAsMissionEntity(Object, 1, 1)
            SetEntityAsMissionEntity(GetVehiclePedIsIn(PlayerPedId(), false), 1, 1)
            DeleteEntity(Object)
            DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), false))
        end

        RequestModel(pojazd)
        while not HasModelLoaded(pojazd) do
            RequestModel(pojazd)
            Citizen.Wait(50)
        end

        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
        local vehicle = CreateVehicle(pojazd, x + 2, y + 2, z + 1, GetEntityHeading(PlayerPedId()), true, false)
        SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
        SetEntityAsNoLongerNeeded(vehicle)
        SetModelAsNoLongerNeeded(vehicleName)
    else
        TriggerEvent("FeedM:showNotification", '~r~Nie mozna załadowac pojazdu', 4000, primary)
    end
end
