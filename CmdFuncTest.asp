<%
dim CmdFunction

	Set CmdFunction = GetRef("WrapperA")
	Call CmdFunction ( GetRef("PrintAlpha") )
	
	Call WrapperB ( GetRef("PrintAlpha") )

	Call WrapperA ( GetRef("PrintBeta") )
	
	
Sub WrapperA( cmdFunction ) 
	Response.Write "WrapperA Start<br/>"
	Call cmdFunction( "WrapperA" )
	Response.Write "WrapperA End<br/>"
	
End Sub

Sub WrapperB( cmdFunction ) 
	Response.Write "WrapperB Start<br/>"
	Call cmdFunction( "WrapperB" )
	Response.Write "WrapperB End<br/>"
	
End Sub
	
Sub PrintAlpha( arg1 )
	Response.Write "Alpha [" & arg1 & "]<br/>"
End Sub

Sub PrintBeta( arg1)
		Response.Write "Beta [" & arg1 & "]<br/>"
End Sub

%>		