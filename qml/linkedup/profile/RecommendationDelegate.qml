import QtQuick 1.0

Item {
	width: parent.width
	height: rootColumn.height + 20



	Rectangle{
		id: border
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.margins: 10
		height: parent.height
		color: palette.dark
		radius: 10

		Column{
			id: rootColumn
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.verticalCenter: parent.verticalCenter
			anchors.margins: 10
			Text {font.pixelSize: 22;  wrapMode: Text.Wrap; width: parent.width; color: palette.text; text: firstName+" "+lastName}
			Text {font.pixelSize: 20;  wrapMode: Text.Wrap; width: parent.width; color: palette.text; text: recommendationType}

		}
	}


}
