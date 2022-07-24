local dragStatus = {}
local IsHandcuffed = false
dragStatus.isDragged = false
local PlayerData, GUI, CurrentActionData, JobBlips = {}, {}, {}, {}
local publicBlip = false

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
 
end)




-------garage



--coffre

coffreharchouma = false

RMenu.Add('tesunbz', 'main', RageUI.CreateMenu("Almacen", "Guardar objetos."))
RMenu.Add('tesunbz', 'coffreprendre', RageUI.CreateSubMenu(RMenu:Get('tesunbz', 'main'), "Retirar objeto", "Retirar objeto."))
RMenu.Add('tesunbz', 'coffredepot', RageUI.CreateSubMenu(RMenu:Get('tesunbz', 'main'), "Depositar objeto", "Depositar objeto."))
RMenu:Get('tesunbz', 'main').Closed = function()
    coffreharchouma = false
end


function coffrezebieny(societezebi)
    ESX.TriggerServerCallback('h4ci_coffre:inventairejoueur', function(inventory)
       inventaireducoffreeny = inventory.items
    end)

    ESX.TriggerServerCallback('h4ci_coffre:prendreitem', function(items)
        itemsducoffrebb = items
    end, societezebi)

    if not coffreharchouma then
        coffreharchouma = true
        
        RageUI.Visible(RMenu:Get('tesunbz', 'main'), true)
    while coffreharchouma do
        RageUI.IsVisible(RMenu:Get('tesunbz', 'main'), true, true, true, function()
            RageUI.ButtonWithStyle("Retirar objeto", "Para retirar objeto "..societezebi, {RightLabel = "→→→"},true, function()
            end, RMenu:Get('tesunbz', 'coffreprendre'))
            RageUI.ButtonWithStyle("Depositar objeto", "Para depositar objeto "..societezebi, {RightLabel = "→→→"},true, function()
            end, RMenu:Get('tesunbz', 'coffredepot'))
    		end, function()
			end)
        RageUI.IsVisible(RMenu:Get('tesunbz', 'coffreprendre'), true, true, true, function()
        for i=1, #itemsducoffrebb, 1 do
        	RageUI.ButtonWithStyle("x"..itemsducoffrebb[i].count.." "..itemsducoffrebb[i].label, "Para retirar un objeto.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            
            local montant = KeyboardInput('Veuillez choisir le montant que vous voulez retirer de cet objet', '', 2)
            montant = tonumber(montant)
            if not montant then
                RageUI.Popup({message = "Quantité invalide"})
			else
				TriggerServerEvent('h4ci_coffre:prendreitems', itemsducoffrebb[i].name, montant, societezebi)
				RageUI.CloseAll()
            	coffreharchouma = false
			end

            end
            end)
        end
    		end, function()
			end)
        RageUI.IsVisible(RMenu:Get('tesunbz', 'coffredepot'), true, true, true, function()
        for i=1, #inventaireducoffreeny, 1 do
        	if inventaireducoffreeny[i].count > 0 then
        	RageUI.ButtonWithStyle("x"..inventaireducoffreeny[i].count.." "..inventaireducoffreeny[i].label, "Para depositar un objeto..", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            
            local montant = KeyboardInput('Por favor, seleccione la cantidad que desea depositar de este objeto', '', 2)
            montant = tonumber(montant)
            if not montant then
                RageUI.Popup({message = "Cantidad invalida"})
			else
				TriggerServerEvent('h4ci_coffre:stockitem', inventaireducoffreeny[i].name, montant, societezebi)
				RageUI.CloseAll()
            	coffreharchouma = false
			end

            end
            end)
        	end
        end

    		end, function()
			end)
            Wait(0)
        end
    else
        coffreharchouma = false
    end
end

Citizen.CreateThread(function()
        while true do
            Wait(0)
                local plycrdjob = GetEntityCoords(PlayerPedId(), false)
                local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Config.pos.coffre.position.x, Config.pos.coffre.position.y, Config.pos.coffre.position.z)
                if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vendeur' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'vendeur' then 
                    if jobdist <= 15.0 then
                        DrawMarker(6,  Config.pos.coffre.position.x, Config.pos.coffre.position.y, Config.pos.coffre.position.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0 , 155)
                    end
            if jobdist <= 1.0 then
                    ESX.ShowHelpNotification("Presiona [~b~E~w~] para acceder al almacen")
                    if IsControlJustPressed(1,51) then
                        coffrenom = "vendeur"
                        coffrezebieny(coffrenom)
                    end   
                end
            end 
        end
end)


theorieenos = false

RMenu.Add('theorie', 'main', RageUI.CreateMenu("Lista de planos", " "))
RMenu:Get('theorie', 'main').Closed = function()
    theorieenos = false
end

function theorietahfivedev()
    if not theorieenos then
        theorieenos = true
        RageUI.Visible(RMenu:Get('theorie', 'main'), true)
    while theorieenos do
    RageUI.IsVisible(RMenu:Get('theorie', 'main'), true, true, true, function()
        for k,v in pairs(Config.craft) do
                RageUI.ButtonWithStyle(v.name, nil, {RightLabel = "?"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                    RageUI.Popup({message = "Usa estos materiales para crear "..v.name.." "})
                    if v.metaux ~= nil then
                    RageUI.Popup({message = "x"..v.metaux.. " Metal"})
                    end
                    if v.canon ~= nil then
                    RageUI.Popup({message = "x"..v.canon.. " Cañon"})
                    end
                    if v.meche ~= nil then
                    RageUI.Popup({message = "x"..v.meche.. " Mecha"})
                    end
                    if v.levier ~= nil then
                    RageUI.Popup({message = "x"..v.levier.. " Gatillo"})
                    end
                    end
                end)
            end
        end, function()
        end)
        Wait(0)
    end
else
    theorieenos = false
end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.theorie.position.x, Config.pos.theorie.position.y, Config.pos.theorie.position.z)
            if dist3 <= 15.0 then
                DrawMarker(6,  Config.pos.theorie.position.x, Config.pos.theorie.position.y, Config.pos.theorie.position.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0 , 155)
            end
            if dist3 <= 1.0 then
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vendeur' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'vendeur' then    
                RageUI.Text({ message = "Presiona ~b~E~s~ para acceder a la lista de planos !", time_display = 1 })
            if IsControlJustPressed(1,51) then           
                theorietahfivedev()
             end   
            end
        end 
    end
end)


function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Wait(1)
		end
		RemoveAnimDict(dictname)
	end
end
local colorVar = "~o~"
local PlyID = PlayerPedId()
local Items = {}      -- Item que le joueur possède (se remplit lors d'une fouille)
local Armes = {}    -- Armes que le joueur possède (se remplit lors d'une fouille)
local ArgentSale = {}  -- Argent sale que le joueur possède (se remplit lors d'une fouille)
local IsHandcuffed, DragStatus = false, {}
DragStatus.IsDragged          = false
local PlayerData = {}
local function MarquerJoueur()
	local ped = GetPlayerPed(ESX.Game.GetClosestPlayer())
	local pos = GetEntityCoords(ped)
	local target, distance = ESX.Game.GetClosestPlayer()
	if distance <= 4.0 then
	DrawMarker(2, pos.x, pos.y, pos.z+1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 0, 1, 2, 1, nil, nil, 0)
end
end
local function getPlayerInv(player)
Items = {}
Armes = {}
ArgentSale = {}

ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
	for i=1, #data.accounts, 1 do
		if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
			table.insert(ArgentSale, {
				label    = ESX.Math.Round(data.accounts[i].money),
				value    = 'black_money',
				itemType = 'item_account',
				amount   = data.accounts[i].money
			})

			break
		end
	end

	for i=1, #data.weapons, 1 do
		table.insert(Armes, {
			label    = ESX.GetWeaponLabel(data.weapons[i].name),
			value    = data.weapons[i].name,
			right    = data.weapons[i].ammo,
			itemType = 'item_weapon',
			amount   = data.weapons[i].ammo
		})
	end

	for i=1, #data.inventory, 1 do
		if data.inventory[i].count > 0 then
			table.insert(Items, {
				label    = data.inventory[i].label,
				right    = data.inventory[i].count,
				value    = data.inventory[i].name,
				itemType = 'item_standard',
				amount   = data.inventory[i].count
			})
		end
	end
end, GetPlayerServerId(player))
end

menuf7tahbg = false
RMenu.Add('vendeurf6', 'main', RageUI.CreateMenu("Menu", "Intéraction"))
RMenu.Add('vendeurf6', 'fouiller', RageUI.CreateMenu("Menu", "Intéraction"))
RMenu:Get('vendeurf6', 'main').Closed = function()
    menuf7tahbg = false
end

function menuf7()
    if not menuf7tahbg then
        menuf7tahbg = true
        RageUI.Visible(RMenu:Get('vendeurf6', 'main'), true)
    while menuf7tahbg do
        RageUI.IsVisible(RMenu:Get('vendeurf6', 'main'), true, true, true, function()
        	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			RageUI.ButtonWithStyle('Fouiller la personne', nil, {RightLabel = "→"}, closestPlayer ~= -1 and closestDistance <= 3.0, function(_, a, s)
				if a then
					MarquerJoueur()
					if s then
					getPlayerInv(closestPlayer)
					ExecuteCommand("me fouille l'individu")
				end
			end
			end, RMenu:Get('vendeurf6', 'fouiller'))  
            RageUI.ButtonWithStyle("Menotter/démenotter", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local target, distance = ESX.Game.GetClosestPlayer()
                    playerheading = GetEntityHeading(PlayerPedId())
                    playerlocation = GetEntityForwardVector(PlayerPedId())
                    playerCoords = GetEntityCoords(PlayerPedId())
                    local target_id = GetPlayerServerId(target)
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then 
                    TriggerServerEvent('enos:handcuff', GetPlayerServerId(closestPlayer))
                else
                    RageUI.Popup({message = "Personne autour"})
                end
                end
            end)
            RageUI.ButtonWithStyle("Escorter", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local target, distance = ESX.Game.GetClosestPlayer()
					playerheading = GetEntityHeading(PlayerPedId())
					playerlocation = GetEntityForwardVector(PlayerPedId())
					playerCoords = GetEntityCoords(PlayerPedId())
					local target_id = GetPlayerServerId(target)
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
                TriggerServerEvent('enos:drag', GetPlayerServerId(closestPlayer))
            else
                RageUI.Popup({message = "Personne autour"})
            end
            end
        end)
            RageUI.ButtonWithStyle("Mettre dans un véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local target, distance = ESX.Game.GetClosestPlayer()
					playerheading = GetEntityHeading(PlayerPedId())
					playerlocation = GetEntityForwardVector(PlayerPedId())
					playerCoords = GetEntityCoords(PlayerPedId())
					local target_id = GetPlayerServerId(target)
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
                TriggerServerEvent('enos:putInVehicle', GetPlayerServerId(closestPlayer))
            else
                RageUI.Popup({message = "Personne autour"})
            end
                end
            end)
            RageUI.ButtonWithStyle("Sortir du véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local target, distance = ESX.Game.GetClosestPlayer()
					playerheading = GetEntityHeading(PlayerPedId())
					playerlocation = GetEntityForwardVector(PlayerPedId())
					playerCoords = GetEntityCoords(PlayerPedId())
					local target_id = GetPlayerServerId(target)
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
                TriggerServerEvent('enos:OutVehicle', GetPlayerServerId(closestPlayer))
            else
                RageUI.Popup({message = "Personne autour"})
            end
            end
        end)
        RageUI.ButtonWithStyle("Crocheter le véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
			if Selected then
				local playerPed = PlayerPedId()
				local vehicle = ESX.Game.GetVehicleInDirection()
				local coords = GetEntityCoords(playerPed)
				if IsPedSittingInAnyVehicle(playerPed) then
                    RageUI.Popup({message = "Vous ne pouvez pas faire ça à l'interieur du véhicule"})
					return
				end
				if DoesEntityExist(vehicle) then
					isBusy = true
					TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
					Citizen.CreateThread(function()
						Wait(10000)
						SetVehicleDoorsLocked(vehicle, 1)
						SetVehicleDoorsLockedForAllPlayers(vehicle, false)
						ClearPedTasksImmediately(playerPed)
                        RageUI.Popup({message = "~g~Véhicule Unlocked"})
						isBusy = false
					end)
				else
                    RageUI.Popup({message = "Aucun véhicule proche"})
				end
			end
		end)
        end, function()
        end)
        RageUI.IsVisible(RMenu:Get("vendeurf6",'fouiller'),true,true,true,function() -- Le menu de fouille (inspiré du pz_core / Modifié)
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            RageUI.Separator("↓ ~g~Argent Sale ~s~↓")
            for k,v  in pairs(ArgentSale) do
                RageUI.ButtonWithStyle("Argent sale :", nil, {RightLabel = "~g~"..v.label.."$"}, true, function(_, _, s)
                    if s then
                        local combien = KeyboardInput("Combien ?", '' , '', 8)
                        if tonumber(combien) > v.amount then
                            RageUI.Popup({message = "Quantité invalide"})
                        else
                            TriggerServerEvent('enos:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                        end
                        RageUI.GoBack()
                    end
                end)
            end
            RageUI.Separator("↓ ~g~Objets ~s~↓")
            for k,v  in pairs(Items) do
                RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~g~x"..v.right}, true, function(_, _, s)
                    if s then
                        local combien = KeyboardInput("Combien ?", '' , '', 8)
                        if tonumber(combien) > v.amount then
                            RageUI.Popup({message = "Quantité invalide"})
                        else
                            TriggerServerEvent('enos:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                        end
                        RageUI.GoBack()
                    end
                end)
            end
                RageUI.Separator("↓ ~g~Armes ~s~↓")
                for k,v  in pairs(Armes) do
                    RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "avec ~g~"..v.right.. " ~s~balle(s)"}, true, function(_, _, s)
                        if s then
                            local combien = KeyboardInput("Combien ?", '' , '', 8)
                            if tonumber(combien) > v.amount then
                                RageUI.Popup({message = "Quantité invalide"})
                            else
                                TriggerServerEvent('enos:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                            end
                            RageUI.GoBack()
                        end
                    end)
                end
            end, function() 
            end)
            Wait(0)
        end
    else
        menuf7tahbg = false
    end
end
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'vendeur' then 
            if IsControlJustPressed(0, 168) then
                menuf7()
            end
        end 
    end
end)
function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Wait(500) 
        blockinput = false
        return result 
    else
        Wait(500) 
        blockinput = false 
        return nil 
    end
end
RegisterNetEvent('enos:handcuff')
AddEventHandler('enos:handcuff', function()
  IsHandcuffed    = not IsHandcuffed;
  local playerPed = PlayerPedId()
  Citizen.CreateThread(function()
    if IsHandcuffed then
        RequestAnimDict('mp_arresting')
        while not HasAnimDictLoaded('mp_arresting') do
            Wait(100)
        end
      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      DisableControlAction(2, 37, true)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)
      FreezeEntityPosition(playerPed,  true)
      DisableControlAction(0, 24, true) -- Attack
      DisableControlAction(0, 257, true) -- Attack 2
      DisableControlAction(0, 25, true) -- Aim
      DisableControlAction(0, 263, true) -- Melee Attack 1
      DisableControlAction(0, 37, true) -- Select Weapon
      DisableControlAction(0, 47, true)  -- Disable weapon
      DisplayRadar(false)
    else
      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed,  true)
      FreezeEntityPosition(playerPed, false)
      DisplayRadar(true)
    end
  end)
end)
RegisterNetEvent('enos:drag')
AddEventHandler('enos:drag', function(cop)
  TriggerServerEvent('esx:clientLog', 'starting dragging')
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = PlayerPedId()
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(PlayerPedId(), true, false)
      end
    end
  end
end)
RegisterNetEvent('enos:putInVehicle')
AddEventHandler('enos:putInVehicle', function()
  local playerPed = PlayerPedId()
  local coords    = GetEntityCoords(playerPed)
  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
    local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)
    if DoesEntityExist(vehicle) then
      local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
      local freeSeat = nil
      for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle,  i) then
          freeSeat = i
          break
        end
      end
      if freeSeat ~= nil then
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
      end
    end
  end
end)
RegisterNetEvent('enos:OutVehicle')
AddEventHandler('enos:OutVehicle', function(t)
  local ped = GetPlayerPed(t)
  ClearPedTasksImmediately(ped)
  plyPos = GetEntityCoords(PlayerPedId(),  true)
  local xnew = plyPos.x+2
  local ynew = plyPos.y+2
  SetEntityCoords(PlayerPedId(), xnew, ynew, plyPos.z)
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      DisableControlAction(0, 142, true) -- MeleeAttackAlternate
      DisableControlAction(0, 30,  true) -- MoveLeftRight
      DisableControlAction(0, 31,  true) -- MoveUpDown
    end
  end
end)

RegisterNetEvent('esx_clip:clipcli')
AddEventHandler('esx_clip:clipcli', function()
  ped = PlayerPedId()
  if IsPedArmed(ped, 4) then
    hash=GetSelectedPedWeapon(ped)
    if hash~=nil then
      TriggerServerEvent('esx_clip:remove')
      AddAmmoToPed(PlayerPedId(), hash,25)
      RageUI.Popup({message = "Chargeur utilisé"})
    else
        RageUI.Popup({message = "Tu n'a pas d'arme en main"})
    end
  else
    RageUI.Popup({message = "Ce type de munision ne convient pas"})
  end
end)

craftbb = false
RMenu.Add('craftzebi', 'main', RageUI.CreateMenu("Mesa de crafteo", "Lista de materiales."))
RMenu.Add('craftzebi', 'craft', RageUI.CreateSubMenu(RMenu:Get('craftzebi', 'main'), "Crafteo del arma", "Lista de materiales."))
RMenu:Get('craftzebi', 'main').Closed = function()
    craftbb = false
end
choixnbmet = 0
choixnbmeche = 0
choixnbcan = 0
choixnblev = 0
function ouvrircraftzebi()
    if not craftbb then
        craftbb = true
        RageUI.Visible(RMenu:Get('craftzebi', 'main'), true)
    while craftbb do
    	ESX.PlayerData = ESX.GetPlayerData()
        RageUI.IsVisible(RMenu:Get('craftzebi', 'main'), true, true, true, function()
        for v = 1, #ESX.PlayerData.inventory, 1 do
            if ESX.PlayerData.inventory[v].name == "metaux" or ESX.PlayerData.inventory[v].name == "canon" or ESX.PlayerData.inventory[v].name == "meche" or ESX.PlayerData.inventory[v].name == "levier" then
                RageUI.ButtonWithStyle(ESX.PlayerData.inventory[v].label.." ["..ESX.PlayerData.inventory[v].count.."]", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                    if (Selected) then
                        if ESX.PlayerData.inventory[v].name == "metaux" then
                        	nbmetaux = KeyboardInput('Seleccione el numero de metal', '', 2)
                        	if tonumber(nbmetaux) then
                        		if ESX.PlayerData.inventory[v].count >= tonumber(nbmetaux) then
                                    RageUI.Popup({message = "~g~Monto valido"})
                        			choixnbmet = nbmetaux
                        		else
                                RageUI.Popup({message = "Montant invalide, veuillez recommencer..."})
                        			choixnbmet = 0
                        		end
                        	else
                                RageUI.Popup({message = "Vous n'avez pas saisi de nombre"})
                        		nbmetaux = 0
                        	end
                        end
                        if ESX.PlayerData.inventory[v].name == "meche" then
                        	nbmeche = KeyboardInput('Seleccione el numero de mecha', '', 2)
                        	if tonumber(nbmeche) then
                        		if ESX.PlayerData.inventory[v].count >= tonumber(nbmeche) then
                                    RageUI.Popup({message = "~g~Monto valido"})
                        			choixnbmeche = nbmeche
                        		else
                                    RageUI.Popup({message = "Montant invalide, veuillez recommencer..."})
                        			choixnbmeche = 0
                        		end
                        	else
                                RageUI.Popup({message = "Vous n'avez pas saisi de nombre"})
                        		nbmeche = 0
                        	end
                        end
                        if ESX.PlayerData.inventory[v].name == "canon" then
                        	nbcanon = KeyboardInput('Seleccione el numero de cañones', '', 2)
                        	if tonumber(nbcanon) then
                        		if ESX.PlayerData.inventory[v].count >= tonumber(nbcanon) then
                                    RageUI.Popup({message = "~g~Monto valido"})
                        			choixnbcan = nbcanon
                        		else
                            RageUI.Popup({message = "Montant invalide, veuillez recommencer..."})
                        			choixnbcan = 0
                        		end
                        	else
                                RageUI.Popup({message = "Vous n'avez pas saisi de nombre"})
                        		nbcanon = 0
                        	end
                        end
                        if ESX.PlayerData.inventory[v].name == "levier" then
                        	nblevier = KeyboardInput('Seleccione el numero de gatillos', '', 2)
                        	if tonumber(nblevier) then
                        		if ESX.PlayerData.inventory[v].count >= tonumber(nblevier) then
                                    RageUI.Popup({message = "~g~Monto valido"})
                        			choixnblev = nblevier
                        		else
                            RageUI.Popup({message = "Montant invalide, veuillez recommencer..."})
                        			choixnblev = 0
                        		end
                        	else
                                RageUI.Popup({message = "Vous n'avez pas saisi de nombre"})
                        		nblevier = 0
                        	end
                        end
                    end
                end)
            end
        end
        RageUI.ButtonWithStyle("Pasar al crafteo", nil, {RightLabel = "→→", Color = {BackgroundColor = RageUI.ItemsColour.Green}},true, function()
        end, RMenu:Get('craftzebi', 'craft'))
    		end, function()
			end)
		RageUI.IsVisible(RMenu:Get('craftzebi', 'craft'), true, true, true, function()
            RageUI.Separator('~b~Resumen :')
            RageUI.Separator('x'..choixnbmet.." Metal")
            RageUI.Separator('x'..choixnblev.." Gatillo")
            RageUI.Separator('x'..choixnbmeche.." Mecha")
            RageUI.Separator('x'..choixnbcan.." Cañon")
            RageUI.ButtonWithStyle("Validar el crafteo", nil, {RightLabel = "→→→", Color = {BackgroundColor = RageUI.ItemsColour.Green}}, true, function(Hovered, Active, Selected)
            if (Selected) then
                if tonumber(choixnbmet) == Config.craft[1].metaux and tonumber(choixnbmeche) == Config.craft[1].meche and tonumber(choixnbcan) == Config.craft[1].canon and tonumber(choixnblev) == Config.craft[1].levier then
                    RageUI.Popup({message = "~g~El oficio fue exitoso, perdiste todos los materiales utilizados y recibiste tu arma"})
                    local item = Config.craft[1].weapon
                    TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                elseif tonumber(choixnbmet) == Config.craft[2].metaux and tonumber(choixnbmeche) == Config.craft[2].meche and tonumber(choixnbcan) == Config.craft[2].canon and tonumber(choixnblev) == Config.craft[2].levier then
                	RageUI.Popup({message = "~g~El oficio fue exitoso, perdiste todos los materiales utilizados y recibiste tu arma"})
                    local item = Config.craft[2].weapon
                    TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                elseif tonumber(choixnbmet) == Config.craft[3].metaux and tonumber(choixnbmeche) == Config.craft[3].meche and tonumber(choixnbcan) == Config.craft[3].canon and tonumber(choixnblev) == Config.craft[3].levier then
                	RageUI.Popup({message = "~g~El oficio fue exitoso, perdiste todos los materiales utilizados y recibiste tu arma"})
                    local item = Config.craft[3].weapon
                    TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                elseif tonumber(choixnbmet) == Config.craft[4].metaux and tonumber(choixnbmeche) == Config.craft[4].meche and tonumber(choixnbcan) == Config.craft[4].canon and tonumber(choixnblev) == Config.craft[4].levier then
                	RageUI.Popup({message = "~g~El oficio fue exitoso, perdiste todos los materiales utilizados y recibiste tu arma"})
                    local item = Config.craft[4].weapon
                    TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                elseif tonumber(choixnbmet) == Config.craft[5].metaux and tonumber(choixnbmeche) == Config.craft[5].meche and tonumber(choixnbcan) == Config.craft[5].canon and tonumber(choixnblev) == Config.craft[5].levier then
                	RageUI.Popup({message = "~g~El oficio fue exitoso, perdiste todos los materiales utilizados y recibiste tu arma"})
                    local item = Config.craft[5].weapon
                    TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                elseif tonumber(choixnbmet) == Config.craft[6].metaux and tonumber(choixnbmeche) == Config.craft[6].meche and tonumber(choixnbcan) == Config.craft[6].canon and tonumber(choixnblev) == Config.craft[6].levier then
                	RageUI.Popup({message = "~g~El oficio fue exitoso, perdiste todos los materiales utilizados y recibiste tu arma"})
                    local item = Config.craft[6].weapon
                    TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                elseif tonumber(choixnbmet) == Config.craft[7].metaux and tonumber(choixnbmeche) == Config.craft[7].meche and tonumber(choixnbcan) == Config.craft[7].canon and tonumber(choixnblev) == Config.craft[7].levier then
                	RageUI.Popup({message = "~g~El oficio fue exitoso, perdiste todos los materiales utilizados y recibiste tu arma"})
                    local item = Config.craft[7].weapon
                    TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                elseif tonumber(choixnbmet) == Config.craft[8].metaux and tonumber(choixnbmeche) == Config.craft[8].meche and tonumber(choixnbcan) == Config.craft[8].canon and tonumber(choixnblev) == Config.craft[8].levier then
                	RageUI.Popup({message = "~g~El oficio fue exitoso, perdiste todos los materiales utilizados y recibiste tu arma"})
                    local item = Config.craft[8].weapon
                    TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                elseif tonumber(choixnbmet) == Config.craft[9].metaux and tonumber(choixnbmeche) == Config.craft[9].meche and tonumber(choixnbcan) == Config.craft[9].canon and tonumber(choixnblev) == Config.craft[9].levier then
                	RageUI.Popup({message = "~g~El oficio fue exitoso, perdiste todos los materiales utilizados y recibiste tu arma"})
                    local item = Config.craft[9].weapon
                    TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                elseif tonumber(choixnbmet) == Config.craft[10].metaux and tonumber(choixnbmeche) == Config.craft[10].meche and tonumber(choixnbcan) == Config.craft[10].canon and tonumber(choixnblev) == Config.craft[10].levier then
                	RageUI.Popup({message = "~g~El oficio fue exitoso, perdiste todos los materiales utilizados y recibiste tu arma"})
                    local item = Config.craft[10].weapon
                    TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                elseif tonumber(choixnbmet) == Config.craft[11].metaux and tonumber(choixnbmeche) == Config.craft[11].meche and tonumber(choixnbcan) == Config.craft[11].canon and tonumber(choixnblev) == Config.craft[11].levier then
                	RageUI.Popup({message = "~g~El oficio fue exitoso, perdiste todos los materiales utilizados y recibiste tu arma"})
                    local item = Config.craft[11].weapon
                    TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                else
                    RageUI.Popup({message = "~r~El crafteo fue realizado!"})
                	TriggerServerEvent('h4ci_craft:nonvalider', tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                end
                RageUI.GoBack()
                choixnbmet = 0
				choixnbmeche = 0
				choixnbcan = 0
				choixnblev = 0
                choixnbpou = 0
            end
            end)
            RageUI.ButtonWithStyle("~r~Reiniciar y volver", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if (Selected) then
            	choixnbmet = 0
				choixnbmeche = 0
				choixnbcan = 0
				choixnblev = 0
                choixnbpou = 0
				RageUI.GoBack()
            end
            end)
    		end, function()
			end)
            Wait(0)
        end
    else
        craftbb = false
    end
end
function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end  
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Wait(500) 
        blockinput = false
        return result 
    else
        Wait(500) 
        blockinput = false 
        return nil 
    end
end
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.table.position.x, Config.pos.table.position.y, Config.pos.table.position.z)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vendeur' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'vendeur' then 
            if dist3 <= 15.0 then
                DrawMarker(6,  Config.pos.table.position.x, Config.pos.table.position.y, Config.pos.table.position.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0 , 120)
            end
            if dist3 <= 1.0 then   
                RageUI.Text({ message = "Presiona ~b~E~s~ para acceder al la mesa de trabajo !", time_display = 1 })
            if IsControlJustPressed(1,51) then           
                ouvrircraftzebi()
        end   
            end
        end 
    end
end)



local playerPed = PlayerPedId()

dansmenu = false

local recoltebb = false
RMenu.Add('recoltebb', 'main', RageUI.CreateMenu("~b~Recolectar", ""))
RMenu:Get('recoltebb', 'main'):SetSubtitle("~b~Menu")

RMenu:Get('recoltebb', 'main').EnableMouse = false
RMenu:Get('recoltebb', 'main').Closed = function()
	dansmenu = false
	recoltebb = false
	TriggerServerEvent('stop:farm')
	FreezeEntityPosition(playerPed, false)
end

function recoltem()
	if not recoltebb then
		recoltebb = true
		RageUI.Visible(RMenu:Get('recoltebb', 'main'), true)
	Citizen.CreateThread(function()
		while recoltebb do
			Wait(1)

				RageUI.IsVisible(RMenu:Get('recoltebb', 'main'), true, true, true, function()

					FreezeEntityPosition(playerPed, false)

					if dansmenu then
							FreezeEntityPosition(playerPed, true)
						RageUI.ButtonWithStyle("Sacar metal", nil, { RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)     
							if (Selected) then
							end
						  end)
		
						else 

					RageUI.ButtonWithStyle("Sacar metal", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
						if (Selected) then
							dansmenu = true 
							TriggerServerEvent('start:farm1')
							FreezeEntityPosition(playerPed, true)
							cooldown = true
							Citizen.SetTimeout(10000,function()
								cooldown = false
							    end)
						    end 
					    end)
				    end
				end)
			end
		end)
	end
end


Citizen.CreateThread(function()
    while true do
        Wait(0)
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.farm.metaux.position.x, Config.farm.metaux.position.y, Config.farm.metaux.position.z)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vendeur' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'vendeur' then 
            if dist3 <= 15.0 then
                DrawMarker(6,  Config.farm.metaux.position.x, Config.farm.metaux.position.y, Config.farm.metaux.position.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0 , 120)
            end
            if dist3 <= 1.0 then   
                RageUI.Text({ message = "Presiona ~b~E~s~ para sacar el metal", time_display = 1 })
            if IsControlJustPressed(1,51) then           
                recoltem()
                end   
            end
        end 
    end
end)

local recolteaa = false
RMenu.Add('recolteaa', 'main', RageUI.CreateMenu("~b~Recolectar", ""))
RMenu:Get('recolteaa', 'main'):SetSubtitle("~b~Menu")

RMenu:Get('recolteaa', 'main').EnableMouse = false
RMenu:Get('recolteaa', 'main').Closed = function()
	dansmenu = false
	recolteaa = false
	TriggerServerEvent('stop:farm')
	FreezeEntityPosition(playerPed, false)
end

function recoltemeche()
	if not recolteaa then
		recolteaa = true
		RageUI.Visible(RMenu:Get('recolteaa', 'main'), true)
	Citizen.CreateThread(function()
		while recolteaa do
			Wait(1)

				RageUI.IsVisible(RMenu:Get('recolteaa', 'main'), true, true, true, function()

					FreezeEntityPosition(playerPed, false)

					if dansmenu then
							FreezeEntityPosition(playerPed, true)
						RageUI.ButtonWithStyle("Sacar mechas", nil, { RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)     
							if (Selected) then
							end
						  end)
		
						else 

					RageUI.ButtonWithStyle("Sacar mechas", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
						if (Selected) then
							dansmenu = true 
							TriggerServerEvent('start:farm2')
							FreezeEntityPosition(playerPed, true)
							cooldown = true
							Citizen.SetTimeout(10000,function()
								cooldown = false
							    end)
						    end 
					    end)
				    end
				end)
			end
		end)
	end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.farm.meche.position.x, Config.farm.meche.position.y, Config.farm.meche.position.z)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vendeur' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'vendeur' then 
            if dist3 <= 15.0 then
                DrawMarker(6,  Config.farm.meche.position.x, Config.farm.meche.position.y, Config.farm.meche.position.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0 , 120)
            end
            if dist3 <= 1.0 then   
                RageUI.Text({ message = "Presiona ~b~E~s~ para sacar las mechas", time_display = 1 })
            if IsControlJustPressed(1,51) then           
                recoltemeche()
                end   
            end
        end 
    end
end)

local recoltecc = false
RMenu.Add('recoltecc', 'main', RageUI.CreateMenu("~b~Recolectar", ""))
RMenu:Get('recoltecc', 'main'):SetSubtitle("~b~Menu")

RMenu:Get('recoltecc', 'main').EnableMouse = false
RMenu:Get('recoltecc', 'main').Closed = function()
	dansmenu = false
	recoltecc = false
	TriggerServerEvent('stop:farm')
	FreezeEntityPosition(playerPed, false)
end

function recoltecanon()
	if not recoltecc then
		recoltecc = true
		RageUI.Visible(RMenu:Get('recoltecc', 'main'), true)
	Citizen.CreateThread(function()
		while recoltecc do
			Wait(1)

				RageUI.IsVisible(RMenu:Get('recoltecc', 'main'), true, true, true, function()

					FreezeEntityPosition(playerPed, false)

					if dansmenu then
							FreezeEntityPosition(playerPed, true)
						RageUI.ButtonWithStyle("Sacar cañones", nil, { RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)     
							if (Selected) then
							end
						  end)
		
						else 

					RageUI.ButtonWithStyle("Sacar cañones", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
						if (Selected) then
							dansmenu = true 
							TriggerServerEvent('start:farmC')
							FreezeEntityPosition(playerPed, true)
							cooldown = true
							Citizen.SetTimeout(10000,function()
								cooldown = false
							    end)
						    end 
					    end)
				    end
				end)
			end
		end)
	end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.farm.canon.position.x, Config.farm.canon.position.y, Config.farm.canon.position.z)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vendeur' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'vendeur' then 
            if dist3 <= 15.0 then
                DrawMarker(6,  Config.farm.canon.position.x, Config.farm.canon.position.y, Config.farm.canon.position.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0 , 120)
            end
            if dist3 <= 1.0 then   
                RageUI.Text({ message = "Presiona ~b~E~s~ para sacar los cañones", time_display = 1 })
            if IsControlJustPressed(1,51) then           
                recoltecanon()
                end   
            end
        end 
    end
end)

local recoltedefou = false
RMenu.Add('recoltedefou', 'main', RageUI.CreateMenu("~b~Recolectar", ""))
RMenu:Get('recoltedefou', 'main'):SetSubtitle("~b~Menu")

RMenu:Get('recoltedefou', 'main').EnableMouse = false
RMenu:Get('recoltedefou', 'main').Closed = function()
	dansmenu = false
	recoltedefou = false
	TriggerServerEvent('stop:farm')
	FreezeEntityPosition(playerPed, false)
end

function recoltelevier()
	if not recoltedefou then
		recoltedefou = true
		RageUI.Visible(RMenu:Get('recoltedefou', 'main'), true)
	Citizen.CreateThread(function()
		while recoltedefou do
			Wait(1)

				RageUI.IsVisible(RMenu:Get('recoltedefou', 'main'), true, true, true, function()

					FreezeEntityPosition(playerPed, false)

					if dansmenu then
							FreezeEntityPosition(playerPed, true)
						RageUI.ButtonWithStyle("Sacar gatillos", nil, { RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)     
							if (Selected) then
							end
						  end)
		
						else 

					RageUI.ButtonWithStyle("Sacar gatillos", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
						if (Selected) then
							dansmenu = true
							TriggerServerEvent('start:farm4')
							FreezeEntityPosition(playerPed, true)
							cooldown = true
							Citizen.SetTimeout(10000,function()
								cooldown = false
							    end)
						    end 
					    end)
				    end
				end)
			end
		end)
	end
end


Citizen.CreateThread(function()
    while true do
        Wait(0)
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.farm.levier.position.x, Config.farm.levier.position.y, Config.farm.levier.position.z)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vendeur' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'vendeur' then 
            if dist3 <= 15.0 then
                DrawMarker(6,  Config.farm.levier.position.x, Config.farm.levier.position.y, Config.farm.levier.position.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0 , 120)
            end
            if dist3 <= 1.0 then   
                RageUI.Text({ message = "Presiona ~b~E~s~ para sacar los gatillos", time_display = 1 })
            if IsControlJustPressed(1,51) then           
                recoltelevier()
                end   
            end
        end 
    end
end)
