import QtQuick 1.0
import "../common"


Item {
	id: root
	width: parent.width; height: column.height

	signal requestStarted
	signal clicked(string profileID)
	signal likeSent(string status)
	signal commentSent(string status)
	SystemPalette{id: palette}


	Column{
		id: column
		Row{
			id: row
			spacing: 10
			Image {
				id: image
				height:  80
				width: height
				source: pictureUrl
				Component.onCompleted: {
					if(!pictureUrl)
						source = "qrc:///qml/images/profile-picture.png"
				}

				MouseArea{
					anchors.fill: parent
					onClicked: {
						root.clicked(id)
					}
				}
			}

			Column{
				Text {font.pixelSize: 20; font.family: "Arial"; color: palette.text; text: firstName + " " + lastName}

			}


		}

		Row{
			id: shareRow
			LikeButton{
				id: like
				liked: isLiked === "true" ? true : false
				likable: isLikable === "true" ? true : false
				key: updateKey
				onRequestStarted: root.requestStarted()
				onLikeSent: root.likeSent(status)
			}

			CommentDialog{
				id: commentButton
				commentable: isCommentable === "true" ? true : false
				key: updateKey
				expandedWidth: root.width
				onRequestStarted: root.requestStarted()
				onCommentSent: root.commentSent(status)
			}


		}

	}




}



