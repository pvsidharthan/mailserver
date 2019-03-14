var chat_window,G_num=-1,G_count=0,z_index=0,GS_name=""; 
function initialise_window()
{
	var i,j;
	j=185;
	chat_window=new Array(3);
	for(i=0;i<3;i++)
	chat_window[i]=new Array(3);
	for(i=0;i<3;i++)
	{
		chat_window[i][0]=0;
		chat_window[i][1]="";
		chat_window[i][2]=j;
		j+=250;
	}
}

function display_chat_window_direct() {
	var lo_element;
	if(GS_browser == 'FF') {
		lo_element = arguments[0].target;
	} else {
		lo_element = window.event.srcElement;
	}
	while(lo_element.nodeName.toUpperCase() != "TR") {
		lo_element = lo_element.parentNode;
	}
	display_chat_window(lo_element.getAttribute("user_name"));

}

function Check_Enter_Key() {
	var lo_event,lo_element;
	var ls_name,ls_index,ls_chat_user;
	
	if(GS_browser == 'FF') {
		lo_event = arguments[0];
		lo_element = lo_event.target;
	} else {
		lo_event = window.event;
		lo_element = lo_event.srcElement;
	}
	if(lo_event.keyCode == 13) {
		ls_name=lo_element.id;
		ls_index=ls_name.indexOf("__");
		ls_chat_user=ls_name.substring(0,ls_index);
		send_chat_message(ls_chat_user);
	}
}

function display_chat_window(ars_user_name)
{
	var chat_msg_div,lo_send_msg_div,lo_current_msg_div,lo_chat_title;
	var lo_chat_text_area,lo_send_button,lo_elemen;
	var leftpx,flag=0;
	var ls_user_name;

	ls_user_name=ars_user_name;
	if(document.getElementById(ls_user_name+"__chat_msg_div"))
	{
		var str=document.getElementById(ls_user_name+"__min_icon").getAttribute("minimize");
		if(document.getElementById(ls_user_name+"__min_icon").getAttribute("minimize")=="false")
		{
			document.getElementById(ls_user_name+"__chat_text_area").focus();
			document.getElementById(ls_user_name+"__chat_msg_div").style.zIndex=++z_index;
		}
		else
		{
		GS_name=ls_user_name;
		minimize_chat();
		GS_name="";
		}
	}
	else
	{
			for(i=0;i<3;i++)
			{
				if(chat_window[i][0]==0)
				{
					flag=1;
					leftpx=chat_window[i][2];
					chat_window[i][0]=1;
					chat_window[i][1]=ls_user_name;
					break;
				}
			}
			if(flag==0)
			{
				var mul;
				G_count++;
				mul=parseInt(G_count/3,10)+1;
				G_num=((G_num+1)%3);
				leftpx=chat_window[G_num][2]+mul*25;
				if(leftpx>785)
				{
						leftpx=chat_window[G_num][2]-mul*20;
				}				
			}
		chat_msg_div=document.createElement("DIV");
		chat_msg_div.id=ls_user_name+"__chat_msg_div";
		chat_msg_div.style.width="215px";
		chat_msg_div.style.position="absolute";
		chat_msg_div.style.left=leftpx;
		chat_msg_div.style.top="315px";
		chat_msg_div.style.height="215px";
		chat_msg_div.style.zIndex="2"
		chat_msg_div.style.border="1px solid black";
		
		lo_chat_title=document.createElement("DIV");
		lo_chat_title.id=ls_user_name+"__chat_title_div";
		lo_chat_title.style.width="215px";
		lo_chat_title.style.position="absolute";
		lo_chat_title.style.left="0px";
		lo_chat_title.style.top="0px";
		lo_chat_title.style.display="block";
		lo_chat_title.style.height="15px";
		lo_chat_title.style.backgroundColor="#CC6600";
		
		var lo_label = document.createElement("label");
		lo_label.style.position = "absolute";
		lo_label.style.left = "6px";
		lo_label.style.top = "-2px";
		lo_label.style.fontSize = "10pt";
		lo_label.innerHTML = ls_user_name;
		lo_chat_title.appendChild(lo_label);
		
	//	lo_chat_title.style.border="1px solid black";
		
		lo_mini_icon=document.createElement("IMG");
		lo_mini_icon.id=ls_user_name+"__min_icon";
		lo_mini_icon.src="Images/minimize.gif";
		lo_mini_icon.style.position="absolute";
		lo_mini_icon.style.left="185px";
		lo_mini_icon.style.top="1px";
		lo_mini_icon.style.zIndex="1";
		lo_mini_icon.setAttribute("minimize","false");
		addEvent(lo_mini_icon,"click",minimize_chat);
		chat_msg_div.appendChild(lo_mini_icon);

		lo_close_icon=document.createElement("IMG");
		lo_close_icon.id=ls_user_name+"__close_icon";
		lo_close_icon.src="Images/close.gif";
		lo_close_icon.style.position="absolute";
		lo_close_icon.style.left="200px";
		lo_close_icon.style.top="1px";
		lo_close_icon.style.zIndex="1";
		addEvent(lo_close_icon,"click",cancel_chat);
		chat_msg_div.appendChild(lo_close_icon);	
		chat_msg_div.appendChild(lo_chat_title);
		
		
	/*	lo_title=document.createElement("DIV");
		lo_title.id=ls_user_name+"__title_div";
		lo_title.style.width="150px";
		lo_title.style.position="absolute";
		lo_title.style.left="0px";
		lo_title.style.top="0px";
		lo_title.style.height="15px";
		lo_title.style.backgroundColor="green";
	//	lo_title.style.border="1px solid black";
	
		chat_msg_div.appendChild(lo_title);*/
		
	
		lo_send_msg_div=document.createElement("DIV");
		lo_send_msg_div.id=ls_user_name+"__send_msg_div";
		lo_send_msg_div.style.overflow="auto";
		lo_send_msg_div.style.backgroundColor="wheat";
		lo_send_msg_div.style.display="block";
		lo_send_msg_div.style.height="105px";
		lo_send_msg_div.style.width="100%";
		lo_send_msg_div.style.position = "absolute";
		lo_send_msg_div.style.top = "15px";
	//	lo_send_msg_div.style.border="1px solid black";
		chat_msg_div.appendChild(lo_send_msg_div);
		
		
		
		lo_current_msg_div=document.createElement("DIV");
		lo_current_msg_div.id=ls_user_name+"__current_msg_div";
		lo_current_msg_div.style.width="100%";
		lo_current_msg_div.style.height="90px";
		lo_current_msg_div.style.top="119px";	
	//	lo_current_msg_div.style.border="1px solid black";
		lo_current_msg_div.style.display="block";
		lo_current_msg_div.style.position = "absolute";
		
		chat_msg_div.appendChild(lo_current_msg_div);
		
		lo_chat_text_area=document.createElement("TEXTAREA");
		lo_chat_text_area.id=ls_user_name+"__chat_text_area";
		lo_chat_text_area.style.width="100%";
		lo_chat_text_area.style.height="65px";
		lo_chat_text_area.style.display="block";
		lo_current_msg_div.appendChild(lo_chat_text_area);
		addEvent(lo_chat_text_area,"keypress",Check_Enter_Key);
				 
		lo_send_button=document.createElement("INPUT");
		lo_send_button.type="button";
		lo_send_button.setAttribute("value","Send");
		lo_send_button.id=ls_user_name+"__send_button";
		lo_send_button.style.position="absolute";
		lo_send_button.style.left="10px";
		lo_send_button.style.top="69px";
		lo_send_button.style.display="block";
		addEvent(lo_send_button,"click",send_chat_message_direct);
		lo_chat_text_area.focus();
		lo_current_msg_div.appendChild(lo_send_button);
		document.body.appendChild(chat_msg_div);
		document.getElementById(ls_user_name+"__chat_text_area").focus();
	}
}
function get_chat_user()
{
	var lo_element;
	var ls_string,ls_index,ls_name;
	if(GS_browser == 'FF') {
		lo_element = arguments.callee.caller.arguments[0].target;
	} else {
		lo_element = window.event.srcElement;
	}
	ls_name=lo_element.id;
	ls_index=ls_name.indexOf("__");
	ls_chat_user=ls_name.substring(0,ls_index);
	return ls_chat_user;
}

function send_chat_message_direct() {
	var lo_element;
	var ls_name,ls_index,ls_chat_user;
	
	if(GS_browser == 'FF') {
		lo_element = arguments[0].target;
	} else {
		lo_element = window.event.srcElement;
	}
	ls_name=lo_element.id;
	ls_index=ls_name.indexOf("__");
	ls_chat_user=ls_name.substring(0,ls_index);
	send_chat_message(ls_chat_user);
}


function send_chat_message(ars_chat_user)
{
	var ls_chat_user,ls_msg,ls_response;
	var lo_div;
	
	ls_chat_user=ars_chat_user;
	ls_msg=document.getElementById(ls_chat_user+"__chat_text_area").value;
	ls_response=AJAX(GS_server+"chat_handler.jsp?RequestType=SendMessage&to_user="+ls_chat_user,"",ls_msg);
	document.getElementById(ls_chat_user+"__chat_text_area").value="";
	lo_div=document.createElement("div");
	lo_div.style.display="block";
	lo_div.style.width="100%";
	lo_div.innerHTML= "Me : "+ls_msg;
	document.getElementById(ls_chat_user+"__send_msg_div").appendChild(lo_div);
	document.getElementById(ls_chat_user+"__send_msg_div").scrollTop = 10000000;
	
}

function cancel_chat()
{
	var ls_chat_user;
	var lo_element;
	ls_chat_user=get_chat_user();
	for(i=0;i<3;i++)
	{
		if(chat_window[i][1]==ls_chat_user)
		{
			chat_window[i][0]=0;
			break;
		}
	}
	lo_element=document.getElementById(ls_chat_user+"__chat_msg_div");
	lo_element.parentNode.removeChild(lo_element);
}

function minimize_chat()
{
	var ls_chat_user;
	if(GS_name=="")
	ls_chat_user=get_chat_user();
	else
	ls_chat_user=GS_name;
	if(document.getElementById(ls_chat_user+"__min_icon").getAttribute("minimize")=="false")
	{
		//RemoveEvent(document.getElementById(ls_chat_user+"__min_icon"),"click",minimize_chat);
		document.getElementById(ls_chat_user+"__min_icon").setAttribute("minimize","true");
		document.getElementById(ls_chat_user+"__send_msg_div").style.display="none";
		document.getElementById(ls_chat_user+"__current_msg_div").style.display="none";
		document.getElementById(ls_chat_user+"__chat_msg_div").style.top="543px";	
		document.getElementById(ls_chat_user+"__chat_msg_div").style.height="15px";	
		document.getElementById(ls_chat_user+"__min_icon").src="Images/maximize.gif";
		document.getElementById(ls_chat_user+"__min_icon").style.top="-2px";
	}
	else
	{
		document.getElementById(ls_chat_user+"__min_icon").setAttribute("minimize","false");
		document.getElementById(ls_chat_user+"__chat_msg_div").style.top="315px";	
		document.getElementById(ls_chat_user+"__chat_msg_div").style.height="215px";	
		document.getElementById(ls_chat_user+"__send_msg_div").style.display="block";
		document.getElementById(ls_chat_user+"__current_msg_div").style.display="block";
		document.getElementById(ls_chat_user+"__min_icon").style.top="1px";
		document.getElementById(ls_chat_user+"__min_icon").src="Images/minimize.gif";
		document.getElementById(ls_chat_user+"__chat_text_area").focus();
	}
}

function Display_Chat_Messages(aro_xml) {
	var lao_messages;
	var i;
	var ls_message,ls_from,ls_time,ls_nick_name,ls_content;
	var lo_div;
	lao_messages = XPath(aro_xml,"Response/Chat/Messages/Message");
	for(i = 0;i<lao_messages.length;i++) {
		ls_from = lao_messages[i].getAttribute('user_name');
		ls_time = lao_messages[i].getAttribute('time');
		ls_message = lao_messages[i].firstChild.nodeValue;
		ls_nick_name = lao_messages[i].getAttribute('nick_name');
		ls_content = ls_time +"<br>"+ls_nick_name+" : "+ ls_message;
		if(!document.getElementById(ls_from+"__chat_msg_div"))
		{
			display_chat_window(ls_from);
		}
		lo_div=document.createElement("div");
		lo_div.style.display="block";
		lo_div.style.width="100%";
		lo_div.innerHTML= ls_content;
		document.getElementById(ls_from+"__send_msg_div").appendChild(lo_div);
		document.getElementById(ls_from+"__send_msg_div").scrollTop = 10000000;
	}
}