-- find keys list @ https://docs.fivem.net/docs/game-references/controls/

--if changing key also change the key in the listener.js line 23
local keys = {
	["~"] = 243, 
	["."] = 81,
}

nui = false

scoreboardActivating = false
scoreboardActive = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		
		if IsControlJustReleased(0, keys["~"]) then 	-- scoreboard toggle
			if not scoreboardActive then
				TriggerServerEvent('SB:getPlayerInfo', nui)
				
				scoreboardActive = true
				
			elseif scoreboardActive then
				CloseScoreboard()
				scoreboardActive = false
			end
		end
		
		if IsControlJustReleased(0, keys["."]) and scoreboardActive then 	--- Mouse toggle
			SetNuiFocus(true, true)		-- (hasFocus [[true/false]], hasCursor [[true/false]])
		end
    end
end)

RegisterNUICallback("NUIFocusOff", function() --close function for when mouse is active
    CloseScoreboard()
end)

RegisterNUICallback("NUIFocusOff_m", function() --close function for mouse
	SetNuiFocus(false, false)
end)

-- Overall Player Table Info
RegisterNetEvent('SB:OpenScoreboard')
AddEventHandler('SB:OpenScoreboard', function(info)
	
	local players = {}
	table.insert(players,
		'<tr><td>'
		.. info.name .. '</td><td>'		--character name (first and last)
		.. info.job .. '</td><td>'		--job info
		.. info.rank .. '</td></tr>'	-- if user is a mod/admin/owner
	)
	
	SendNUIMessage({ text = table.concat(players) }) 	--send info to scoreboard
	
	-- call player counts and job counts server event
	TriggerServerEvent('SB:getJobCount')
end)

-- Overall Job/Player Count Info
RegisterNetEvent('SB:getJobCount')
AddEventHandler('SB:getJobCount', function(j_info)

	SendNUIMessage({
		action = 'updatePlayerJobs',
		jobs   = {
			-- main row for jobs
			job1 = j_info.job1, 
			job2 = j_info.job2, 
			job3 = j_info.job3, 
			job4 = j_info.job4,
			
			--extra job rows 
			ex1 = j_info.ex1,
			ex2 = j_info.ex2,
			ex3 = j_info.ex3,
			ex4 = j_info.ex4,
			
			--counter for bottom row
			owner = j_info.owner, 
			admin = j_info.admin, 
			mod = j_info.mod, 
			user = j_info.user,
		}
	})
	
end)

function CloseScoreboard()		-- main closing function
	scoreboardActive = false
	SetNuiFocus(false, false)
	
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
