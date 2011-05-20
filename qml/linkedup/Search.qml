import QtQuick 1.0
import "search"

Rectangle {
	width: 800; height: 480
//	width: parent.width; height: parent.height

	SearchBar{
		anchors.top: parent.top
		anchors.margins: 10
	}
}
