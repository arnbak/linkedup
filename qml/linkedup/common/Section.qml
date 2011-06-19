import QtQuick 1.0


Item{
	id: root
	width:  parent.width
	height: button.shown ? button.height + list.expanedHeight : button.height


	property alias expandedWidth: background.width
	property alias backgroundColor: background.color

	property alias model: list.model
	property Component delegate
	property int expandedHeight: 0
	property alias count: list.count
	property alias text: button.text

	property alias orientation: list.orientation
	property alias interactive: list.interactive
	property alias snapMode: list.snapMode
	property alias listClip: list.clip
	property alias listSpacing: list.spacing
	property alias cacheBuffer: list.cacheBuffer
	property alias flickDeceleration: list.flickDeceleration

	Behavior on height { NumberAnimation{ duration: 250}}

	SystemPalette{id:palette}

	SectionButton{
		id: button
		shown: true

		ListView{

			id: list
			z:-1

			property int expanedHeight : root.expandedHeight ? root.expandedHeight : contentHeight

			height: 0
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.top: parent.top
			anchors.topMargin: 10
			anchors.leftMargin: 20
			anchors.rightMargin: 20
			spacing: 30
			interactive: false
			opacity: 0
			delegate: root.delegate

			Behavior on anchors.topMargin {PropertyAnimation{target: list; property: "y"; easing.type: Easing.OutExpo; duration: 250} }
			Behavior on opacity {NumberAnimation{duration: 250}}
			Behavior on height {NumberAnimation{duration: 250}}

			Rectangle{
				id: background


				anchors.fill: list
				anchors.leftMargin: -10
				anchors.rightMargin: -10
				anchors.topMargin: -10
				anchors.bottomMargin: -10
				color: palette.dark
				radius: 5
				z:-2
			}

			states: [
				State {
					name: "shown"
					when: button.shown
					PropertyChanges {target: list; anchors.topMargin: button.height; opacity: 1; height: expanedHeight}
				}
			]

		}
	}
}
