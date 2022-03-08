--##########	VRP Main	##########--
-- init vRP server context
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

local cvRP = module("vrp", "client/vRP")
vRP = cvRP()

local pvRP = {}
-- load script in vRP context
pvRP.loadScript = module
Proxy.addInterface("vRP", pvRP)

local cfg = module("vrp_scoreboard", "cfg/cfg")

local Scoreboard = class("Scoreboard", vRP.Extension)

local refresh = false
local focus = false
local active = false

function Scoreboard:__construct()
    vRP.Extension.__construct(self)
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if IsControlJustReleased(0, cfg.keys["~"]) then
				if not active then
					SetDisplay(not display)
					active = true
					self.remote._getInfo()
				elseif active then
					SetDisplay(false)
					active = false
				end
			end
			
			if IsControlJustReleased(0, cfg.keys["."]) and active then 	--- Mouse toggle
				SetNuiFocus(true, true)		-- (hasFocus [[true/false]], hasCursor [[true/false]])
			end
		end
	end)
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if active then
				if cfg.vehicle_driver or not cfg.vehicle_driver then
					if IsPedInAnyVehicle(GetPlayerPed(-1), false) and IsPedInAnyVehicle(GetPlayerPed(-1), true) then
						for k,v in pairs(cfg.veh_class) do
							if GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false)) == v then	
								if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) then
									SetDisplay(false)
									active = false
								end
							end
						end
					else
						-- task: set Invincible
						if cfg.lock_position then
							FreezeEntityPosition(GetPlayerPed(-1), true)
							SetEntityInvincible(GetPlayerPed(-1), false)
							SetEntityVisible(GetPlayerPed(-1), true, false)
						end
						if cfg.temp_god then
							SetEntityInvincible(GetPlayerPed(-1), true)
						end
						-- task: set Invisible
						if cfg.temp_invisible then
							SetEntityVisible(GetPlayerPed(-1), false, false)
						end
						-- task: Disable Controls
						if cfg.disable_controls then
							for k,v in pairs(cfg.disable_keys) do
								DisableControlAction(0, v, display)
							end
						end
					end
				end
			else
				FreezeEntityPosition(GetPlayerPed(-1), false)
				SetEntityInvincible(GetPlayerPed(-1), false)
				SetEntityVisible(GetPlayerPed(-1), true, false)
			end
		end
	end)
	
	-- task: fall disable
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if GetPedParachuteState(GetPlayerPed(-1)) >= 0 or IsPedRagdoll(GetPlayerPed(-1)) or IsPedInParachuteFreeFall(GetPlayerPed(-1)) or IsPedFalling(GetPlayerPed(-1)) then
				SetDisplay(false)
				active = false
				DisableControlAction(0, 243, display)
			end
		end
	end)
	
	-- task: Auto Refresh scoreboard
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(cfg.time * cfg.refresh)
			autoRefresh()
			self.remote._refresh()
			refresh = false
		end
	end)
	
	-- task: Forced Refresh scoreboard
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if refresh then
				self.remote._refresh()
				refresh = false
			end
		end
	end)
end

-- toggle off ui
RegisterNUICallback("exit", function(data) 
	SetNuiFocus(false, false)
	SetDisplay(false) 
	active = false
end)

-- refresh scoreboard
RegisterNUICallback("refresh", function(data) 
	refresh = true
	SetDisplay(true)
end)

-- toggle off mouse
RegisterNUICallback("mouse", function(data) 
	SetNuiFocus(false, false) 
end)

-- toggle ui
function SetDisplay(bool)
	display = bool
	SendNUIMessage({
		type = "ui",
		status = bool,
	})
end

function autoRefresh()
	refresh = true
	SendNUIMessage({
		type = "refresh",
	})
end

--update player list
function Scoreboard:updateTable(player)
	local players = {}
	refresh = false
	
	table.insert(players,
		'<tr><td><div class="profile"><div class="player_info flex"><div class="player_info--id_container"><figure class="player_id--mask"><h1 class="player_id" id="player_id">'
		.. player.id ..'</h1></figure></div><div class="player_info--name_container"><div class="player_name--mask"><h1 class="player_name" id="player_name">'
		.. player.name ..'</h1></div></div><div class="player_info--extras_container"><div class="extra_link--mask"><div class="extra_link"><i class="fas fa-phone-square-alt"></i><h4 class="extra_info" id="player_number">'
		.. player.phone ..'</h4></div><div class="extra_link"><i class="fas fa-user"></i><h4 class="extra_info" id="player_job">'
		.. player.job ..'</h4></div></div></div></div></div></td></tr>'
	)
	
	SendNUIMessage({
		type = "table",
		text = table.concat(players)
	})
end

--update player counts
function Scoreboard:updateCounts(count)
	refresh = false
	SendNUIMessage({
		type = "counts",
		counts = {
			job_1 = count.job_1,
			job_2 = count.job_2,
			job_3 = count.job_3,
			job_4 = count.job_4,
			
			online_1 = count.online_1,
			online_2 = count.online_2,
			online_3 = count.online_3,
			online_4 = count.online_4,
		}
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

Scoreboard.tunnel = {}

Scoreboard.tunnel.updateTable 	= Scoreboard.updateTable
Scoreboard.tunnel.updateCounts 	= Scoreboard.updateCounts

vRP:registerExtension(Scoreboard)