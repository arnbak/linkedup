import QtQuick 1.0
import "../components"

Button{
	id: button

	property bool liked
	property bool likable
	property string key

	property string likedIcon: "qrc:///qml/images/like-added-small.png"
	property string likeIcon: "qrc:///qml/images/like-add-small.png"
	property string disabledIcon: "qrc:///qml/images/comment-disabled-small.png"

	signal requestStarted
	signal likeSent(string status)

	/**
	  Javascript PUT method for sending the like request
	  */
	function like(list){
		button.requestStarted()
		var xmlHttp = new XMLHttpRequest();
		var url = list[0]
		var header = list[1]
		var body = list[2]

		xmlHttp.onreadystatechange = function(){
			if(xmlHttp.readyState == 4){
				button.likeSent(xmlHttp.status)
				console.log(xmlHttp.status)
				console.log(xmlHttp.statusText)
			}
		}
		xmlHttp.open( "PUT", url, true );
		xmlHttp.setRequestHeader("Content-Type", "text/xml")
		xmlHttp.setRequestHeader("Host", "api.linkedin.com");
		xmlHttp.setRequestHeader("Authorization", header);
		xmlHttp.send( body );
	}

	onLikeSent: {
		liked = status === "201" ? !liked : liked
		iconSource = liked ? likedIcon : likeIcon
		if(liked)
			Notifier.notify("Liked")
		else
			Notifier.notify("Unliked")
	}

	onPressAndHold: Notifier.longNotify("Like:\n\nLike or unlike this item.")
	iconSource: likable ? (liked ? likedIcon :likeIcon) : disabledIcon
	enabled: likable
	onClicked: {
		if(!wasHeld)
			button.like(API.put_like(key, liked ? "false":"true"))
	}
}
