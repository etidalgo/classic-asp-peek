<!-- #include file="aspJSON1.17.asp" -->
<%
'Usage: POST SessionCmd.asp
'Session data assignment, limited to assigning strings. Will need a way to define non-string objects. 
'Returns: JSON object
'{
'    "ALPHA": "ALPHA_VALUE  1462332824",
'    "BETA": "BETA_VALUE  1462332824",
'    "Key With Spaces": "Does this work?"
'}

dim command 
	command = Request.QueryString("Cmd") & ""

'Function pointers in classic asp
'	asp classic - vbscript: getref with parameter - Stack Overflow <http://stackoverflow.com/questions/10741292/vbscript-getref-with-parameter>
'GetRef Function <https://msdn.microsoft.com/en-us/library/ekabbe10%28v=vs.84%29.aspx?f=255&MSPPError=-2147217396>
dim CmdFunction	
	If (command = "Remove") Then 
		Set CmdFunction = GetRef ("Session_RemoveVariable")
	Else
		Set CmdFunction = GetRef ("Session_SetVariable")
	End If	

dim objJson
	Set objJson = new aspJSON

'Need a way to filter questionable requests, maybe whitelist certain Session variables	
'If Request.ServerVariables("REMOTE_ADDR") <> Request.ServerVariables("LOCAL_ADDR") then
'	Response.End
'End If	

    If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
        For Each strItem In Request.Form 
		
			Call CmdFunction( strItem, ResolveType( Request.Form(strItem) ) )
			With objJson.data
				.Add strItem, ResolveType( Request.Form(strItem) )
			End With			
        Next 
    End If

Response.Write objJson.JSONoutput()

'Really need to post proper boolean data
Function ResolveType(strItem)
    Select Case strItem
        Case "true"
            ResolveType = true
        Case "false"
            ResolveType = false
        Case Else
            ResolveType = strItem
    End Select
End Function  


'Runnable commands
Function WrapperFunction( cmdFunc ) 
    If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
        For Each strItem In Request.Form 
		
			Call cmdFunc( strItem, ResolveType( Request.Form(strItem) ) )
			With objJson.data
				.Add strItem, ResolveType( Request.Form(strItem) )
			End With			
        Next 
    End If
End Function

Function Session_SetVariable( varKey, varValue ) 
	Session(varKey) = varValue
End Function

Function Session_RemoveVariable( varKey, bogusArg )
	Session.Contents.Remove(varKey)
End Function

Function Session_Reset() 
	Session.Abandon
End Function
%>
