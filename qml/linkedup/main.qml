import QtQuick 1.0

Rectangle {
	id: root
	width: 800
	height: 480

	Component.onCompleted: {
		if(Settings.get("oauth_token") == "" || Settings.get("oauth_token_secret") == "")
			getAuthorization()
		else
			var object = profileSCreen.createObject(root)
	}

	property int borderHeight: 40
	signal authorized
	function getAuthorization(){
		var object = loginScreen.createObject(root)
		object.z = 100
	}

	/**Screen for authorizing the application
	  This screen is launched
	  */
	Component{
		id: loginScreen
		LoginScreen{
			anchors.fill: parent
			anchors.topMargin: borderHeight
			Component.onCompleted: root.authorized.connect(authorized)
		}
	}


	Component{
		id: profileSCreen
		Profile{
			anchors.fill: parent
			anchors.leftMargin: 10
			anchors.topMargin: borderHeight
		}
	}

	Rectangle {
		id: border
		height: borderHeight
		color: "#3399cc"
		anchors.right: parent.right
		anchors.rightMargin: 0
		anchors.left: parent.left
		anchors.leftMargin: 0
		anchors.top: parent.top
		anchors.topMargin: 0
		z:100
	}

}
