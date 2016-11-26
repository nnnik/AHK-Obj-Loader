#Include %A_LineFile%\..\Vector.ahk

class Material
{
	
	__New()
	{
		This.setDiffuseColorRGB(   0.5, 0.5, 0.5 )
		This.setAmbientColorRGB(   0.5, 0.5, 0.5 )
		This.setSpecularColorRGB(  0,   0  , 0   )
		This.setShininess( 0 )
	}
	
	setDiffuseColor( Color )
	{
		return This.cDiffuse  := Color
	}
	
	setAmbientColor( Color )
	{
		return This.cAmbient  := Color
	}
	
	setSpecularColor( Color )
	{
		return This.cSpecular := Color
	}
	
	setShininess( shininess )
	{
		return This.shininess := shininess
	}
	
	setDiffuseColorRGB( R, G, B )
	{
		return This.setDiffuseColor( New kVector3D( R, G, B, 1 ) )
	}
	
	setAmbientColorRGB( R, G, B )
	{
		return This.setAmbientColor( New kVector3D( R, G, B, 1 ) )
	}
	
	setSpecularColorRGB( R, G, B )
	{
		return This.setSpecularColor( New kVector3D( R, G, B, 1 ) )
	}
	
	getDiffuseColor()
	{
		return This.cDiffuse
	}
	
	getAmbientColor()
	{
		return This.cAmbient
	}
	
	getSpecularColor()
	{
		return This.cSpecular
	}
	
	getShininess()
	{
		return This.shininess
	}
}