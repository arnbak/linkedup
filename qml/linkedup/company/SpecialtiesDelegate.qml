import QtQuick 1.0
import "../common"


Item {
	width: parent.width
	height :content.height

	SystemPalette{id: palette}

	Text {id: content; font.pixelSize: 25; font.family: "Arial"; wrapMode: Text.Wrap; width: parent.width-10; color: palette.text; text: specialty}


}
