<%@ page  import="com.sun.mail.imap.IMAPFolder,javax.mail.*,javax.activation.*,javax.mail.internet.*,java.util.*,java.lang.*,java.io.*"%><%
	String host="imap.gmail.com";
	String username = "p.lijith@gmail.com";
	String password = "zxcvbnma";
	Properties prop  = new Properties();
	Session ses1 = Session.getDefaultInstance(prop,null);
	Store store1 = ses1.getStore("imaps");
	store1.connect(host,username,password);
	Folder folder1 = store1.getFolder("INBOX");
	folder1.open(Folder.READ_ONLY);
	IMAPFolder inbox_folder = (IMAPFolder) folder1;
	Message msg = inbox_folder.getMessageByUID(25);
	if(msg == null) {
		out.print("Null is returned");
	} else {
		out.print("subject = "+msg.getSubject()+" UID = "+Long.toString(inbox_folder.getUID(msg)));
	}
	folder1.close(false);
	store1.close();
%>