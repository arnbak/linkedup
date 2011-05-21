import QtQuick 1.0

Item {
	width: parent.width
	height: parent.height

	Profile{
		id: profile
		anchors.fill: parent
		anchors.leftMargin: 10
		visible: false
	}

	Search{
		id: search
		anchors.fill: parent
		anchors.leftMargin: 10
		visible: false
	}



	states: [
		State {
			name: "profile"
			PropertyChanges {target: profile; visible: true}
		},
		State {
			name: "search"
			PropertyChanges {target: search; visible: true}
		}
	]
}
