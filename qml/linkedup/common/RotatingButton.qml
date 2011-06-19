import QtQuick 1.0

Rectangle {
	id: button
	width: 40
	height: width
	color: "#32000000"
	radius: 5
	border.color: "#7e7e7e"

	MouseArea {
		id: mouse_area1
	   anchors.rightMargin: -30
	   anchors.leftMargin: -30
		anchors.fill: parent
		anchors.margins: -20
		onClicked: button.state = button.state === "" ? "down" : ""
	}

	 Image {
		 id: arrow
		 smooth: true
		 anchors.fill: parent
		 source: "qrc:///qml/images/arrow.png"
		 Behavior on rotation{NumberAnimation{duration:250}}
	 }


	 states: [
		 State {
			 name: "down"
			 PropertyChanges { target: arrow; rotation: 180}
		 }
	 ]
}
