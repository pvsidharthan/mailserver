<%@ page import="java.sql.*"%><%
String req_type;
String first_name,last_name,user_name,password,sec_qn,answer,rec_email,location,dob;
req_type = request.getParameter("RequestType");
Connection con;
Statement st;
ResultSet rs;
Class.forName("com.mysql.jdbc.Driver");
con=DriverManager.getConnection("jdbc:mysql://127.0.0.1/mail_server?user=root&password=tt");
st=con.createStatement();
if ( req_type.equals("Save"))
{
		first_name=request.getParameter("first_name");
		last_name=request.getParameter("last_name");
		user_name=request.getParameter("user_name");
		password=request.getParameter("password");
		sec_qn=request.getParameter("security_question");
		answer=request.getParameter("answer");
		rec_email=request.getParameter("recovery_email");
		location=request.getParameter("loc");
		dob=request.getParameter("dob");
		st.executeUpdate("insert into registration values('"+first_name+"','"+last_name+"','"+user_name+"','"+password+"','"+sec_qn+"','"+answer+"','"+rec_email+"','"+location+"','"+dob+ "')");
		st.executeUpdate("insert into chat_status values('"+user_name+"',3)");
		
		out.print("Success");
}	
else if( req_type.equals("Available"))
{
		String email;
		email = request.getParameter("email");
		rs = st.executeQuery("select * from registration where user_name = '"+email+"'");
		if(rs.next()) {
			out.print("ERROR");
		} else {
			out.print("OK");
		}
}
%>