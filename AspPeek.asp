<%@ Language=VBScript %>
<%
	'A utility to view and insert session variables
	'Must be an ASP running in the same site as QIK to share the same session
	
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
<html>
	<head>
		<title>AspPeek - ASP Application and Session Data Ver 0.1</title>
		<script src="https://code.jquery.com/jquery-2.2.3.min.js" ></script>
		<script src="bzoCookie.js" ></script>

		<script type="text/javascript">
			<!-- 
		var overrideEmail = "<%=overrideEmail%>";
		var ccToMe = "<%=ccToMe%>";
		var REFRESH_INTERVAL_SECONDS = 120;
		var refreshIntervalId = 0; 

		function ToggleRefresh() {
			if (refreshIntervalId == 0) {
				refreshIntervalId = setInterval( RefreshVariableDisplay, REFRESH_INTERVAL_SECONDS * 1000);
			} else {
				clearInterval(refreshIntervalId);
				refreshIntervalId = 0;
			}
		}
	// JavaScript Cookies <http://www.w3schools.com/js/js_cookies.asp>
	function PostSessionCommand( url, data) {
		var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": url,
		  "method": "POST",
		  "headers": {
			"cache-control": "no-cache",
			"content-type": "application/x-www-form-urlencoded"
		  },
		  "data": data
		}

		$.ajax(settings).done(function (response) {
			console.log(response);
			RefreshVariableDisplay();
		});	
	}

	// .append() | jQuery API Documentation <http://api.jquery.com/append/>
	function SetSessionValues() {
		if ( $("#key01").val() == "" ) {
			return;
		}
		var data = { };
		data[$("#key01").val()] = $("#value01").val();
		PostSessionCommand( "./SessionCmd.asp?cmd=Assign", data );

		// Prefer execute on return from PostSessionCommand
		$("#key01").val("");
		$("#value01").val("");
	}

	function RemoveSessionValue() {
		if ( $("#key01").val() == "" ) {
			return;
		}
		var data = { };
		data[$("#key01").val()] = "";

		PostSessionCommand( "./SessionCmd.asp?cmd=Remove", data );

		// Prefer execute on return from PostSessionCommand
		$("#key01").val("");
		$("#value01").val("");
	}

	function RefreshVariableDisplay() {
		$("#VariablesDisplay").load("./DataDump.asp");
	}
	
	var UpdateKeyValue = function(container) {
		var varKey = $(container).find(".keyField input").val();
		var varValue = $(container).find(".valueField input").val();
		// 
		console.log("Key: " + varKey);
		console.log("value: " + varValue);
		bzo.setCookie(varKey, varValue, 365);
		var data = { };
		data[varKey] = varValue;
		PostSessionCommand( "./SessionCmd.asp?cmd=Assign", data );		
	}
	
	var DisableKeyValue = function(container) {
		var varKey = $(container).find(".keyField input").val();
		var data = { };
		data[varKey] = "";
		PostSessionCommand( "./SessionCmd.asp?cmd=Remove", data );
	}
	
	var UpdatePreset = function() {
		var container = $(this).closest(".KeyValuePairContainer");
		UpdateKeyValue(container);
	}
	
	var TogglePreset = function() {
		var container = $(this).closest(".KeyValuePairContainer");
		var isChecked = $(this).is(":checked");
		$(container).find(".updateAction input[type=button]").prop("disabled", !isChecked);
		if (isChecked) {
			UpdateKeyValue(container);
		} else {
			DisableKeyValue(container);
		}
	}
	function AddFeatureElement( keyName, keyValue ) {	
		var container = $("<div/>", { id: keyName, class: "KeyValuePairContainer" });
		
		container.append($("<div/>", { class: "checkField" }).append( $("<input/>", { type: "checkbox" }) ) );
		container.append($("<div/>", { class: "keyField" }).append($("<input/>", { type:"text", value: keyName, readonly: "readonly" })) );
		container.append($("<div/>", { class: "valueField" }).append($("<input/>", { type:"text", value: keyValue })) );
		container.append($("<div/>", { class: "updateAction" }).append($("<input/>", { type:"button", value: "Update" })) );
		container.appendTo("#OverrideSection");

		return container;
	}	

	$(document).ready(function(){
		RefreshVariableDisplay();
		$("#RefreshView").change(ToggleRefresh);

		$("#OverrideSection div.checkField input[type=checkbox]").click(TogglePreset);
		$("#OverrideSection div.updateAction input[type=button]").click(UpdatePreset).prop("disabled", true);
		$("#Dev_EmailOverride .valueField input").prop("value", overrideEmail);
		$("#Dev_CCToMe .valueField input").prop("value", ccToMe);
	});
	-->
		</script>
		<link rel="stylesheet" type="text/css" href="styles.css" />

	</head>
	<body>
		<p>Helper for Classic ASP - Session and Application value dump</p>
		<div class="ControlContainer">
			<p>Aims</p>
			<ul>
				<li>Batch add session variables</li>
				<li>Click and edit session variables</li>
				<li>Delete session variables</li>
				<li>Improve formatting</li>
				<li>Single page app style - refresh section instead of page</li>
			</ul>
			<div id="ApplicationCommands" class="CommandContainer" >
				<div><input type="button" value="Post Session Values" onclick="SetSessionValues()"></input></div>
				<div><input type="button" value="Clear Session Value" onclick="RemoveSessionValue()"></input></div>
				<div><input type="button" value="Reload" onclick="RefreshVariableDisplay()"></input></div>
			</div>
			<div class="ParamsContainer">
				<div id="kv_01" class="KeyValuePairContainer">
					<div class="keyField" ><input id="key01" type="text" value="" ></input></div>
					<div class="valueField" ><input id="value01" type="text" value="" ></input></div>
				</div>
			</div>
			<div id="ApplicationSettings" class="SettingsContainer" >
				<div class="Setting" ><input id="RefreshView" type="checkbox" ></input><label for="RefreshView">Refresh View</label></div>
			</div>

			<div id="OverrideSection" class="ParamsContainer">
				<p>Overrides / Developer Features</p>
				<div id="Dev_EmailOverride" class="KeyValuePairContainer">
					<div class="checkField" ><input id="override_check_01" type="checkbox" ></input></div>
					<div class="keyField" ><input id="override_key_01" type="text" value="Dev_EmailOverride" readonly="readonly" ></input></div>
					<div class="valueField" ><input id="override_value_01" value="" type="text" ></input></div>
					<div class="updateAction" ><input id="override_update_01" type="button" value="Update" ></input></div>
				</div>
				<div id="Dev_CCToMe" class="KeyValuePairContainer">
					<div class="checkField" ><input id="override_check_02" type="checkbox" ></input></div>
					<div class="keyField" ><input id="override_key_02" type="text" value="Dev_CCToMe" readonly="readonly" ></input></div>
					<div class="valueField" ><input id="override_value_02" value="" type="text" ></input></div>
					<div class="updateAction" ><input id="override_update_02" type="button" value="Update" ></input></div>
				</div>
			</div>

		</div>

		<div class="DisplayContainer" >
			<div id="VariablesDisplay" >
			</div>
		</div>
	</body>
</html>

