<html>
	<head>
		<title>Untitled Document</title>
		<script language="javascript" src="common.js"></script>
      	  	<script language="javascript" src="mail.js"></script>
		<script language="javascript" src="chat.js"></script>
    		<script language="javascript" src="chat_window.js"></script>
		<script language="javascript" src="richtext.js"></script>
    		<link rel="stylesheet" type="text/css" href="rte.css">

        <style>
			.link {
				text-decoration:underline;
				cursor:pointer;
				color:blue;
			}
        </style>        
	</head>
     <body onLoad="SetBrowser();SetTransparency();initialise_window();getUser();initRTE();" bgcolor="#A6A6A6" onclick="HideContextMenu(event)">
       	<a style="position:absolute; left: 21px; top: 72px;" onClick="test()" class="link">Compose Mail</a>
        <a class="link"  style="position:absolute; left: 22px; top: 104px;" onClick="Read_Inbox()">Inbox</a>
        <a class="link" style="position:absolute; left: 22px; top: 132px;">Sent Mail</a>
        <a class="link" style="position:absolute; left: 23px; top: 162px;" onClick="search_mail()">Drafts</a>
        <a class="link" style="position:absolute; left: 22px; top: 192px;">Contacts</a>
     
        <div id="chat_div" style="position:absolute; width:155px; height:342px; left: 12px; top: 228px;border:1px solid black;z-index:2;">
<div id="option_div" style="position:absolute; width:78px; height:39px; z-index:2; background-color:yellow; left: 76px; top: 288px;text-align:right;display:none;">
            	<div option_code="2" style="display:block;width:100%;" onClick="Do_Options(event)">Settings</div>
            	<div option_code="1" style="display:block;width:100%;" onClick="Do_Options(event)">Invite Friend</div>
            </div>
            
	        <table border="0px" id="status_table" cellpadding="0" cellspacing="0" style="position:absolute;left:140px;top:20px;display:none;z-index:3">
<tbody style="background-color:#3FF;">
                    <tr onClick="set_status(event)" status="1" >
                        <td><img src="Images/online.png" /></td>
                        <td>Available</td>
                    </tr>
                    <tr onClick="set_status(event)" status="2">
                        <td><img src="Images/busy.png" /></td>
                        <td>Busy</td>
                    </tr>
                     <tr status="3" onClick="set_status(event)">
                        <td><img src="Images/offline.png" /></td>
                        <td>Offline</td>
                    </tr>
                    <tr status="4" onClick="set_status(event)">
                        <td><img src="Images/offline.png" /></td>
                        <td>Invisible</td>
                    </tr>
                 </tbody>
            </table>
<div style="position:absolute; width:133px; height:20px; background-color:#000; color:white;">Chatting</div>
            <img id="status_img" onClick="change_status(event)" style="position:absolute; left:140px; height:9px; width:9px; top: 7px;">
       	  	<div id="chat_friend_div" style="position:absolute; width:155px; height:305px; border:1px solid blue; left: 0px; top: 20px;overflow:auto;">
            	<table style="width:100%;">
                	<tbody id="chat_friend_tbody">
                    </tbody>
                </table>
            </div>
            <div id="chat_group_div" style="position:absolute; width:155px; height:284px; border:1px solid blue; left: 0spx; top: 43px;overflow:auto;display:none;"></div>
          <div style="position:absolute;width:154px;height:15px;top:327px;background-color:#FEFEFE;">
	          <label style="position:absolute; left: 97px; top: 0px; font-size:9pt;">Options</label>
              <img src="Images/up_arrow.png" style="position:absolute; left: 142px; top: 3px;" onClick="Display_Options(event)">
          </div>
    </div>
	    <div id="container" style="position:absolute; width:825px; height:478px; left: 175px; top: 82px;z-index:1;"></div>
        <table id="friend_context" border="0px" cellpadding="0" cellspacing="0" style="position:absolute;left:100px;top:0px;z-index:2;display:none;">
            <tbody style="background-color:#3FF;">
                <tr onClick="Do_Context_Function(event)" option_code="1">
                    <td id="friend_block">Block</td>
                </tr>
                <tr onClick="Do_Context_Function(event)" option_code="2">
                    <td>Send Email</td>
                </tr>
                <tr onClick="Do_Context_Function(event)" option_code="3">
                    <td>Set nick name</td>
                </tr>
                   </tbody>
        </table>
        <div id="transparent_div" style="position:absolute;left:0px;top:0px;width:100%;height:100%;background-color:#E8E8E8;z-index:3;display:none;" onClick="Cancel_Event(event)"></div>
        <div id="invite_container" style="position:absolute; left: 287px; top: 158px;z-index:4;"></div>
        <div id="invitation_accept_container" style="position:absolute; left: 287px; top: 158px;z-index:4;"></div>
        <div id="invitation_response_container" style="position:absolute; left: 287px; top: 158px;z-index:4;"></div>
        <a style="position:absolute; left: 932px; top: 9px; width: 56px;" onClick="Sign_Out()" class="link">Sign out</a>        
    </body>
</html>

