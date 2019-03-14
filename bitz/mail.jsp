<html>
<body>
<form action="mail.jsp" id="form1">
<%@ page  import="javax.mail.*"%>
<%@ page  import="javax.activation.*"%>
<%@ page  import="javax.mail.internet.*"%>
<%@ page  import="java.util.*"%>
<%@ page  import="java.lang.*"%>
<%@ page  import="java.io.*"%>

<%
 try  
{
   	String SMTP_HOST_NAME = "smtp.gmail.com";
    int SMTP_HOST_PORT = 465;
    String SMTP_AUTH_USER = "sidharthanz@gmail.com";
    String SMTP_AUTH_PWD  = "14011990";
 
              
        Properties props= System.getProperties();
	    props.put("mail.transport.protocol", "smtps");
        props.put("mail.smtps.host", SMTP_HOST_NAME);
        props.put("mail.smtps.auth", "true");
        props.put("mail.smtps.quitwait", "false");
		
	    Session mailSession = Session.getDefaultInstance(props);
        mailSession.setDebug(true);
        Transport transport = mailSession.getTransport();
 
        MimeMessage message = new MimeMessage(mailSession);
        message.setSubject("SMTP-SSL");
        message.setContent("********a test", "text/plain");
  
        message.addRecipient(Message.RecipientType.TO,
        new InternetAddress("pvsidharthan@yahoo.com"));
 
        transport.connect
          (SMTP_HOST_NAME, SMTP_HOST_PORT, SMTP_AUTH_USER, SMTP_AUTH_PWD);
 
        transport.sendMessage(message,message.getRecipients(Message.RecipientType.TO));
        transport.close();
		out.println("send");
	  
  }
  catch(Exception e)
		{
	 out.println(e);
		}
		%>

</form>
</body>
</html>
