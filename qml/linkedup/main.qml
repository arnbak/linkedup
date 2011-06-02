import QtQuick 1.0
import "main"

Rectangle {
	id: root
	width: 480
	height: 800

	Component.onCompleted: {
		updateLoader.sourceComponent = updateComp
		if(Settings.get("oauth_token") === "" || Settings.get("oauth_token_secret") === "")
			getAuthorization()
	}

	signal authorized
	function getAuthorization(){
		var object = loginScreen.createObject(root)
		object.z = 100
	}

	Home{
		id: home
		onClicked: state = "hidden"
		onStateChanged: {
			if(state === "hidden")
				updateLoader.shown = "down"
			else
				updateLoader.shown = ""
		}
	}


	Loader{
		id: updateLoader

		property string shown
		z:1
		width: parent.width
		anchors.bottom: parent.bottom
	}

	Component{
		id: updateComp
		Status{
			id: updater
			profileID: "~"
			state: updateLoader.state
			shown: updateLoader.shown

		}
	}





	/**Screen for authorizing the application
	  This screen is launched if no token is found for
	  the user
	  */
	Component{
		id: loginScreen
		LoginScreen{
			anchors.fill: parent
			Component.onCompleted: root.authorized.connect(authorized)
		}
	}



}
