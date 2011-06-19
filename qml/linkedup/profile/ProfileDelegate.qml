import QtQuick 1.0

Item{
	id: root
	width: parent.width
	height: rootColumn.height

	SystemPalette{id: palette}

   Column{
		id: rootColumn
		width: root.width
		spacing: 20
	   Row{
		   id: row
		   spacing: 10
		   width: parent.width

		   Image {
			   id: image
			   height:  100
			   width: height
			   smooth: true
			   source: pictureUrl
			   Component.onCompleted: {
				   if(!pictureUrl)
					   source = "qrc:///qml/images/profile-picture.png"
			   }
		   }

		   Column{
			   width: parent.width - image.width

//			   Text {font.pixelSize: 20; font.family: "Arial"; wrapMode: Text.Wrap; width: parent.width-10; color: palette.text; text: firstName + " " + lastName}
			   Text {font.pixelSize: 22; font.family: "Arial"; wrapMode: Text.Wrap; width: parent.width-10; color: palette.text; text: headline}
			   Text {font.pixelSize: 18; font.family: "Arial"; wrapMode: Text.Wrap; width: parent.width-10; color: palette.text; text: location}
			   Text {font.pixelSize: 18; font.family: "Arial"; wrapMode: Text.Wrap; width: parent.width-10; color: palette.text; text: industry}


		   }


	   }




   }



}
