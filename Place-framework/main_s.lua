-- Author of this server: Fineeasz#1809
-- Author of this server: Fineeasz#1809

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


local nameofserver = "PlaceRDM"
local TriggerNiggerClient = TriggerClientEvent

-- Menu gracza 

RegisterCommand("menugracza", function(src)
    TriggerNiggerClient('PlaceRDM:MenuGracza', src)
end)

-- Naprawianie pojazdu

RegisterCommand("fix", function(src)
    TriggerNiggerClient('PlaceRDM:fix', src)
end)


-- TPM

RegisterCommand("tpm", function(src)
    TriggerNiggerClient('PlaceRDM:Tpm', src)
end)

-- Flip

RegisterCommand("flip", function(src)
    TriggerNiggerClient('PlaceRDM:flip', src)
end)

-- Clean

RegisterCommand("clean", function(src)
    TriggerNiggerClient('PlaceRDM:clean', src)
end)

-- DV

RegisterCommand("dv", function(src)
    TriggerNiggerClient('PlaceRDM:deleteVehicle', src)
end)

-- Shuff

RegisterCommand("shuff", function(src)
    TriggerNiggerClient('PlaceRDM:Shuff', src)
end)

-- Heal

RegisterCommand("heal", function(src)
    TriggerNiggerClient('PlaceRDM:heal', src)
end)

-- Dodatki

RegisterCommand("dodatki", function(src)
    TriggerNiggerClient('PlaceRDM:dodatki', src)
end)



RegisterServerEvent('Fineeasz:HealMsg') 
AddEventHandler('Fineeasz:HealMsg', function(id)
    TriggerNiggerClient('fineeasz:chat', -1 , id , {21, 255, 0}, '^*Gracz [' .. id .. '] Uleczyl się')
end)

TriggerEvent('es:addGroupCommand', 'announce', "admin", function(source, args, user)
	TriggerClientEvent('chat:addMessage', -1, {
		args = {"^1OGŁOSZENIE", table.concat(args, " ")}
	})
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Announce a message to the entire server", params = {{name = "announcement", help = "The message to announce"}}})




		AddEventHandler("playerDropped", function(reason)
			local crds = GetEntityCoords(GetPlayerPed(source))
			local id = source
			local identifier = ""
				identifier = GetPlayerIdentifier(source, 0)
			TriggerClientEvent("pixel_anticl", -1, id, crds, identifier, reason)
		end)

-- Author of this server: Fineeasz#1809
-- Author of this server: Fineeasz#1809