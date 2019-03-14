var attach_array=new Array();
function Create_Table(ars_name,ars_parent,ars_xml) {
	var lo_table,lo_td,lo_tr,lo_element,lo_column;
	var lao_columns;
	var i;
	var ls_type;
	var lo_xml;	
	eval("lo_xml="+ars_xml);
	lo_table = document.createElement("TABLE");
	lo_table.setAttribute("row_nos","0");
	lo_table.style.border="1px solid black";
	lo_table.cellPadding = "0px";
	lo_table.cellSpacing = "0px"
	lo_table.setAttribute("xml_name",ars_xml);
	lo_table.id=ars_name;
	lo_tbody = document.createElement("TBODY");
	lo_tbody.id = ars_name + "__tbody"
	lo_table.appendChild(lo_tbody);
	lo_tr = document.createElement("TR");
	lo_tbody.appendChild(lo_tr);
	lao_columns = XPath(lo_xml,"Columns/Column")

	for(i=0;i<lao_columns.length;i++) {
		lo_column = lao_columns[i];
		lo_td = document.createElement("TD");
		if(i != (lao_columns.length - 1)) {
			lo_td.style.borderRight = "1px solid black";
		}
		lo_td.style.borderWidth = "1px";
		lo_td.style.width = lo_column.getAttribute("width");
		ls_type = lao_columns[i].getAttribute("type");
		switch(ls_type) {
			case "Check":
				lo_element = document.createElement("INPUT");
				lo_element.id = ars_name + "__"+lo_column.getAttribute("id");
				lo_element.type = "checkbox";
				lo_element.checked = false;
				lo_td.appendChild(lo_element);
				break;
			case "Text":
				lo_element = document.createElement("label");
				lo_element.id = ars_name + "__"+lo_column.getAttribute("id");
				lo_element.innerHTML = lo_column.getAttribute("caption");
				lo_td.appendChild(lo_element);

				break;
				
		}
		lo_tr.appendChild(lo_td);
	}
	document.getElementById(ars_parent).appendChild(lo_table);
}

function Insert_Row(ars_table) {
	var xml_name;
	var lo_xml,lo_tr,lo_td,lo_element,lo_table,lo_column;
	var lao_columns;
	var i;
	var ls_type;
	var ln_row_nos;
	
	lo_table = document.getElementById(ars_table);
	xml_name = lo_table.getAttribute("xml_name");
	ln_row_nos = parseInt(lo_table.getAttribute("row_nos"),10);
	ln_row_nos += 1;
	lo_table.setAttribute("row_nos",ln_row_nos)
	
	lo_tr = document.createElement("TR");
	eval("lo_xml="+xml_name);
	lao_columns = XPath(lo_xml,"Columns/Column");
	for(i=0;i<lao_columns.length;i++) {
		lo_column = lao_columns[i];
		lo_td = document.createElement("TD");
		lo_td.style.borderTop = "1px solid black";
		if(i != (lao_columns.length - 1)) {
			lo_td.style.borderRight = "1px solid black";
		}
		lo_tr.appendChild(lo_td);
		lo_td.style.width = lo_column.getAttribute("width");
		ls_type = lao_columns[i].getAttribute("type");
		switch(ls_type) {
			case "Check":
				lo_element = document.createElement("INPUT");
				lo_element.id = ars_table + "__"+ln_row_nos+"_"+lo_column.getAttribute("id");
				lo_element.type = "checkbox";
				lo_element.checked = false;
				lo_td.appendChild(lo_element);
				break;
			case "Text":
				lo_element = document.createElement("INPUT");
				lo_element.type = "Text";
				lo_element.style.borderStyle = "none";
				lo_element.style.borderWidth = "0px";
				lo_element.setAttribute("autocomplete","off");
				lo_element.readOnly=true;
				lo_element.tabIndex = 0;
				lo_element.id = ars_table + "__"+ln_row_nos+"_"+lo_column.getAttribute("id");
				lo_element.style.width = lo_column.getAttribute("width");
				lo_td.appendChild(lo_element);
				break;	
		}
	}
	document.getElementById(ars_table+"__tbody").appendChild(lo_tr);
	return ln_row_nos;
}

function set_value(ars_table,ars_row,ars_col,ars_value)
{
	document.getElementById(ars_table+"__"+ars_row+"_"+ars_col).value=ars_value;
}

function test1() {
	alert('Hello');
}

function inbox() {
	var lo_response;
	var ls_response;
	var lo_all_inbox;
	var lao_messages;
	var i,ln_row_no;
	
	GO_inbox = AJAX(GS_server+"mail_handler.jsp?RequestType=GetInboxTableXML","XML");
	Create_Table("inbox","container","GO_inbox");
	lo_all_inbox = AJAX(GS_server+"mail_handler.jsp?RequestType=GETALLINBOX","XML");
	lao_messages = XPath(lo_all_inbox,"Messages/Message");
	for(i=0;i<lao_messages.length;i++) {
		ln_row_no = Insert_Row("inbox");
		set_value("inbox",ln_row_no,"sender",lao_messages[i].getAttribute("sender"));
		set_value("inbox",ln_row_no,"subject",lao_messages[i].getAttribute("subject"));
		set_value("inbox",ln_row_no,"time",lao_messages[i].getAttribute("time"));
	}
//GO_inbox_timer = setInterval(Read_Inbox,1000);
	//Read_Inbox();
}

function Read_Inbox() {
	
}

function Add_CC() {
	var ls_clicked;
	ls_clicked = document.getElementById("cc_div").getAttribute('clicked');
	if(ls_clicked == 1) {
		return;
	}
	document.getElementById("cc_div").style.display = 'block';
	document.getElementById("cc_label").style.color = 'gray';
	document.getElementById("cc_div").setAttribute('clicked',"1");
}

function Add_BCC() {
	var ls_clicked;
	ls_clicked = document.getElementById("bcc_div").getAttribute('clicked');
	if(ls_clicked == 1) {
		return;
	}
	document.getElementById("bcc_div").style.display = 'block';
	document.getElementById("bcc_label").style.color = 'gray';
	document.getElementById("bcc_div").setAttribute('clicked',"1");
}

function Add_attachment() {
	var lo_event;
	if(GS_browser == 'FF') {
		lo_event = arguments[0];
	} else {
		lo_event = window.event;
	}
	document.getElementById("attachment_div").style.display = "block";
	document.getElementById("att_label").style.display = "none";
	Add_another_attach(lo_event);
}

function Add_another_attach() {
	var lo_file,lo_button;
	var ln_nos,ln_del_nos;
	var lo_tr,lo_td1,lo_td2;
	
	
	///////////////////////////////////////////////////////////////////////////sid
	var lo_element;
	if(GS_browser == 'IE') {
		lo_element = window.event.srcElement;
	} else {
		lo_element = arguments[0].target;
	}
	if(lo_element.type)
	{
		if(lo_element.value!="Remove")
		{
		var ln_no = parseInt(lo_element.id.substring(lo_element.id.lastIndexOf('_')+1),10);
		attach_array.push(ln_no);
		}
	}
		
	lo_file = document.createElement("INPUT");
	lo_file.type = "file";
	ln_nos = parseInt(document.getElementById("attach_file_div").getAttribute("attach_nos"),10);
	ln_nos++;
	document.getElementById("attach_file_div").setAttribute("attach_nos",ln_nos);
	ln_del_nos = parseInt(document.getElementById("attach_file_div").getAttribute("deleted_nos"),10);
	ln_del_nos++;
	document.getElementById("attach_file_div").setAttribute("deleted_nos",ln_del_nos);
	lo_file.name = "att_file_"+ln_nos;
	lo_file.id="att_file_"+ln_nos;
	lo_file.style.position = "relative";
	lo_file.style.display = "inline";
	lo_file.style.left = "80px";
	addEvent(lo_file,"change",Add_another_attach);
	lo_button = document.createElement("INPUT");
	lo_button.id="remove_button_"+ln_nos;
	lo_button.type="button";
	lo_button.value = "Remove";
	lo_button.style.position = "relative";
	lo_button.style.display = "inline";
	lo_button.style.left = "0px";
	addEvent(lo_button,"click",remove_attach);
	lo_tr = document.createElement("TR");
	lo_td1 = document.createElement("TD");
	lo_td1.style.width = "330px";
	lo_tr.appendChild(lo_td1);
	lo_td1.appendChild(lo_file);
	lo_td2 = document.createElement("TD");
	lo_td2.style.width="200px";
	lo_tr.appendChild(lo_td2);
	lo_td2.appendChild(lo_button);
	document.getElementById("attach_tbody").appendChild(lo_tr);
	
}

function remove_attach()
	{
		var lo_element,lo_file;
		var ls_id;
		var ln_del_nos,ln_attach_nos,ln_no;
		
		if(GS_browser == 'IE') {
			lo_element = window.event.srcElement;
			lo_event = window.event;
		} else {
			lo_element = arguments[0].target;
			lo_event = arguments[0];
		}
		lo_element.parentNode.parentNode.parentNode.removeChild(lo_element.parentNode.parentNode);
		ln_del_nos = parseInt(document.getElementById("attach_file_div").getAttribute("deleted_nos"),10);
		ln_del_nos--;
		document.getElementById("attach_file_div").setAttribute("deleted_nos",ln_del_nos);
		if(ln_del_nos == 0) {
			document.getElementById("att_label").style.display = "inline";
		}
		
		
		
		////////////////////////////////////////////////////////////sid
		var i;
		var ls_strid=parseInt(lo_element.id.substring(lo_element.id.lastIndexOf('_')+1),10);
		for(i=0;i<attach_array.length;i++)
		{
			if(attach_array[i]==ls_strid)
			{
				attach_array.splice(i,1);
			}
		}
		
		
		ln_attach_nos = parseInt(document.getElementById("attach_file_div").getAttribute("attach_nos"),10);
		ln_no = parseInt(lo_element.id.substring(lo_element.id.lastIndexOf('_')+1),10);
		if((ln_no == ln_attach_nos) && ln_del_nos != 0 ) {
			Add_another_attach(lo_event);
		}
		
}
//function to return the inner html (content of msg)
function return_innerstring()
{
var oRTE,inner_string;
if (document.all) 
{
	oRTE = frames['rte1'].document;
} else {
	oRTE = document.getElementById('rte1').contentWindow.document;
}
inner_string=oRTE.body.innerHTML;
return inner_string;
}
function submitForm() 
{
//make sure hidden and iframe values are in sync before submitting form
updateRTE('rte1'); //use this when syncing only 1 rich text editor ("rtel" is name of editor)
//updateRTEs(); //uncomment and call this line instead if there are multiple rich text editors inside the form.

////////////////sid
var inner_string=return_innerstring();
return true; //Set to false to disable form submission, for easy debugging.
}

function Send_Mail() {
	submitForm();
	var lo_form,lo_file;
	var ln_attach_nos;
	
	ln_attach_nos = parseInt(document.getElementById("attach_file_div").getAttribute("attach_nos"),10);
	if(ln_attach_nos > 0) {
		lo_file = document.getElementById('att_file_'+ln_attach_nos);
		lo_file.parentNode.removeChild(lo_file);
	}
	lo_form = document.getElementsByName("att_form")[0];
	lo_form.submit();
	
	send_body();
}

//sid for show compose screen
function test()
{
		var ls_string;
		var string;
	ls_string=AJAX(GS_server+"mail_handler.jsp?RequestType=compose&filename=Compose.txt","");
		document.getElementById("container").innerHTML=ls_string;
		writeRichText('rte1', '', 650, 250, true, false);
		string=return_string();
		document.getElementById("message_body").innerHTML=string;
		document.getElementById("att_username").value=GS_user;
		
}

function send_body()
{
	var ls_string,ls_subject,ls_body,ls_attach_string="",ls_inline_count=0;
	var to_user,cc_user,bcc_user,ln_attach_nos;
	var ls_short,ls_full;
	ln_attach_nos = parseInt(document.getElementById("attach_file_div").getAttribute("attach_nos"),10);
	to_user=document.getElementById("to").value;
	cc_user=document.getElementById("cc").value;
	bcc_user=document.getElementById("bcc").value;
	ls_subject=document.getElementById("subject").value;
	ls_body=return_innerstring();
	var i,j;
	var msg_body=ls_body;
	while(true)
	{
	j=msg_body.indexOf("<img src=\"cid:");
	if(j>0)
	{
		j+=14;
		msg_body=msg_body.substring(j);
		var k=msg_body.indexOf("\">");
		if(k<0)
		{
			break;
		}
		var inline_name=msg_body.substring(0,k);
		ls_attach_string+=inline_name+"$";
		ls_inline_count++;
		msg_body=msg_body.substring(k+1);
	}
	else
	break;
	}
	for(i=0;i<attach_array.length;i++)
	{
		ls_full=document.getElementById("att_file_"+attach_array[i]).value;
		var j=ls_full.lastIndexOf("\\");
		ls_short=ls_full.substring(j+1);
		ls_attach_string=ls_attach_string+ls_short+"$";
	}
	
	
	ln_attach_nos--;
	alert(ls_attach_string+"xxx"+ls_inline_count);
	var ls_string=AJAX(GS_server+"mail_handler.jsp?RequestType=SentMail&to_user="+to_user+"&cc_user=" +cc_user+"&bcc_user="+bcc_user+"&subject="+ls_subject+"&attach_no="+ln_attach_nos+"&attach_file_names="+ls_attach_string+"&inline_count="+ls_inline_count,"",ls_body);
	alert(ls_string);
//	window.open("main_page.jsp","_self");
}
function inline_image()
{
	var ls_string=AJAX(GS_server+"mail_handler.jsp?RequestType=compose&filename=inline_upload.txt","");
	var inline_div=document.createElement("DIV");
	inline_div.id="inline_div";
	inline_div.style.width="270px";
	inline_div.style.position="absolute";
	inline_div.style.left="270px";
	inline_div.style.top="315px";
	inline_div.style.height="70px";
	inline_div.style.zIndex="2"
	inline_div.style.border="1px solid black";
	inline_div.innerHTML=ls_string;
	document.body.appendChild(inline_div);
	
}
function cancel_inline()
{
	var ls_div=document.getElementById("inline_div");
	ls_div.parentNode.removeChild(ls_div);
}

//INCOMPLETE FUNCTION

var gs_uid=7;
function Read_Inbox() //for reply mail
{
	var subject,from_user,ls_string;
	if(gs_uid!=0)
	{
		ls_string=AJAX(GS_server+"mail_handler.jsp?RequestType=Reply&msg_uid="+gs_uid,"");
		alert(ls_string);
		//document.getElementById("message_body").innerHTML="";
		document.getElementById("container").innerHTML="";
		//insert fields into container
		test();
		var index=ls_string.indexOf('$');
		from_user=ls_string.substring(0,index);
		subject=ls_string.substring(index+1);
		document.getElementById("to").value=from_user;
		document.getElementById("subject").value="Re: "+subject;
	}
	
}
function search_mail()
{
	var mail_sub="xxx";
	
	var ls_string=AJAX(GS_server+"mail_handler.jsp?RequestType=Search&subject="+mail_sub,"");
	
	alert(ls_string);
}
fuction forward()
{
	var subject,from_user,ls_string;
	if(gs_uid!=0)
	{
		ls_string=AJAX(GS_server+"mail_handler.jsp?RequestType=Forward&msg_uid="+gs_uid,"");
		alert(ls_string);
	}
			
}



