<html>
<body>
<div id= "invite_div" style="position:absolute; width:392px; height:221px; left: 0px; top:0px; background-color:#D2D2D2;border:1px solid BLACK;z-index:2;">
  <label style="position:absolute; left: 41px; top: 47px;">Friend e-mail ID</label>
    <input type="text" id="chat_friend_email_id" style="position:absolute; left: 166px; top: 46px; width: 180px;">
    <label style="position:absolute; left: 34px; top: 86px;">Invitation message</label>
    <textarea id="invitation_message" style="position:absolute; left: 167px; top: 89px; width: 180px; height: 63px;"></textarea>
    <input type="button" style="position:absolute; left: 167px; top: 163px; width: 70px;" value="Invite" onClick="Invite_Chat_Friend()">
    <input type="button" style="position:absolute; left: 279px; top: 163px; width: 67px;" value="Cancel" onClick="DeleteInvite()">
</div>
</body>
</html>