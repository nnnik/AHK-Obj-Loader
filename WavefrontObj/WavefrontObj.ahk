#Include %A_LineFile%\..\..\Rendering\Mesh.ahk
#Include %A_LineFile%\..\..\Errors\ErrorHandler.ahk
#Include %A_LineFile%\..\MaterialTemplate.ahk

class WavefrontObj
{
	
	__New( FileName, slang = "" )
	{
		This.setFile( FileName )
		This.setParsingSlang( slang )
		This.loadFromFile()
	}
	
	loadFromFile()
	{
		FileRead,FileContent,% This.getFile()
		If ( ErrorLevel )
			return new Error( "Error opening File: " . This.getFile() )
		If !FileContent
			return new Error( "Error empty File: " . This.getFile()  )
		This.clear()
		keyTable := This.getKeyTable()
		Loop,Parse,FileContent, `n
		{
			If ( A_LoopField ~= "^\d*$" )
				continue
			data := StrSplit( A_LoopField, " " )
			key := data.1
			data.1 := This
			If !( keyTable.HasKey( key ) )
				return new Error( "Error Parsing File at " . This.getFile() . " at line " . A_Index . ". Unknown Key" )
			If !IsFunc( keyTable[ key ] )
				continue
			fn := keyTable[ key ]
			If ( data.Length() < fn.MinParams )
				return new Error( "Error Parsing File at " . This.getFile() . " at line " . A_Index . ". Too few parameters for key " . key )
			If ( data.Length() > fn.MaxParams && !fn.isVariadic )
				return new Error( "Error Parsing File at " . This.getFile() . " at line " . A_Index . ". Too many parameters for key " . key )
			fn.call( data* )
		}
		This.cleanUp
	}
	
	clear()
	{
		This.cleanUp()
		This.setMeshes(    {} )
	}
	
	cleanUp()
	{
		This.setPositionVectors( [] )
		This.setTextureVectors(  [] )
		This.setNormalVectors(   [] )
		This.setMaterials( {} )
		This.deleteActiveMaterial()
		This.deleteActiveMesh()
	}
	
	addPositionVector( Vector )
	{
		This.getPositionVectors().Push( Vector )
	}
		
	addTextureVector( Vector )
	{
		This.getTextureVectors().Push(  Vector )
	}
	
	addNormalVector( Vector )
	{
		This.getNormalVectors().Push(   Vector )
	}
	
	addPolygon( polygon )
	{
		This.getActiveMesh().add( polygon )
	}
	
	addMaterial( materialName, material )
	{
		This.getMaterials()[ materialName ] := material
	}
	
	getFile()
	{
		return This.fileName
	}
	
	getSlang( slangName )
	{
		slangs := {(""):{ v:This.createPositionVector, vt:This.createTextureVector, vn:This.createNormalVector, g:This.setActiveMesh, f:This.parsePolygon, ("#"):"", mtllib:This.parseMtlFile, usemtl:This.setActiveMaterial, o:This.setActiveObj, s: This.setActiveSmoothingMode}}
		return slangs[ slangName ]
	}
	
	getKeyTable()
	{
		return This.slang
	}
	
	getActiveMesh()
	{
		if !( This.hasKey( "cMesh" ) )
			This.setActiveMesh( 1 )
		return This.cMesh
	}
	
	getActiveMaterial()
	{
		if !( This.hasKey( "cMaterial" ) )
			This.createMaterial( 1 ),This.setActiveMaterial( 1 )
		return This.cMaterial
	}
	
	getPositionVectors()
	{
		return This.posVectors
	}
	
	getPositionVector( vectorID )
	{
		if ( vectorID < 0 )
			vectorID := This.getPositionVectors().MaxIndex() + vectorID + 1
		return This.getPositionVectors()[ vectorID ]
	}
	
	getTextureVectors()
	{
		return This.texVectors
	}
	
	getTextureVector( vectorID )
	{
		if ( vectorID < 0 )
			vectorID := This.getTextureVectors().MaxIndex() + vectorID + 1
		return This.getTextureVectors()[ vectorID ]
	}
	
	getNormalVectors()
	{
		return This.normVectors
	}
	
	getNormalVector( vectorID )
	{
		if ( vectorID < 0 )
			vectorID := This.getNormalVectors().MaxIndex() + vectorID + 1
		return This.getNormalVectors()[ vectorID ]
	}
	
	getMaterials()
	{
		return This.materials
	}
	
	getMaterial( materialName )
	{
		return This.getMaterials()[ materialName ]
	}
	
	getMeshes()
	{
		return This.meshes
	}
	
	getMesh( meshName )
	{
		return This.getMeshes()[ meshName ]
	}
	
	createPositionVector( x, y, z, w=1 )
	{
		This.addPositionVector( New kVector3D( x, y, z, w) )
	}
	
	createTextureVector( x, y, w=0 )
	{
		This.addTextureVector( New kVector2D( x, y, w ) )
	}
	
	createNormalVector( x, y, z )
	{
		This.addNormalVector( New Vector3D( x, y, z ) )
	}
	
	createMesh( meshName )
	{
		This.getMeshes()[ meshName ] := New Mesh()
	}
	
	createMaterial( materialName )
	{
		This.getMaterials()[ materialName ] := New Material()
 	}
	
	setFile( FileName )
	{
		If !FileExist( FileName )
			return New Error( "No such File:" . FileName )
		This.FileName := FileName
	}
	
	setParsingSlang( keyTable )
	{
		If !IsObject( keyTable )
			This.slang := This.getSlang( keyTable )
		Else
			This.slang := keyTable
	}
	
	setActiveMesh( meshName )
	{
		if !This.getMesh( meshName )
			This.createMesh( meshName )
		This.cMesh := This.getMesh( meshName )
	}
	
	setActiveMaterial( materialName )
	{
		if !This.getMaterials().hasKey( materialName )
			return New Error( "No such Material" )
		This.cMaterial := This.getMaterials()[ materialName ]
	}
	
	setPositionVectors( posVectors )
	{
		return This.posVectors := posVectors
	}
	
	setTextureVectors( texVectors )
	{
		return This.texVectors := texVectors
	}
	
	setNormalVectors( normVectors )
	{
		return This.normVectors := normVectors
	}
	
	setMaterials( materials )
	{
		return This.materials := materials
	}
	
	setMeshes( meshes )
	{
		return This.meshes := meshes
	}
	
	deleteActiveMaterial()
	{
		This.Delete( "cMaterial" )
	}
	
	deleteActiveMesh()
	{
		This.Delete( "cMesh" )
	}
	
	parsePolygon( v1, v2, v3, v* )
	{
		poly := New Polygon( This.getActiveMaterial() )
		v.InsertAt( 1, v1, v2, v3 )
		For Each,sVert in v
		{
			oVert := StrSplit( sVert, "/" )
			pVert := New Vertex( This.getPositionVector( oVert.1 ) )
			If ( This.getTextureVector( oVert.2 ) )
				pVert.setTexture( This.getTextureVector( oVert.2 ) )
			If ( This.getNormalVector( oVert.3 ) )
				pVert.setNormal( This.getNormalVector( oVert.3 ) )
			poly.add( pVert )
		}
		This.addPolygon( poly )
	}
	
	parseMtlFile( filename )
	{
		mtl := New MaterialTemplateLibrary( filename )
		materials := mtl.getMaterials()
		For materialName, mat in materials
			This.addMaterial( materialName, mat )
	}
}

test := new WavefrontObj( "test.obj" )