
//Derma configs
TBFY_LIB.style = {
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



surface.CreateFont("tbfy_theory_paneltext", {
	font = "Verdana",
	size = 17,
	weight = 1000,
	antialias = true,
})
surface.CreateFont("tbfy_theory_question", {
	font = "Verdana",
	size = 14,
	weight = 1000,
	antialias = true,
})
surface.CreateFont("tbfy_theory_answer", {
	font = "Verdana",
	size = 12,
	weight = 500,
	antialias = true,
})
surface.CreateFont("tbfy_theory_choose_text", {
	font = "Verdana",
	size = 13,
	weight = 500,
	antialias = true,
})
surface.CreateFont("tbfy_theory_text", {
	font = "Verdana",
	size = 25,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_header", {
	font = "Arial",
	size = 20,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_entname", {
	font = "Verdana",
	size = 12,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_buttontext", {
	font = "Verdana",
	size = 11,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_archives_button", {
	font = "Verdana",
	size = 12,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_archives_header", {
	font = "Verdana",
	size = 18,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_archives_subheader", {
	font = "Verdana",
	size = 13,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_archives_text", {
	font = "Verdana",
	size = 12,
	weight = 500,
	antialias = true,
})

surface.CreateFont("tbfy_computer_programtitle", {
	font = "Verdana",
	size = 17,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_computer_font_login", {
	font = "Arial",
	size = 22,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_computer_window_letters", {
	font = "Arial",
	size = 19,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_computer_font_login_text", {
	font = "Arial",
	size = 14,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_computer_cmdtitle", {
	font = "Consolas",
	size = 22,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_computer_amanager_text", {
	font = "Consolas",
	size = 16,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_computer_cmd", {
	font = "Consolas",
	size = 14,
	weight = 0,
	antialias = true,
})

surface.CreateFont("tbfy_computer_icon", {
	font = "Verdana",
	size = 11,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_country", {
	font = "Verdana",
	size = 14,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_config_name", {
	font = "Arial",
	size = 16,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_config_desc", {
	font = "Arial",
	size = 14,
	weight = 0,
	antialias = true,
})

surface.CreateFont("tbfy_computer_firewall_title", {
	font = "Arial",
	size = 20,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_computer_firewall", {
	font = "Arial",
	size = 16,
	weight = 0,
	antialias = true,
})

surface.CreateFont("tbfy_falkstore_title", {
	font = "Arial",
	size = 16,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_falkstore_desc", {
	font = "Arial",
	size = 14,
	weight = 0,
	antialias = true,
})

surface.CreateFont("tbfy_comp_admin_pinfo", {
	font = "Arial",
	size = 18,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_comp_overview_infotext", {
	font = "Arial",
	size = 14,
	weight = 1000,
	antialias = true,
})

surface.CreateFont("tbfy_comp_overview_infoval", {
	font = "Arial",
	size = 14,
	weight = 0,
	antialias = true,
})
