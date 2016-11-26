class Error
{
	
	static ErrorLog := []
	static Errors   := {}
	
	__New( String )
	{
		Error.Errors[ Object( This ) ] := Error.ErrorLog.Push( "[ " . A_NowUTC . " " . A_OSType . " " A_OSVersion . " " . A_AhkVersion . " ]:" . String )
		This.base        := ""
		This.handleError := Error.handleError
		This.__Delete    := Error.__Delete
		This.base        := Error
	}
	
	__Get( p* )
	{
		Throw "Unhandled Error: " . Error.ErrorLog[ Error.Errors[ Object( This ) ] ]
	}
	
	__Set( p* )
	{
		Throw "Unhandled Error: " . Error.ErrorLog[ Error.Errors[ Object( This ) ] ]
	}
	
	__Call( p* )
	{
		Throw "Unhandled Error: " . Error.ErrorLog[ Error.Errors[ Object( This ) ] ]
	}
	
	__Delete()
	{
		Throw "Unhandled Error: " . Error.ErrorLog[ Error.Errors[ Object( This ) ] ]
	}
	
	handleError()
	{
		Error.Errors.Remove( Object( This ) )
		This.base := ""
	}
	
	isError( obj )
	{
		return This.Errors[ Object( obj ) ]
	}
	
}