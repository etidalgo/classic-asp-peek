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
	
dim CmdFunction	
	If (command = "Remove") Then 
		Set CmdFunction = GetRef ("Session_RemoveVariable")
	Else
		Set CmdFunction = GetRef ("Session_SetVariable")
	End If	

dim objJson
	Set objJson = new aspJSON
	
If Request.ServerVariables("REMOTE_ADDR") = Request.ServerVariables("LOCAL_ADDR") then
    If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
        For Each strItem In Request.Form 
		
			Call CmdFunction( strItem, ResolveType(strItem) )
			With objJson.data
				.Add strItem, ResolveType( Request.Form(strItem) )
			End With			
        Next 
    End If
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

Function Session_SetVariable( varKey, varValue ) 
	Session(varKey) = varValue
End Function

Function Session_RemoveVariable( varKey, bogusArg )
	Session.Contents.Remove(varKey)
End Function

%>
