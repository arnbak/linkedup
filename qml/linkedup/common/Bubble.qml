import QtQuick 1.0

/**
  This class represents a chat bubble for entering text with a
  button acnhored to the bottom right corner.
  Used for sending status updates.
  */
Rectangle {
	id: root

	property alias text: input.text
	property alias fontSize: input.fontSize
	property alias buttonFontSize: share.fontSize
	signal clicked

	width: parent.width
	height: parent.height
	color: "transparent"

	BorderImage {//to stretch the bubble image without changing side resolution
		id: bubble

		width: parent.width - x - 20
		horizontalTileMode: BorderImage.Stretch
		border.left: 20
		border.right: 20
		smooth: true
		source: "qrc:///qml/images/bubble.png"

		anchors.margins: 10

		Button{
			id: share
			z: 100
			text: "Share"
			anchors.top: parent.bottom
			anchors.right: parent.right
			anchors.topMargin: -20
			anchors.rightMargin: 15
			onClicked: {//so the placeholder text isn't posted
				if(input.state != "placeholder")
					bubble.posted()
//					root.clicked()
			}

//			Connections{
//				onClicked: root.clicked()
//			}
		}

		function posted(){
			input.state = "posted"
			root.clicked()
		}
		Timer{
			id: timer
			interval: 1000
			onTriggered: input.focus = false
		}


		Rectangle{
			anchors.fill: parent
			id: background

			anchors.rightMargin: 25
			anchors.leftMargin: 30
			anchors.bottomMargin: 20
			anchors.topMargin: 20
			border.width: 0
			border.color: "black"

			Flickable{
				id: textScroll
				anchors.fill: parent
				contentHeight: height
				contentWidth: width
				clip:true

				TextEdit {
					property int fontSize:12
					id: input
					font.pixelSize: fontSize
					anchors.fill: parent
					wrapMode: Text.Wrap
					onCursorPositionChanged: ensureVisible(cursorRectangle)

					function ensureVisible(r)
						 {
							 if (contentX >= r.x)
								 textScroll.contentX = r.x;
							 else if (contentX+width <= r.x+r.width)
								 textScroll.contentX = r.x+r.width-width;
							 if (contentY >= r.y)
								 textScroll.contentY = r.y;
							 else if (contentY+height <= r.y+r.height)
								 textScroll.contentY = r.y+r.height-height;
						 }

					states: [ /*creates a placeholder effect*/
						State {
							name: "placeholder"
							when: input.focus == false
							PropertyChanges {target: input; text: "Enter a status!"; color: "gray"}
						},
						State {
							name: "posted"
							PropertyChanges {target: background; color: "darkgray"}
							PropertyChanges {target: timer; running: true}
						}
					]
				}

			}

		}





	}


}
