ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'vendeur', 'alerte vendeur', true, true)

TriggerEvent('esx_society:registerSociety', 'vendeur', 'vendeur', 'society_vendeur', 'society_vendeur', 'society_vendeur', {type = 'public'})

RegisterNetEvent('craft:gg')
AddEventHandler('craft:gg', function(item, nbmetaux, nbmeche, nbcanon, nblevier)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addInventoryItem(item, 1)
    xPlayer.removeInventoryItem('metaux', nbmetaux)
    xPlayer.removeInventoryItem('meche', nbmeche)
    xPlayer.removeInventoryItem('canon', nbcanon)
    xPlayer.removeInventoryItem('levier', nblevier)
    xPlayer.removeInventoryItem('poudre', nbpoudre)
end)

RegisterNetEvent('craft:ggi')
AddEventHandler('craft:ggi', function(item, nbmetaux)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addInventoryItem(item, 1)
    xPlayer.removeInventoryItem('metaux', nbmetaux)
end)

RegisterNetEvent('h4ci_craft:nonvalider')
AddEventHandler('h4ci_craft:nonvalider', function(nbmetaux, nbmeche, nbcanon, nblevier)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.removeInventoryItem('metaux', nbmetaux)
    xPlayer.removeInventoryItem('meche', nbmeche)
    xPlayer.removeInventoryItem('canon', nbcanon)
    xPlayer.removeInventoryItem('levier', nblevier)
end)

RegisterServerEvent('enos:handcuff')
AddEventHandler('enos:handcuff', function(target)
  TriggerClientEvent('enos:handcuff', target)
end)

RegisterServerEvent('enos:drag')
AddEventHandler('enos:drag', function(target)
  local _source = source
  TriggerClientEvent('enos:drag', target, _source)
end)

RegisterServerEvent('enos:putInVehicle')
AddEventHandler('enos:putInVehicle', function(target)
  TriggerClientEvent('enos:putInVehicle', target)
end)

RegisterServerEvent('enos:OutVehicle')
AddEventHandler('enos:OutVehicle', function(target)
    TriggerClientEvent('enos:OutVehicle', target)
end)



ESX.RegisterServerCallback('enos:getOtherPlayerData', function(source, cb, target, notify)
  local xPlayer = ESX.GetPlayerFromId(target)

  TriggerClientEvent("esx:showNotification", target, "~r~Quelqu'un vous fouille ...")

  if xPlayer then
      local data = {
          name = xPlayer.getName(),
          job = xPlayer.job.label,
          grade = xPlayer.job.grade_label,
          inventory = xPlayer.getInventory(),
          accounts = xPlayer.getAccounts(),
          weapons = xPlayer.getLoadout()
      }

      cb(data)
  end
end)

RegisterNetEvent('enos:confiscatePlayerItem')
AddEventHandler('enos:confiscatePlayerItem', function(target, itemType, itemName, amount)
  local _source = source
  local sourceXPlayer = ESX.GetPlayerFromId(_source)
  local targetXPlayer = ESX.GetPlayerFromId(target)

  if itemType == 'item_standard' then
      local targetItem = targetXPlayer.getInventoryItem(itemName)
  local sourceItem = sourceXPlayer.getInventoryItem(itemName)
  
    targetXPlayer.removeInventoryItem(itemName, amount)
    sourceXPlayer.addInventoryItem   (itemName, amount)
          TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~"..amount..' '..sourceItem.label.."~s~.")
          TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris ~b~"..amount..' '..sourceItem.label.."~s~.")
      else
    TriggerClientEvent("esx:showNotification", source, "~r~Quantité invalide")
  end
      
  if itemType == 'item_account' then
      targetXPlayer.removeAccountMoney(itemName, amount)
      sourceXPlayer.addAccountMoney   (itemName, amount)
      
      TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~"..amount.." d' "..itemName.."~s~.")
      TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous aconfisqué ~b~"..amount.." d' "..itemName.."~s~.")
      
  elseif itemType == 'item_weapon' then
      if amount == nil then amount = 0 end
      targetXPlayer.removeWeapon(itemName, amount)
      sourceXPlayer.addWeapon   (itemName, amount)

      TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~b~"..amount.."~s~ balle(s).")
      TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a confisqué ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~b~"..amount.."~s~ balle(s).")
  end
end)

RegisterServerEvent('h4ci_coffre:prendreitems')
AddEventHandler('h4ci_coffre:prendreitems', function(itemName, count, societe)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..societe, function(inventory)
        local inventoryItem = inventory.getItem(itemName)

        -- is there enough in the society?
        if count > 0 and inventoryItem.count >= count then

            inventory.removeItem(itemName, count)
            xPlayer.addInventoryItem(itemName, count)
            TriggerClientEvent('esx:showNotification', _source, 'Objeto retirado', count, inventoryItem.label)
        else
            TriggerClientEvent('esx:showNotification', _source, "Cantidad invalida")
        end
    end)
end)


RegisterNetEvent('h4ci_coffre:stockitem')
AddEventHandler('h4ci_coffre:stockitem', function(itemName, count, societe)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local sourceItem = xPlayer.getInventoryItem(itemName)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..societe, function(inventory)
        local inventoryItem = inventory.getItem(itemName)

        -- does the player have enough of the item?
        if sourceItem.count >= count and count > 0 then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
            TriggerClientEvent('esx:showNotification', _source, "Objeto depositado "..count..""..inventoryItem.label.."")
        else
            TriggerClientEvent('esx:showNotification', _source, "Cantidad invalida")
        end
    end)
end)


ESX.RegisterServerCallback('h4ci_coffre:inventairejoueur', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local items   = xPlayer.inventory

    cb({items = items})
end)

ESX.RegisterServerCallback('h4ci_coffre:prendreitem', function(source, cb, societe)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..societe, function(inventory)
        cb(inventory.items)
    end)
end)

PlayersHarvesting  = {}
PlayersHarvesting2 = {}
PlayersHarvesting3 = {}

function HarvestMet(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local metQuantity = xPlayer.getInventoryItem('metaux').count

        if metQuantity >= 100 then
            TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('metaux', 1)
            HarvestMet(source)
            end)
        end
    end
end

function Harvest2(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local mechQuantity = xPlayer.getInventoryItem('meche').count

        if mechQuantity >= 100 then
            TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('meche', 1)
            Harvest2(source)
            end)
        end
    end
end

function HarvestC(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local canQuantity = xPlayer.getInventoryItem('canon').count

        if canQuantity >= 100 then
            TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('canon', 1)
            HarvestC(source)
            end)
        end
    end
end

function Harvest4(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local levQuantity = xPlayer.getInventoryItem('levier').count

        if levQuantity >= 100 then
            TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('levier', 1)
            Harvest4(source)
            end)
        end
    end
end

RegisterServerEvent('start:farm1')
AddEventHandler('start:farm1', function()
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('esx:showNotification', _source, 'Sacando...')
    HarvestMet(source)
end)

RegisterServerEvent('start:farm2')
AddEventHandler('start:farm2', function()
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('esx:showNotification', _source, 'Sacando...')
    Harvest2(source)
end)

RegisterServerEvent('start:farmC')
AddEventHandler('start:farmC', function()
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('esx:showNotification', _source, 'Sacando...')
    HarvestC(source)
end)

RegisterServerEvent('start:farm4')
AddEventHandler('start:farm4', function()
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('esx:showNotification', _source, 'Sacando...')
    Harvest4(source)
end)

RegisterServerEvent('stop:farm')
AddEventHandler('stop:farm', function()
	local _source = source
	-- Harvest
	PlayersHarvesting[_source] = false
	PlayersHarvesting2[_source] = false
	PlayersHarvesting3[_source] = false
end)

RegisterServerEvent('esx_clip:remove')
AddEventHandler('esx_clip:remove', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('clip', 1)
end)

ESX.RegisterUsableItem('clip', function(source)
	TriggerClientEvent('esx_clip:clipcli', source)
end)

ESX.RegisterUsableItem('WEAPON_ASSAULTRIFLE', function(source)
	TriggerClientEvent('esx_clip:clipcli', source)
end)

ESX.RegisterUsableItem('WEAPON_STICKYBOMB', function(source)
	TriggerClientEvent('esx_clip:clipcli', source)
end)

ESX.RegisterUsableItem('WEAPON_SMG', function(source)
	TriggerClientEvent('esx_clip:clipcli', source)
end)

ESX.RegisterUsableItem('WEAPON_PUMPSHOTGUN', function(source)
	TriggerClientEvent('esx_clip:clipcli', source)
end)

ESX.RegisterUsableItem('WEAPON_PISTOL', function(source)
	TriggerClientEvent('esx_clip:clipcli', source)
end)

ESX.RegisterUsableItem('WEAPON_MOLOTOV', function(source)
	TriggerClientEvent('esx_clip:clipcli', source)
end)

ESX.RegisterUsableItem('WEAPON_KNIFE', function(source)
	TriggerClientEvent('esx_clip:clipcli', source)
end)

ESX.RegisterUsableItem('WEAPON_HEAVYSNIPER', function(source)
	TriggerClientEvent('esx_clip:clipcli', source)
end)

ESX.RegisterUsableItem('WEAPON_GRENADE', function(source)
	TriggerClientEvent('esx_clip:clipcli', source)
end)

ESX.RegisterUsableItem('WEAPON_FLARE', function(source)
	TriggerClientEvent('esx_clip:clipcli', source)
end)
