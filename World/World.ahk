class World
{
	
	
}


class PhysicalMesh
{
	
	__New( x, y, z, mesh, physicalData )
	{
		This.position  := new kVector3D( x, y, z, 1 )
		This.movement  := new Vector3d( 0, 0, 0 )
		This.spin      := new kVector3D( 0, 0, 0, 0 ) ;axis + Speed
		This.setForces( {} )
	}
	
	registerRelative(  )
	{
		
		
	}
	
}