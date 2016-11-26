#Include %A_LineFile%\..\Vector.ahk
#Include %A_LineFile%\..\Material.ahk

class Vertex
{
	__New( position )
	{
		This.setPosition( position )
	}
	
	getTexture()
	{
		return This.texture
	}
	
	getPosition()
	{
		return This.position
	}
	
	getNormal()
	{
		return This.normal
	}
	
	setPosition( position )
	{
		return This.position := position
	}
	
	setTexture( texture )
	{
		return This.texture := texture
	}
	
	setNormal( normal )
	{
		return This.normal := normal
	}
}

class Polygon
{
	__New( material )
	{
		This.setVertices( [] )
		This.setMaterial( material )
	}
	
	add( newpVertex )
	{
		This.getVertices().Push( newpVertex )
	}
	
	getVertices()
	{
		return This.vertices
	}
	
	getVertice( index )
	{
		return This.getVertices()[ index ]
	}
	
	getMaterial()
	{
		return This.material
	}
	
	setVertices( vertices )
	{
		return This.vertices := vertices
	}
	
	setVertice( index, vertice )
	{
		return This.getVertices()[ index ] := vertice
	}
	
	setMaterial( material )
	{
		return This.material := material
	}
}