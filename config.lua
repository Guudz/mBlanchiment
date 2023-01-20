Config					        = {}

Config = {
	TempsBlanchiment = 7, -- secondes
	Pourcentage = 50,

	job = {
		JobOrEveryone = "job", -- "job" or "everyone"
		jobName = "blanchisseur",
	},
	TypeDeBlanchisseur = {
		Ped = true,
		Marker = false,
	},
	ped = {
		Name = "cs_bankman",
		JamaisChanger = true,
		Animation = true,
		Animation_action = "WORLD_HUMAN_CLIPBOARD",
		PositionXYZH = vector4(-974.39, -1968.94, 12.19, 318.68),
		ShopRange = 1.5,
	},
	Marker = {
		Type = 1,
		Color = vector3(255, 0, 0),
		Opacity = 255,
		PositionXYZ = vector3(-974.39, -1968.94, 12.19),
		TailleXYZ = vector3(1.0, 1.0, 0.2),
		Saute = false,
		CameraSuivie = false,
		Tourne = true,
		ShopRange = 1.2,
	},
	Menu = {
		PosduMenuX = 0,
		PosduMenuY = 50,
		CouleurduMenu = {
			R = 0,
			G = 0,
			B = 0,
			A = 255,
		},
		Titre = "Blanchiment",
		SousTitre = "Combien veux-tu blanchir ?",
	},

	webhooks = {
		activate = true,
		link = "https://discord.com/api/webhooks/1010420384748806194/xi8YLprrHzteqwOdQIswazIStFiQ4o2ysfgVWoEAejQGnyUc-G57glVvcMoYiP3cmz8-"
	}
}

