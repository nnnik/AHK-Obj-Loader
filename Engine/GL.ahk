class GL 
{
	static Init := GL.GL()
	
	static ALPHA_TEST := 0x0BC0, BLEND := 0x0BE2, TEXTURE_2D := 0x0DE1, DEPTH_TEST := 0x0B71, CULL_FACE := 0x0B44
	static SRC_ALPHA := 0x0302, ONE_MINUS_SRC_ALPHA := 0x0303
	static DONT_CARE := 0x1100, FASTEST := 0x1101, NICEST := 0x1102
	static NEVER := 0x0200, LESS := 0x0201,EQUAL := 0x0202, LEQUAL := 0x0203, GREATER := 0x0204, NOTEQUAL := 0x0205, GEQUAL := 0x0206, ALWAYS := 0x0207
	static COLOR_BUFFER_BIT := 0x4000, DEPTH_BUFFER_BIT := 0x100
	static MODELVIEW := 0x1700, PROJECTION := 0x1701
	static TEXTURE_MAG_FILTER := 0x2800, TEXTURE_MIN_FILTER := 0x2801
	static NEAREST   := 0x2600, LINEAR := 0x2601
	static TRIANGLES := 0x4, QUADS := 0x7, 
	static COMPILE   := 0x1300
	static LIGHTING  := 0xB50, LIGHT := {0:0x4000,1:0x4001}, AMBIENT := 0x1200, DIFFUSE := 0x1201, SPECULAR := 0x1202, POSITION := 0x1203
	static SHININESS := 0x1601
	static COLORMATERIAL := 0xB57
	static FRONT := 0x404, BACK := 0x405, FRONTANDBACK := 0x408
	
	enableLogging()
	{
		GL := {base:GL}
	}
	
	GL()
	{
		GL.hgl  := DllCall("LoadLibrary", "str", "opengl32", "ptr")
		GL.hglu := DllCall("LoadLibrary", "str", "glu32", "ptr")
		GL.onExit := {base:{__delete:GL.Free()}}
	}
	
	Free()
	{
		DllCall("FreeLibrary", ptr, DllCall("GetModuleHandle", "str", "opengl32", "ptr"))
		DllCall("FreeLibrary", ptr, DllCall("GetModuleHandle", "str", "glu32", "ptr"))
	}
	
	Enable(cap)
	{
		return DllCall("opengl32\glEnable","UInt",cap)
	}
	
	BlendFunc(src,target)
	{
		return DllCall("opengl32\glBlendFunc","uint",Src,"uint",Target)
	}
	
	Hint(target,mode)
	{
		return DllCall("opengl32\glHint","UInt",target,"UInt",mode)
	}
	
	DepthFunc(mode)
	{
		return DllCall("opengl32\glDepthFunc","uint",mode)
	}
	
	ClearDepth(depth)
	{
		return DllCall("opengl32\glClearDepth","double",depth)
	}
	
	PolygonMode(sides,fillmode)
	{
		return DllCall("opengl32\glPolygonMode","UInt",sides,"UInt",fillmode)
	}
	
	Clear(mask)
	{
		return DllCall("opengl32\glClear","UInt",mask)
	}
	
	Viewport(x,y,w,h)
	{
		return DllCall("opengl32\glViewport","Int", x,"Int", y,"Int", w,"Int", h)
	}
	
	MatrixMode(mat)
	{
		return DllCall("opengl32\glMatrixMode","UInt",mat)
	}
	
	LoadIdentity()
	{
		return DllCall("opengl32\glLoadIdentity")
	}
	
	Frustrum( minX, maxX, minY, maxY, minZ, maxZ )
	{
		return DllCall("opengl32\glFrustum","Double", minX,"Double", maxX,"Double", minY,"Double", maxY,"Double", minZ,"Double", maxZ) ;keep in mind that minz needs to be larger than 0
	}
	
	Ortho( minX, maxX, minY, maxY, minZ, maxZ )
	{
		return DllCall("opengl32\glOrtho","Double", minX,"Double", maxX,"Double", minY,"Double", maxY,"Double", minZ,"Double", maxZ)
	}
	
	GenTextures(n,byref buffer)
	{
		VarSetCapacity(buffer,n*4)
		return DllCall("opengl32\glGenTextures","int", n, "ptr", &buffer)
	}
	
	GenTexture()
	{
		DllCall("opengl32\glGenTextures","int", 1, "int*", i )
		return i
	}
	
	BindTexture(tex,id)
	{
		return DllCall("opengl32\glBindTexture","int",tex,"int",id)
	}
	
	TexParami(tex,mode,filter)
	{
		return DllCall("opengl32\glTexParameteri","uint", tex,"uint", mode,"int", filter )
	}
	
	TexImage2d()
	{
		return DllCall("opengl32\glTexImage2D","UInt",0xDE1,"Int",0,"Int",4,"Int",Width,"Int",Height,"Int",0,"UInt",0x80E1,"UInt",0x1401,"UInt",Bits) 
	}
	
	Translated(x,y,z)
	{
		return DllCall("opengl32\glTranslated","Double",x ,"Double",y , "Double",z )
	}
	
	Rotated(angle,X,Y,Z)
	{
		return DllCall("opengl32\glRotated", "Double",angle ,"Double",X ,"Double",Y ,"Double",Z)
	}
	
	Begin(mode)
	{
		return DllCall("opengl32\glBegin", "UInt",mode)
	}
	
	End()
	{
		return DllCall("opengl32\glEnd")
	}
	
	Vertex3d(x,y,z)
	{
		return DllCall("opengl32\glVertex3d","double",x, "double",y, "double",z )
	}
	
	TexCoord2d(x,y)
	{
		return DllCall("opengl32\glTexCoord2d","double",x, "double",y )
	}
	
	wCreateContext(hDC)
	{
		return DllCall("opengl32\wglCreateContext", "ptr", hDC, "ptr")
	}
	
	wMakeCurrent(hDC,hRC)
	{
		return DllCall("opengl32\wglMakeCurrent", "ptr", hDC, "ptr", hRC)
	}
	
	GetError()
	{
		return DllCall("opengl32\glGetError","UInt")
	}
	
	Color3ub(R,G,B)
	{
		return DllCall("opengl32\glColor3ub","UChar",R ,"UChar",G ,"UChar",B )
	}
	
	Color3f(R,G,B)
	{
		return DllCall("opengl32\glColor3f","Float",R ,"Float",G ,"Float",B )
	}
	
	PushMatrix()
	{
		return DllCall("opengl32\glPushMatrix")
	}
	
	PopMatrix()
	{
		return DllCall("opengl32\glPopMatrix")
	}
	
	GenLists(n)
	{
		return DllCall("opengl32\glGenLists","UInt",n)
	}
	
	NewList(Id,mode)
	{
		return DllCall("opengl32\glNewList", "UInt",Id, "UInt",mode )
	}
	
	EndList()
	{
		DllCall("opengl32\glEndList")
	}
	
	CallList(Id)
	{
		DllCall("opengl32\glCallList", "UInt",Id)
	}
	
	MultMatrix(Mat)
	{
		static buf := "",Init := VarSetCapacity(buf,128,0)
		For y,Row in Mat
			For x,Value in Row
				NumPut(Value,buf,((x-1)*4+(y-1))*8,"Double")
		DllCall("opengl32\glMultMatrixd","ptr",&buf)
	}
	
	Lightfv( Light, Param, Value )
	{
		return DllCall( "opengl32\glLightfv", "UInt", ( This.Light.0 > Light ) ? Light + This.Light.0 : Light, "UInt", This.HasKey( Param ) ? This[ Param ] : Param, "Ptr",  IsObject( Value ) ? This.FloatArray( Value ) : Value )
	}
	
	Materialfv( Param, Value )
	{
		DllCall( "opengl32\glMaterialfv", "UInt", This.FRONTANDBACK, "UInt", This.HasKey( Param ) ? This[ Param ] : Param, "Ptr", IsObject( Value ) ? This.FloatArray( Value ) : Value )
	}
	
	Normal3d( x, y, z )
	{
		DllCall( "opengl32\glNormal3d","Double", x, "Double", y, "Double", z )
	}
	
	FloatArray( arr )
	{
		static floatArray
		VarSetCapacity( floatArray, arr.Length()*4, 0)
		For Each, val in arr
			NumPut( val, floatArray, Each*4-4, "float" )
		return &floatArray
	}
	
	CullFace( mode )
	{
		DllCall( "opengl32\glCullFace", "UInt", mode )
	}
}