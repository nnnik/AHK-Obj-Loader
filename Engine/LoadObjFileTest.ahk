#Include GL.ahk
#Include GLCamera.ahk
#Include GLGUI.ahk
#Include 3DMatrix.ahk
#Include GLDrawData.ahk
#Include AHKEngine.ahk
#Include ..\WavefrontObj\WavefrontObj.ahk

#Persistent
SetBatchLines,-1
SetMouseDelay,-1

objfiles := ""
Loop,%A_ScriptDir%/*.obj
	objfiles .=  A_LoopFileName . "|"
Gui,Select:Add,DropDownList,vobjFile gstartup,%objfiles%
Gui,Select:Show
return

startup:
Gui,Select:Submit
Gui,Select:Destroy
objCar  := new WavefrontObj( objFile )
Car := new DrawObject()
meshes := objCar.getMeshes()
For each,mesh in meshes
	Car.drawMesh( mesh )
Car.Finish()
Car.compile()


World.add( 0,0,-5, Car )

Engine.setLightMode( 1 )
Engine.SetZFunc("LEqual",1.0)
Engine.SetCam()
Engine.SetFPS(60)
Engine.SetInputFunc("UpdateInput")
Engine.StartUp()

Cam.enableLight()

Space::Engine.Toggle()
esc::Engine.Shutdown()



UpdateInput()
{
	static init
	if !init
	{
		MouseMove,A_ScreenWidth/2,A_ScreenHeight/2,0
		init := 1
		DllCall("ShowCursor","UInt",0)
	}
	MouseGetPos,newX,newY
	MouseMove,A_ScreenWidth/2,A_ScreenHeight/2,0
	Speed := 0.2 + (GetKeyState("x"))
	Cam.LocalMove((GetKeyState("w")-GetKeyState("s"))*Speed,( GetKeyState("Shift")-GetKeyState("Ctrl") )*Speed,(GetKeyState("a")-GetKeyState("d"))*Speed)
	Cam.Rotate(((newX-A_ScreenWidth/2)/24),((newY-A_ScreenHeight/2)/24))
	return 1
}