GS_browser = "";
GS_IP = "http://localhost";
GS_PORT = ":8080";
GS_server = GS_IP+GS_PORT+"/Mail_Server/";
GS_user="";
GS_context_id = null;
GAO_invitations = new Array();
GB_invitation_processing = false;
GAO_inv_responses = new Array();
GB_inv_response_processing = false;
function SetBrowser() {
	if(window.event) {
		GS_browser = "IE";
	} else {
		GS_browser = "FF";
	}
}

INST_PATH = "C:\\Program Files\\Apache Software Foundation\\Tomcat 6.0\\webapps\\Mail_Server\\";

function AJAX(url,ars_type,ars_data) {
	var req;
	var xmlDom;
	var ls_response;
	if(!ars_data) {
		ars_data = null;
	}
	if(GS_browser == 'IE') {
			req = new ActiveXObject("Msxml2.XMLHTTP");
	} else {
		req = new XMLHttpRequest();
	}
	req.open("POST",url,false);
	req.send(ars_data);
	ls_response = req.responseText;
	if(ars_type == "XML") {
		if(GS_browser== 'FF') {
			var parser = new DOMParser();
			xmlDom = document.implementation.createDocument("","",null);
			xmlDom = parser.parseFromString(ls_response,"text/xml");
		} else if(window.ActiveXObject ) {
			xmlDom = new ActiveXObject("Microsoft.XMLDOM");
			xmlDom.loadXML(ls_response);
		}
			return xmlDom;
	} else {	
		return ls_response;
	}
	
}
function getUser()
{
	GS_user=AJAX(GS_server+"mail_handler.jsp?RequestType=GetUserName","");
}

function XPath(ars_node, ars_exp) {
	var result_array,temp_result;
	var xpe,nsResolver,res;
	if(window.ActiveXObject) {
		result_array =  ars_node.selectNodes(ars_exp);
	} else {
		xpe = new XPathEvaluator();
		nsResolver = xpe.createNSResolver(ars_node.ownerDocument === null ?
		ars_node.documentElement : ars_node.ownerDocument.documentElement);
		temp_result = xpe.evaluate(ars_exp,ars_node, nsResolver, 0, null);
		result_array = new Array();
		while (res = temp_result.iterateNext())
			result_array.push(res);
	}
	return result_array;
}

function GetValue(ars_id) {
	return document.getElementById(ars_id).value;
}

function addEvent(aro_element,ars_event,arf_function) {
	var lo_element;
	
	if(typeof(aro_element) == "string") {
		lo_element = document.getElementById(aro_element);
	} else {
		lo_element = aro_element;
	}
	if(lo_element.addEventListener) {
        lo_element.addEventListener(ars_event,arf_function,false);
    }
    else if(lo_element.attachEvent) {
       lo_element.attachEvent("on"+ars_event,arf_function);
    }
    else {
        lo_element["on"+ars_event]=arf_function;
    }
}

function RemoveEvent(ars_target,ars_event_type,arf_fn_handler) {

    var lo_target;

    if(typeof(ars_target)=='string') {
        lo_target=Get_Element(aro_target);       
    }
    else {
        lo_target=ars_target;           
    }             

    if(lo_target.removeEventListener) {
        lo_target.removeEventListener(ars_event_type,arf_fn_handler,false);
    }
    else if(lo_target.detachEvent) {
        lo_target.detachEvent("on"+ars_event_type,arf_fn_handler);
    }
    else {
       lo_target["on"+ars_event_type]=null;
    }
}

function PP() {
	var ln_button;
	var lo_event;
	alert('Tet');
	/*if(GS_browser == 'IE') {
		lo_event = window.event;
	} else {
		lo_event = arguments[0];
	}
	ln_button = lo_event.button;
	alert(ln_button);
	if(ln_button == 2) {
		if(GS_browser == 'FF') {
			lo_event.preventDefault();
		} else {
			//lo_event.returnValue = false;
			//window.event.returnValue = false;
			alert("true");
		}
	}
	*/
}


