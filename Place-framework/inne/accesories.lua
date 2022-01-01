
ESX									= nil
local HasAlreadyEnteredMarker		= false
local LastZone						= nil
local CurrentAction					= nil
local CurrentActionMsg				= ''
local CurrentActionData				= {}
local lastSkin = {}
local newSkin = {}
local clearSkinMale = {
	['tshirt_1'] = 15,
	['tshirt_2'] = 0,
	['torso_1'] = 15,
	['torso_2'] = 0,
	['chain_1'] = 0,
	['chain_2'] = 0,
	['arms'] = 15,
	['pants_1'] = 61,
	['pants_2'] = 0,
	['shoes_1'] = 34,
	['shoes_2'] = 0,
	['helmet_1'] = -1,
	['helmet_2'] = 0,
	['ears_1'] = -1,
	['ears_2'] = 0,
	['mask_1'] = 0,
	['mask_2'] = 0,
	['glasses_1'] = 0,
	['glasses_2'] = 0,
	['bags_1'] = 0,
	['bags_2'] = 0,
}

local clearSkinFemale = {
	['tshirt_1'] = 15,
	['tshirt_2'] = 0,
	['torso_1'] = 15,
	['torso_2'] = 0,
	['chain_1'] = 0,
	['chain_2'] = 0,
	['arms'] = 15,
	['pants_1'] = 15,
	['pants_2'] = 0,
	['shoes_1'] = 35,
	['shoes_2'] = 0,
	['helmet_1'] = -1,
	['helmet_2'] = 0,
	['ears_1'] = -1,
	['ears_2'] = 0,
	['mask_1'] = 0,
	['mask_2'] = 0,
	['glasses_1'] = 5,
	['glasses_2'] = 0,
	['bags_1'] = 0,
	['bags_2'] = 0,
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
local whichSkin = nil
local updatedSkin = {}
local set = true
function OpenAccessoryMenu()
	UpdateSkin()
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'FineeaszTooDaddy',
	{
		title = "Menu akcesoriów",
		align = 'bottom-right',
		elements = {
			{label = 'Kask/Czapka', value = 'helmet_1', value2 = 'helmet_2', lib = 'missheistdockssetup1hardhat@', anim  = 'put_on_hat' },
			{label = 'Szyja',		value = 'chain_1', value2 = 'chain_2', lib = 'mp_masks@standard_car@rds@', anim  = 'put_on_mask' },
			{label = 'Uszy', 		value = 'ears_1', value2 = 'ears_2', lib = 'mp_masks@standard_car@rds@', anim  = 'put_on_mask' },
			{label = 'Maska', 		value = 'mask_1', value2 = 'mask_2', lib = 'mp_masks@standard_car@rds@', anim  = 'put_on_mask' },
			{label = 'Okulary', 	value = 'glasses_1', value2 = 'glasses_2', lib = 'mp_masks@standard_car@rds@', anim  = 'put_on_mask' },
			{label = 'Bluza/T-shirt',value = 'tshirt_1', value2 = 'tshirt_2', lib = 'clothingshirt', anim  = 'try_shirt_positive_a'},
			{label = 'Spodnie',		value = 'pants_1', value2 = 'pants_2', lib = 'clothingtrousers', anim  = 'try_trousers_neutral_c' },
			{label = 'Buty', 		value = 'shoes_1', value2 = 'shoes_2', lib = 'clothingshoes', anim  = 'try_shoes_positive_d' },
			{label = 'Torba/Plecak',value = 'bags_1', value2 = 'bags_2', lib = 'skydive@parachute@', anim  = 'chute_off' },
		}
	},
	function(data, menu)
		UpdateSkin()
		local currentData = data.current
		if currentData.lib ~= '' and currentData.anim ~= '' then
			PA(currentData.lib, currentData.anim)
		end
		whichSkin = tostring(currentData.value)
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 and (updatedSkin[currentData.value] ~= clearSkinMale[currentData.value] or currentData.value == 'tshirt_1' and updatedSkin[currentData.value] == 15 and updatedSkin['torso_1'] ~= 15) then
				newSkin[currentData.value] = clearSkinMale[currentData.value]
				if currentData.value == 'tshirt_1' then
					newSkin['arms'] = clearSkinMale['arms']
					newSkin['torso_1'] = clearSkinMale['torso_1']
				end
				if currentData.value == 'shoes_1' then
					newSkin['shoes_2'] = clearSkinMale[currentData.value2]
				end
				if currentData.value == 'tshirt_1' and updatedSkin[currentData.value] == 15 and updatedSkin['torso_1'] ~= 15 then
					newSkin['torso_1'] = clearSkinMale['torso_1']
				end
				if currentData.value2 ~= '' and  currentData.value2 ~= 'tshirt_1' then
					newSkin[currentData.value2] = clearSkinMale[currentData.value2]
				end
				
			elseif skin.sex == 1 and (updatedSkin[currentData.value] ~= clearSkinFemale[currentData.value] or currentData.value == 'tshirt_1' and updatedSkin[currentData.value] == 15 and updatedSkin['torso_1'] ~= 15) then
				newSkin[currentData.value] = clearSkinFemale[currentData.value]
				if currentData.value == 'tshirt_1' then
					newSkin['arms'] = clearSkinFemale['arms']
					newSkin['torso_1'] = clearSkinFemale['torso_1']
				end
				if currentData.value == 'shoes_1' then
					newSkin['shoes_2'] = clearSkinMale[currentData.value2]
				end
				if currentData.value2 ~= '' then
					newSkin[currentData.value2] = clearSkinMale[currentData.value2]
				end
				if currentData.value == 'tshirt_1' and updatedSkin[currentData.value] == 15 and updatedSkin['torso_1'] ~= 15 then
					newSkin['torso_1'] = clearSkinFemale['torso_1']
				end
			else
				newSkin[currentData.value] = lastSkin[currentData.value]
				if currentData.value == 'tshirt_1' then
					newSkin['torso_1'] = lastSkin['torso_1']
					newSkin['arms'] = lastSkin['arms']
				end
				if currentData.value2 ~= '' then
					newSkin[currentData.value2] = lastSkin[currentData.value2]
				end
			end
			Wait(1000)
			TriggerEvent('skinchanger:loadClothes', skin, newSkin)
			local _accessory = whichSkin
			if (_accessory == "helmet" or _accessory == "glasses" or _accessory == "ears" or _accessory == "mask")  then
			ESX.TriggerServerCallback('esx_accessories:get', function(hasAccessory, accessorySkin)
		
				if hasAccessory  then
					TriggerEvent('skinchanger:getSkin', function(skin)
						local mAccessory = -1
						local mColor = 0

						if _accessory == "mask" then
							mAccessory = 0
						elseif _accessory == "glasses" then
							if skin.sex == 0 then mAccessory = 0 else mAccessory = 5 end
						end

						if skin[_accessory .. '_1'] == mAccessory then
							mAccessory = accessorySkin[_accessory .. '_1']
							mColor = accessorySkin[_accessory .. '_2']
						end

						local accessorySkin = {}
						accessorySkin[_accessory .. '_1'] = mAccessory
						accessorySkin[_accessory .. '_2'] = mColor
						TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
					end)
				else
					ESX.ShowNotification(_U('no_' .. _accessory))
				end
			end, whichSkin)
			end
		end)
	end,
	function(data, menu)
		menu.close()
	end)
end


function UpdateSkin()
	TriggerEvent('skinchanger:getSkin', function(skin)
		updatedSkin = skin
		newSkin = skin
		if skin.sex == 0 then
			for i in pairs(skin) do
				if lastSkin[i] == nil then
					lastSkin[i] = skin[i]
				elseif clearSkinMale[i] ~= nil and skin[i] ~= clearSkinMale[i] then
					lastSkin[i] = skin[i]
				end
			end
		else
			for i in pairs(skin) do
				if lastSkin[i] == nil then
					lastSkin[i] = skin[i]
				elseif clearSkinFemale[i] ~= nil and skin[i] ~= clearSkinFemale[i] then
					lastSkin[i] = skin[i]
				end
			end
		end
	end)
end

function PA(lib, anim)
	RequestAnimDict(lib)
	while not HasAnimDictLoaded(lib) do
		Citizen.Wait(10)
	end
	TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, 0, 0, 0)
end

function SetUnsetAccessory(accessory)
	ESX.TriggerServerCallback('esx_accessories:get', function(hasAccessory, accessorySkin)
		local _accessory = string.lower(accessory)
		if hasAccessory then
			TriggerEvent('skinchanger:getSkin', function(skin)
				local mAccessory = -1
				local mColor = 0	  
				if _accessory == "mask" then
					mAccessory = 0
				end
				if skin[_accessory .. '_1'] == mAccessory then
					mAccessory = accessorySkin[_accessory .. '_1']
					mColor = accessorySkin[_accessory .. '_2']
				end
				local accessorySkin = {}
				accessorySkin[_accessory .. '_1'] = mAccessory
				accessorySkin[_accessory .. '_2'] = mColor
				TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
			end)
		else
			ESX.ShowNotification(_U('no_' .. _accessory))
		end
	end, accessory)
end



AddEventHandler('esx_accessories:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_access')
	CurrentActionData = { accessory = zone }
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
			if IsControlJustReleased(0, 311) and GetLastInputMethod(2)  then
				OpenAccessoryMenu()
		end
	end
end)
