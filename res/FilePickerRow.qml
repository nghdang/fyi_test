import QtQuick 2.0

Item {
    id: root

    property bool isFolder
    property int itemHeight
    property string itemText
    property var enterDirHandler: function enterDir(path) {}
    property var selectFileHanlder: function selectFile(path) {}

    Rectangle {
        id: rowWraper
        width: root.width
        height: itemHeight
        color: "transparent"

        Rectangle {
            id: rowHighlight
            anchors.fill: parent
            visible: false
            color: "yellow"
        }

        Rectangle {
            id: rowIcon
            width: itemHeight
            height: itemHeight
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            Image {
                id: rowIconImage
                source: isFolder ? "qrc:/graphics/folder.png" : "qrc:/graphics/file.png"
            }
        }

        Text {
            id: rowText
            height: itemHeight
            anchors.left: rowIcon.right
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            text: itemText
        }

        MouseArea {
            id: rowMouseArea
            anchors.fill: parent
            onClicked: {
                root.ListView.currentIndex = index
                var path = "file://" + filePath
                if (isFolder) {
                    enterDirHandler(path)
                } else {
                    selectFileHanlder(path)
                }
            }
        }

        states: [
            State {
                name: "pressed"
                when: rowMouseArea.pressed
                PropertyChanges {
                    target: rowHighlight
                    visible: true
                }
            }
        ]
    }
}
