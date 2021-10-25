local lang = vRP.lang
local Luang = module("vrp", "lib/Luang")

local Scoreboard = class("Scoreboard", vRP.Extension)
Scoreboard.event = {}
Scoreboard.tunnel = {}

function Scoreboard:__construct()
	vRP.Extension.__construct(self)
	
	-- load config
	self.cfg = module("vrp_scoreboard", "cfg/cfg")
	
	for k,v in pairs(self.cfg.disable_keys) do
		--self:log("\r\27[10;92m["..k..": "..v.."] Keys \r\27[0m")	
	end
		
	-- load language 
	self.luang = Luang()
	self.luang:loadLocale(vRP.cfg.lang, module("vrp_scoreboard", "cfg/lang/"..vRP.cfg.lang))
	self.lang = self.luang.lang[vRP.cfg.lang]
end

function Scoreboard.event:getUsersInfo()
	local player = {}
	local content = ""
	
	for id, user in pairs(vRP.users) do
		local identity = vRP.EXT.Identity:getIdentity(user.cid)
		local firstName = identity.firstname
		local lastName = identity.name
		local gtype = user:getGroupByType("job")
		
		-- server id or cid 
		if self.cfg.showServerID then
			server_id = id
		else
			server_id = user.cid
		end
		
		-- server name or character name
		if self.cfg.showServerName then
			local player_name = user.name
			if player_name == nil then
				name = content.."<div>"..firstName.." "..lastName.."</div>"
			else
				name = user.name
			end
		else
			name = content.."<div>"..firstName.." "..lastName.."</div>"
		end
		
		-- show/hide phone number
		if self.cfg.showNumber then
			phoneNumber = user.identity.phone
		else
			phoneNumber = "Hidden"
		end
		
		-- show/hide job title
		if self.cfg.showJob then
			if self.cfg.hide_special then
				for k,v in pairs(self.cfg.hidden_jobs) do
					if vRP.EXT.Group:getUsersByPermission(v) then
						job = self.cfg.default_job
					end	
				end
			else
				if job then
					if not user:hasGroup(gtype) then
						user:addGroup(self.cfg.default_job)
					else 
						job = vRP.EXT.Group:getGroupTitle(gtype)
					end
				end
			end
		else
			job = "Hidden"
		end
		
		player.id = server_id
		player.name = name
		player.phone = phoneNumber
		player.job = job
		
		self.remote._updateTable(source, player)
	end
end

function Scoreboard.event:getJobCounts()
	local count = {}
	local perm = self.cfg.counts.perms
	
	for _, user in pairs(vRP.users) do
		count.job_1 = #vRP.EXT.Group:getUsersByPermission(perm.job_1)
		count.job_2 = #vRP.EXT.Group:getUsersByPermission(perm.job_2)
		count.job_3 = #vRP.EXT.Group:getUsersByPermission(perm.job_3)
		count.job_4 = #vRP.EXT.Group:getUsersByPermission(perm.job_4)
		
		count.online_1 = #vRP.EXT.Group:getUsersByPermission(perm.online_1)
		if user:hasPermission(perm.online_1) and user:hasPermission(perm.online_2) then
			count.online_2 = #vRP.EXT.Group:getUsersByPermission(perm.online_2) - #vRP.EXT.Group:getUsersByPermission(perm.online_1)
		else
			count.online_2 = #vRP.EXT.Group:getUsersByPermission(perm.online_2)
		end
		count.online_3 = #vRP.EXT.Group:getUsersByPermission(perm.online_3)
		count.online_4 = #vRP.EXT.Group:getUsersByPermission(perm.online_4)
		
		self.remote._updateCounts(user.source, count)
	end
end

function Scoreboard.tunnel:getInfo()
	vRP:triggerEvent("getUsersInfo")
	vRP:triggerEvent("getJobCounts")
end

function Scoreboard.tunnel:refresh()
	vRP:triggerEvent("getUsersInfo")
	vRP:triggerEvent("getJobCounts")
end

-- (async)
function vRP:onPlayerDropped(source)
	vRP:triggerEvent("getUsersInfo")
	vRP:triggerEvent("getJobCounts")
end

function vRP:disconnectUser(source)
	vRP:triggerEvent("getUsersInfo")
	vRP:triggerEvent("getJobCounts")
end

vRP:registerExtension(Scoreboard)