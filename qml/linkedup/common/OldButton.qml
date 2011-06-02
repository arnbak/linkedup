import QtQuick 1.0

Rectangle {
	id: button

	property alias text: text.text
	property alias fontSize: text.fontSize
	property string iconUrl
	signal clicked

	width: text.width +10
	height: text.height
	border.width: 1

	Component.onCompleted:{
		if(iconUrl){
			var object = icon.createObject(button)
		}
	}

	radius: 5
	gradient: Gradient {
		GradientStop {position: 0; color: "#ffffff"}
		GradientStop {position: 0; color: "#4969c2"}
		GradientStop {position: 0.01; color: "#67b1d5"}
		GradientStop {position: 0.96; color: "#3399cc"}
	}


	Text {
		property int fontSize
		id: text
		x: 37
		y: 23
		color: "#f1f1f1"
		font.family: "Arial"
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
		anchors.centerIn: parent
		font.pixelSize: fontSize
	}

	Component{
		id: icon
		Image {
			id: image
			anchors.fill: parent
			source: iconUrl
			smooth: true
		}
	}

	MouseArea {
		id: mouseArea
		anchors.fill: parent
		Connections{
			onClicked: button.clicked()
		}
	}
}
