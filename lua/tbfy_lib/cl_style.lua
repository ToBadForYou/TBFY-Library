
TBFY_LIB.style = {
	materials = {
		interactionCircle = Material("tbfy/lib/interaction_circle.png")
	},
	mainPanel = {
		font = "tbfy_mainpanel", 
		color = Color(45, 45, 45, 255),
		headerColor = Color(65, 65, 65, 255)
	},
	button = {
		font = "tbfy_button", 
		color = Color(55, 55, 55, 255),
		textColor = Color(255, 255, 255, 255),
		buttonHovering = Color(75, 75, 75, 200),
		buttonPressed = Color(150, 150, 150, 200),
	},
	toggleButton = {
		font = "tbfy_button", 
		color = Color(55, 55, 55, 255),
		textColor = Color(255, 255, 255, 255),
		colorON = Color(50,175,50,225),
		colorOFF = Color(200,50,50,225),
		textON = "Enabled",
		textOFF = "Disabled"
	},
	dScrollPanel = {
		color = Color(85, 85, 85, 255),
		barColor = Color(65, 65, 65, 255),
		barGripColor = Color(35, 35, 35, 255),
	},
	config = {
		fontID = "tbfy_config_id",
		fontDesc = "tbfy_config_desc",
		color = Color(55, 55, 55, 255),
		nthColor = Color(45, 45, 45, 255),
		textColor = color_white
	},

	// OLD will be removed
	MainPanelColor = Color(255,255,255,200),
	SecondPanelColor = Color(215,215,220,255),
	HeaderColor = Color(50,50,50,255),
	TabListColors = Color(215,215,220,255),
	ArchiveColor = Color(200,200,210,255),
	ArchiveColor2 = Color(210,210,220,255),
	ButtonColor = Color(50,50,50,255),
	ButtonColorHovering = Color(75,75,75,200),
	ButtonColorPressed = Color(150,150,150,200),
	ButtonOutline = Color(0,0,0,200),
	CB = Color(255,255,255,0),
	CBHover = Color(175,175,225,50),
	CBPress = Color(175,175,225,100),
	WindowBorder = Color(0,0,0,100),
	SoftwareBorderColor = Color(255,255,255,200),
	TopFrame = Color(255,255,255,180),
	CProgramBG = Color(215,215,215,225),
	WColor = Color(255,255,255,225),
	GBGColor = Color(50,175,50,225),
	RBGColor = Color(200,50,50,255),
	Padding = 5,
	HeaderH = 25,
}

surface.CreateFont("tbfy_mainpanel", {
	font = "Verdana",
	size = 17,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_button", {
	font = "Verdana",
	size = 11,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_config_addons", {
	font = "Verdana",
	size = 12,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_config_id", {
	font = "Verdana",
	size = 14,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_config_desc", {
	font = "Verdana",
	size = 11,
	weight = 0,
	antialias = true,
})

surface.CreateFont("tbfy_interaction_hud", {
	font = "bahnschrift",
	size = 20,
	weight = 1000,
	antialias = true,
})