local keys = {["~"] = 243} -- keys list in cfg file


local nui = false

Citizen.CreateThread(function()
    nui = false
    while true do
        Citizen.Wait(1)

        if IsControlPressed(0, keys["~"]) then 
            if not nui then
                TriggerServerEvent('SB:getPlayerInfo')

                nui = true
                while nui do
                    Wait(0)
                    if(IsControlPressed(0, keys["~"]) == false) then
                        CloseScoreboard()
                    end
                end
            end
        end
    end
end)

-- Overall Info
RegisterNetEvent('SB:OpenScoreboard')
AddEventHandler('SB:OpenScoreboard', function(info)
		
	local players = {}
	table.insert(players,
		'<tr style=\"color: #fff"><td>'
		.. info.name .. '</td><td>'
		.. info.job .. '</td><td>'
		.. info.phone .. '</td><td>'
		.. info.rank .. '</td></tr>'
	)

	SendNUIMessage({ text = table.concat(players) })
	
	TriggerServerEvent('SB:getJobCount')
end)

-- Overall Info
RegisterNetEvent('SB:getJobCount')
AddEventHandler('SB:getJobCount', function(j_info)

	SendNUIMessage({
		action = 'updatePlayerJobs',
		jobs   = {
			ems = j_info.ems, 
			police = j_info.police, 
			taxi = j_info.taxi, 
			mechanic = j_info.mechanic, 
			
			--cardealer = j_info.cardealer, 
			--estate = j_info.estate, 
			
			owner = j_info.owner, 
			admin = j_info.admin, 
			mod = j_info.mod, 
		}
	})
	
end)

function CloseScoreboard()
    nui = false
	SendNUIMessage({
		meta = 'close'
	})
end

function GetPlayers()
    local players = {}

    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end
