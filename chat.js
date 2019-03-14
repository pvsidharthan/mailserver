function change_status()
{
	var ls_table;
	var lo_div,lo_table;
	lo_table = document.getElementById("status_table");
	lo_table.style.display = "inline";
	HideContextMenu();
	GS_context_id = "status_table";
	if(GS_browser == 'FF') {
		arguments[0].stopPropagation();
	} else {
		window.event.cancelBubble = true;
	}
	
}

function set_status()
{
	var lo_element,lo_img;
	var ls_status;
	lo_img=document.getElementById("status_img");
	if(GS_browser == 'IE') {
		lo_element = window.event.srcElement;
	} else {
		lo_element = arguments[0].target;
	}
	while((lo_element.nodeName).toUpperCase() != "TR") {
		lo_element = lo_element.parentNode;
	}
	ls_status = lo_element.getAttribute('status');
	Change_Status_Image(lo_img,ls_status);
	document.getElementById("status_table").style.display="none";
	AJAX(GS_server+"chat_handler.jsp?RequestType=SetStatus&status="+ls_status,"");
}

function display_friend_context_menu() {
	var lo_event;
	var lo_element;
	var ls_blocked;
	var x,y;
	if(GS_browser == 'FF') {
		lo_event = arguments[0];
		lo_event.preventDefault();
		lo_element = lo_event.target;
	} else {
		window.event.returnValue = false;
		lo_element = window.event.srcElement;
		lo_event = window.event;
	}

	while(lo_element.nodeName.toUpperCase() != "TR") {
		lo_element = lo_element.parentNode;
	}
	ls_blocked = lo_element.getAttribute("blocked");
	if(ls_blocked == 'Y') {
		document.getElementById("friend_block").innerHTML = "Unblock";
	} else {
		document.getElementById("friend_block").innerHTML = "Block";
	}
	GS_current_friend = lo_element.getAttribute("user_name");
	document.getElementById("friend_context").style.left = lo_event.clientX;
	document.getElementById("friend_context").style.top = lo_event.clientY;
	document.getElementById("friend_context").style.display = "inline";
	HideContextMenu();
	GS_context_id = "friend_context";
}

function HideContextMenu() {
	if(GS_context_id) {
		document.getElementById(GS_context_id).style.display = "none";
		GS_context_id = null;
	}
}

function load_friend_list() {
	var lo_friends;
	var lao_friends;
	var i;
	var ls_status,ls_block_status,ls_user_status,ls_block_status,ls_nick_name;
	
	lo_friends= AJAX(GS_server+"chat_handler.jsp?RequestType=GetFriends","XML");
	lao_friends = XPath(lo_friends,"Friends/Friend");
	//the following line is for updating status of logged user while refreshing
	ls_user_status = lo_friends.documentElement.getAttribute("status");
	Change_Status_Image("status_img",ls_user_status);
	for(i=0;i<lao_friends.length;i++) {
		ls_user_name = lao_friends[i].getAttribute("user_name");
		ls_nick_name = lao_friends[i].getAttribute("nick_name");
		ls_status = lao_friends[i].getAttribute("status");
		ls_block_status = lao_friends[i].getAttribute("block_status");
		Add_Chat_Friend(ls_user_name,ls_nick_name,ls_status,ls_block_status);
	}
	GO_timer = setInterval(Timer_Functions,2000);
}

function Add_Chat_Friend(ars_name,ars_nick_name,ars_status,ars_block_status) {
	var lo_tr,lo_td1,lo_td2,lo_img;
	var ls_status;
	
	lo_tr = document.createElement("TR");
	addEvent(lo_tr,"click",display_chat_window_direct);
	lo_tr.setAttribute("user_name",ars_name);
	lo_tr.id=ars_name+"__tr";
	addEvent(lo_tr,"contextmenu",display_friend_context_menu);
	lo_td1 = document.createElement("TD");
	lo_td1.style.width = "10px";
	lo_td2 = document.createElement("TD");
	lo_td2.id = ars_name+"__td";
	lo_td2.style.width = "145px";
	lo_img = document.createElement("IMG");
	lo_img.id =ars_name+"_img";
	ls_status = ars_status;
	if(ars_block_status == 'B') {
		lo_tr.setAttribute("blocked","Y");
		ls_status = "3";
	}
	Change_Status_Image(lo_img,ls_status);
	lo_td1.appendChild(lo_img);
	lo_td2.appendChild(document.createTextNode(ars_nick_name));
	lo_tr.appendChild(lo_td1);
	lo_tr.appendChild(lo_td2);
	document.getElementById("chat_friend_tbody").appendChild(lo_tr);
	
}

function Timer_Functions() {
/*	var lo_response;
	var lao_friends,lao_invitations,lao_inv_responses,lao_messages;
	
	lo_response = AJAX(GS_server+"chat_handler.jsp?RequestType=TIMER_REQUEST","XML");
	lao_friends = XPath(lo_response,"Response/Chat/Status/Friends/Friend");
	if(lao_friends.length > 0) {
		update_friends_status(lo_response);
	}
	lao_invitations = XPath(lo_response,"Response/Chat/Invitations/Request/Invitation");
	if(lao_invitations.length > 0) {
		Process_Invitation(lo_response);
	}
	lao_inv_responses = XPath(lo_response,"Response/Chat/Invitations/Response/Invitation");
	if(lao_inv_responses.length > 0) {
		Process_Invitation_Response(lo_response);
	}
	lao_messages = XPath(lo_response,"Response/Chat/Messages/Message");
	if(lao_messages.length > 0) {
		Display_Chat_Messages(lo_response);
	}*/
}

function Process_Invitation_Response(aro_response) {
	var lao_inv_responses;
	var i;
	lao_inv_responses = XPath(aro_response,"Response/Chat/Invitations/Response/Invitation");

	for(i=0;i<lao_inv_responses.length;i++) {
		if(lao_inv_responses[i].getAttribute('status') == 'R') {
			Show_Transparent();
			alert("Invitation rejected from "+lao_inv_responses[i].getAttribute("full_name"));
			Hide_Transparent();
			lao_inv_responses[i].parentNode.removeChild(lao_inv_responses[i]);
		} else {
			GAO_inv_responses.push(lao_inv_responses[i]);
		}
	}
	if(GAO_inv_responses.length > 0) {
		if(!GB_inv_response_processing) {
			GB_inv_response_processing = true;
			Display_Invitation_Response();
		}
	}
}

function Process_Invitation(lo_response) {
	var lao_invitations;
	var i;
	
	lao_invitations= XPath(lo_response,"Response/Chat/Invitations/Request/Invitation");
	for(i=0;i<lao_invitations.length;i++) {
		GAO_invitations.push(lao_invitations[i]);
	}
	if(!GB_invitation_processing) {
		GB_invitation_processing = true;
		Display_Invitation();
	}
}

function Display_Invitation_Response() {
	var lo_invitation;
	var lo_from;
	var ls_inv_res;

	Show_Transparent();
	lo_invitation = GAO_inv_responses.shift();
	lo_from = document.getElementById("inv_res_from_user");
	if(!lo_from) {
		ls_inv_res = AJAX(GS_server+"chat_handler.jsp?RequestType=GetInviteResponse","");
		document.getElementById("invitation_response_container").innerHTML = ls_inv_res;
	} else {
		document.getElementById("invitation_response_container").style.display = "inline";
	}
	document.getElementById("inv_res_from_user").value = lo_invitation.getAttribute("full_name");
	document.getElementById("invitation_response_container").setAttribute("to_user_name",lo_invitation.getAttribute("user_name"));
}

function Display_Invitation() {
	var lo_invitation,lo_inv_msg;
	var ls_invite;
	
	Show_Transparent();
	lo_invitation = GAO_invitations.shift();
	lo_inv_msg = document.getElementById("invitation_msg");
	if(!lo_inv_msg) {
		ls_invite= AJAX(GS_server+"chat_handler.jsp?RequestType=GetInviteAccept","");
		document.getElementById("invitation_accept_container").innerHTML=ls_invite;
	} else {
		document.getElementById("invitation_accept_container").style.display = "inline";
	}
	document.getElementById("invitation_from").value = lo_invitation.getAttribute("from_name");
	document.getElementById("invitation_msg").value = lo_invitation.firstChild.nodeValue;
	document.getElementById("invitation_accept_container").setAttribute("from_user_name",lo_invitation.getAttribute("from"));
}

function update_friends_status(aro_xml) {
	var lao_friends;
	var i;
	var ls_user_name,ls_status,ls_block_status;
	
	lao_friends = XPath(aro_xml,"Response/Chat/Status/Friends/Friend");
	for(i=0;i<lao_friends.length;i++) {
		ls_user_name = lao_friends[i].getAttribute("user_name");
		ls_status = lao_friends[i].getAttribute("status");
		ls_block_status = lao_friends[i].getAttribute("block_status");
		if(ls_block_status == 'B') {
			ls_status = "3";
			document.getElementById(ls_user_name+"__tr").setAttribute("blocked","Y");
		}
		Change_Status_Image(ls_user_name+"_img",ls_status);
	}
}

function Change_Status_Image(ars_id,ars_status) {
	var lo_img;
	if(typeof(ars_id) == "string") {
		lo_img = document.getElementById(ars_id);
	} else {
		lo_img = ars_id;
	}
	switch(ars_status) {
			case "1":
				lo_img.src="Images/online.png";
				break;
			case "2":
				lo_img.src="Images/busy.png";
				break;
			case "3":
				lo_img.src="Images/offline.png";
				break;		
			case "4":
				lo_img.src="Images/offline.png";
				break;	
	}
}

function Do_Context_Function() {
	var lo_element;
	var ls_option;
	var ls_blocked,ls_nick_name;
	
	if(GS_browser == 'FF') {
		lo_element = arguments[0].target;
	} else {
		lo_element = window.event.srcElement;
	}
	while(lo_element.nodeName.toUpperCase() != "TR") {
		lo_element = lo_element.parentNode;
	}
	ls_option=lo_element.getAttribute("option_code");
	
	switch(ls_option) {
		case "1":
			ls_blocked = document.getElementById(GS_current_friend+"__tr").getAttribute("blocked");
			if(ls_blocked == 'Y') {
				document.getElementById(GS_current_friend+"__tr").setAttribute("blocked","N");
				AJAX(GS_server+"chat_handler.jsp?RequestType=SetUnBlock&friend_name="+GS_current_friend,"");
			} else {
				document.getElementById(GS_current_friend+"__tr").setAttribute("blocked","Y");
				AJAX(GS_server+"chat_handler.jsp?RequestType=SetBlock&friend_name="+GS_current_friend,"");
			}
			
			
			break;
		case "3":
			HideContextMenu();
			ls_nick_name = prompt("Enter nick name","");
			if(ls_nick_name) {
				document.getElementById(GS_current_friend+"__td").innerHTML = ls_nick_name;
				AJAX(GS_server+"chat_handler.jsp?RequestType=ChangeNickName&friend_name="+GS_current_friend+"&nick_name="+ls_nick_name,"");
			}
	}
	document.getElementById("friend_context").style.display = "none";
}

function Display_Options() {
	document.getElementById("option_div").style.display = "inline";
	GS_context_id = "option_div";
	if(GS_browser == 'FF') {
		arguments[0].stopPropagation();
	} else {
		window.event.cancelBubble = true;
	}
}

function Do_Options() {
	
	var lo_element;
	var ls_option,ls_div;
	if(GS_browser == 'FF') {
		lo_element = arguments[0].target;
	} else {
		lo_element = window.event.srcElement;
	}
	ls_option = lo_element.getAttribute("option_code");
	switch(ls_option) {
		case "1":
			Show_Transparent();
			ls_div=AJAX(GS_server+"chat_handler.jsp?RequestType=GetInvitation","");
			document.getElementById("invite_container").innerHTML=ls_div;
			break;			
			
	}
}

function DeleteInvite() {
	Hide_Transparent();
	document.getElementById("invite_container").innerHTML="";
}

function Invite_Chat_Friend() {
	var ls_email,ls_message,ls_response;
	
	ls_email = document.getElementById("chat_friend_email_id").value;
	ls_response = AJAX(GS_server+"chat_handler.jsp?RequestType=CheckEmail&email="+ls_email,"");
	if(ls_response != "OK") {
		alert("Invalid friend E-mail ID");
		document.getElementById("chat_friend_email_id").focus();
		return;
	}
	ls_message = document.getElementById("invitation_message").value;
	ls_response= AJAX(GS_server+"chat_handler.jsp?RequestType=SendInvitation&email="+ls_email,"",ls_message);
	if(ls_response != "OK") {
		alert(ls_response);
		return;
	}
	DeleteInvite();
}

function AcceptInvitation() {
	document.getElementById("invitation_div_1").style.display = "none";
	document.getElementById("invitation_div_2").style.display = "inline";
}

function Inv_Response_OK() {
	var ls_nick_name;
	var ls_to;
	
	ls_nick_name = document.getElementById("inv_res_nick_name").value;
	if(!ls_nick_name) {
		alert("Nick name cannot be blank");
		document.getElementById("inv_res_nick_name").focus();
		return;
	}
	Hide_Transparent();
	ls_to = document.getElementById("invitation_response_container").getAttribute("to_user_name");
	Add_Chat_Friend(ls_to,ls_nick_name,"3");
	AJAX(GS_server+"chat_handler.jsp?RequestType=InvitationResponseComplete&nick_name="+ls_nick_name+"&to="+ls_to,"");
	
	if(GAO_inv_responses.length > 0) {
		document.getElementById("inv_res_nick_name").value = "";
		document.getElementById("invitation_response_container").style.display = "none";
		setTimeout(Display_Invitation_Response,1000);
	} else {
		document.getElementById("invitation_response_container").innerHTML = "";
		GB_inv_response_processing = false;
	}
}

function AcceptInvitationOK() {
	var ls_nick_name;
	var ls_from;
	ls_nick_name = document.getElementById("invitation_nick_name").value;
	if(!ls_nick_name) {
		alert("Nick name cannot be blank");
		document.getElementById("invitation_nick_name").focus();
		return;
	}
	ls_from = document.getElementById("invitation_accept_container").getAttribute("from_user_name");
	Add_Chat_Friend(ls_from,ls_nick_name,"3");
	AJAX(GS_server+"chat_handler.jsp?RequestType=InvitationResponse&inv_status=A&nick_name="+ls_nick_name+"&from="+ls_from,"");
	Hide_Transparent();
	if(GAO_invitations.length > 0) {
		document.getElementById("invitation_nick_name").value = "";
		document.getElementById("invitation_div_2").style.display = "none";
		document.getElementById("invitation_div_1").style.display = "inline";
		document.getElementById("invitation_accept_container").style.display = "none";
		setTimeout(Display_Invitation,1000);
	} else {
		document.getElementById("invitation_accept_container").innerHTML = "";
		GB_invitation_processing = false;
	}
}

function RejectInvitation() {
	var ls_from;
	ls_from = document.getElementById("invitation_accept_container").getAttribute("from_user_name");
	AJAX(GS_server+"chat_handler.jsp?RequestType=InvitationResponse&inv_status=R&from="+ls_from,"");
	Hide_Transparent();
	if(GAO_invitations.length > 0) {
		document.getElementById("invitation_accept_container").style.display = "none";
		setTimeout(Display_Invitation,1000);
	} else {
		document.getElementById("invitation_accept_container").innerHTML = "";
		GB_invitation_processing = false;
	}
}

function Show_Transparent() {
	document.getElementById("transparent_div").style.display = "inline";
}

function Hide_Transparent() {
	document.getElementById("transparent_div").style.display = "none";
}

function Cancel_Event() {
	if(GS_browser == 'FF') {
		arguments[0].stopPropagation();
	} else {
		window.event.cancelBubble = true;
	}
}

function SetTransparency() {
	var lo_div;
	
	lo_div = document.getElementById("transparent_div");
	if(GS_browser == 'FF') {
		lo_div.style.opacity = "0.5";
	} else {
		lo_div.style.filter =  "alpha(opacity=50)";
	}
}

function Sign_Out() {
	clearInterval(GO_timer);
	ls_resp= AJAX(GS_server+"chat_handler.jsp?RequestType=SignOut","");
	window.open("login.jsp","_self");
}