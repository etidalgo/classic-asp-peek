
// JavaScript Cookies <http://www.w3schools.com/js/js_cookies.asp>

// BozoTech (bzo)
var bzo = (function() {
	
	return {
		setCookie: 
			function (cname, cvalue, expiryDays) {
				var d = new Date();
				d.setTime(d.getTime() + (expiryDays*24*60*60*1000));
				var expires = "expires="+d.toUTCString();
				document.cookie = cname + "=" + cvalue + "; " + expires;
			},

		getCookie: 
			function (cname) {
				var name = cname + "=";
				var carray = document.cookie.split(';');
				for(var i = 0; i < carray.length; i++) {
					var c = carray[i];
					while (c.charAt(0) == ' ') {
						c = c.substring(1);
					}
					if (c.indexOf(name) == 0) {
						return c.substring(name.length, c.length);
					}
				}
				return "";
			}
		};
})();