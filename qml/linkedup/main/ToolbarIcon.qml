import QtQuick 1.0

Rectangle {
	id: root

	signal clicked
	property string url

    width: 100
	height: width
	color: "#32000000"
	radius: 5
	border.color: "#000000"

	Image {
		id: image
		anchors.fill: parent
		source: "qrc:///qml/images/arrow.png"
	}

	MouseArea {
		id: mouse_area
		anchors.fill: parent
		Connections{
			onClicked: root.clicked
		}
	}



}
