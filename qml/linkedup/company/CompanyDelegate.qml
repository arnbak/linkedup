import QtQuick 1.0
import "../components"

Item{
	id: root
	width: parent.width
	height: rootColumn.height

	property bool following: User.following(id) ? true : false

	signal follow(string id)
	signal stopFollow(string id)

	SystemPalette{id: palette}

   Column{
		id: rootColumn
		width: root.width
		spacing: 20



	   Column{
		   width: parent.width

		   Row{
			   spacing: 20
			   Image {
				   id: image
				   height: 100
				   width: 200
				   fillMode: Image.PreserveAspectFit
				   source: logo
				   smooth: true
				   Component.onCompleted: {
					   if(!logo)
						   source = "qrc:///qml/images/profile-picture.png"
				   }
			   }
			   Text {font.pixelSize: 25; font.family: "Arial"; wrapMode: Text.Wrap;  color: palette.text; text: name; anchors.verticalCenter: parent.verticalCenter}

		   }



		   Text {font.pixelSize: 20; font.family: "Arial"; color: palette.text; text: '<a href="'+website+'">'+website+'</a>'
			   onLinkActivated: Qt.openUrlExternally(website)  }
		   Text {font.pixelSize: 20; font.family: "Arial"; wrapMode: Text.Wrap; width: parent.width-10; color: palette.text; text: industry}


		   Row{
			   Button{
				   id: follow
				   text: following ? "Following " + name : "Follow " + name
//				   onClicked: following ? root.stopFollow(id) : root.follow(id) //mm uncomment this when xmlhttp delete is implemented
				   onClicked: root.follow(id)
				   iconSource: following ? "qrc:///qml/images/star-on.png" : "qrc:///qml/images/star-off.png"
//				   Behavior on text { NumberAnimation{ duration: 250}}
			   }
		   }

	   }



	   Row{ //mm this text resizing does not seem to register to the parent row. The components underneath it don't get repositioned
		   Text {font.pixelSize: 20; font.family: "Arial"; wrapMode: Text.Wrap; width: root.width-10; color: palette.text; text: description}

	   }




   }



}
