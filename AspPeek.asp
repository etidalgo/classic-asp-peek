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
	
	function TogglePreset() {
	}
	
	$(document).ready(function(){
		RefreshVariableDisplay();
		// setInterval( RefreshVariableDisplay, 5000);
		$("div.checkField input[type=checkbox]").click(function() {});
	});

	</script>
	<style>
		.pageContent {
		
		}
		.header {
		}
		
		.entry {
			margin-left: 20px;
			width: 700px;
		}
		
		.entry div {
			display: inline-block;			
		}
		.keyName {
		}
		
		.keyValue {
			color: blue;
			margin-left: 50px;

		}
		
		.CommandContainer div {
			display: inline-block
		}
		
		.ParamsContainer {
			margin-top: 10px;
		}
		
		.KeyValuePairContainer div {
			display: inline-block
		}
		
		#VariablesDisplay {
			height: 600px;
			overflow: scroll;
		}
		
		#VariablesDiv {
			margin: 10px;
		}
		
		.ControlContainer {
			float: left;
			width: 40%;
		}
		
		.DisplayContainer {
			float: right;
			width: 55%;
			border: 1px solid #000000;
		}
	
	</style>
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
	<div class="keyField" ><input id="override_key_01" type="text" value="OverrideRecipient" readonly="readonly ></input></div>
	<div class="valueField" ><input id="override_value_01" type="text" value="" ></input></div>
</div>
</div>

</div>

<div class="DisplayContainer" >
	<div id="VariablesDisplay" >
	</div>
</div>
</body>
</html>
