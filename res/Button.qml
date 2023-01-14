import QtQuick 2.0

Item {
    id: root

    property string text: ""
    property color color: "transparent"
    property url image

    signal clicked

    Rectangle {
        id: buttonRect
        anchors.fill: parent
        color: root.color

        Text {
            id: buttonText
            anchors.centerIn: parent
            text: root.text
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Image {
            id: buttonImage
            anchors.fill: parent
            source: root.image
            fillMode: Image.PreserveAspectFit
        }

        MouseArea {
            id: buttonMouseArea
            anchors.fill: parent
            onClicked: {
                root.clicked()
            }
        }
    }
}
