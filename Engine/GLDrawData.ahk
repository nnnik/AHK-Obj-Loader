class World
{
	static Content := []
		
	Add( x ,y ,z ,DrawObject ,PhysicalObject="" ,Behaviour="" )
	{
		World.Content.Push([[x,y,z],DrawObject,PhysicalObject,Behaviour])
	}
	
	Draw()
	{
		Cam.ApplyView()
		For each,Obj in World.Content
		{
			GL.PushMatrix()
			GL.Translated((Obj.1)*)
			Obj.2.Draw()
			GL.PopMatrix()
		}
	}
}

class DrawObject
{
	__New()
	{
		
		this.DrawData    := []
		this.Draw        := ""
		this.Compile     := ""
		this.CompileDraw := ""
	}
	
	drawMesh( Mesh )
	{
		polygons := Mesh.getPolygons()
		For each, polygon in polygons
		{
			vertices := polygon.getVertices()
			This.setMaterial( polygon.getMaterial() )
			This.Begin( {3:4,4:7}[ vertices.maxIndex() ] ? {3:4,4:7}[ vertices.maxIndex() ] : 9 )
			For Each,vertice in vertices
			{
				This.Normal( vertice.getNormal().get() )
				This.Vector( vertice.getPosition().get() )
			}
			This.End()
		}
	}
	
	setMatrixMode( mode )
	{
		This.matrixIsEnabled := mode
		if ( mode )
			This.Matrix := New k3DMatrix()
		else
			This.Delete( "Matrix" )
	}
	
	getMatrixMode()
	{
		return This.matrixIsEnabled
	}
	
	enableMatrixMode()
	{
		if !( This.getMatrixMode() )
			This.setMatrixMode( 1 )
	}
	
	Begin(mode)
	{
		this.DrawData.Push([GL.Begin,[mode]])
	}
	
	End()
	{
		this.DrawData.Push([GL.End,[]])
	}
	
	Transform( vec )
	{
		if This.getMatrixMode()
			vec := This.Matrix.Vector(vec)
		vec2 := []
		Loop 3
			vec2[A_Index] := vec[A_Index]
		return vec2
	}
	
	Vector( vec )
	{
		This.DrawData.Push([GL.Vertex3d,This.Transform( vec )])
	}
	
	Normal(vec)
	{
		This.DrawData.Push([GL.Normal3d,This.Transform( vec )])
	}
	
	Translate(x,y,z)
	{
		This.enableMatrixMode()
		This.Matrix.Translate(x,y,z)
	}
	
	Rotate(angle,x,y,z)
	{
		This.enableMatrixMode()
		This.Matrix.Rotate(angle,x,y,z)
	}
	
	Scale(x,y,z)
	{
		This.enableMatrixMode()
		This.Matrix.Scale(x,y,z)
	}
	
	ColorRGB( R, G, B )
	{
		This.DrawData.Push([GL.Color3f,[R,G,B]])
	}
	
	setMaterial( Material )
	{
		This.DrawData.Push( [Gl.Materialfv,["Ambient", Material.getAmbientColor().get()]] )
		This.DrawData.Push( [Gl.Materialfv,["Diffuse", Material.getDiffuseColor().get()]] )
		This.DrawData.Push( [Gl.Materialfv,["Specular",Material.getSpecularColor().get()]] )
		This.DrawData.Push( [Gl.Materialfv,["shininess",[Material.getShininess()]]]  )
	}
	
	Compile()
	{
		This.List := GL.GenLists(1)
		GL.NewList(This.List,Gl.Compile)
		This.Draw()
		GL.EndList()
		This.Draw := This.Base.CompileDraw
	}
	
	Finish()
	{
		This.Vector    := ""
		This.Translate := ""
		This.Rotate    := ""
		This.Scale     := ""
		This.Color     := ""
		This.Finish    := ""
		This.drawMesh  := ""
		This.Remove("Draw")
		This.Remove("Compile")
	}
	
	CompileDraw()
	{
		Gl.CallList(this.list)
	}
	
	Draw()
	{
		For each, Command in this.DrawData
		{
			a := Command.2
			Command.1.Call(gl,a*)
		}
	}
}