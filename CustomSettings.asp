<%
	'Separates custom settings from AspPeek. Allows AspPeek to be more somewhat flexible...
	
	'OverrideEmail value hierarchy - dealer email from Session, then override email value from cookie
	Dim overrideEmail 
	If Request.Cookies("Dev_EmailOverride") <> "" Then
		overrideEmail = Request.Cookies("Dev_EmailOverride")
	Else
		overrideEmail = CStr(Session("DLR_EMAIL"))
	End If

	Dim ccToMe 
	If Request.Cookies("Dev_CCToMe") <> "" Then
		ccToMe = Request.Cookies("Dev_CCToMe")
	Else
		ccToMe = CStr(Session("DLR_EMAIL"))
	End If	
%>
		<script type="text/javascript">
		function Local_CustomSettings(){
			return { 
				Dev_EmailOverride: "<%=overrideEmail%>",
				Dev_CCToMe:"<%=ccToMe%>"
			};
		}
		</script>