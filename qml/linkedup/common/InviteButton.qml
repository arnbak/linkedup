import QtQuick 1.0
import "../components"

Button{
	id: button

	/*message parameters*/
	property string email
	property string firstName
	property string lastName
	property string subject
	property string body

	property bool sent : false


	property string sentIcon: "qrc:///qml/images/add_connection_sent.png"
	property string sendIcon: "qrc:///qml/images/add_connection.png"
	property string disabledIcon: "qrc:///qml/images/comment-disabled-small.png"

	signal messageSent(string status)
	signal sendingMessage

	/**
	  Javascript POST method for sending the like request
	  */
	function post(list){
		button.sendingMessage()
		var xmlHttp = new XMLHttpRequest();
		var url = list[0]
		var header = list[1]
		var body = list[2]

		xmlHttp.onreadystatechange = function(){
			if(xmlHttp.readyState == 4){
				button.messageSent(xmlHttp.status)
				console.log(xmlHttp.status)
				console.log(xmlHttp.statusText)
			}
		}
		xmlHttp.open( "POST", url, true );
		xmlHttp.setRequestHeader("Content-Type", "text/xml")
		xmlHttp.setRequestHeader("Host", "api.linkedin.com");
		xmlHttp.setRequestHeader("Authorization", header);
		xmlHttp.send( body );
	}

	onMessageSent: {
		sent =  status === "201" ? !sent : sent
		iconSource = sent ? sentIcon : sendIcon
		if(sent)
			Notifier.notify("Connection request sent")
	}


	iconSource: sent ? sentIcon : sendIcon
	onClicked: {
		if(!email)
			Notifier.notify("Enter an E-mail address")
		else if(!subject)
			Notifier.notify("Enter an subject for the invitation message")
		else if(!body)
			Notifier.notify("Enter an body for the invitation message")
		else
			button.post(API.post_invitation(email, firstName, lastName, subject, body))
	}
}
