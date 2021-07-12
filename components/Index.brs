sub init()

	    m.taskRegistryNode = m.top.findNode("taskRegistry")
	    m.taskRelaunchSceneNode = m.top.findNode("relaunchScene")

      example = m.top.findNode("instructLabel")

      examplerect = example.boundingRect()
      centerx = (1280 - examplerect.width) / 2
      centery = (720 - examplerect.height) / 2
      example.translation = [ centerx, centery ]

      m.indexLabel = m.top.findNode("indexLabel")
	    m.simpleTask = CreateObject("roSGNode", "SimpleTask")
	    m.simpleTask.ObserveField("index", "onIndexChanged")

			m.hasSeenScreen = false

      showdialog()


end sub

function onIndexChanged() as void
    'str = "Iteration " + stri(m.simpleTask.index)
    'if m.global.errorexists = "true"
    	  'dialog = createObject("roSGNode", "Dialog")
		  'dialog.title = "Error"
		  'dialog.optionsDialog = true
		  'dialog.message = "Can't find user or hashtag. Try entering a username as-is, or a hashtag beginning with the # character."
		  'dialog.buttons=["OK"]
	  	 ' dialog.observeField("buttonSelected","dismissError")
		  'm.top.dialog = dialog
		  'm.top.setFocus(true)
    	  'showdialog()
    'else
    	launchScreenSaver()
    'end if
end function

sub showdialog()
	  m.global.onScreenSaverScreen = "false"
    keyboarddialog = createObject("roSGNode", "KeyboardDialog")
	  keyboarddialog.title = "Enter vehicle access code (you can get this from contrabandinteractive.com/ford or use DEMO):"
	  keyboarddialog.buttons=["OK"]
	  keyboarddialog.observeField("buttonSelected","confirmSelection")
	  'keyboarddialog.observeField("wasClosed","backBtnClosed")
	  keyboarddialog.text = "DEMO"
	  m.top.setFocus(true)
	  m.top.dialog = keyboarddialog
end sub

sub launchScreenSaver()

    	  m.top.overhang.visible = false
        m.top.panelset.visible = false

				if m.hasSeenScreen = true
        	m.top.removeChild(m.currentexample)
					print "tried to remove"
				end if

				m.currentexample = createObject("roSGNode", "StockPrice")
				m.top.appendChild(m.currentexample)

        m.currentexample.setFocus(true)



end sub

Sub confirmSelection()
            m.cFocused=m.top.dialog.buttonFocused
            If m.cFocused=0
               Print "OK"
               Print "Entry complete"
               m.top.dialog.close = true

			   m.global.igurltext = m.top.dialog.text
			   print m.global.igurltext
				 m.global.previousvehiclecode = m.top.dialog.text

			   config =  {
						  key1: m.global.igurltext
						  }
			   m.taskRegistryNode.write = config
			   m.taskRegistryNode.control = "RUN"

			   m.simpleTask.control = "RUN"

               'sleep(5000)

               'launchScreenSaver()
            End If
            If m.cFocused=1 Print"Cancel"
End Sub

Sub dismissError()
	m.top.dialog.close = true
	print "Dismissed"
	m.relaunchTask.control = "RUN"
End Sub

Sub backBtnClosed()
	print "Dialog was closed"
End Sub

function onKeyEvent(key as String, press as Boolean) as Boolean
	  handled = false
	  if press then
		if (key = "back") then
		  handled = false
		  print "Back button pressed"
			m.hasSeenScreen = true
			showdialog()

		  if m.global.onScreenSaverScreen = "true" then
			print "onScreenSaverScreen?"
		  	print m.global.onScreenSaverScreen
		  	'm.relaunchTask.control = "RUN"
		  else
		  	print "onScreenSaverScreen?"
		  	print m.global.onScreenSaverScreen
		  	'm.endProgramTask.control = "RUN"
		  end if

		end if
	  end if
	  return handled
end function
