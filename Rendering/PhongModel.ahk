class basicPhong
{
	
	getDiffuseColor()
	{
		return This.diffuse
	}
	
	getAmbientColor()
	{
		return This.ambient
	}
	
	getSpecularColor()
	{
		return This.specular
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
	
	setDiffuseColor( color )
	{
		return This.diffuse  := color
	}
	
	setAmbientColor( color )
	{
		return This.ambient := color
	}
	
	setSpecularColor( color )
	{
		return This.specular := color
	}
}