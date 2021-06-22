local hasStarted, startedRobbing, cancontinue = false, false, false
local CurrentCoords, started = nil, nil
local taken = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

AddEventHandler('onClientResourceStart', function (resourceName)
	if (GetCurrentResourceName() ~= resourceName) then return end
	for k,v in pairs(Config.VendingMachineModels) do 
	    if Config.FivemTarget then
	        exports['fivem-target']:AddTargetModel({
	    	    name = 'robbery',
	    	    label = 'Vending Machine',
	    	    icon = 'fas fa-mug-hot',
	    	    model = GetHashKey(v.prop),
	    	    interactDist = 2.0,
	    	    onInteract = StartRobbing,
	    	    options = {
	    	        {
	    		        name = 'rob',
	    		        label = 'Rob Vending Machine'
	    	        },
	    	        {
	    		        name = 'buy',
	    		        label = 'Buy Soda'
	    	        }
	    	    },
	    	vars = {}
	        })
	    else
			local machines = {}
	        for k,v in pairs(Config.VendingMachineModels) do 
		        table.insert(machines,GetHashKey(v.prop))
	 	    end
		    Wait(5)
		    exports['bt-target']:AddTargetModel(machines, {
		    	options = {
		    		{
		    			event = 'szi_vendingmachine:startRobbing',
		    			icon = 'fas fa-mug-hot',
		    			label = 'Rob Vending Machine',
		    		},
					{
					    event = 'szi_vendingmachine:buy',
					    icon = 'fas fa-mug-hot',
					    label = 'Buy Soda',
				    }
		    	},
		    	job = {'all'},
		    	distance = 1.5
		    })
	    end
	end    
end)

function OpenVendingMenu()
	ESX.UI.Menu.CloseAll()

	local elements = {}
	for k, v in pairs(Config.Rewards) do
	    table.insert(elements, {label = ('%s - <span style="color:green;">%s</span>'):format(v.name, ESX.Math.GroupDigits(v.price)), item = v.name, price = v.price, type = 'slider', value = 1, min = 1, max = 100})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vending', {
		title    = 'Vending Machine',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		TriggerServerEvent('szi_vendingmachine:buyItem', data.current.item, data.current.price, data.current.value)
		TaskPlayAnim(PlayerPedId(),Config.VendingDict,Config.VendingAnim,1.0,1.0,-1,1,0,false,false,false)
		Wait(5000)
		ClearPedTasks(PlayerPedId())
	end, function(data, menu)
		menu.close()
	end)
end

function FinishRobbings(success)
	TriggerServerEvent('szi_vendingmachine:robSuccess', success)
	FinishRobbing(success)
	Cooldown(true)
end

function FinishRobbing(success)
	TriggerEvent('mhacking:hide')
	if success and taken < Config.MaxTake then
		ClearPedTasks(PlayerPedId())
		RequestAnimDict(Config.VendingDict)
		while not HasAnimDictLoaded(Config.VendingDict) do
			 Wait(10)
		end
		TaskPlayAnim(PlayerPedId(),Config.VendingDict,Config.VendingAnim,1.0,1.0,-1,1,0,false,false,false)
		cancontinue = true
		ESX.ShowHelpNotification(_U('press_stop'))
		exports['mythic_progbar']:Progress({
			name = 'using',
			duration = Config.RobTime * 1000,
			label = 'Robbing Vending Machine',
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}
		}, function(cancelled)
			if not cancelled then
				TriggerServerEvent('szi_vendingmachine:success')
				taken = taken + 1
				FinishRobbing(true)
			else
				ClearPedTasks(PlayerPedId())
				cancontinue = false
				taken = 0
				Cooldown(true)
			end
		end)
	else
		if not (taken < Config.MaxTake) then
		    ESX.ShowHelpNotification(_U('max_amount'))
		end
		ClearPedTasks(PlayerPedId())
		cancontinue = false
		taken = 0
		Cooldown(true)
	end
end

function StartRobbing(targetName, optionName, vars, entityHit)
	if optionName and  optionName == 'rob' then
	    if not startedRobbing then
		    startedRobbing = true
	        ESX.TriggerServerCallback('szi_vendingmachine:canRob', function(CanRob)
		        if CanRob then
					local chance = math.random(Config.MinChance, Config.MaxChance)
				    local pos = GetEntityCoords(PlayerPedId(),  true)
                    local s1, s2 = GetStreetNameAtCoord( pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
                    local street1 = GetStreetNameFromHashKey(s1)
                    local street2 = GetStreetNameFromHashKey(s2)
			        ClearPedTasks(PlayerPedId())
			        RequestAnimDict(Config.RobbingDict)
			        while not HasAnimDictLoaded(Config.RobbingDict) do
			            Wait(1)
			        end
			        TaskPlayAnim(PlayerPedId(),Config.RobbingDict,Config.RobbingAnim ,8.0,8.0,-1,1,0,false,false,false)
			        TriggerEvent('mhacking:show')
			        TriggerEvent('mhacking:start',5,30,FinishRobbings)
					if chance <= Config.Chance then
				        TriggerServerEvent('szi_vendingmachine:notifyPolice', street1, street2, pos)
					end
		        else
			        ESX.ShowHelpNotification(_U('cant_rob'), false, true, 2000)
			        Wait(2000)
			        hasStarted = false
			        startedRobbing = false
		        end
	        end)
        end
    else
		OpenVendingMenu()
	end
end

RegisterNetEvent('szi_vendingmachine:startRobbing')
AddEventHandler('szi_vendingmachine:startRobbing', function()
	StartRobbing(nil, 'rob')
end)

RegisterNetEvent('szi_vendingmachine:buy')
AddEventHandler('szi_vendingmachine:buy', function()
	OpenVendingMenu()
end)

RegisterNetEvent('szi_vendingmachine:notifyPolice')
AddEventHandler('szi_vendingmachine:notifyPolice', function(msg)
    exports['mythic_notify']:DoHudText('error', msg)
end)

RegisterNetEvent('szi_vendingmachine:blip')
AddEventHandler('szi_vendingmachine:blip', function(x,y,z)
    Blip = AddBlipForCoord(x,y,z)
    SetBlipSprite(Blip,  587)
    SetBlipColour(Blip,  1)
    SetBlipAlpha(Blip,  250)
    SetBlipDisplay(Blip, 4)
    SetBlipScale(Blip, 1.2)
    SetBlipFlashes(Blip, true)
    SetBlipAsShortRange(Blip,  true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Robbery In Progress | Vending Machine')
    EndTextCommandSetBlipName(Blip)
    Wait(Config.BlipTimer * 1000)
    RemoveBlip(Blip)
end)

function Cooldown(hasStarted)
    local timer = Config.CooldownTime
    while hasStarted == true do
        Citizen.Wait(1000)
        if timer > 0 then
            timer = timer -1
        end

        if timer == 1 then
			hasStarted = false
			startedRobbing = false
            break
        end
    end
end