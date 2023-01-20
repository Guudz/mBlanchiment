CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)
		Wait(5000)
	end
    while ESX.GetPlayerData().job == nil do
        Wait(10)
    end
    while ESX.GetPlayerData().job2 == nil do
        Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)
RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

function menuBlanchiment()    
	local mainMenu = RageUI.CreateMenu(Config.Menu.Titre, Config.Menu.SousTitre, Config.Menu.PosduMenuX, Config.Menu.PosduMenuY)
	mainMenu:SetRectangleBanner(Config.Menu.CouleurduMenu.R, Config.Menu.CouleurduMenu.G, Config.Menu.CouleurduMenu.B, Config.Menu.CouleurduMenu.A)
    
    local open = false
    mainMenu.Closed = function()
        open = false
    end
	if open then
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
			while open do
				RageUI.IsVisible(mainMenu, function()
					RageUI.Separator("↓  ~g~Blanchiment~s~  ↓")
					RageUI.Button("Blanchir de l'argent sale", nil, {RightLabel = "→→"}, true, {
						onSelected = function()
							local isSet, argent = mBlanchimentCheckQuantity(mBlanchimentKeyboardInput('mBlanchiment', "Combien voulez vous blanchir ?", '', 10))
							if isSet then
								TriggerServerEvent('mBlanchiment:Blanchiment', tonumber(argent))
								RageUI.CloseAll()
							else
								ESX.ShowAdvancedNotification('Information', 'Blanchiment', '~r~Montant invalide')
							end
						end
					})
				end)
				Wait(0)
			end
		end)
        if not RageUI.Visible(mainMenu)  then
            mainMenu = RMenu:DeleteType("mainMenu", true)
        end
	end
end


function mBlanchimentKeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLength)
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

function mBlanchimentCheckQuantity(number)
    number = tonumber(number)
    if type(number) == 'number' then
        number = ESX.Math.Round(number)
        if number > 0 then
            return true, number
        end
    end
    return false, number
end

CreateThread(function()
    while true do
        local Timer = 500
		if Config.TypeDeBlanchisseur.Marker == true then
            if Config.job.JobOrEveryone == "job" then
                if (ESX.PlayerData.job and ESX.PlayerData.job.name == Config.job.jobName) or (ESX.PlayerData.job2 and  ESX.PlayerData.job2.name == Config.job.jobName) then
                    local plyCoordsMarker3 = GetEntityCoords(PlayerPedId(), false)
                    local distMarker3 = Vdist(plyCoordsMarker3.x, plyCoordsMarker3.y, plyCoordsMarker3.z, Config.Marker.PositionXYZ)
                    if distMarker3 <= 10.0 then
                        Timer = 0
                        DrawMarker(Config.Marker.Type, Config.Marker.PositionXYZ, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.TailleXYZ, Config.Marker.Color, Config.Marker.Opacity, Config.Marker.Saute, Config.Marker.CameraSuivie, 2, Config.Marker.Rotation)
                    end
                    if distMarker3 <= Config.Marker.ShopRange then
                        Timer = 0
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~blanchir")
                        if IsControlJustPressed(1, 51) then
                            menuBlanchiment()
                            isInMenuBlanchiment = true
                        end
                    else
                        isInMenuBlanchiment = false
                        open = false
                        RageUI.CloseAll()
                    end
                end
            end
            if Config.job.JobOrEveryone == "everyone" then
                local plyCoordsMarker3 = GetEntityCoords(PlayerPedId(), false)
                local distMarker3 = Vdist(plyCoordsMarker3.x, plyCoordsMarker3.y, plyCoordsMarker3.z, Config.Marker.PositionXYZ)
                if distMarker3 <= 10.0 then
                    Timer = 0
                    DrawMarker(Config.Marker.Type, Config.Marker.PositionXYZ, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.TailleXYZ, Config.Marker.Color, Config.Marker.Opacity, Config.Marker.Saute, Config.Marker.CameraSuivie, 2, Config.Marker.Rotation)
                end
                if distMarker3 <= Config.Marker.ShopRange then
                    Timer = 0
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~blanchir")
                    if IsControlJustPressed(1, 51) then
                        menuBlanchiment()
                        isInMenuBlanchiment = true
                    end
                else
                    isInMenuBlanchiment = false
                    open = false
                    RageUI.CloseAll()
                end
            end
		end
		if Config.TypeDeBlanchisseur.Ped == true then
            if Config.job.JobOrEveryone == "job" then
                if (ESX.PlayerData.job and ESX.PlayerData.job.name == Config.job.jobName) or (ESX.PlayerData.job2 and  ESX.PlayerData.job2.name == Config.job.jobName) then
                    local plyCoordsPed3 = GetEntityCoords(PlayerPedId(), false)
                    local distPed3 = Vdist(plyCoordsPed3.x, plyCoordsPed3.y, plyCoordsPed3.z, Config.ped.PositionXYZH)
                    if distPed3 <= Config.ped.ShopRange then
                        Timer = 0
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour parler avec ~b~Jack")
                        if IsControlJustPressed(1, 51) then
                            menuBlanchiment()
                            isInMenuBlanchiment = true
                        end
                    else
                        isInMenuBlanchiment = false
                        open = false
                        RageUI.CloseAll()
                    end
                end
            end
            if Config.job.JobOrEveryone == "everyone" then
                local plyCoordsPed3 = GetEntityCoords(PlayerPedId(), false)
                local distPed3 = Vdist(plyCoordsPed3.x, plyCoordsPed3.y, plyCoordsPed3.z, Config.ped.PositionXYZH)
                if distPed3 <= Config.ped.ShopRange then
                    Timer = 0
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour parler avec ~b~Jack")
                    if IsControlJustPressed(1, 51) then
                        menuBlanchiment()
                        isInMenuBlanchiment = true
                    end
                else
                    isInMenuBlanchiment = false
                    open = false
                    RageUI.CloseAll()
                end
            end
		end
        Wait(Timer)
	end
end)
	

CreateThread(function()
	if Config.TypeDeBlanchisseur.Ped == true then
		local hash = GetHashKey(Config.ped.Name)
        while not HasModelLoaded(hash) do
        RequestModel(hash)
            Wait(20)
        end
        ped = CreatePed("PED_TYPE_CIVFEMALE", Config.ped.Name, Config.ped.PositionXYZH, false, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
		if Config.ped.JamaisChanger == true then
			SetPedDefaultComponentVariation(ped)
		end
		if Config.ped.Animation == true then
			TaskStartScenarioInPlace(ped, Config.ped.Animation_action, 0, true)
		end
	end
end)
