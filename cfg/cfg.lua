--- Boss Man Discord: https://discord.gg/M3YRSy2

local cfg = {}

cfg.showNumber = true			-- hide/show Phone number
cfg.showJob = true				-- hide/show jobs
cfg.hide_special = true			-- hide/show high value positions (owner, admin, mod ect)
cfg.showServerName = true		-- true shows server name / false shows character name
cfg.showServerID = true			-- true shows server id / false shows character id
cfg.default_job = "citizen"		-- sets default job if no job title avaliable

cfg.vehicle_driver = false		-- allow/disable driver to open scoreboard in vehicle
cfg.vehicles = true				-- allow/disable scoreboard for specific vehicle classes

--setting for on foot only
cfg.disable_controls = true 	-- allow/disable disables controls			
cfg.lock_position = true		-- allow/disable freeze in location			
cfg.temp_god = true				-- allow/disable temp god			
cfg.temp_invisible = false		-- allow/disable invisibility	

cfg.time = 60000				-- ms for base time (60000 ms = 1 minute)
cfg.refresh = 1					-- time multiplyer

cfg.keys = {
	["~"] = 243, 				-- open ui
	["."] = 81,					-- toggle mouse overlay
}

cfg.hidden_jobs = {
	["owner"] 		= "superadmin", 	
	["admin"] 		= "admin", 	
}

cfg.veh_class = {
	["Compacts"] 		=  0,
	["Sedans"] 			=  1,
	["SUVs"] 			=  2, 
	["Coupes"] 			=  3, 
	["Muscle"] 			=  4, 
	["Sports Classics"] =  5, 
	["Sports"] 			=  6, 
	["Super"] 			=  7, 
	["Motorcycles"] 	=  8, 
	["Off-road"] 		=  9, 
	["Industrial"] 		=  10, 
	["Utility"] 		=  11, 
	["Vans"] 			=  12, 
	["Cycles"] 			=  13, 
	["Boats"] 			=  14, 
	["Helicopters"] 	=  15, 
	["Planes"] 			=  16, 
	["Service"] 		=  17, 
	["Emergency"] 		=  18, 
	["Military"] 		=  19, 
	["Commercial"] 		=  20, 
	["Trains"] 			=  21,
}

cfg.disable_keys = {
	["move"] 		= 1, 	-- Look Left Right
	["move_1"] 		= 2, 	-- Look Up Down
	["move_2"] 		= 30, 	-- move let right
	["move_3"] 		= 31, 	-- move up down
	
	["player"] 		= 21, 	-- sprint
	["player_1"] 	= 22, 	-- jump
	["player_2"] 	= 23, 	-- enter
	["player_3"] 	= 24, 	-- attack
	
	["wepon"] 		= 45,	-- reload
	["wepon_1"] 	= 47,	-- detonate
	
	["melee"] 		= 263,	-- Melee 
	["melee_1"] 	= 264,	-- Melee 
	["melee_2"] 	= 257,	-- Melee 
	["melee_3"] 	= 140,	-- Melee 
	["melee_4"] 	= 141,	-- Melee
	["melee_5"] 	= 142,	-- Melee 
	["melee_6"] 	= 143,	-- Melee
	
	["vehicle"] 	= 75,	-- disable exit/enter vehicle
	
	["enter"] 		= 18,	-- Enter
	["veh_ctrl"] 	= 106,	-- Vehicle Mouse Control Override
}

cfg.counts = {
	perms = {
		job_1 = "", --!group.(group name)  example: "!group.police"
		job_2 = "",
		job_3 = "",
		job_4 = "",
		
		online_1 = "!group.superadmin",
		online_2 = "!group.admin",
		online_3 = "!group.mod",
		online_4 = "!group.user",
	},
}

return cfg