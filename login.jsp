<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script language="javascript" src="common.js"></script>
	<script language="javascript">
		function SignIN() {
			var ls_uname,ls_pwd;
			ls_uname = document.getElementById("user_name").value;
			ls_pwd = document.getElementById("password").value;
			ls_result = AJAX("login_handler.jsp?RequestType=login&user_name="+ls_uname+"&pwd="+ls_pwd,"");
			switch(ls_result) {
				case "OK":
					window.open("main_page.jsp","_self");
				/*	if(GS_browser=="FF")
					location.replace("main_page.jsp");
					else
						location.href="main_page.jsp";*/
					break;
				case "ERROR":
					alert("Invalid user name or password");
					document.getElementById("user_name").focus();
					break;
				default:
					alert(ls_result);
					break;
			}
		}
	</script>
</head>

<body onload="SetBrowser()">
<form id="form1" name="form1" method="post" action="test.jsp">
  <label style="position:absolute; left: 732px; top: 107px;">User Name</label>
    	<input type="text" id="user_name" style="position:absolute; left: 825px; top: 106px;" value="lijith"/>
<label style="position:absolute; left: 744px; top: 150px;">Password</label>
       	<input type="password" id="password" style="position:absolute; left: 826px; top: 148px;" value="patoli"/>
    <input type="button" value="Sign in" onclick="SignIN()" style="position:absolute; left: 827px; top: 186px;"/>
</form>
</body>
</html>