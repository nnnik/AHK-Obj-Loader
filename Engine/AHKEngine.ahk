class Engine
{
	static CLEAR_BIT   := GL.COLOR_BUFFER_BIT
	static camModes    := {FPS:{Mode:"Frustrum",ClipFar:5000},CAD:{Mode:"Ortho",BoxSize:10}}
	
	setLightMode( enable = 1 )
	{
		if ( enable )
		{	
			GL.Enable( GL.Lighting )
			;GL.Enable( GL.COLORMaterial )
		}
	}
	
	SetZFunc(zFunc="",clear="")
	{
		GL.Enable(GL.DEPTH_TEST)
		This.CLEAR_BIT := This.CLEAR_BIT|GL.DEPTH_BUFFER_BIT
		If (zFunc)
			GL.DepthFunc(GL[zFunc])
		If (clear!="")
			GL.ClearDepth(clear)
	}
	
	SetCam(mode="FPS")
	{
		Cam.Init(This.camModes[mode])
	}
	
	SetInputFunc(Fn)
	{
		If (IsFunc(Fn)&&(IsObject(Fn)||IsObject(Fn := Func(Fn))))
			This.UpdateInput := Fn
	}
	
	StartUp()
	{
		GUI.Show()
		GUI.OnExit := Engine.Shutdown.Bind(Engine)
		This.Start()
	}
	
	Start()
	{
		This.Running := 1
		SetTimer,Redraw,% (1000/This.fps)
	}
	
	Stop()
	{
		This.Running := 0
		SetTimer,Redraw, Off
	}
	
	Toggle()
	{
		If This.Running 
			This.Stop()
		Else
			This.Start()
	}
	
	Shutdown()
	{
		This.Stop()
		ExitApp,0
	}
	
	SetFps(fps)
	{
		This.fps := fps
		if (This.Start)
			SetTimer,Redraw,% (1000/This.fps)
	}
	
	
	DrawFrame()
	{
		This.UpdateInput.Call()
		GL.Clear(Engine.CLEAR_BIT)
		World.Draw()
		Gui.SwapBuffers()
		return
		Redraw:
		Engine.DrawFrame()
		return		
	}
}
