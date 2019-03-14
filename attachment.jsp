<%@page import="java.util.*,java.util.Properties,javax.mail.*,javax.mail.internet.*,java.io.*,java.sql.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,javax.xml.transform.stream.StreamResult,javax.xml.parsers.*,org.w3c.dom.*,java.io.FileReader,com.sun.mail.imap.IMAPFolder,javax.mail.*,javax.activation.*,javax.mail.internet.*,java.io.BufferedReader,java.io.IOException;" %><%
		//edited by sid
		Connection con;
		Statement st;
		ResultSet rs;
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://127.0.0.1/mail_server?user=root&password=password");
		st=con.createStatement();
		int i=0;
	String user_name;
	//String user_name=request.getParameter("att_file_1");
	String user = (String) session.getAttribute("user_name");

	DataInputStream in = new DataInputStream(request.getInputStream());
	//we are taking the length of Content type data
	int formDataLength = request.getContentLength();
	byte dataBytes[] = new byte[formDataLength];
	int byteRead = 0;
	int totalBytesRead = 0;
	int ln_file_name_index=0;
	String contentType = request.getContentType();
	//this loop converting the uploaded file into byte code
	while (totalBytesRead < formDataLength) {
		byteRead = in.read(dataBytes, totalBytesRead,formDataLength);
		totalBytesRead += byteRead;
		}
	String file = new String(dataBytes);
	int index=file.indexOf('\n');
	user_name=file.substring(index);
	index=user_name.indexOf(13);
	user_name=user_name.substring(index);
	index=user_name.indexOf(13)+1;
	user_name=user_name.substring(index+1);
	user_name=user_name.substring(0,'\n');
	user_name=user_name.trim();
	while(true) {
		ln_file_name_index = file.indexOf("filename=\"",ln_file_name_index);
		if(ln_file_name_index < 0) {
			break;
		}
		//for saving the file name
		String saveFile = file.substring(ln_file_name_index + 10);
		saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
		saveFile = saveFile.substring(saveFile.lastIndexOf("\\")+ 1,saveFile.indexOf("\""));
		saveFile=user+"_"+saveFile;
		i++;
		int lastIndex = contentType.lastIndexOf("=");
		
		String boundary = contentType.substring(lastIndex + 1,contentType.length());
		int pos;
		//extracting the index of file 
		pos = file.indexOf("filename=\"",ln_file_name_index);
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		int boundaryLocation = file.indexOf(boundary, pos) - 4;
		int startPos = ((file.substring(0, pos)).getBytes()).length;
		int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
		// creating a new file with the same name and writing the content in new file
		FileOutputStream fileOut = new FileOutputStream("C:\\Program Files\\Apache Software Foundation\\Tomcat 6.0\\webapps\\Mail_Server\\Downloaded\\"+saveFile);
		fileOut.write(dataBytes, startPos, (endPos - startPos));
		fileOut.flush();
		fileOut.close();
		ln_file_name_index = endPos;
	}

%>