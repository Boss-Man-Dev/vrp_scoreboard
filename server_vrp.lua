local lang = vRP.lang
local Luang = module("vrp", "lib/Luang")

local htmlEntities = module("lib/htmlEntities")

local SB = class("SB", vRP.Extension)

function SB:__construct()
	vRP.Extension.__construct(self)
  
	self.cfg = module("vrp_scoreboard", "cfg/cfg")
	
	-- iteams
	--vRP.EXT.Inventory:defineItem("phone_book", self.lang.item.phone_book.name(), lang.item.phone_book.description(), nil, 0.5)
	
	-- load lang
	self.luang = Luang()
	self.luang:loadLocale(vRP.cfg.lang, module("vrp_scoreboard", "cfg/lang/"..vRP.cfg.lang))
	self.lang = self.luang.lang[vRP.cfg.lang]
	
end

RegisterServerEvent('SB:getPlayerInfo')
AddEventHandler('SB:getPlayerInfo', function()
	vRP:triggerEvent("getPlayerInfo")
end)

RegisterServerEvent('SB:getJobCount')
AddEventHandler('SB:getJobCount', function()
	vRP:triggerEvent("getJobCount")
end)

SB.event = {}

local info = {
	name = "",
	job = "Unemplyed",
}

function SB.event:getPlayerInfo()
	local user = vRP.users_by_source[source]
	
	local gtype = user:getGroupByType("job")
	
	local identity = vRP.EXT.Identity:getIdentity(user.cid)
	local firstName = identity.firstname
	local lastname = identity.name

	local phoneNumber = identity.phone
	
	if user ~= nil then
----------------------name info
		info.name = firstName and lastname
-----------------------------job info
		if info.job == nil then
			info.job = "Unemplyed"
		else 
			info.job = vRP.EXT.Group:getGroupTitle(gtype)
		end
----------------------phone info
		info.phone = phoneNumber
---------------------rank info
		local content = ""
		if user:hasPermission(self.cfg.owner) then
			if self.cfg.text then
				content = content.."<div style="..self.cfg.owner_color..">".."Owner".."</div>"
				info.rank = content
			else
				content = content.."<div><img src=\""..self.cfg.owner_img.."\" /></div>"
				info.rank = content
			end
		elseif user:hasPermission(self.cfg.admin) then
			if self.cfg.text then
				content = content.."<div style="..self.cfg.mod_color..">".."Admin".."</div>"
				info.rank = content
			else
				content = content.."<div><img src=\""..self.cfg.mod_img.."\" /></div>"
				info.rank = content
			end
		elseif user:hasPermission(self.cfg.mod) then
			if self.cfg.text then
				content = content.."<div style="..self.cfg.mod_color..">".."Admin".."</div>"
				info.rank = content
			else
				content = content.."<div><img src=\""..self.cfg.mod_img.."\" /></div>"
				info.rank = content
			end
		end
		
		TriggerClientEvent("SB:OpenScoreboard", source, info)
	end	
end

local j_info = {}

function SB.event:getJobCount()
	--primary jobs
	j_info.ems = #vRP.EXT.Group:getUsersByPermission(self.cfg.ems)
	j_info.police = #vRP.EXT.Group:getUsersByPermission(self.cfg.police)
	j_info.taxi = #vRP.EXT.Group:getUsersByPermission(self.cfg.taxi)
	j_info.mechanic = #vRP.EXT.Group:getUsersByPermission(self.cfg.mechanic)
	
	--extra jobs  
	j_info.cardealer = #vRP.EXT.Group:getUsersByPermission(self.cfg.cardealer)
	j_info.estate = #vRP.EXT.Group:getUsersByPermission(self.cfg.estate)
	
	--special (owner/Admin/mod)
	j_info.owner = #vRP.EXT.Group:getUsersByPermission(self.cfg.owner)
	j_info.admin = #vRP.EXT.Group:getUsersByPermission(self.cfg.admin)
	j_info.mod = #vRP.EXT.Group:getUsersByPermission(self.cfg.mod)
	
	TriggerClientEvent("SB:getJobCount", source, j_info)
end

vRP:registerExtension(SB)