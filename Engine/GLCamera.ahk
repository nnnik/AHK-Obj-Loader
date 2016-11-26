class Cam
{
	static Mode        := "Ortho"
	static BoxSize     := 1
	static ClipNear    := 0.001
	static ClipFar     := 100
	static FieldOfView := 90
	
	Init(Settings="")
	{
		For each, val in Settings
			This[each] := val
		THis.ApplyProjectionMatrix := Cam[This.Mode]
		This.Matrix := new Matrix()
		this.x := 0
		this.y := 0
		this.z := 0
		this.ry := 0
		this.rx := 0
	}
	
	Move(x,y,z)
	{
		this.x+=x
		this.y+=y
		this.z+=z
	}
	
	LocalMove(x,y,z)
	{
		static pt := (ATan(1)*4)/180
		this.x+=x*cos(this.rx*pt)+z*sin(this.rx*pt)
		this.y+=y
		this.z+=-x*sin(this.rx*pt)+z*cos(this.rx*pt)
	}
	
	Rotate(x,y)
	{
		this.ry+=y
		this.rx+=x
	}
	
	Frustrum(ratio)
	{
		GL.LoadIdentity()
		MaxY := This.ClipNear * Tan(This.FieldOfView * 0.00872664626)
		MaxX := MaxY * ratio
		GL.Frustrum(-MaxX ,MaxX ,-MaxY ,MaxY ,This.ClipNear ,This.ClipFar)
	}
		
	Ortho(ratio)
	{
		GL.Ortho(-This.Boxsize*ratio,This.BoxSize*Ratio,-This.BoxSize,This.BoxSize,-This.BoxSize,This.BoxSize)
	}
	
	Ortho2d(ratio)
	{
		GL.Ortho2d(-This.BoxSize*ratio,This.BoxSize*ratio,-This.BoxSize,This.BoxSize)
	}
	
	ApplyView()
	{
		GL.LoadIdentity()
		GL.Lightfv( 0, "Position", [0,0,0,1] )
		GL.Rotated(this.ry,1,0,0)
		GL.Rotated(this.rx,0,1,0)
		GL.Translated(this.z,this.y,this.x)
	}
	
	EnableLight()
	{
		GL.Enable( GL.Light.0 )
		This.hasLight := 1
	}
}