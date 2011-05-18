import QtQuick 1.0

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
//			anchors.top: parent.top
			anchors.bottom: parent.bottom
			width: root.width - x

			anchors.margins: {
//				top: -5
				left: 10
			}
		}

	}
}
