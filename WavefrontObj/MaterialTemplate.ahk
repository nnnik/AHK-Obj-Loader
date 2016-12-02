#Include %A_LineFile%\..\..\Rendering\Material.ahk
#Include %A_LineFile%\..\..\Errors\ErrorHandler.ahk

class MaterialTemplateLibrary 
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
	}
	
	clear()
	{
		This.setMaterials( {} )
		This.deleteActiveMaterial()
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
		slangs := {"":{ newmtl:This.CreateMaterial, kd:This.setDiffuse, ka:This.setAmbient, ks:This.setSpecular, Ns:This.setShininess, tf:"", Ni:"", illum:"",  ("#"):"", ke:"", d:"" }}
		return slangs[ slangName ]
	}
	
	getKeyTable()
	{
		return This.slang
	}
	
	getActiveMaterial()
	{
		if !( This.hasKey( "cMaterial" ) )
			return New Error( "Error parsing File: " . This.getFile() . " No Material has been defined yet" )
		return This.cMaterial
	}
	
	getMaterials()
	{
		return This.materials
	}
	
	getMaterial( materialName )
	{
		return This.getMaterials()[ materialName ]
	}
	
	createMaterial( materialName )
	{
		This.getMaterials()[ materialName ] := New Material()
		This.setActiveMaterial( materialName )
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
	
	setActiveMaterial( materialName )
	{
		if !This.getMaterials().hasKey( materialName )
			return New Error( "No such Material" )
		This.cMaterial := This.getMaterials()[ materialName ]
	}
	
	setAmbient(  R, G, B )
	{
		This.getActiveMaterial().setAmbientColorRGB(  R, G, B )
	}
	
	setDiffuse(  R, G, B )
	{
		This.getActiveMaterial().setDiffuseColorRGB(  R, G, B )
	}
	
	setSpecular( R, G, B )
	{
		This.getActiveMaterial().setSpecularColorRGB( R, G, B )
	}
	
	setShininess( sn )
	{
		This.getActiveMaterial().setShininess( sn )
	}
	
	setMaterials( materials )
	{
		return This.materials := materials
	}
	
	deleteActiveMaterial()
	{
		This.Delete( "cMaterial" )
	}
}