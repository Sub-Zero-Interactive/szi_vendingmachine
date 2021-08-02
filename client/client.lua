--[[
Copyright (C) 2021 Sub-Zero Interactive

All rights reserved.

Permission is hereby granted, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software with 'All rights reserved'. Even if 'All rights reserved' is very clear :

  You shall not sell and/or resell this software
  The rights to use, modify and merge
  The above copyright notice and this permission notice shall be included in all copies and files of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--]]
local hasStarted, startedRobbing, cancontinue, opened = false, false, false, false
local CurrentCoords, started = nil, nil
local taken = 0

Citizen.CreateThread(function()
	while QBCore == nil do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
		Citizen.Wait(100)
	end
end)

AddEventHandler('onClientResourceStart', function (resourceName)
	if (GetCurrentResourceName() ~= resourceName) then return end
	for k,v in pairs(Config.VendingMachineModels) do 
	    if GetDependency("FivemTarget") then
	        exports['fivem-target']:AddTargetModel({
	    	    name = 'vending-robbery',
	    	    label = 'Vending Machine',
	    	    icon = 'fas fa-mug-hot',
	    	    model = GetHashKey(v.prop),
	    	    interactDist = 2.0,
	    	    onInteract = StartRobbing,
	    	    options = {
	    	        {
	    		        name = 'rob',
	    		        label = 'Steal'
	    	        },
	    	        {
	    		        name = 'buy',
	    		        label = 'Buy Soda'
	    	        }
	    	    },
	    	vars = {}
	        })
	    else
	        for k,v in pairs(Config.VendingMachineModels) do 
				exports['qtarget']:AddTargetModel({v.prop}, {
					options = {
							{
									event = "szi_vendingmachine:buy",
									icon = "fas fa-coffee",
									label = "Buy",
							},
							{
								event = "szi_vendingmachine:startRobbing",
								icon = "fas fa-coffee",
								label = "Steal",
						},
					},
					distance = 2.0
			})			
				end
	    end
	end    
end)

function GetAnim(action)
    for k,v in pairs(Config.Animations) do
        if action == v.name then
            return v
        end
    end
end

function OpenVendingMenu()
if not opened then
	FreezeEntityPosition(PlayerPedId(), true)
	opened = true
	local menu = MenuV:CreateMenu('Vending Machine', 'Buy An Item!', 'bottomright', 255, 0, 0)

	local menuButtons = {}
	for k, v in pairs(Config.VendingItems) do
	menuButtons[k] = menu:AddButton({ icon = v.icon, label = v.label.. " - $".. v.price, value = v, description = v.description})
	menuButtons[k]:On("select",function()
	MenuV:CloseMenu(menu)
  BuyAnim(v.itemname,v.label, v.price)
end)
	end
	

	MenuV:OpenMenu(menu)

	menu:On('close', function(m)
		FreezeEntityPosition(PlayerPedId(), false)
		ClearPedTasks(PlayerPedId())
		opened = false
end)
			end
end

function FinishRobbings(success)
	TriggerServerEvent('szi_vendingmachine:robSuccess', success)
	FinishRobbing(success)
	Cooldown(true)
end

function BuyAnim(name, label, price)
	Wait(2)
	local buyanim = GetAnim("Buying")
	local pocketanim = GetAnim("Pocket")
	RequestAnimDict(buyanim.dictionary)
			while not HasAnimDictLoaded(buyanim.dictionary) do
					 Wait(10)
			end
			RequestAnimDict(pocketanim.dictionary)
			while not HasAnimDictLoaded(pocketanim.dictionary) do
					 Wait(10)
			end		
	TaskPlayAnim(PlayerPedId(),buyanim.dictionary,buyanim.animation,1.0,1.0,-1,1,0,false,false,false)
	Wait(3300)
	TaskPlayAnim(PlayerPedId(),pocketanim.dictionary,pocketanim.animation,1.0,1.0,-1,1,0,false,false,false)
	Wait(1000)
	TriggerServerEvent('szi_vendingmachine:buyItem', name, label, price, 1)
	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(PlayerPedId(), false)
	ClearPedTasks(PlayerPedId())
	opened = false
end

function FinishRobbing(success)
	if success and taken < GetOptions("MaxTake") then
		ClearPedTasks(PlayerPedId())
		local buyanim = GetAnim("Buying")
		RequestAnimDict(buyanim.dictionary)
        while not HasAnimDictLoaded(buyanim.dictionary) do
             Wait(10)
        end
		TaskPlayAnim(PlayerPedId(),buyanim.dictionary,buyanim.animation,1.0,1.0,-1,1,0,false,false,false)
		cancontinue = true
		QBCore.Functions.Notify("Press [DEL] To Stop Stealing!")
		exports['mythic_progbar']:Progress({
			name = 'using',
			duration = GetOptions("RobTime") * 1000,
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
		if not (taken < GetOptions("MaxTake")) then
			QBCore.Functions.Notify("There is Nothing Left To Steal!", "error")
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
				QBCore.Functions.TriggerCallback('szi_vendingmachine:canRob', function(CanRob)
		      if CanRob then
					local chance = math.random(GetOptions("MinChance"), GetOptions("MaxChance"))
				    local pos = GetEntityCoords(PlayerPedId(),  true)
                    local s1, s2 = GetStreetNameAtCoord( pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
                    local street1 = GetStreetNameFromHashKey(s1)
                    local street2 = GetStreetNameFromHashKey(s2)
			        ClearPedTasks(PlayerPedId())
					local robanim = GetAnim("Robbing")
					RequestAnimDict(robanim.dictionary)
					while not HasAnimDictLoaded(robanim.dictionary) do
						 Wait(10)
					end
					TaskPlayAnim(PlayerPedId(),robanim.dictionary,robanim.animation,1.0,1.0,-1,1,0,false,false,false)
					if chance <= GetOptions("Chance") then
				      TriggerServerEvent('szi_vendingmachine:notifyPolice', street1, street2, pos)
					end

					if GetDependency("CDKeymaster") then
					    local CustomSettings = {
					    	settings = {
					    		handleEnd = true;  --Send a result message if true and callback when message closed or callback immediately without showing the message
					    		speed = 15; --pixels / second
					    		scoreWin = 900; --Score to win
					    		scoreLose = -150; --Lose if this score is reached
					    		maxTime = 60000; --sec
					    		maxMistake = 5; --How many missed keys can there be before losing
					    		speedIncrement = 1; --How much should the speed increase when a key hit was successful
					    	},
					    	keys = {"a", "w", "d", "s", "g"}; --You can hash this out if you want to use default keys in the java side.
					    }
    
					    local robGame = exports['cd_keymaster']:StartKeyMaster(CustomSettings)
					    if robGame then
					    	FinishRobbings(true)
					    else
					    	FinishRobbings(false)
					    end
				    else 
					    Wait(GetDependency("RobbingTime"))
					    FinishRobbings(true)
				    end
		        else
			        QBCore.Functions.Notify("You Cannot Steal!", "error")
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
	if GetDependency("MythicNotify") then 
        exports['mythic_notify']:DoHudText('error', msg)
	else
		QBCore.Functions.Notify(msg)
	end
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
    Wait(GetOptions("BlipTimer") * 1000)
    RemoveBlip(Blip)
end)

function Cooldown(hasStarted)
    local timer = GetOptions("CooldownTime")
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
