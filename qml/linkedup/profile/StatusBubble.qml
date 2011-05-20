import QtQuick 1.0
import "../"

Rectangle {
	id: root
	property alias image: profileImage.source
	width: parent.width

	Image {
		id: profileImage
		anchors.margins: 10

		Bubble{
			id: bubble
			anchors.left: parent.right
			anchors.bottom: parent.bottom
			width: root.width - x
			anchors.top: parent.top
			anchors.topMargin: -5
			onClicked:API.post_status(text)
		}

	}
}
