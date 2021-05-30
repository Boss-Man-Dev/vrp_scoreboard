--- Boss Man Discord: https://discord.gg/M3YRSy2

local cfg = {}

cfg.user_text = false				-- shows text just for users 
cfg.text = false					-- shows text instead of icon
cfg.color = true 					-- gives colors for users with owner/admin/mod perms
cfg.blank = true					-- users will have blank image place holder
cfg.d_color = "color:#white;"		-- default color aka white

--[[
	color: keep it as either color:#colorid; or color:colorname, (color:red;)
	image: can be link or local image your choice.
		reccomend images be between 36px x 40px & 40px x 50px
	text: pick whatever you want for a count name	
	Unemployed is set as citizen can be changed to whatever for user
		with no job
--]]
cfg.info = {
	owner = {
		color = "color:#f100ff;",
		img = "https://i.imgur.com/nlcsKJS.png",
		text = "Owner",
		perm = "!group.superadmin",
	},
	admin = {
		color = "color:#ff8800;",
		img = "https://i.imgur.com/J1eNgQE.png",
		text = "Admin",
		perm = "!group.admin",
	},
	mod = {
		color = "color:#00ff85;",
		img = "https://i.imgur.com/30hkNj5.png",
		text = "Mod",
		perm = "!group.mod",
	},
	user = {
		color = "color:#white;",
		img = "https://i.imgur.com/nlcsKJS.png",		--visible image (change to something)
		b_img = "https://i.imgur.com/5F0t6nO.png",		--blank image
		text = "User",
		perm = "!group.user",
	},
	default = {		-- forced per for those withoug a job
		"citizen"
	}
}

--[[
	default: all basic jobs for counter (change to anything you want and use right perm)
--]]
cfg.perms = {
	default = {
		job1 = "!group.safd",
		job2 = "!group.police",
		job3 = "!group.jdtc",
		job4 = "!group.taxi",
	},
	extra = {		--add opions (!group.(group name)) or permission name
		ex1 = "!group.malitia",
		ex2 = "!group.faa",
		ex3 = "!group.swm",
		ex4 = "",
	},
}

return cfg