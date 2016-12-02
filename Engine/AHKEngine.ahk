class Engine
{
	static CLEAR_BIT   := GL.COLOR_BUFFER_BIT
	static camModes    := {FPS:{Mode:"Frustrum",ClipFar:5000},CAD:{Mode:"Ortho",BoxSize:10}}
	
	setCullMode( mode ) ;0-3
	{
		if !mode
			GL.disable( GL.Cull_Face )
		else
		{
			GL.enable( GL.Cull_Face )
			GL.CullFace([GL.BACK,GL.FRONT,GL.FRONTANDBACK][mode])
		}
	}
	
	setLightMode( enable = 1 )
	{
		if ( enable )
		{	
			GL.Enable( GL.Lighting )
			;GL.Enable( GL.COLORMaterial )
		}
	}
	
	setZFunc(zFunc="",clear="")
	{
		GL.Enable(GL.DEPTH_TEST)
		This.CLEAR_BIT := This.CLEAR_BIT|GL.DEPTH_BUFFER_BIT
		If (zFunc)
			GL.DepthFunc(GL[zFunc])
		If (clear!="")
			GL.ClearDepth(clear)
	}
	
	setCam(mode="FPS")
	{
		Cam.Init(This.camModes[mode])
	}
	
	setInputFunc(Fn)
	{
		If (IsFunc(Fn)&&(IsObject(Fn)||IsObject(Fn := Func(Fn))))
			This.UpdateInput := Fn
	}
	
	startUp()
	{
		GUI.Show()
		GUI.OnExit := Engine.Shutdown.Bind(Engine)
		This.Start()
	}
	
	start()
	{
		This.Running := 1
		SetTimer,Redraw,% (1000/This.fps)
	}
	
	stop()
	{
		This.Running := 0
		SetTimer,Redraw, Off
	}
	
	toggle()
	{
		If This.Running 
			This.Stop()
		Else
			This.Start()
	}
	
	shutdown()
	{
		This.Stop()
		ExitApp,0
	}
	
	setFps(fps)
	{
		This.fps := fps
		if (This.Start)
			SetTimer,Redraw,% (1000/This.fps)
	}
	
	
	drawFrame()
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
