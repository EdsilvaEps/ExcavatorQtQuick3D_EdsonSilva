import QtQuick
import MyModule

Item {
    id: root
    width: 150
    height: 150
    /*anchors {
        bottom: parent.bottom
        horizontalCenter: parent.horizontalCenter
        bottomMargin: 20
    }*/

    // Knob properties
    readonly property real radius: width / 2
    readonly property real knobRadius: 30

    // public api
    property string command: "None"
    property string upLabel: "Up"
    property string downLabel: "Down"
    property string leftLabel: "Left"
    property string rightLabel: "Right"


    // Bg circle
    Rectangle {
        anchors.fill: parent
        radius: root.radius // round it
        color: "#33333388"
    }

    // Action labels defined by the user (ex: lift, down, left, right)
    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: parent.width
        height: parent.height / 3
        color: "transparent"
        Text {
            anchors.centerIn: parent
            text: root.upLabel
            color: "white"
            font.bold: true
        }
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height / 3
        color: "transparent"
        Text {
            anchors.centerIn: parent
            text: root.downLabel
            color: "white"
            font.bold: true
        }
    }

    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        width: parent.width / 3
        height: parent.height
        color: "transparent"
        Text {
            anchors.centerIn: parent
            text: root.leftLabel
            color: "white"
            font.bold: true
        }
    }

    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        width: parent.width / 3
        height: parent.height
        color: "transparent"
        Text {
            anchors.centerIn: parent
            text: root.rightLabel
            color: "white"
            font.bold: true
        }
    }

    // movable knob
    Rectangle {
        id: knob
        width: root.knobRadius * 2
        height: root.knobRadius * 2
        radius: root.knobRadius
        color: "#ffffffcc"

        // cannot use anchoring with a draggable element
        // so we hardcode the knob position
        x: root.width / 2 - width / 2
        y: root.height / 2 -  height / 2


        MouseArea {
            anchors.fill: parent
            drag.target: knob
            drag.axis: Drag.XAndYAxis

            drag.minimumX: 0
            drag.maximumX: root.width - parent.width
            drag.minimumY: 0
            drag.maximumY: root.height - parent.height

            onPositionChanged: {
                parent.color = 'red'
                // calculate the knob's position relative to the center to determine the region
                let centerPos = root.radius - root.knobRadius
                // distance moved from center
                let dx = knob.x - centerPos
                let dy = knob.y - centerPos

                // normalize (distance between -1 and +1, for example, -1 being full left and +1 full right)
                let nx = dx / (root.radius - root.knobRadius)
                let ny = dy / (root.radius - root.knobRadius)

                // TODO: add diagnoal regions to the joystick:
                /*if (nx < -0.6 && ny < -0.6) {
                    root.command = root.upLeftLabel
                } else if (nx > 0.6 && ny < -0.6) {
                    root.command = root.upRightLabel
                } else if (nx < -0.6 && ny > 0.6) {
                    root.command = root.downLeftLabel
                } else if (nx > 0.6 && ny > 0.6) {
                    root.command = root.downRightLabel
                }*/

                // Determine region the user has selected
                if (Math.abs(nx) < 0.4 && ny < -0.6) {
                    root.command = root.upLabel //"Lift"
                } else if (Math.abs(nx) < 0.4 && ny > 0.6) {
                    root.command = root.downLabel //"Lower"
                } else if (Math.abs(ny) < 0.4 && nx < -0.6) {
                    root.command = root.leftLabel // "Left"
                } else if (Math.abs(ny) < 0.4 && nx > 0.6) {
                    root.command = root.rightLabel // "Right"
                } else {
                    root.command = "None"
                }
            }

            onReleased: {
                // reset to center
                parent.color = '#ffffffcc'
                knob.x = root.radius - root.knobRadius
                knob.y = root.radius - root.knobRadius

                root.command = "None"
            }
        }

    }
}
