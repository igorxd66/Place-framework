local status = true -- True = wlaczone false = wylaczone
local przycisk5 = 57 -- Przycisk odpalania menu gracza
local TriggerNiggerEvent = TriggerEvent -- Nigger
local PlaceWiad = "Twój ulubiony server ~r~RDM"

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(1)
		if IsControlJustReleased(0, przycisk5) and status then
			MenuGracza()
		end
	end
end)

RegisterNetEvent("PlaceRDM:MenuGracza")
AddEventHandler("PlaceRDM:MenuGracza",function()
    if status then
    MenuGracza()
    else
        notify("~r~Menu gracza jest aktualnie wyłączone")
    end
end)

function MenuGracza()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'PlaceRDM',
	{
	  title    = 'MENU GRACZA',
	  align    = 'center',
	  elements = {
		{label = 'PlaceRDM', value = 'fxxd'},
        {label = 'Menu postaci', value = 'fxplayer'},
        {label = 'Menu broni', value = 'fxweapons'},
        {label = 'Menu pojazdów', value = 'fxcarsmenu'},
	  }
	},
	function(data, menu)
        if data.current.value == 'fxxd' then
            notify(PlaceWiad)
        elseif data.current.value == 'fxplayer' then
            MenuPostaci()
			menu.close()		
        elseif data.current.value == 'fxweapons' then
            MenuBroni()
			menu.close()		
		elseif data.current.value == 'fxcarsmenu' then
            MenuPojazdow()
			menu.close()		
		end
	end,
	function(data, menu)
	  menu.close()
	end)
end

function MenuPostaci()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'FineeaszMenuPostaci',
	{
	  title    = 'MENU POSTACI',
	  align    = 'center',
	  elements = {
		{label = 'PlaceRDM', value = 'fxxd'},
        {label = 'Otwórz menu skina', value = 'fxskin'},
        {label = 'Ulecz się', value = 'fxheal'},
        {label = 'Teleportuj do waypointa', value = 'fxtpm'},
        {label = 'Cofnij', value = 'fxback'},
	  }
	},
	function(data, menu)
        if data.current.value == 'fxxd' then
            notify(PlaceWiad)
        elseif data.current.value == 'fxskin' then
            TriggerNiggerEvent("fineeaszek:OtworzMenuSkina")
		elseif data.current.value == 'fxheal' then
            TriggerNiggerEvent('PlaceRDM:heal')
        elseif data.current.value == 'fxtpm' then
            TriggerNiggerEvent('PlaceRDM:Tpm')
        elseif data.current.value == 'fxback' then
            MenuGracza()
		end
	end,
	function(data, menu)
	  menu.close()
	end)
end

function MenuBroni()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'FineeaszMenuBroni',
	{
	  title    = 'MENU BRONI',
	  align    = 'center',
	  elements = {
		{label = 'PlaceRDM', value = 'fxxd'},
        {label = 'Dodaj bronie', value = 'fxgiveweapons'},
        {label = 'Usun wszystkie bronie', value = 'fxdelweapons'},
        {label = 'Cofnij', value = 'fxback'},
	  }
	},
	function(data, menu)
        if data.current.value == 'fxxd' then
            notify(PlaceWiad)
        elseif data.current.value == 'fxgiveweapons' then
            GiveAllWeapons()
		elseif data.current.value == 'fxdelweapons' then
            TriggerNiggerEvent('PlaceRDM:usunBronie')
        elseif data.current.value == 'fxback' then
            MenuGracza()
		end
	end,
	function(data, menu)
	  menu.close()
	end)
end


function MenuPojazdow()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'FineeaszMenuPojazdow',
	{
	  title    = 'MENU POJAZDÓW',
	  align    = 'center',
	  elements = {
		{label = 'PlaceRDM', value = 'fxxd'},
        {label = 'Zresp pojazdy', value = 'fxcarspawner'},
        {label = 'Napraw pojazd', value = 'fxfixcar'},
        {label = 'Usun pojazd', value = 'fxdelcar'},
        {label = 'Obróć pojazd', value = 'fxflipcar'},
        {label = 'Umyj pojazd', value = 'fxcleancar'},
        {label = 'Cofnij', value = 'fxback'},
	  }
	},
	function(data, menu)
        if data.current.value == 'fxxd' then
              notify(PlaceWiad)
        elseif data.current.value == 'fxcarspawner' then
            MenuAutek()
		elseif data.current.value == 'fxfixcar' then
            TriggerNiggerEvent('PlaceRDM:fix')
        elseif data.current.value == 'fxdelcar' then
            TriggerNiggerEvent('PlaceRDM:deleteVehicle')
        elseif data.current.value == 'fxflipcar' then
            TriggerNiggerEvent('PlaceRDM:flip')
        elseif data.current.value == 'fxcleancar' then
            TriggerNiggerEvent('PlaceRDM:clean')
        elseif data.current.value == 'fxback' then
            MenuGracza()
		end
	end,
	function(data, menu)
	  menu.close()
	end)
end