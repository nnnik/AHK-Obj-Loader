#Include GL.ahk
#Include GLCamera.ahk
#Include GLGUI.ahk
#Include 3DMatrix.ahk
#Include GLDrawData.ahk
#Include AHKEngine.ahk

#Persistent
SetBatchLines,-1
SetMouseDelay,-1

TriangleCount := 100

Triangle := new DrawObject()
Triangle.Begin(GL.Triangles)
Triangle.Scale(1,1,1)
Triangle.Rotate(120,0,0,1)
Triangle.ColorRGB(0,255,0)
Triangle.Vector([0,1,0])
Triangle.Rotate(120,0,0,1)
Triangle.ColorRGB(255,0,0)
Triangle.Vector([0,1,0])
Triangle.Rotate(120,0,0,1)
Triangle.ColorRGB(0,0,255)
Triangle.Vector([0,1,0])
Triangle.End()
Triangle.Finish()
Triangle.Compile()

Loop % TriangleCount
	World.Add(0,0,-A_Index*5,Triangle)

Engine.SetZFunc("LEqual",1.0)
Engine.SetCam()
Engine.SetFPS(60)
Engine.SetInputFunc("UpdateInput")
Engine.StartUp()

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
	Speed := 0.2 + (GetKeyState("Ctrl"))
	Cam.LocalMove((GetKeyState("w")-GetKeyState("s"))*Speed,0,(GetKeyState("a")-GetKeyState("d"))*Speed)
	Cam.Rotate(((newX-A_ScreenWidth/2)/24),((newY-A_ScreenHeight/2)/24))
	return 1
}