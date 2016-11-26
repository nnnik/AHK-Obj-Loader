class kVector3D
{
	
	__New( x, y, z, w )
	{
		This.x := x
		This.y := y
		This.z := z
		This.w := w
	}
	
	get()
	{
		return [ this.x, this.y, this.z, this.w ]
	}
	
	set( values )
	{
		this.x := values[ 1 ]
		this.y := values[ 2 ]
		this.z := values[ 3 ]
		this.w := values[ 4 ]
	}
	
}

class kVector2D
{
	
	__New( x, y, w )
	{
		This.x := x
		This.y := y
		This.w := w
	}
	
	get()
	{
		return [ this.x, this.y, this.w ]
	}
	
	set( values )
	{
		this.x := values[ 1 ]
		this.y := values[ 2 ]
		this.w := values[ 3 ]
	}
	
}

class Vector3D
{
	
	__New( x, y, z )
	{
		This.x := x
		This.y := y
		This.z := z
	}
	
	get()
	{
		return [ this.x, this.y, this.z ]
	}
	
	set( values )
	{
		this.x := values[ 1 ]
		this.y := values[ 2 ]
		this.z := values[ 3 ]
	}
	
}