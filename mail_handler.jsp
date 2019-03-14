<%@ page import="java.util.*,java.util.Properties,javax.mail.*,javax.mail.internet.*,java.io.*,java.sql.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,javax.xml.transform.stream.StreamResult,javax.xml.parsers.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,java.lang.*,org.w3c.dom.*,java.io.FileReader,com.sun.mail.imap.IMAPFolder,javax.mail.*,javax.activation.*,javax.mail.internet.*,javax.mail.search.*,java.io.BufferedReader,java.io.IOException"%><%	
	
	String INST_PATH = "C:\\Program Files\\Apache Software Foundation\\Tomcat 6.0\\webapps\\Mail_Server\\";
	String req_type,l,ls_result = "",ajax_data=null;
   	String SMTP_HOST_NAME = "smtp.gmail.com";
    int SMTP_HOST_PORT = 465;
	DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
	DocumentBuilder db = dbf.newDocumentBuilder();
	//edited by sid
	String ls_username="";	
	Transformer serializer = TransformerFactory.newInstance().newTransformer();
	StringWriter stw = new StringWriter();	
	req_type = request.getParameter("RequestType");
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
	
	if(req_type.equals("compose")) {
	String fname=request.getParameter("filename");

		
        FileReader inputStream = null;
        try {
            inputStream = new FileReader(INST_PATH+"\\Files\\"+fname);            
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
 else if(req_type.equals("GetInboxTableXML")) {
		org.w3c.dom.Document doc = db.parse(new File(INST_PATH+"XML\\inbox_table.xml"));
		serializer.transform(new DOMSource(doc), new StreamResult(stw));
		out.print(stw.toString());
	}
 else if(req_type.equals("Reply")) {
		int uid=Integer.parseInt(request.getParameter("msg_uid"));
		String host="imap.gmail.com";
		String username = "sidharthanz@gmail.com";
		String password = "14011990";
		String ls_from,ls_from_name,ls_from_email,ls_date,ls_time;
		Properties prop  = new Properties();
		Session ses1 = Session.getDefaultInstance(prop,null);
		Store store1 = ses1.getStore("imaps");
		store1.connect(host,username,password);
		Folder folder1 = store1.getFolder("INBOX");
		folder1.open(Folder.READ_ONLY);
		IMAPFolder inbox_folder = (IMAPFolder) folder1;
		Message msg = inbox_folder.getMessageByUID(uid);
		InternetAddress []from_user=(InternetAddress[])msg.getFrom();
		String result_string=new String(from_user[0].getAddress());
		//String result_string=new String(from_user[0].toString());
		//String result_string=msg.toString(msg.getFrom());
		result_string+="$";
		result_string=result_string+msg.getSubject();
		out.print(result_string);
	}
	else if(req_type.equals("Forward")) {
		int uid=Integer.parseInt(request.getParameter("msg_uid"));
		String host="imap.gmail.com";
		String username = "sidharthanz@gmail.com";
		String password = "14011990";
		Properties prop  = new Properties();
		Session ses1 = Session.getDefaultInstance(prop,null);
		Store store1 = ses1.getStore("imaps");
		store1.connect(host,username,password);
		Folder folder1 = store1.getFolder("INBOX");
		folder1.open(Folder.READ_ONLY);
		IMAPFolder inbox_folder = (IMAPFolder) folder1;
		Message msg = inbox_folder.getMessageByUID(uid);
		InternetAddress []from_user=(InternetAddress[])msg.getFrom();
		String result_string=new String(from_user[0].getAddress());
		result_string+="$";
		result_string=result_string+msg.getSubject();
		out.print(result_string);
	}
	else if(req_type.equals("GetUserName"))
	{
		ls_username=(String)session.getAttribute("user_name");
		out.print(ls_username);
	}

	else if(req_type.equals("Search"))
	{
		String host="imap.gmail.com";
		String username = "pvsidharthan@gmail.com";
		String password = "14011990";
		Properties prop  = new Properties();
		Session ses1 = Session.getDefaultInstance(prop,null);
		Store store1 = ses1.getStore("imaps");
		store1.connect(host,username,password);
		IMAPFolder folder1 = (IMAPFolder)store1.getFolder("INBOX");
		folder1.open(Folder.READ_ONLY);
		
		String subject,from,return_date,date;
		//search operation begins...
		SearchTerm term=null;
		subject=request.getParameter("subject");
		from=request.getParameter("from");
				int or=Integer.parseInt(request.getParameter("cond"));
		if (subject != null)
		term=new SubjectTerm(subject);
		if (from != null) {
		FromStringTerm fromTerm = new FromStringTerm(from);
		if (term != null) {
		//If condition=1 then OR else AND
			if (or==1)
			term = new OrTerm(term, fromTerm);
			else
			term = new AndTerm(term, fromTerm);
			}
		else
		term = fromTerm;
	}
	return_date=request.getParameter("date");
	if (return_date!=null) {
	SimpleDateFormat df1 = new SimpleDateFormat( "dd/MM/yy" );
	java.util.Date dDate= df1.parse(return_date);
	ReceivedDateTerm dateTerm =new ReceivedDateTerm(ComparisonTerm.EQ,dDate);
	if (term != null) {
		if (or==1)
		term = new OrTerm(term, dateTerm);
		else
		term = new AndTerm(term, dateTerm);
		}
	else
	term = dateTerm;
	}	
	Message[] msgs = folder1.search(term);

////////////////////////////////////////////////////////
		org.w3c.dom.Document doc = db.newDocument();
		Element lo_messages = doc.createElement("Messages");
		String ls_from,ls_from_name,ls_from_email,ls_date,ls_time;
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat sdf1 = new SimpleDateFormat("hh:mm:ss");
		Date ld_date;
		Time lt_time;
		int i,j,k;
		for(i=0;i<msgs.length;i++) {	
			Element lo_message = doc.createElement("Message");
			ls_from = (msgs[i].getFrom()[0]).toString();
			if(ls_from.indexOf('<')>0)
			{
			     ls_from_name = ls_from.substring(0,(ls_from.indexOf('<')) - 1);
			     ls_from_email = ls_from.substring((ls_from.indexOf('<')) + 1,(ls_from.indexOf('>')));
			}
			else
			{
			     ls_from_name=ls_from;
		        	     ls_from_email=ls_from;
			}
			lo_message.setAttribute("sender_name",ls_from_name);
			lo_message.setAttribute("sender_email",ls_from_email);
			lo_message.setAttribute("subject",msgs[i].getSubject());
			ld_date = msgs[i].getSentDate();
			lt_time = new Time(ld_date.getTime());
			ls_date = sdf.format(ld_date);
			ls_time = sdf1.format(lt_time);
			lo_message.setAttribute("time",ls_date + " " +ls_time);
			lo_message.setAttribute("UID",Long.toString(folder1.getUID(msgs[i])));
			
			/////////////////////
			
			
			
			
			
			//////////////////////
			//Multipart mPart = (Multipart) msgs[i].getContent();
			//for(k=0;k<mPart.getCount();k++) {
				//Part part1 = mPart.getB
			//}
			Flags flags = msgs[i].getFlags();
			Flags.Flag[] sf = flags.getSystemFlags();
			for(j=0;j<sf.length;j++) {
				if (sf[j] == Flags.Flag.RECENT) {
					lo_message.setAttribute("flag","RECENT");
				} else if(sf[j] == Flags.Flag.SEEN) {
					lo_message.setAttribute("flag","SEEN");
				}
			}
			lo_messages.appendChild(lo_message);
		}
		doc.appendChild(lo_messages);
		serializer.transform(new DOMSource(doc), new StreamResult(stw));
		out.print(stw.toString());
////////////////////
	}
		
	else if(req_type.equals("SentMail"))
	{
		String user_name=(String)session.getAttribute("user_name");
		String SMTP_AUTH_USER = "sidharthanz@gmail.com";
		String SMTP_AUTH_PWD  = "14011990";
		String to_user=request.getParameter("to_user");
		String cc_user=request.getParameter("cc_user");
		String bcc_user=request.getParameter("bcc_user");    
		String subject=request.getParameter("subject");
		String attach_no=request.getParameter("attach_no");
		String attach_names=request.getParameter("attach_file_names");
		String inline=request.getParameter("inline_count");
		int inline_count=Integer.parseInt(inline);
		String att_name=new String(attach_names);
		int atno=Integer.parseInt(attach_no);
		to_user=to_user+",";
		cc_user=cc_user+",";
		bcc_user=bcc_user+",";
		
		int to=get_no_users(to_user);
		String[] to_user_array=new String[to];
		to_user_array=getNames(to_user,to);
				
        Properties props= System.getProperties();
        props.put("mail.transport.protocol", "smtps");
        props.put("mail.smtps.host", SMTP_HOST_NAME);
        props.put("mail.smtps.auth", "true");
        props.put("mail.smtps.quitwait", "false");
        Session mailSession = Session.getDefaultInstance(props);
        mailSession.setDebug(true);
        Transport transport = mailSession.getTransport();
        MimeMessage message = new MimeMessage(mailSession);
        message.setSubject(subject);
        		for(int i=0;i<to;i++)
		{
		message.addRecipient(Message.RecipientType.TO,new InternetAddress(to_user_array[i]));
		}
				
			BodyPart messageBodyPart = new MimeBodyPart();
			//message
		   	//messageBodyPart.setText(ajax_data);
            messageBodyPart.setContent(ajax_data, "text/html");
			
			//Multipart multipart = new MimeMultipart();
			MimeMultipart multipart = new MimeMultipart("related");
			multipart.addBodyPart(messageBodyPart);
			
			// attachment
			if(atno==-1)
			{
				atno=0;
			}
			for(int i=0;i<atno+inline_count;i++)
			{
				
				int q=attach_names.indexOf("$");
				if(q<0)
				break;
				String att_file_name=attach_names.substring(0,q);
				attach_names=attach_names.substring(q+1);
				messageBodyPart = new MimeBodyPart();
				String si=Integer.toString(i);
				String filename = INST_PATH+"Downloaded\\"+user_name+"_"+att_file_name;
				DataSource source = new FileDataSource(filename);
				messageBodyPart.setDataHandler(new DataHandler(source));
				messageBodyPart.setFileName(att_file_name);
				if(i<inline_count)
				{
					messageBodyPart.setHeader("Content-ID","<"+att_file_name+">");
				}
				multipart.addBodyPart(messageBodyPart);
				// Put parts in message
			}
			message.setContent(multipart);
		
			
			// Send the message
		
		transport.connect(SMTP_HOST_NAME, SMTP_HOST_PORT, SMTP_AUTH_USER, SMTP_AUTH_PWD);
		if(!cc_user.equals(","))
		{
			int cc=get_no_users(cc_user);
			String[] cc_user_array=new String[cc];
			cc_user_array=getNames(cc_user,to);
			for(int i=0;i<cc;i++)
			{
			message.addRecipient(Message.RecipientType.CC,new InternetAddress(cc_user_array[i]));
			}
			
		//transport.sendMessage(message,message.getRecipients(Message.RecipientType.CC));
		}
		if(!bcc_user.equals(","))
		{
			int bcc=get_no_users(bcc_user);
			String[] bcc_user_array=new String[bcc];
			bcc_user_array=getNames(bcc_user,to);
			for(int i=0;i<bcc;i++)
			{
			message.addRecipient(Message.RecipientType.BCC,new InternetAddress(bcc_user_array[i]));
			}			
		//transport.sendMessage(message,message.getRecipients(Message.RecipientType.BCC));
		}  
		transport.sendMessage(message,message.getAllRecipients());
		transport.close();
	/*	if(atno>0)
		{
			for(int i=0;i<atno;i++)
			{
				int q=att_name.indexOf("$");
				if(q<0)
				break;
				String att_file_name=att_name.substring(0,q);
				att_name=att_name.substring(q+1);
				String si=Integer.toString(i);
				String filename = INST_PATH+"Downloaded\\"+user_name+"_"+si+att_file_name;
				File f1=new File(filename);
				f1.delete();
			}
		}*/
	
		out.print("success");
		
}
%>
<%! String[] getNames(String str,int no)
	{
		String[] temp=new String[no];
		for(int i=0;i<no;i++)
		{
			int j=str.indexOf(',');
			temp[i]=str.substring(0,j);
			str=str.substring(j+1);
		}
		return temp;
	}
%>
<%! int get_no_users(String str)
	{
		int nos=0;
		for(int i=0;i<str.length();i++)
		{
			if (str.charAt(i)==',')
			nos++;
		}
		return nos;
	}
%>
	  
	
	
