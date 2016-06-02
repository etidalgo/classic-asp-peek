<%@ Language=VBScript %>
<% 'Partial view
 %>

<div id="VariablesDiv">

<label class="header">SessionID: <%=Session.SessionID%></label> <div> Updated: <%=FormatDateTime(Now)%> </div> 
<BR/>
Auth_User: <%=Request.ServerVariables("AUTH_USER")%><BR/>
LOGON_USER: <%=Request.ServerVariables("LOGON_USER")%><BR/>
REMOTE_USER: <%=Request.ServerVariables("REMOTE_USER")%><BR/>
REMOTE_ADDR: <%=Request.ServerVariables("REMOTE_ADDR")%><BR/>
LOCAL_ADDR: <%=Request.ServerVariables("LOCAL_ADDR")%><BR/>

<label class="header">Application Variables - <% =Application.Contents.Count %> Found</label><BR/><BR/>
<div id="ApplicationValues" class="ValueBlock">
<%

Const VALUETYPE_OBJECT = "object"
Const VALUETYPE_ARRAY = "array"
Const VALUETYPE_NOTHING = "nothing"
Const VALUETYPE_STRING = "string"

Dim keyName
Dim keyValue
Dim valueType

For Each keyName In Application.Contents
    If ( IsObject( Application(keyName) ) ) Then
        keyValue = "[OBJECT]"
		valueType = VALUETYPE_OBJECT
    ElseIf ( IsArray( Application(keyName) ) ) Then
        keyValue = "[ARRAY]"
		valueType = VALUETYPE_ARRAY
    ElseIf ( IsNull(Application.Contents(keyName) ) ) Then
        keyValue = "[NOTHING]"
		valueType = VALUETYPE_NOTHING
    Else
        keyValue = cstr(Application.Contents(keyName))
		valueType = VALUETYPE_STRING
    End If
%>	
    <div id="AppValue_<%=keyName%>" class="ValueEntry">
		<div class="keyName"><%=keyName%></div> <div class="keyValue"><%=keyValue%></div>
	</div>
<%	
Next 
%>	
</div>

<hr>
<label class="header">Session Variables - <% =Session.Contents.Count %> Found</label><BR/><BR/>
<div id="SessionValues" class="ValueBlock">
<%	
For Each keyName In Session.Contents
    If ( IsObject( Session(keyName) ) ) Then
        keyValue = "[OBJECT]"
		valueType = VALUETYPE_OBJECT
    ElseIf ( IsArray( Session(keyName) ) ) Then
        keyValue = "[ARRAY]"
		valueType = VALUETYPE_ARRAY
    ElseIf ( IsNull(Session.Contents(keyName) ) ) Then
        keyValue = "[NOTHING]"
		valueType = VALUETYPE_NOTHING
    Else
        keyValue = cstr(Session.Contents(keyName))
		valueType = VALUETYPE_STRING
    End If
%>	
    <div id="SessionValue_<%=keyName%>" class="ValueEntry"><div class="keyName"><%=keyName%></div> <div class="keyValue"><%=keyValue%></div></div>
<%	
Next 
%>
</div>

</div>

