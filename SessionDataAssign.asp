<%
    'Session data assignment, limited to assigning strings. Will need a way to define non-string objects. 
dim sessionVarName
dim sessionVarValue
    'Stop
    Response.Write "SessionID: " & Session.SessionID & "<BR><BR>"
If Request.ServerVariables("REMOTE_ADDR") = Request.ServerVariables("LOCAL_ADDR") then
    If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
        For Each strItem In Request.Form 
            Session(strItem) = ResolveType( Request.Form(strItem) )
            Response.Write "Request.Form[" & strItem & "]: " & Request.Form(strItem) & "<BR>"
        Next 
    End If
End If
'Stop

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
%>
<html>
    <head></head>
    <body></body>

    </html>