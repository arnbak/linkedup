import QtQuick 1.0

Rectangle {
	id: root
	width: 800
	height: 480

	signal authorized
	onAuthorized: console.log("asdf")
	Component.onCompleted: {
		var object = loginScreen.createObject(root)

	}


	Component{
		id: loginScreen
		LoginScreen{
			id: login
			anchors.fill: parent
			Component.onCompleted: root.authorized.connect(authorized)
		}
	}

}
