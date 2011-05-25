import QtQuick 1.0

Rectangle {
	id: root

	signal clicked
	property alias source: image.source
	property string name
	property string title

    width: 100
	height: width
	color: "#32000000"
	radius: 5
	border.color: "#000000"

	Image {
		id: image
		anchors.fill: parent
		smooth: true
	}


	MouseArea {
		id: mouse_area
		anchors.fill: parent
		z: 100
		Connections{
			onClicked: root.clicked()
		}
	}



}
