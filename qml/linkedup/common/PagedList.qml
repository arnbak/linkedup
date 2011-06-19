import QtQuick 1.0


Item {
	id: rootItem

	property string pageQuery : "/people-search"
	property string xml

	property string start: "0"
	property string count: "10"

	property Component delegate
	property alias	model: mainList.model

	anchors.fill: parent
	anchors.topMargin: borderHeight

	signal xmlSet
	signal xmlLoaded

	ListView{
		id: mainList

		header: headerComp
		clip: true
		spacing: 10
		anchors.fill: parent
		model: rootItem.model
		delegate: rootItem.delegate
	}

	/*
	  This model and component represent the page numbers displayed
	  along the top and bottom of the list.
	  */
	PageModel{
		id: pageModel
		query: rootItem.pageQuery
		xml: rootItem.xml
		onStatusChanged: {
			if(status === XmlListModel.Ready && xml)
				rootItem.xmlLoaded()
		}
		onXmlChanged: rootItem.xmlSet()
	}

	Component{
		id: pageComp
		PageDelegate{
			onChangePage: {
				rootItem.start = start
				rootItem.count = count
			}
		}
	}
	Component{
		id: headerComp
		ListView{
			id: pages
			clip: true
			spacing: 5
			height: 80
			model: pageModel
			anchors.left: parent.left
			anchors.right: parent.right
			orientation: ListView.Horizontal
			delegate: pageComp

		}
	}


}
