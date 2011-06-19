import QtQuick 1.0
import "../components"

Item {
	id: root
	width: toggleButton.width
	height: Math.max(toggleButton.height, commentBox.height+toggleButton.height)

	property alias commentable: button.commentable
	property alias key: button.key
	property int expandedWidth

	property alias placeholderText: textArea.placeholderText

	signal requestStarted
	signal commentSent(string status)

	Button{
		id: toggleButton
		iconSource: button.iconSource
		z:100
		onClicked: {
			if(!wasHeld)
				root.state = root.state === "shown" ? "":"shown"
		}

		onPressAndHold: Notifier.longNotify("Comment:\n\nComment on this item")
	}


	Item{
		id: commentBox
		width: expandedWidth
		anchors.left: parent.left
		anchors.top: parent.top
		anchors.leftMargin: -toggleButton.width
		anchors.topMargin: toggleButton.height
		Behavior on opacity {NumberAnimation{duration:250}}
		Behavior on height {NumberAnimation{duration:250}}

		height: 0
		opacity: 0

		TextArea{
			id: textArea
			anchors.fill: parent
			placeholderText: "Enter a Comment!"
			anchors.rightMargin: button.width
		}

		CommentButton{
			id: button
			anchors.right: parent.right
			anchors.bottom: parent.bottom
			commentStr: textArea.text
			onRequestStarted: root.requestStarted()
			onCommentSent: {
				root.commentSent(status)
				if(status === "201"){
					textArea.placeholderText = "Successfuly sent!"
					textArea.text = ""
					button.focus = true
					root.state = ""
				}

			}
		}

	}





	states: [
		State {
			name: "shown"
			PropertyChanges {target: commentBox; opacity: 1; height: 200}
		}
	]
}
