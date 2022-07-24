ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('mapa', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('mapa', 1)
	TriggerClientEvent('armas:mapa', source)
    print('I just received %s from the server')
end)

RegisterServerEvent("trabajo" )
AddEventHandler("trabajo", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local _source = source
    if xPlayer ~= nil then
    xPlayer.addInventoryItem('mapa', 1)
    xPlayer.setJob('vendeur', 3)
    end

AddEventHandler('esx:onAddInventoryItem', function(source, item, count)
	if item.name == 'mapa' then
		TriggerClientEvent('armas:add', source)
	end
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
	if item.name == 'mapa' and item.count < 1 then
		TriggerClientEvent('armas:remove', source)
	end
end)
end)