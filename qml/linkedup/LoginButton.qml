import QtQuick 1.0

Rectangle {
	width: 197
	height: 31

	Image {
		id: image
		anchors.fill: parent
		source: "qrc:///qml/images/linkedin-login.png"
	}

	MouseArea{
		id:mouseArea
		anchors.fill: parent
		onClicked: OAuth.request_token()
	}
}
