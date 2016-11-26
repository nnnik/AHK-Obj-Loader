#Include %A_LineFile%\..\Polygon.ahk

class Mesh
{
	__New()
	{
		This.setPolygons( [] )
	}
	
	add( polygon )
	{
		This.getPolygons().Push( polygon )
	}
	
	getPolygons()
	{
		return This.polygons
	}
	
	getPolygon( index )
	{
		return This.getPolygons()[ index ]
	}
	
	setPolygons( polygons )
	{
		return This.polygons := polygons
	}
	
	setPolygon( index, polygon )
	{
		return This.getPolygons()[ index ] := polygon
	}
}