import QtQuick 1.0
import "../common"


Item {
	width: parent.width
	height: t1.height+t2.height+t3.height+t4.height

	SystemPalette{id: palette}

	Column{
		id: content
		width: parent.width
		Text {id: t1; font.pixelSize: 25; font.family: "Arial"; wrapMode: Text.Wrap; width: parent.width-10; color: palette.text; text: street1
			Component.onCompleted: height = text.length > 0 ? height : 0}
		Text {id: t2; font.pixelSize: 25; font.family: "Arial"; wrapMode: Text.Wrap; width: parent.width-10; color: palette.text; text: street2
			Component.onCompleted: height = text.length > 0 ? height : 0}
		Text {id: t3; font.pixelSize: 25; font.family: "Arial"; wrapMode: Text.Wrap; width: parent.width-10; color: palette.text; text: city + ", "+ postalCode
			Component.onCompleted: height = text.length > 0 ? height : 0}
		Text {id: t4; font.pixelSize: 25; font.family: "Arial"; wrapMode: Text.Wrap; width: parent.width-10; color: palette.text; text: phone
			Component.onCompleted: height = text.length > 0 ? height : 0}

	}



}
