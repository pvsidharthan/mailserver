<%@ page import="java.sql.*,java.lang.*"%><%
	String req_type;
	Connection con;
	Statement st;
	ResultSet rs;
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://127.0.0.1/mail_server?user=root&password=password");
	st=con.createStatement();
	req_type = request.getParameter("RequestType");
	if(req_type.equals("login")) {
		String uname,pwd;
		uname= (String)session.getAttribute("user_name");
		if(uname != null) {
			out.print("You are already logged in");
		} else {
			uname = request.getParameter("user_name");
			session.setAttribute("user_name",uname);
			session.setAttribute("att_number","1");
			pwd = request.getParameter("pwd");
			rs = st.executeQuery("select * from registration where user_name='"+uname+"' and password='"+pwd+"'");
			if(rs.next()) {
				st.executeUpdate("update chat_status set status = 1 where user_name = '"+uname+"'");
				out.print("OK");
				//response.sendRedirect("main_page.jsp");
			} else {
				out.print("ERROR");
			}
		}
		
	}
%>