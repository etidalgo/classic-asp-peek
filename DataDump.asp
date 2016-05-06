<%@ Language=VBScript %>
<% 'Partial view
 %>

<div id="VariablesDiv">

<label class="header">SessionID: <%=Session.SessionID%></label> <div> Updated: <%=FormatDateTime(Now)%> </div> 
<BR><BR> 
Auth_User: <%=Request.ServerVariables("AUTH_USER")%><BR><BR>
REMOTE_ADDR: <%=Request.ServerVariables("REMOTE_ADDR")%><BR><BR>
LOCAL_ADDR: <%=Request.ServerVariables("LOCAL_ADDR")%><BR><BR>

<label class="header">Application Variables - <% =Application.Contents.Count %> Found</label><br><br>
<%

Dim keyName
Dim keyValue

For Each keyName In Application.Contents
    If ( IsObject( Application(keyName) ) ) Then
        keyValue = "&lt;object&gt;"
    ElseIf ( IsArray( Application(keyName) ) ) Then
        keyValue = "&lt;array&gt;"
    ElseIf ( IsNull(Application.Contents(keyName) ) ) Then
        keyValue = "&lt;nothing&gt;"
    Else
        keyValue = cstr(Application.Contents(keyName))
    End If
%>	
    <div class="entry"><div class="keyName"><%=keyName%></div> <div class="keyValue"><%=keyValue%></div></div><BR>
<%	
Next 
%>	
<hr>
<label class="header">Session Variables - <% =Session.Contents.Count %> Found</label><br><br>
<%	
For Each keyName In Session.Contents
    If ( IsObject( Session(keyName) ) ) Then
        keyValue = "&lt;object&gt;"
    ElseIf ( IsArray( Session(keyName) ) ) Then
        keyValue = "&lt;array&gt;"
    ElseIf ( IsNull(Session.Contents(keyName) ) ) Then
        keyValue = "&lt;nothing&gt;"
    Else
        keyValue = cstr(Session.Contents(keyName))
    End If
%>	
    <div class="entry"><div class="keyName"><%=keyName%></div> <div class="keyValue"><%=keyValue%></div></div><BR>
<%	
Next 
%>


</div>

