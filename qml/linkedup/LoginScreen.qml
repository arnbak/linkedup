import QtQuick 1.0

Rectangle {
	width: parent.width
	height: parent.height

	Text {
		id: instruction1
		width: parent.width
		text: "Authenticate "
		font.pixelSize: 20
		horizontalAlignment: Text.Center
		wrapMode: Text.Wrap

	Text {
		id: instruction1
		width: parent.width
		text: "Press the login button below to allow this application to access your LinkedIn profile"
		font.pixelSize: 20
		horizontalAlignment: Text.Center
		wrapMode: Text.Wrap

		LoginButton {
			id: loginbutton1
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: parent.bottom
			anchors.margins: 10


		}

		Text {
			id: instruction2
			width: parent.width
			text: "Enter the code you receive bellow"
			font.pixelSize: 20
			anchors.top: parent.bottom
			horizontalAlignment: Text.Center
			wrapMode: Text.Wrap

		}
	}






}
