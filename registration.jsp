
<%@ page import="java.sql.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
  <TITLE> New Document </TITLE>
  <META NAME="Generator" CONTENT="EditPlus">
  <META NAME="Author" CONTENT="">
  <META NAME="Keywords" CONTENT="">
  <META NAME="Description" CONTENT="">
  <script language = 'javascript' src='common.js'></script>
  <script language = 'javascript'>
	function Save() {
		var first_name,last_name,user_name,password,security_question,answer,recovery_email,loc,dob;
		var ls_response;
		var lo_select;

		first_name = GetValue('first_name');
		last_name = GetValue('last_name');
		user_name = GetValue('user_name');
		password = GetValue('password');
		security_question = GetValue('security_question');
		answer = GetValue('answer');
		recovery_email = GetValue('recovery_email');
		if(!Validate_Email(recovery_email)) {
			alert("Invalid recovery email");
			document.getElementById("recovery_email").focus();
			return;
		}
		lo_select = document.getElementById('location');
		loc = lo_select.options[lo_select.selectedIndex].value;
		dob = GetValue('dob');
		ls_response  = AJAX("registration1.jsp?RequestType=Save&first_name="+first_name+"&last_name="+last_name+"&user_name="+user_name+"&password="+password+"&security_question="+security_question+"&answer="+answer+"&recovery_email="+recovery_email+"&loc="+loc+"&dob="+dob);
		alert(ls_response);
	}

	function Check_Available_Email(ars_email) {
		var ls_response;

		if(!Validate_User_Name(ars_email)) {
			return;
		}
		ls_response = AJAX("registration1.jsp?RequestType=Available&email="+ars_email);
		if(ls_response != 'OK') {
			document.getElementById('not_avail').style.display = 'inline';
		}
	}

	function hide_invalid() {
			document.getElementById('not_avail').style.display = 'none';
	}
	function Validate_User_Name(ars_email) {
		var re;
		re = /[~!@#$%^&*()-+?\<>/]/;
		if(re.test(ars_email)) {
			alert('Invalid character in user name');
			return false;
		}
		return true;
	}

	function Validate_Email(ars_email) {
		var re;

		re = /^.+@.+$/;
		if(!re.test(ars_email)) {
			return false;
		}	
		return true;
	}
  </script>
 </HEAD>

 <BODY bgcolor="RED" onload = "SetBrowser()">
	<form action="registration1.jsp" method="post">
		<label style='position:absolute;left:100px;top:50px;'>First Name</label>
		<input type = 'text' id='first_name' style='position:absolute;left:200px;width:300px;top:50px;'>
		<label style='position:absolute;left:100px;top:100px;'>Last Name</label>
		<input type = 'text' id='last_name' style='position:absolute;left:200px;width:300px;top:100px;'>
		<label style='position:absolute;left:100px;top:150px;'>User Name</label>
		<input type = 'text' id='user_name' style='position:absolute;left:200px;width:300px;top:150px;' onBlur="Check_Available_Email(this.value)" onFocus="hide_invalid()">
		<label id='not_avail' style='position:absolute;left:100px;top:180px;display:none;'>Not available</label>
		<label style='position:absolute;left:100px;top:200px;'>Password</label>
		<input type = 'password' id='password' style='position:absolute;left:200px;width:300px;top:200px;'>
		<label style='position:absolute;left:100px;top:250px;'>Security Question</label>
		<input type = 'text' id='security_question' style='position:absolute;left:200px;width:300px;top:250px;'>
		<label style='position:absolute;left:100px;top:300px;'>answer</label>
		<input type = 'text' id='answer' style='position:absolute;left:200px;width:300px;top:300px;'>
		<label style='position:absolute;left:100px;top:350px;'>Recovery E-Mail</label>
		<input type = 'text' id='recovery_email' style='position:absolute;left:200px;width:300px;top:350px;'>
		<label style='position:absolute;left:100px;top:400px;'>Location</label>
		<select type = 'text' id='location' style='position:absolute;left:200px;width:300px;top:400px;'>
		<%
		Connection con;
			Statement st;
			ResultSet rs;
			String name;
			Integer code;
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://127.0.0.1/mail_server?user=root&password=tt");
			st=con.createStatement();
			rs=st.executeQuery("select code,name from location");
			while(rs.next())
			{
				code=rs.getInt(1);
				name=rs.getString(2);
		%>
		
			<option value=<%=code%>><%=name%></option>		
		<%
			}
		
		%>
		
		
		
		
		</select>
		<label style='position:absolute;left:100px;top:450px;'>Date of birth</label>
		<input type = 'text' id='dob' style='position:absolute;left:200px;width:300px;top:450px;'>
		<input type='button' value="save" style='position:absolute;left:200px;top:500px;width:80px;' onclick='Save()'> 
	</form>
 </BODY>
</HTML>
