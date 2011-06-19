import QtQuick 1.0
import "../components"

Button{
	id: button

	property bool commentable
	property string commentStr
	property string key

	property string commentedIcon: "qrc:///qml/images/comment-accept-small.png"
	property string commentIcon: "qrc:///qml/images/comment-add-small.png"
	property string disabledIcon: "qrc:///qml/images/comment-disabled-small.png"

	signal requestStarted
	signal commentSent(string status)

	/**
	  Javascript POST method for sending the comment
	  */
	function comment(list){
		button.requestStarted()
		var xmlHttp = new XMLHttpRequest();
		var url = list[0]
		var header = list[1]
		var body = list[2]

		xmlHttp.onreadystatechange = function(){
			if(xmlHttp.readyState == 4){
				button.commentSent(xmlHttp.status)
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

	onCommentSent: {
		iconSource = status === "201" ? commentedIcon : commentIcon
		if(status === "201")
			Notifier.notify("Comment sent")
	}


	iconSource: commentable ? commentIcon : disabledIcon
	enabled: commentable
	onClicked: {
		if(!commentStr)
			Notifier.notify("Enter a comment")
		else
			button.comment(API.post_comment(key, commentStr))

	}
}
