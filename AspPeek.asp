<%@ Language=VBScript %>
<html>
<head>
	<title>AspPeek - ASP Application and Session Data</title>
	<script src="https://code.jquery.com/jquery-2.2.3.min.js" ></script>
    <script type="text/javascript">

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
	
	$(document).ready(function(){
		RefreshVariableDisplay();
		// setInterval( RefreshVariableDisplay, 5000);
		$("div.checkField input[type=checkbox]").click(TogglePreset);
		$("div.updateAction input[type=button]").click(UpdatePreset).prop("disabled", true);
	});
	
	</script>
	<link rel="stylesheet" type="text/css" href="styles.css" />

</head>
<body>
<p>Helper for Classic ASP - Session and Application value dump</p>
<div class="ControlContainer">
<p>Aims</p>
<ul>
<li>Batch session variables</li>
<li>Click and edit</li>
<li>Improve formatting</li>
<li>Delete</li>
<li>Single page app style - refresh section instead of page</li>
</ul>
<div class="CommandContainer" >
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
<div class="ParamsContainer">
<div id="override_01" class="KeyValuePairContainer">
	<div class="checkField" ><input id="override_check_01" type="checkbox" ></input></div>
	<div class="keyField" ><input id="override_key_01" type="text" value="OverrideRecipient" readonly="readonly" ></input></div>
	<div class="valueField" ><input id="override_value_01" value="ernest@financenow.co.nz" type="text" ></input></div>
	<div class="updateAction" ><input id="override_update_01" type="button" value="Update" ></input></div>
</div>
</div>

</div>

<div class="DisplayContainer" >
	<div id="VariablesDisplay" >
	</div>
</div>
</body>
</html>
