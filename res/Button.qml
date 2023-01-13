import QtQuick 2.0

Item {
    id: root

    property string text
    property color color

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

        MouseArea {
            id: buttonMouseArea
            anchors.fill: parent
            onClicked: root.clicked()
        }
    }
}
