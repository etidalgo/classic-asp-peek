<%
    'Session data assignment, limited to assigning strings. Will need a way to define non-string objects. 
dim sessionVarName
dim sessionVarValue

dim command 
	command = Request.QueryString("Cmd") & ""
    'Response.Write "SessionID: " & Session.SessionID & "<BR><BR>"
If Request.ServerVariables("REMOTE_ADDR") = Request.ServerVariables("LOCAL_ADDR") then
    If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
        For Each strItem In Request.Form 
			If (command = "Remove") Then 
				Call RemoveVariable(strItem)
			Else
				Session(strItem) = ResolveType( Request.Form(strItem) )
			End If
        Next 
    End If
End If

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

Function RemoveVariable( varKey )
	Session.Contents.Remove(varKey)
End Function

%>
