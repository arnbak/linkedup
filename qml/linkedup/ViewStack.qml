import QtQuick 1.0

Item {
	id: root
	width: parent.width
	height: parent.height

	Profile{ //home page
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
		onClicked: viewConnection.xml = xml
	}

	Mail{
		id: mail
		anchors.fill: parent
		anchors.leftMargin: 10
		visible: false
	}

	ViewConnection{ //views a user's profile
		id: viewConnection
		anchors.fill: parent
		anchors.margins: 10
		visible: false
		onXmlChanged: root.state = "viewConnection"
	}

	SelfConnections{ //all connections in current users network
		id: connections
		anchors.fill: parent
		anchors.margins: 10
		visible: false
		onClicked: viewConnection.xml = xml
	}

	News{
		id: news
		anchors.fill: parent
		anchors.margins: 10
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
		},
		State {
			name: "mail"
			PropertyChanges {target: mail; visible: true}
		},
		State {
			name: "viewConnection"
			PropertyChanges {target: viewConnection; visible: true}
		},
		State {
			name: "connections"
			PropertyChanges {target: connections; visible: true}
		},
		State {
			name: "news"
			PropertyChanges {target: news; visible: true}
		}
	]
}
