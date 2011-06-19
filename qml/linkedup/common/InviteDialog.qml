import QtQuick 1.0
import "../components"

Item {
	id: root
	width: toggleButton.width
	height: Math.max(toggleButton.height, commentBox.height+toggleButton.height)

	property alias firstName: button.firstName
	property alias lastName: button.lastName
	property int expandedWidth

	property alias placeholderText: textArea.placeholderText

	signal messageSent(string status)
	signal sendingMessage

	Button{
		id: toggleButton
		iconSource: button.iconSource
		z:100
		onClicked: {
			if(!wasHeld)
				root.state = root.state === "shown" ? "":"shown"
		}
		onPressAndHold: Notifier.longNotify("Connect:\n\nRequest to be connected as friends with this user. Currently LinkedIn only allows applications to connect as friends.")
	}


	Item{
		id: commentBox
		width: expandedWidth
		anchors.left: parent.left
		anchors.top: parent.top
		anchors.leftMargin: -root.x
		anchors.topMargin: toggleButton.height
		Behavior on opacity {NumberAnimation{duration:250}}
		Behavior on height {NumberAnimation{duration:250}}

		height: 0
		opacity: 0


		TextArea{
			id: emailArea
			anchors.left: parent.left
			anchors.right: parent.right
			placeholderText: "Enter the member's E-mail address"
			anchors.rightMargin: button.width
		}

		TextArea{
			id: subjectArea
			anchors.top: parent.top
			anchors.topMargin: emailArea.height
			anchors.left: parent.left
			anchors.right: parent.right
			placeholderText: "Subject"
			anchors.rightMargin: button.width
		}

		TextArea{
			id: textArea
			anchors.fill: parent
			anchors.topMargin: subjectArea.height + emailArea.height
			text: "I'd like to add you as a friend on LinkedIn.\n\n"
			placeholderText: "Enter your message."
			anchors.rightMargin: button.width
		}

		InviteButton{
			id: button

			anchors.right: parent.right
			anchors.bottom: parent.bottom

			email:  emailArea.text
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
