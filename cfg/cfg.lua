local cfg = {}

cfg.text = false

-- custom images 40 px x 20 px (max size is 50 x 25
cfg.owner_color = "color:#f100ff;"
cfg.owner_img = "https://i.imgur.com/nlcsKJS.png"

cfg.admin_color = "color:#ff8800;"
cfg.admin_img = "https://i.imgur.com/J1eNgQE.png"

cfg.mod_color = "color:#00ff85;"
cfg.mod_img = "https://i.imgur.com/30hkNj5.png"

-- primary jobs
cfg.ems = "!group.emergency"
cfg.police = "!group.police"
cfg.taxi = "!group.taxi"
cfg.mechanic = "!group.repair"

-- Extra jobs (cardealer/estate)

cfg.cardealer = "!group.Car Dealer"
cfg.estate = "!group.PermGroupName"

-- Specail (owner/Admin/mod)
cfg.owner = "!group.superadmin"
cfg.admin = "!group.admin"
cfg.mod = "!group.mod"

return cfg