<%@ page import="java.text.DateFormat,java.util.Date,java.io.*,java.sql.*,javax.xml.XMLConstants,javax.xml.namespace.QName,javax.xml.parsers.*,javax.xml.xpath.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,javax.xml.transform.stream.StreamResult,javax.xml.parsers.*,org.w3c.dom.*,java.io.FileReader,java.io.BufferedReader,java.io.IOException,java.util.*,java.text.*,java.text.SimpleDateFormat;"%><%
	String ls_reqtype,ls_result="",ls_email,expression,ajax_data=null;
	String INST_PATH = "C:\\Program Files\\Apache Software Foundation\\Tomcat 5.5\\webapps\\Mail_Server\\";
	
	Connection con;
	Statement st;
	ResultSet rs;
	String user_name;
	user_name = (String) session.getAttribute("user_name");
	DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
	DocumentBuilder db = dbf.newDocumentBuilder();
	Transformer serializer = TransformerFactory.newInstance().newTransformer();
	StringWriter stw = new StringWriter();
	DataInputStream in = new DataInputStream(request.getInputStream());
	int formDataLength = request.getContentLength();
	if(formDataLength != -1) {
		byte dataBytes[] = new byte[formDataLength];
		int byteRead = 0;
		int totalBytesRead = 0;
		while (totalBytesRead < formDataLength) {
			byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
			totalBytesRead += byteRead;
		}
		ajax_data = new String(dataBytes);
	}
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://127.0.0.1/mail_server?user=root&password=tt");
	st=con.createStatement();

	XPath xpath = XPathFactory.newInstance().newXPath();
	
	ls_reqtype=request.getParameter("RequestType");
	if(ls_reqtype.equals("TIMER_REQUEST"))
	{
		org.w3c.dom.Document doc = db.parse(new File(INST_PATH+"XML\\Response.xml"));
		rs = st.executeQuery("select a.friend_user_name,a.status,b.status from chat_friends as a,chat_status as b where a.user_name = '"+user_name+"' and a.friend_user_name = b.user_name");
		if(rs.next()) {
			Element lo_status = (Element) xpath.evaluate("Response/Chat/Status",doc,XPathConstants.NODE);
			Element lo_friends,lo_friend;
			lo_friends = doc.createElement("Friends");
			lo_status.appendChild(lo_friends);
			do {
				lo_friend = doc.createElement("Friend");
				lo_friend.setAttribute("user_name",rs.getString(1));
				lo_friend.setAttribute("block_status",rs.getString(2));
				lo_friend.setAttribute("status",rs.getString(3));
				lo_friends.appendChild(lo_friend);
			} while(rs.next());
		}
		
		// For invitation
		rs = st.executeQuery("select from_user_name,message from chat_invitation where to_user_name = '"+user_name+"' and status='P'");
		if(rs.next()) {
			Element lo_invitations = (Element) xpath.evaluate("Response/Chat/Invitations",doc,XPathConstants.NODE);
			Element lo_request,lo_invitation;
			Statement st1 = con.createStatement();
			Statement st2 = con.createStatement();
			ResultSet rs1;
			
			lo_request = doc.createElement("Request");
			lo_invitations.appendChild(lo_request);
			do {
				lo_invitation = doc.createElement("Invitation");
				lo_request.appendChild(lo_invitation);
				lo_invitation.setAttribute("from",rs.getString(1));
				rs1 = st2.executeQuery("select concat(first_name,last_name) as name from registration where user_name='"+rs.getString(1)+"'");
				rs1.next();
				lo_invitation.setAttribute("from_name",rs1.getString(1));
				lo_invitation.appendChild(doc.createTextNode(rs.getString(2)));
				st1.executeUpdate("update chat_invitation set status='O' where from_user_name = '"+rs.getString(1)+"' and to_user_name='"+user_name+"'");
			}while(rs.next());
		}
		
		// For invitation response
		rs = st.executeQuery("select a.to_user_name,concat(b.first_name,b.last_name) as full_name,a.status from chat_invitation a,registration b where a.from_user_name = '"+user_name+"' and a.to_user_name = b.user_name and (a.status = 'A' or a.status = 'R')");
		if(rs.next()) {
			Element lo_invitations = (Element) xpath.evaluate("Response/Chat/Invitations",doc,XPathConstants.NODE);
			Element lo_response,lo_invitation;
			Statement st1 = con.createStatement();
			
			lo_response = doc.createElement("Response");
			lo_invitations.appendChild(lo_response);
			do {
				lo_invitation = doc.createElement("Invitation");
				lo_response.appendChild(lo_invitation);
				lo_invitation.setAttribute("user_name",rs.getString(1));
				lo_invitation.setAttribute("full_name",rs.getString(2));
				lo_invitation.setAttribute("status",rs.getString(3));
				st1.executeUpdate("delete from chat_invitation where from_user_name = '"+user_name+"' and to_user_name='"+rs.getString(1)+"'");
			} while(rs.next());
		}
		
		// For chat messages
		rs = st.executeQuery("select a.from_user_name,a.time,a.sl_no,a.message,b.nick_name from chat_message as a,chat_friends as b where a.to_user_name = '"+user_name+"' and a.status = 'U' and a.from_user_name=b.friend_user_name and a.to_user_name=b.user_name");
		if(rs.next()) {
			Element lo_messages = (Element) xpath.evaluate("Response/Chat/Messages",doc,XPathConstants.NODE);
			Element lo_message;
			Statement st1 = con.createStatement();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat sdf1 = new SimpleDateFormat("hh:mm:ss");
			String ls_date,ls_time;
			Date ld_date;
			Time lt_time;
			do {
				lo_message = doc.createElement("Message");
				lo_messages.appendChild(lo_message);
				lo_message.setAttribute("user_name",rs.getString(1));
				ld_date = rs.getDate(2);
				lt_time = rs.getTime(2);
				ls_date = sdf.format(ld_date);
				ls_time = sdf1.format(lt_time);
				lo_message.setAttribute("time",ls_date + " " +ls_time);
				lo_message.appendChild(doc.createTextNode(rs.getString(4)));
				lo_message.setAttribute("nick_name",rs.getString(5));
				st1.executeUpdate("update chat_message set status = 'R' where sl_no = "+rs.getString(3));
			} while(rs.next());
		}
		serializer.transform(new DOMSource(doc), new StreamResult(stw));
		out.print(stw.toString());
	}
	else if(ls_reqtype.equals("GetFriends")) {
		
		Element lo_friends,lo_friend;
		
		rs = st.executeQuery("select a.friend_user_name,a.status,b.status,a.nick_name from chat_friends as a,chat_status as b where a.user_name = '"+user_name+"' and a.friend_user_name = b.user_name");
		org.w3c.dom.Document doc = db.newDocument();
		lo_friends = doc.createElement("Friends");
		doc.appendChild(lo_friends);
		while(rs.next()) {
			lo_friend = doc.createElement("Friend");
			lo_friend.setAttribute("user_name",rs.getString(1));
			lo_friend.setAttribute("block_status",rs.getString(2));
			lo_friend.setAttribute("status",rs.getString(3));
			lo_friend.setAttribute("nick_name",rs.getString(4));
			lo_friends.appendChild(lo_friend);
		}
		rs=st.executeQuery("select status from chat_status where user_name = '"+user_name+"'");
		rs.next();
		lo_friends.setAttribute("status",rs.getString(1));
		serializer.transform(new DOMSource(doc), new StreamResult(stw));
		out.print(stw.toString());
	}
	
	else if (ls_reqtype.equals("SetStatus"))
	{
		String ls_status;
		
		ls_status=request.getParameter("status");
		st.executeUpdate("update chat_status set status="+ls_status+" where user_name='"+user_name+"'");
	}
	else if(ls_reqtype.equals("SetBlock"))
	{
		String ls_friend;
		ls_friend=request.getParameter("friend_name");
		st.executeUpdate("update chat_friends set status='B' where user_name='"+user_name+"' and friend_user_name='"+ls_friend+"'");
	}
	else if(ls_reqtype.equals("SetUnBlock"))
	{
		String ls_friend;
		ls_friend=request.getParameter("friend_name");
		st.executeUpdate("update chat_friends set status='A' where user_name='"+user_name+"' and friend_user_name='"+ls_friend+"'");
	}
	else if(ls_reqtype.equals("ChangeNickName"))
	{
		String friend_name,nick_name;
		friend_name=request.getParameter("friend_name");
		nick_name=request.getParameter("nick_name");
		st.executeUpdate("update chat_friends set nick_name='"+nick_name+"' where user_name='"+user_name+"' and friend_user_name='"+friend_name+"'");
	}	
	else if(ls_reqtype.equals("GetInvitation"))
	{
		FileReader inputStream = null;	
        try {
            inputStream = new FileReader(INST_PATH+"Files\\invite.txt");
            
            int c;
            while ((c = inputStream.read()) != -1) {
				ls_result +=  new Character((char)c).toString();
            }
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
        }
		out.print(ls_result);	
	} 
	else if(ls_reqtype.equals("SendInvitation"))
	{
		String ls_inv_message;
		ls_email = request.getParameter("email");
		rs = st.executeQuery("select * from chat_invitation where from_user_name='"+user_name+"' and to_user_name='"+ls_email+"'");
		if(rs.next()) {
			out.print("Invitation already exists.....");
			return;
		}
		st.executeUpdate("insert into chat_invitation values('"+user_name+"','"+ls_email+"','P','"+ajax_data+"')");
		out.print("OK");
	}
	else if(ls_reqtype.equals("CheckEmail")) {
		ls_email = request.getParameter("email");
		rs = st.executeQuery("select user_name from registration where user_name='"+ls_email+"'");
		if(rs.next()) {
			out.print("OK");
		} else {
			out.print("ERROR");
		}
	}
	else if(ls_reqtype.equals("GetInviteAccept")) {
		FileReader inputStream = null;	
        try {
            inputStream = new FileReader(INST_PATH+"Files\\invite_accept.txt");
            
            int c;
            while ((c = inputStream.read()) != -1) {
				ls_result +=  new Character((char)c).toString();
            }
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
        }
		out.print(ls_result);	
	}
	else if(ls_reqtype.equals("InvitationResponse")) {
		String ls_inv_status,ls_from;
		ls_inv_status = request.getParameter("inv_status");
		ls_from = request.getParameter("from");
		if(ls_inv_status.equals("A")) {
			String ls_nick_name = request.getParameter("nick_name");
			st.executeUpdate("update chat_invitation set status ='A' where from_user_name='"+ls_from+"' and to_user_name = '"+user_name+"'");
			st.executeUpdate("insert into chat_friends values('"+user_name+"','"+ls_from+"','A','"+ls_nick_name+"')");
		} else {
			st.executeUpdate("update chat_invitation set status ='R' where from_user_name='"+ls_from+"' and to_user_name = '"+user_name+"'");
		}
	}
	else if(ls_reqtype.equals("GetInviteResponse")) {
		FileReader inputStream = null;	
        try {
            inputStream = new FileReader(INST_PATH+"Files\\invite_response.txt");
            
            int c;
            while ((c = inputStream.read()) != -1) {
				ls_result +=  new Character((char)c).toString();
            }
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
        }
		out.print(ls_result);
	}
	else if(ls_reqtype.equals("InvitationResponseComplete")) {
		String ls_nick_name,ls_to;
		
		ls_nick_name = request.getParameter("nick_name");
		ls_to = request.getParameter("to");
		st.executeUpdate("insert into chat_friends values('"+user_name+"','"+ls_to+"','A','"+ls_nick_name+"')");
	}
	else if(ls_reqtype.equals("SendMessage")) 
	{
		String to_user;
		String date;
		to_user=request.getParameter("to_user");
		double sl_no=0;
		rs = st.executeQuery("select MAX(sl_no) from chat_message");
		if(rs.next()) {
			sl_no=rs.getDouble(1)+1;
		}
		java.util.Date now = new java.util.Date();
		String DATE_FORMAT = "yyyy-MM-dd hh:mm:ss";
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
		String strDateNew = sdf.format(now) ;
		st.executeUpdate("insert into chat_message values('"+to_user+"','"+user_name+"','"+ajax_data+"','U','"+strDateNew+"',"+sl_no+")");
		out.print(ajax_data);
	}
	else if(ls_reqtype.equals("SignOut")) {
		st.executeUpdate("update chat_status set status = 3 where user_name='"+user_name+"'");
		session.removeAttribute("user_name");
	}
%>