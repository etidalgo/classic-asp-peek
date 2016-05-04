<!-- #include virtual="qik/util/asppeek/aspJSON1.17.asp" -->
<%
'Usage: POST SessionDataAssign.asp
'Returns: JSON object
'{
'    "ALPHA": "ALPHA_VALUE  1462332824",
'    "BETA": "BETA_VALUE  1462332824",
'    "Key With Spaces": "Does this work?"
'}

    'Session data assignment, limited to assigning strings. Will need a way to define non-string objects. 
dim sessionVarName
dim sessionVarValue

dim objJson
Set objJson = new aspJSON

    'Response.Write "SessionID: " & Session.SessionID & "<BR><BR>"
If Request.ServerVariables("REMOTE_ADDR") = Request.ServerVariables("LOCAL_ADDR") then
    If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
        For Each strItem In Request.Form 
            Session(strItem) = ResolveType( Request.Form(strItem) )
			With objJson.data
				.Add strItem, ResolveType( Request.Form(strItem) )
			End With
            'Response.Write "Request.Form[" & strItem & "]: " & Request.Form(strItem) & "<BR>"
        Next 
    End If
End If
'Stop

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

Function RemoveVariable( varKey )
	Session.Contents.Remove(varKey)
End Function

%>
