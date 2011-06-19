import QtQuick 1.0
import "../"
import "../common"

Item {
	id: root
	width: parent.width; height: col.height

	signal requestStarted
	signal clicked(string profileID)
	signal likeSent(string status)
	signal commentSent(string status)
	SystemPalette{id: palette}

	Component.onCompleted: {
		if(!newFirstName){
			root.visible = false
			root.height = 0
//			root.destroy()
		}
	}

	function like(list){
		var xmlHttp = new XMLHttpRequest();
//		var list = API.post_share(status.text)
		var url = list[0]
		var header = list[1]
		var body = list[2]

		xmlHttp.onreadystatechange = function(){
			if(xmlHttp.readyState == 4){
				console.log(xmlHttp.responseText)
			}
		}
		xmlHttp.open( "PUT", url, true );
		xmlHttp.setRequestHeader("Content-Type", "text/xml")
		xmlHttp.setRequestHeader("Host", "api.linkedin.com");
		xmlHttp.setRequestHeader("Authorization", header);
		xmlHttp.send( body );
	}

//	MouseArea{
//		width: row.width
//		height: row.height
//		Connections{
//			onClicked: root.clicked(API.get_person_by_id(id))
//		}

		Column{
			id: col
			spacing: 5

			Row{ //the updating user
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
					Text {font.pixelSize: 18; font.family: "Arial"; color: palette.text; text: headline}
//					Text {font.pixelSize: 16; font.family: "Arial"; color: palette.text; text: location}
//					Text {font.pixelSize: 16; font.family: "Arial"; color: palette.text; text: industry}
				}


			}

			Row{ //the users new connection
				id: newRow
				spacing: 10
				scale: .9

				Image {
					id: link
					source: "qrc:///qml/images/link.png"
					width: 40
					height: 45
				}

				Image {
					id: newImage
					height:  80
					width: height
					source: newPictureUrl
					Component.onCompleted: {
						if(!newPictureUrl)
							source = "qrc:///qml/images/profile-picture.png"
					}
					MouseArea{
						anchors.fill: parent
						onClicked: {
							root.clicked(newId)
						}
					}
				}

				Column{
					Text {font.pixelSize: 20; font.family: "Arial"; color: palette.text; text: newFirstName + " " + newLastName}
					Text {font.pixelSize: 18; font.family: "Arial"; color: palette.text; text: newHeadline}
					Text {font.pixelSize: 16; font.family: "Arial"; color: palette.text; text: newIndustry}
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
					id: commentBox
					commentable: isCommentable === "true" ? true : false
					key: updateKey
					expandedWidth: root.width
					onRequestStarted: root.requestStarted()
					onCommentSent: root.commentSent(status)
				}


			}

			Rectangle{
				id: seperator

			}

//		}


	}


}



