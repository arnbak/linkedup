import QtQuick 1.0

Rectangle {
	id: border

	signal clicked(string name)
	property alias currentTitle: icons.title

	SystemPalette{id: palette}

	height: 40
	color:  palette.light
//	color: "#3399cc"
//	gradient: Gradient {
//		GradientStop {
//			position: 0.00;
//			color: "#6aafd1";
//		}
//		GradientStop {
//			position: 1.00;
//			color: "#3399cc";
//		}
//	}

	anchors.right: parent.right
	anchors.rightMargin: 0
	anchors.left: parent.left
	anchors.leftMargin: 0
	anchors.top: parent.top
	anchors.topMargin: 0

	Behavior on height{NumberAnimation{duration:250}}

	Text {
		property string newText
		id: title
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		anchors.leftMargin: 10
		font.pixelSize: 30
		font.bold: true
		color: "white"
		font.family: "Arial"

		Behavior on newText { SequentialAnimation{
//				PropertyAnimation {target: title; property: "opacity"; to: 0; duration:250}
//				PropertyAnimation {target: title; property: "text"; to: icons.title; duration: 0}
//				PropertyAnimation {target: title; property: "opacity"; to: 1; duration:250}
			} }
	}


	ToolbarOptions{
		id: icons
		opacity: 0
		anchors.verticalCenter: parent.verticalCenter
		onTitleChanged: title.text = icons.title
		Behavior on opacity {NumberAnimation{duration: 250}}
		Connections{
			onClicked: border.clicked(name)
		}
		Component.onCompleted: title.text = icons.title

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
			anchors.rightMargin: -30
			anchors.leftMargin: -30
			 anchors.fill: parent
			 anchors.margins: -20
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
