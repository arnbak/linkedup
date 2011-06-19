import QtQuick 1.0
import "../components"

Item {
	id: root
	width: toggleButton.width
	height: Math.max(toggleButton.height, commentBox.height+toggleButton.height)

//	property alias commentable: button.commentable
	property alias toID: button.toID
	property int expandedWidth

	property alias placeholderText: textArea.placeholderText

	signal messageSent(string status)
	signal sendingMessage

	Button{
		id: toggleButton
		iconSource: button.iconSource
		z:100
		focus: true
		onClicked: {
			if(!wasHeld)
				root.state = root.state === "shown" ? "":"shown"
		}
		onPressAndHold: Notifier.longNotify("E-mail:\n\nSend an email to this member")
	}


	Item{
		id: commentBox
		width: expandedWidth
		anchors.left: parent.left
		anchors.top: parent.top
		anchors.topMargin: toggleButton.height
		Behavior on opacity {NumberAnimation{duration:250}}
		Behavior on height {NumberAnimation{duration:250}}

		height: 0
		opacity: 0


		TextArea{
			id: subjectArea
			anchors.left: parent.left
			anchors.right: parent.right
			placeholderText: "Subject"
			anchors.rightMargin: button.width
		}

		TextArea{
			id: textArea
			anchors.fill: parent
			anchors.topMargin: subjectArea.height
			placeholderText: "Enter your message."
			anchors.rightMargin: button.width
		}

		EmailButton{
			id: button

			anchors.right: parent.right
			anchors.bottom: parent.bottom
			subject: subjectArea.text
			body: textArea.text
			onMessageSent: {
				textArea.placeholderText = "Successfuly sent!"
				textArea.text = ""
				subjectArea.text = ""
				button.focus = true
				root.state = ""
			}
			Connections{
				onMessageSent: root.messageSent(status)
				onSendingMessage: root.sendingMessage()
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
