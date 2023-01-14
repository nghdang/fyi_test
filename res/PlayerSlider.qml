import QtQuick 2.0

Rectangle {
    property int value: 0
    property int maximumValue: 100

    signal seeked(int seekValue)

    id: slider
    color: "darkGray"
    height: 5
    radius: 5

    function calculateWidth() {
        return slider.width * (value / maximumValue)
    }

    Rectangle {
        id: playedBar
        anchors.verticalCenter: parent.verticalCenter
        width: calculateWidth()
        radius: 5
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: "lightBlue"
            }
            GradientStop {
                position: 1.0
                color: "blue"
            }
        }
        state: "default"

        states: [
            State {
                name: "default"
                PropertyChanges {
                    target: playedBar
                    height: slider.height
                }
            },
            State {
                name: "entered"
                when: sliderMouseArea.entered
                PropertyChanges {
                    target: playedBar
                    height: slider.height + 5
                }
            }
        ]
    }

    MouseArea {
        id: sliderMouseArea
        anchors.fill: parent
        hoverEnabled: true
        onReleased: {
            slider.seeked(value)
        }
        onMouseXChanged: {
            if (sliderMouseArea.pressed && mouseX > 0 && mouseX < width) {
                value = Math.floor(maximumValue * (mouseX / width))
            }
        }
        onEntered: {
            playedBar.state = "entered"
        }
        onExited: {
            playedBar.state = "default"
        }
    }
}
