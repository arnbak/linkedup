import QtQuick 1.0

Rectangle {
	id: root
	width: 800
	height: 480

	Component.onCompleted: {
		if(Settings.get("oauth_token") == "" || Settings.get("oauth_token_secret") == "")
			getAuthorization()
		else{
//			var object = profileSCreen.createObject(root)
			var object = searchScreen.createObject(root)
		}

	}

	property alias borderHeight: border.height
	signal authorized
	function getAuthorization(){
		var object = loginScreen.createObject(root)
		object.z = 100
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

	/**Screen to show the user their profile
	  */
	Component{
		id: profileSCreen
		Profile{
			anchors.fill: parent
			anchors.leftMargin: 10
			anchors.topMargin: borderHeight
		}
	}

	Component{
		id: searchScreen
		Search{
			anchors.fill: parent
			anchors.leftMargin: 10
			anchors.topMargin: borderHeight
		}
	}

	Toolbar{
		id:border
		z: 100
	}



	ListView{
		id: view
		anchors.fill: parent
		anchors.topMargin: border.height
		orientation: ListView.Horizontal
		model: mainModel{}
	}

}
