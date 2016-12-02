#Include %A_LineFile%\..\Vector.ahk
#Include %A_LineFile%\..\PhongModel.ahk

class Light extends basicPhong
{
	
	__New()
	{
		This.setPosition( new Vector3d( 0, 0, 0 ) )
		This.setDiffuseColorRGB( 1, 1, 1 )
		This.setAmbientColorRGB( 1, 1, 1 )
		This.setSpecularColorRGB( 1, 1, 1 )
	}
	
	setPosition( vec )
	{
		return This.position := vec
	}
	
	getPosition()
	{
		return This.position
	}
	
}

class LightSpot extends Light
{
	
	__New()
	{
		This.base.base.__New.Call( This )
		This.setSpotDirection( new Vector3d( 0, 0, 1 ) )
		This.setSpotCutoff( 90 )
	}
	
	setSpotDirection( vec )
	{
		return This.spotDirection := vec
	}
	
	setSpotCutOff( angle )
	{
		return This.spotCutOff := angle
	}
	
	getSpotDirection()
	{
		return This.spotDirection
	}
	
	getSpotCutOff()
	{
		return This.spotCutOff
	}
	
}

class DirectionalLight extends basicPhong
{
	
	__New()
	{
		This.setDirection( new Vector3d( 0, 0, 1 ) )
		This.setDiffuseColorRGB( 1, 1, 1 )
		This.setAmbientColorRGB( 1, 1, 1 )
		This.setSpecularColorRGB( 1, 1, 1 )
	}
	
	setDirection( vec )
	{
		return This.direction := vec
	}
	
	getDirection()
	{
		return This.direction
	}
	
}