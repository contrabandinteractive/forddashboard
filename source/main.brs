sub Main()


	  m.di = CreateObject("roDeviceInfo")


  	screen = CreateObject("roSGScreen")
	  m.port = CreateObject("roMessagePort")
	  screen.setMessagePort(m.port)
	  scene = screen.CreateScene("Index")

		scene.backgroundUri = "pkg:/images/Blue-Background.jpg"
	  scene.backgroundColor="0000000000"
	  scene.backExitsScene = false

		m.global = screen.getGlobalNode() 'Creates (Global) variable MyField

		m.global.AddField("igfeed", "assocarray", false)

		m.global.AddField("igurltext", "string", false)

		m.global.AddField("previoususer", "string", false)
		m.global.previoususer = ""

		m.global.AddField("previousvehiclecode", "string", false)
		m.global.previoususer = "DEMO"

		m.global.AddField("searchtype", "string", false)
		m.global.searchtype = "user"

		m.global.AddField("errorexists", "string", false)
		m.global.errorexists = "false"

		m.global.AddField("masterRefreshToken", "string", false)
		m.global.AddField("masterAccessToken", "string", false)
		m.global.AddField("masterVehicleID", "string", false)
		m.global.AddField("modelName", "string", false)
		m.global.AddField("modelYear", "string", false)
		m.global.AddField("mileage", "string", false)
		m.global.AddField("fuelLevel", "string", false)
		m.global.AddField("latitude", "string", false)
		m.global.AddField("longitude", "string", false)
		m.global.AddField("tirePressureWarning", "string", false)

		m.global.AddField("onScreenSaverScreen", "string", false)
		m.global.onScreenSaverScreen = "false"

		m.global.AddField("thescreensize", "assocarray", false)
		m.global.thescreensize = m.di.GetDisplaySize()
		print m.global.thescreensize.w


  	getConfig()

	  screen.show()

	  print "Previous user"
	  print m.global.previoususer

	  while(true)
		msg = wait(0, m.port)
		msgType = type(msg)

		if msgType = "roSGScreenEvent"
		  if msg.isScreenClosed() then return
		end if
	  end while


end sub

function getConfig() as Object
    config = {}
    registrySection = CreateObject("roRegistrySection", "IGname")
    configString = registrySection.Read("config")
    if configString = ""
        print "getConfig. No config registry info found"
    else
        config = ParseJson(configString)
        if Type(config) <> "roAssociativeArray"
            print "getConfig. Expecting roAssociativeArray, found: "; Type(config)
            config = {}
        end if
        m.global.previoususer = config.key1
    end if
    return config
end function

sub showChannelSGScreen()
  screen = CreateObject("roSGScreen")
  m.port = CreateObject("roMessagePort")
  screen.setMessagePort(m.port)
  scene = screen.CreateScene("Index")

  scene.backgroundUri = ""
  scene.backgroundColor="0000000000"

    m.global = screen.getGlobalNode() 'Creates (Global) variable MyField
    m.global.AddField("MyField", "int", true)
    m.global.MyField = 0
    m.global.AddField("PicSwap", "int", true)
    m.global.PicSwap = 0

    m.global.AddField("igfeed", "assocarray", false)
    m.global.igfeed = m.json
    print m.global.igfeed

    m.global.AddField("thescreensize", "assocarray", false)
    m.global.thescreensize = m.di.GetDisplaySize()
    print m.global.thescreensize.w


  screen.show()

  while(true)
    msg = wait(0, m.port)
    msgType = type(msg)

    if msgType = "roSGScreenEvent"
      if msg.isScreenClosed() then return
    end if
  end while

end sub


Function HandleButtonPress(id as integer) as void
    if (id = m.buttons[0].ID)
        LoadJSONFile()
    else if (id = m.buttons[1].ID)
        LoadXMLFile()
    end if
End Function
