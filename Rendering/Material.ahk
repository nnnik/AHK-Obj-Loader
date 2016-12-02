#Include %A_LineFile%\..\Vector.ahk
#Include %A_LineFile%\..\PhongModel.ahk

class Material extends basicPhong
{
	
	__New()
	{
		This.setDiffuseColorRGB(   0.5, 0.5, 0.5 )
		This.setAmbientColorRGB(   0.5, 0.5, 0.5 )
		This.setSpecularColorRGB(  0,   0  , 0   )
		This.setShininess( 0 )
	}
	
	setShininess( shininess )
	{
		return This.shininess := shininess
	}
	
	getShininess()
	{
		return This.shininess
	}
	
}