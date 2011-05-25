import QtQuick 1.0
import "common/user"

Rectangle {
	id: root
	width: parent.width; height: parent.height

	property alias xml: user.xml

	User{
		id: user
		anchors.fill: parent
	}


}
