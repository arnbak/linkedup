import QtQuick 1.0

Item {
	width: parent.width
	height: rootColumn.height + 20

	property string endCurrent: endDate

	Component.onCompleted: {
		if(!endDate)
			endCurrent = "current"
	}

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
			Text {font.pixelSize: 18; font.family: "Arial"; wrapMode: Text.Wrap; width: parent.width; color: palette.text; text: schoolName}
			Text {font.pixelSize: 16; font.family: "Arial"; wrapMode: Text.Wrap; width: parent.width; color: palette.text; text: degree+", "+fieldOfStudy}
			Text {font.pixelSize: 16; font.family: "Arial"; wrapMode: Text.Wrap; width: parent.width; color: palette.text; text: startDate + " - " + endCurrent}

			Text {font.pixelSize: 16; font.family: "Arial"; wrapMode: Text.Wrap; width: parent.width; color: palette.text; text: activities}
			Text {font.pixelSize: 16; font.family: "Arial"; wrapMode: Text.Wrap; width: parent.width; color: palette.text; text: summary}

		}
	}


}
