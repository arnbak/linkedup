import QtQuick 1.0

XmlListModel{
	id: root

	query: "/updates/update"

	XmlRole { name: "updateType"; query: "update-type/string()"; isKey: true}
	XmlRole { name: "updateKey"; query: "update-key/string()"; isKey: true}
	XmlRole { name: "isLikable"; query: "is-likable/string()"; isKey: true}
	XmlRole { name: "isLiked"; query: "is-liked/string()"; isKey: true}

	XmlRole { name: "isCommentable"; query: "is-commentable/string()"; isKey: true}

	XmlRole { name: "id"; query: "update-content/person/id/string()"; isKey: true}
	XmlRole { name: "firstName"; query: "update-content/person/first-name/string()"; isKey: true }
	XmlRole { name: "lastName"; query: "update-content/person/last-name/string()"; isKey: true }
	XmlRole { name: "headline"; query: "update-content/person/headline/string()"; isKey: true}
	XmlRole { name: "pictureUrl"; query: "update-content/person/picture-url/string()"; isKey: true }

	XmlRole { name: "newId"; query: "update-content/person/connections/person/id/string()"; isKey: true}
	XmlRole { name: "newFirstName"; query: "update-content/person/connections//person/first-name/string()"; isKey: true }
	XmlRole { name: "newLastName"; query: "update-content/person/connections//person/last-name/string()"; isKey: true }
	XmlRole { name: "newHeadline"; query: "update-content/person/connections//person/headline/string()"; isKey: true}
	XmlRole { name: "newPictureUrl"; query: "update-content/person/connections//person/picture-url/string()"; isKey: true }
	XmlRole { name: "newIndustry"; query: "update-content/person/connections//person/industry/string()"; isKey: true}


}
