import QtQuick 1.0
import "../components"

Item{
	id: root
	height: button.height
	width: parent.width


	property bool shown: false
	property alias text: label.text

	Button{
		id: button
		width: parent.width
		height: image.height +20
		onClicked: shown = !shown

		Image {
			id: image
			source: "qrc:///qml/images/arrow-down-small.png"
			anchors.right: parent.right
			anchors.margins: 20
			anchors.verticalCenter: parent.verticalCenter
			Behavior on rotation { NumberAnimation{duration: 250}}
		}

		Text{
			id: label
			color: palette.text
			font.pixelSize: 25
			anchors.left: parent.left
			anchors.verticalCenter: parent.verticalCenter
			anchors.leftMargin: 10
		}
	}

	states: [
		State {
			name: "shown"
			when: shown
			PropertyChanges {target: image; rotation: 180}
		}
	]


}
