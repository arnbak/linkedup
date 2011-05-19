import QtQuick 1.0

Rectangle {
	id: button

	property alias text: text.text
	signal clicked

	width: text.width
	height: text.height + 10
	border.width: 1

	radius: 5
	gradient: Gradient {
		GradientStop {position: 0; color: "#ffffff"}
		GradientStop {position: 0; color: "#4969c2"}
		GradientStop {position: 0.01; color: "#67b1d5"}
		GradientStop {position: 0.96; color: "#3399cc"}
	}

	Text {
		id: text
		x: 37
		y: 23
		width: 80
		height: 20
		color: "#f1f1f1"
		font.family: "Arial"
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
		anchors.centerIn: parent
		font.pixelSize: 20
	}

	MouseArea {
		id: mouseArea
		anchors.fill: parent
		Connections{
			onClicked: button.clicked()
		}
	}
}
