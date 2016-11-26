Class GemometryCanvas
{
	__New(Name)
	{
		This.Name := Name
		This.Color.Matrix := new Matrix()
	}
	__Delete()
	{
		If !()
	}
	
	DrawTriangle(Vertex1,Vertex2,Vertex3)
	{
		This.Draw(3,Vertex1,Vertex2,Vertex3)
	}
	DrawRectangle(Vertex1,Vertex1,Vertex3,Vertex4)
	{
		This.Draw(7,Vertex1,Vertex2,Vertex3,Vertex4)
	}
	DrawLine(Vertex1,Vertex2)
	{
		This.Draw(1,Vertex1,Vertex2)
	}
	Draw(Mode,Vertices*)
	{
		For Each,Vertex in Vertices
			This.Mode[Mode].Push(Vertex.AcquireContext(This))
	}
	
}

Class Vertex
{
	SetColorPortion(p*)
	{
		This.Color := p
	}
	SetPositionPortion(p*)
	{
		This.Position := p
	}
	SetTexturePortion(p*)
	{
		This.Texture := p
	}
	AcquireContext(Obj)
	{
		cVertex := new Vertex()
		For each, Value in This
			cVertex["Set" . each . "Portion"].( Obj[each].Matrix.Vector(Value)*)
	}
	
}