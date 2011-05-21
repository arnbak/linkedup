import QtQuick 1.0
import "main"

Rectangle {
	id: root
	width: 800
	height: 480

	Component.onCompleted: {
		if(Settings.get("oauth_token") == "" || Settings.get("oauth_token_secret") == "")
			getAuthorization()
	}

	property alias borderHeight: border.height
	signal authorized
	function getAuthorization(){
		var object = loginScreen.createObject(root)
		object.z = 100
	}

	ViewStack{
		id: viewStack
		anchors.fill: parent
		anchors.topMargin: borderHeight
		Component.onCompleted: state = "profile"
	}

	/**Screen for authorizing the application
	  This screen is launched if no token is found for
	  the user
	  */
	Component{
		id: loginScreen
		LoginScreen{
			anchors.fill: parent
			anchors.topMargin: borderHeight
			Component.onCompleted: root.authorized.connect(authorized)
		}
	}


	Toolbar{
		id:border
		z: 100
		onClicked: viewStack.state = name
	}



}
