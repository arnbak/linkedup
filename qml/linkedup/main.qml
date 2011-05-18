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
			Component.onCompleted: root.authorized.connect(authorized)
		}
	}


	Component{
		id: profileSCreen
		Profile{}
	}

}
