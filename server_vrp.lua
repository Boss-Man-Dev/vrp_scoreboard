--[[
	owner info --- line 80
	admin info --- line 108
	mod info   --- line 135
	user info  --- line 162
	counters   --- line 189
	ver check  --- line 214
--]]


local lang = vRP.lang
local Luang = module("vrp", "lib/Luang")

local htmlEntities = module("lib/htmlEntities")

local SB = class("SB", vRP.Extension)

function SB:__construct()
	vRP.Extension.__construct(self)
  
	self.cfg = module("vrp_scoreboard", "cfg/cfg")
	
	-- load lang
	self.luang = Luang()
	self.luang:loadLocale(vRP.cfg.lang, module("vrp_scoreboard", "cfg/lang/"..vRP.cfg.lang))
	self.lang = self.luang.lang[vRP.cfg.lang]
	
	-- items
	vRP.EXT.Inventory:defineItem("phonebook", self.lang.item.phonebook.name(), self.lang.item.phonebook.description(), nil, 0.5)
end

--client call for table info
RegisterServerEvent('SB:getPlayerInfo')
AddEventHandler('SB:getPlayerInfo', function()
	vRP:triggerEvent("getPlayerInfo")
end)

--client call for job/player counts
RegisterServerEvent('SB:getJobCount')
AddEventHandler('SB:getJobCount', function()
	vRP:triggerEvent("getJobCount")
end)

SB.event = {}

local info = {}

--table info
function SB.event:getPlayerInfo()
	
	local users = vRP.EXT.Group:getUsersByPermission(self.cfg.info.user.perm)
	local config = self.cfg.info
	
	for _,user in pairs(users) do
		local identity = vRP.EXT.Identity:getIdentity(user.cid)
		local gtype = user:getGroupByType("job")
		local id = user.id
		local firstName = identity.firstname
		local lastName = identity.name
		local phoneNumber = "Hidden"
		local m_job = "Unemployed"
		if m_job then
			if not user:hasGroup(gtype) then
				user:addGroup(self.cfg.default)
			else 
				m_job = vRP.EXT.Group:getGroupTitle(gtype)
			end
		end
		if phoneNumber then
			if users then
				phoneNumber = "Hidden"
				if user then
					phoneNumber = user.identity.phone
				end
			end
		end
		
-----------------ALL SERVER OWNER PLAYER INFO----------------------------
		local content = ""
		if user:hasPermission(config.owner.perm) then
			if self.cfg.text then
				if self.cfg.color then
					info.name = content.."<div style="..config.owner.color..">"..firstName.." "..lastName.." ("..id..")".."</div>"
					info.job = content.."<div style="..config.owner.color..">"..m_job.."</div>"
					info.phone = content.."<div style="..config.owner.color..">"..phoneNumber.."</div>"
					info.rank = content.."<div style="..config.owner.color..">"..config.owner.text.."</div>"
				else 
					info.name = content.."<div style="..self.cfg.d_color..">"..firstName.." "..lastName.."</div>"
					info.job = content.."<div style="..self.cfg.d_color..">"..m_job.."</div>"
					info.phone = content.."<div style="..self.cfg.d_color..">"..phoneNumber.."</div>"
					info.rank = content.."<div style="..self.cfg.d_color..">"..config.owner.text.."</div>"
				end
			else
				if self.cfg.color then
					info.name = content.."<div style="..config.owner.color..">"..firstName.." "..lastName.." ("..id..")".."</div>"
					info.job = content.."<div style="..config.owner.color..">"..m_job.."</div>"
					info.phone = content.."<div style="..config.owner.color..">"..phoneNumber.."</div>"
					info.rank = content.."<div><img src=\""..config.owner.img.."\" /></div>"
				else
					info.name = content.."<div style="..self.cfg.d_color..">"..firstName.." "..lastName.." ("..id..")".."</div>"
					info.job = content.."<div style="..self.cfg.d_color..">"..m_job.."</div>"
					info.phone = content.."<div style="..self.cfg.d_color..">"..phoneNumber.."</div>"
					info.rank = content.."<div><img src=\""..config.owner.img.."\" /></div>"
				end
			end
-----------------ALL SERVER ADMIN PLAYER INFO----------------------------
		elseif user:hasPermission(config.admin.perm) then
			if self.cfg.text then
				if self.cfg.color then
					info.name = content.."<div style="..config.admin.color..">"..firstName.." "..lastName.." ("..id..")".."</div>"
					info.job = content.."<div style="..config.admin.color..">"..m_job.."</div>"
					info.phone = content.."<div style="..config.admin.color..">"..phoneNumber.."</div>"
					info.rank = content.."<div style="..config.admin.color..">"..config.admin.text.."</div>"
				else 
					info.name = content.."<div style="..self.cfg.d_color..">"..firstName.." "..lastName.." ("..id..")".."</div>"
					info.job = content.."<div style="..self.cfg.d_color..">"..m_job.."</div>"
					info.phone = content.."<div style="..self.cfg.d_color..">"..phoneNumber.."</div>"
					info.rank = content.."<div style="..self.cfg.d_color..">"..config.admin.text.."</div>"
				end
			else
				if self.cfg.color then
					info.name = content.."<div style="..config.admin.color..">"..firstName.." "..lastName.." ("..id..")".."</div>"
					info.job = content.."<div style="..config.admin.color..">"..m_job.."</div>"
					info.phone = content.."<div style="..config.admin.color..">"..phoneNumber.."</div>"
					info.rank = content.."<div><img src=\""..config.admin.img.."\" /></div>"
				else
					info.name = content.."<div style="..self.cfg.d_color..">"..firstName.." "..lastName.." ("..id..")".."</div>"
					info.job = content.."<div style="..self.cfg.d_color..">"..m_job.."</div>"
					info.phone = content.."<div style="..self.cfg.d_color..">"..phoneNumber.."</div>"
					info.rank = content.."<div><img src=\""..config.admin.img.."\" /></div>"
				end
			end
-----------------ALL SERVER MOD PLAYER INFO----------------------------
		elseif user:hasPermission(config.mod.perm) then
			if self.cfg.text then
				if self.cfg.color then
					info.name = content.."<div style="..config.mod.color..">"..firstName.." "..lastName.." ("..id..")".."</div>"
					info.job = content.."<div style="..config.mod.color..">"..m_job.."</div>"
					info.phone = content.."<div style="..config.mod.color..">"..phoneNumber.."</div>"
					info.rank = content.."<div style="..config.mod.color..">"..config.mod.text.."</div>"
				else 
					info.name = content.."<div style="..self.cfg.d_color..">"..firstName.." "..lastName.." ("..id..")".."</div>"
					info.job = content.."<div style="..self.cfg.d_color..">"..m_job.."</div>"
					info.phone = content.."<div style="..self.cfg.d_color..">"..phoneNumber.."</div>"
					info.rank = content.."<div style="..self.cfg.d_color..">"..config.mod.text.."</div>"
				end
			else
				if self.cfg.color then
					info.name = content.."<div style="..config.mod.color..">"..firstName.." "..lastName.." ("..id..")".."</div>"
					info.job = content.."<div style="..config.mod.color..">"..m_job.."</div>"
					info.phone = content.."<div style="..config.mod.color..">"..phoneNumber.."</div>"
					info.rank = content.."<div><img src=\""..config.mod.img.."\" /></div>"
				else
					info.name = content.."<div style="..self.cfg.d_color..">"..firstName.." "..lastName.." ("..id..")".."</div>"
					info.job = content.."<div style="..self.cfg.d_color..">"..m_job.."</div>"
					info.phone = content.."<div style="..self.cfg.d_color..">"..phoneNumber.."</div>"
					info.rank = content.."<div><img src=\""..config.mod.img.."\" /></div>"
				end
			end
-----------------ALL SERVER USER PLAYER INFO----------------------------
		else
			if self.cfg.user_text then
				info.name = content.."<div style="..config.user.color..">"..firstName.." "..lastName.." ("..id..")".."</div>"
				info.job = content.."<div style="..config.user.color..">"..m_job.."</div>"
				info.phone = content.."<div style="..config.user.color..">"..phoneNumber.."</div>"
				info.rank = content.."<div style="..config.user.color..">"..config.user.text.."</div>"
			else
				if self.cfg.blank then
					info.name = content.."<div style="..config.user.color..">"..firstName.." "..lastName.." ("..id..")".."</div>"
					info.job = content.."<div style="..config.user.color..">"..m_job.."</div>"
					info.phone = content.."<div style="..config.user.color..">"..phoneNumber.."</div>"
					info.rank = content.."<div><img src=\""..config.user.b_img.."\" /></div>"
				else
					info.name = content.."<div style="..config.user.color..">"..firstName.." "..lastName.." ("..id..")".."</div>"
					info.job = content.."<div style="..config.user.color..">"..m_job.."</div>"
					info.phone = content.."<div style="..config.user.color..">"..phoneNumber.."</div>"
					info.rank = content.."<div><img src=\""..config.user.img.."\" /></div>"
				end
			end
		end
		TriggerClientEvent("SB:OpenScoreboard", source, info)
	end
end

local j_info = {}

--job/player counts
function SB.event:getJobCount()
	local perm = self.cfg.perms
	local config = self.cfg.info
	--primary job
	j_info.job1 = #vRP.EXT.Group:getUsersByPermission(perm.default.job1)
	j_info.job2 = #vRP.EXT.Group:getUsersByPermission(perm.default.job2)
	j_info.job3 = #vRP.EXT.Group:getUsersByPermission(perm.default.job3)
	j_info.job4 = #vRP.EXT.Group:getUsersByPermission(perm.default.job4)
	
	--extra job counts
	j_info.ex1 = #vRP.EXT.Group:getUsersByPermission(perm.extra.ex1)
	j_info.ex2 = #vRP.EXT.Group:getUsersByPermission(perm.extra.ex2)
	j_info.ex3 = #vRP.EXT.Group:getUsersByPermission(perm.extra.ex3)
	j_info.ex4 = #vRP.EXT.Group:getUsersByPermission(perm.extra.ex4)

	--special counts (owner/Admin/mod/all users)
	j_info.owner = #vRP.EXT.Group:getUsersByPermission(config.owner.perm)
	j_info.admin = #vRP.EXT.Group:getUsersByPermission(config.admin.perm)
	j_info.mod = #vRP.EXT.Group:getUsersByPermission(config.mod.perm)
	j_info.user = #vRP.EXT.Group:getUsersByPermission(config.user.perm)
	
	TriggerClientEvent("SB:getJobCount", source, j_info)
end

vRP:registerExtension(SB)

-- Check for version updates.
PerformHttpRequest("https://github.com/Boss-Man-Dev/vrp_scoreboard/tags", function(errorCode, result, headers)
    local tag = 'v1.6'
    if (string.find(tostring(result), tag) == nil) then
        print("\n\r\27[10;91m[vrp_scoreboard] WARNING: Your version is not up to date. Please make sure to update whenever possible.\n\r\27[0m")
    else
        print("\r\27[10;92m[vrp_scoreboard] You are running the latest version. Thanks for using a Boss Mod!\r\n\27[0m")

    end
end, "GET", "", "")