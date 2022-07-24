local display = false
ESX= nil
local isInMarker = false
local hablo = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
        quitarmapa()
	end
	ESX.PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('armas:mapa')
AddEventHandler('armas:mapa', function()
    mapa()
    desactivarcontroles()
end)
RegisterNetEvent('armas:add')
AddEventHandler('armas:add', function()
	item = true
end)

RegisterNetEvent('armas:remove')
AddEventHandler('armas:remove', function()
	item = false
end)

--NPC--
Citizen.CreateThread(function ()
    RequestModel(GetHashKey(Config.NPC))

    while not HasModelLoaded(GetHashKey(Config.NPC)) do
        Wait(1)

    end 


    if Config.ActivarNPC then
        for _, item in pairs (Config.LocalizacionNPC) do
            local npc = CreatePed(4, 0x342333D3, item.x, item.y, item.z, item.heading, false, true)
            SetEntityHeading(npc, item.heading)
            FreezeEntityPosition(npc, true)
            SetEntityInvincible(npc, true)
            SetBlockingOfNonTemporaryEvents(npc, true)

        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil
			for k,v in pairs(Config.Localizacion) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, v.Pos.h, true) < v.Size.x) then
					isInMarker  = true
					DisplayHelpText("~r~Presiona E para hablar con el sujeto")
                    if IsControlJustReleased(1,86) then
                        if hablo == false then
                    pregunta()
                    TriggerServerEvent("InteractSound_SV:PlayOnSource", "armas", 0.3)
                    end
            
            end
			
            end
			end
	end
end)


function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function charla(texto)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(texto)
    DrawNotification(false,true)

end

function pregunta()
	local elements = {
		{label = "Si", value = "yes"},
		{label = "No", value = "no"}
	}
	    ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'job_menu',
		{
			title  = '¿Te interesa?',
			align    = 'bottom-right',
			elements = elements
		},
		    function(data, menu)
			    if data.current.value == "yes" then
                        TriggerServerEvent("InteractSound_SV:PlayOnSource", "armas2", 0.3)
                        TriggerServerEvent("trabajo")
                        TriggerServerEvent("armas:add")
                        TriggerEvent("pNotify:SendNotification", {
							text = "<font size=4 color=#ff0000 ><p align=Center><b>".."<font size=4 color=#ffffff>".."Usa /quitarmapa para cerrar el mapa</font>",
							type = "alert",
							timeout = 3000,
							layout = "centerLeft",
							queue = "left"
						})
                        hablo = true
                     
                        menu.close()
			            elseif data.current.value == "no" then
                            TriggerServerEvent("InteractSound_SV:PlayOnSource", "armas3", 0.3)
				        menu.close()
                       
                      
			end
        
		
			menu.close()
		end
	)
end
  --[[ ////////////////////////////////////////// ]]

  RegisterNetEvent('nui:off')
  AddEventHandler('nui:off', function()
    SendNUIMessage({
      type = "ui",
      display = false
    })
  end)
  RegisterNetEvent('nui:on')
  AddEventHandler('nui:on', function()
    SendNUIMessage({
      type = "ui",
      display = true
    })
  end)


function mapa()
    Citizen.CreateThread(function()
        TriggerEvent('nui:on', true)
      end)
end

function quitarmapa()
    Citizen.CreateThread(function()
        TriggerEvent("nui:off", true)
    end)
    
end

RegisterCommand("quitarmapa", function()
    Citizen.CreateThread(function()
        TriggerEvent("nui:off", true)
    end)
    activarcontroles()
  end)

  RegisterNetEvent('esx:playerLoaded')
  AddEventHandler('esx:playerLoaded', function(xPlayer)
      PlayerData = xPlayer
  
      item = false
  
      for i=1, #PlayerData.inventory, 1 do
          if PlayerData.inventory[i].name == 'mapa' then
              if PlayerData.inventory[i].count > 0 then
                  item = true
              end
          end
      end
  
  end)

function desactivarcontroles()
    Citizen.CreateThread(function()			
        while true do
            Citizen.Wait(0)
                DisableControlAction(0,21,true) -- disable sprint
                DisableControlAction(0,24,true) -- disable attack
                DisableControlAction(0,25,true) -- disable aim
                DisableControlAction(0,47,true) -- disable weapon
                DisableControlAction(0,58,true) -- disable weapon
                DisableControlAction(0,263,true) -- disable melee
                DisableControlAction(0,264,true) -- disable melee
                DisableControlAction(0,257,true) -- disable melee
                DisableControlAction(0,140,true) -- disable melee
                DisableControlAction(0,141,true) -- disable melee
                DisableControlAction(0,142,true) -- disable melee
                DisableControlAction(0,143,true) -- disable melee
                DisableControlAction(0,75,true) -- disable exit vehicle
                DisableControlAction(27,75,true) -- disable exit vehicle
                DisableControlAction(0,32,true) -- move (w)
                DisableControlAction(0,34,true) -- move (a)
                DisableControlAction(0,33,true) -- move (s)
                DisableControlAction(0,35,true) -- move (d)
                DisableControlAction(0,322,true) -- ESC
                
            
        end
    end)
end    

function activarcontroles()
    Citizen.CreateThread(function()			
        while true do
            Citizen.Wait(0)
                EnableControlAction(0,21,true) -- disable sprint
                EnableControlAction(0,24,true) -- disable attack
                EnableControlAction(0,25,true) -- disable aim
                EnableControlAction(0,47,true) -- disable weapon
                EnableControlAction(0,58,true) -- disable weapon
                EnableControlAction(0,263,true) -- disable melee
                EnableControlAction(0,264,true) -- disable melee
                EnableControlAction(0,257,true) -- disable melee
                EnableControlAction(0,140,true) -- disable melee
                EnableControlAction(0,141,true) -- disable melee
                EnableControlAction(0,142,true) -- disable melee
                EnableControlAction(0,143,true) -- disable melee
                EnableControlAction(0,75,true) -- disable exit vehicle
                EnableControlAction(27,75,true) -- disable exit vehicle
                EnableControlAction(0,32,true) -- move (w)
                EnableControlAction(0,34,true) -- move (a)
                EnableControlAction(0,33,true) -- move (s)
                EnableControlAction(0,35,true) -- move (d)
                EnableControlAction(0,322,true) -- ESC
                
            end
        
    end)
end    
display = false