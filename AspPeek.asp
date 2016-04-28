<%@ Language=VBScript %>
<html>
<head>
	<title>AspPeek - ASP Application and Session Data</title>
	<script src="https://code.jquery.com/jquery-2.2.3.min.js" ></script>
    <script type="text/javascript">

	function PostSessionValues() {
		if ( $("#key01").val() == "" ) {
			return;
		}
		var data = { };
		data[$("#key01").val()] = $("#value01").val();
		var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": "./SessionDataAssign.asp",
		  "method": "POST",
		  "headers": {
			"cache-control": "no-cache",
			"content-type": "application/x-www-form-urlencoded"
		  },
		  "data": data
		}

		$.ajax(settings).done(function (response) {
		  console.log(response);
		  $("#key01").val("");
		  $("#value01").val("");
			RefreshVariableDisplay();
		});	
	}

	function RefreshVariableDisplay() {
		$("#VariablesDisplay").load("./DataDump.asp");
	}
	
	$(document).ready(function(){
		RefreshVariableDisplay();
		// setInterval( RefreshVariableDisplay, 5000);
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
	<div><input type="button" value="Post Session Values" onclick="PostSessionValues()"></input></div>
	<div><input type="button" value="Reload" onclick="javascript:RefreshVariableDisplay();"></input></div>
</div>
<div class="ParamsContainer">
<div id="kv_01" class="KeyValuePairContainer">
	<div class="keyField" ><input id="key01" type="text" value="" ></input></div>
	<div class="valueField" ><input id="value01" type="text" value="" ></input></div>
</div>
</div>

</div>

<div class="DisplayContainer" >
	<div id="VariablesDisplay" >
	</div>
</div>
</body>
</html>
