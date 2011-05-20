import QtQuick 1.0

Rectangle {
	id: border
	height: 40
	color: "#3399cc"
	anchors.right: parent.right
	anchors.rightMargin: 0
	anchors.left: parent.left
	anchors.leftMargin: 0
	anchors.top: parent.top
	anchors.topMargin: 0

	Behavior on height{NumberAnimation{duration:250}}


	ToolbarOptions{
		id: icons
		opacity: 0
		anchors.verticalCenter: parent.verticalCenter
		Behavior on opacity {NumberAnimation{duration: 250}}
	}

	 Rectangle {
		 id: button
		 y: 11
		 width: 40
		 height: 40
		 z: 100
		 color: "#32000000"
		 radius: 5
		 border.color: "#7e7e7e"
		 anchors.horizontalCenter: parent.horizontalCenter
		 anchors.bottom: parent.bottom
		 anchors.bottomMargin: 1

		 MouseArea {
			 id: mouse_area1
			 anchors.fill: parent
			 onClicked: {
				 if(border.state == "down")
					 border.state = ""
				 else
					 border.state = "down"
			 }
		 }

		  Image {
			  id: arrow
			  smooth: true
			  anchors.fill: parent
			  source: "qrc:///qml/images/arrow.png"
			  Behavior on rotation{NumberAnimation{duration:250}}
		  }


		 }
		 states: [
			 State {
				 name: "down"
				 PropertyChanges { target: arrow; rotation: 180}
				 PropertyChanges { target: border; height: 180}
				 PropertyChanges { target: icons; opacity: 1}
			 }
		 ]


}
