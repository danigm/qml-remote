// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import Xte 1.0

Rectangle {
    width: 360
    height: 360

    property int xpos: 0
    property int ypos: 0
    property int prevX: 0
    property int prevY: 0

    property string server: "192.168.2.1"
    property int port: 8432

    Xte {
        id: xte
    }

    Text {
        id: serverLabel
        text: "Server: "
    }

    TextInput {
        id: serverInput
        text: server

        anchors.left: serverLabel.right
        anchors.right: parent.right

        onTextChanged: {
            server = text
        }
    }

    Text {
        id: textLabel
        text: "text: "

        anchors.left: parent.left
        anchors.top: serverLabel.bottom
    }

    TextInput {
        id: textInput

        anchors.left: textLabel.right
        anchors.top: serverLabel.bottom
        anchors.right: parent.right

        onAccepted: {
            xte.send(server, port, "str " + textInput.text)
            textInput.text = ""
        }

        Rectangle {
            id: sendButton
            width: 80
            height: parent.height
            color: "#4A9EFF"
            radius: 8
            smooth: true

            anchors.right: parent.right
            anchors.margins: 5

            Text {
                text: "Send"
                anchors.centerIn: parent
                color: "white"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    xte.send(server, port, "str " + textInput.text)
                    textInput.text = ""
                }
            }
        }
    }

    Rectangle {
        id: mouseDrag
        border.width: 1
        border.color: "black"
        color: "gray"

        anchors.top: textInput.bottom
        anchors.bottom: leftButton.top
        anchors.left: parent.left
        anchors.right: parent.right

        MouseArea {
            anchors.fill: parent
            onPressed: {
                prevX = mouseX;
                prevY = mouseY;
            }
            onReleased: {
                prevX = 0;
                prevY = 0;
            }
            onPositionChanged: {
                xpos = mouseX - prevX;
                ypos = mouseY - prevY;

                console.log("drag (" + xpos + ", " + ypos + ")");
                xte.send(server, port, "mousermove " + xpos + " " + ypos);

                prevX = mouseX;
                prevY = mouseY;
            }
        }
    }

    Rectangle {
        id: leftButton
        border.width: 1
        border.color: "black"
        color: "gray"

        height: 60
        width: parent.width * 0.45

        anchors.bottom: parent.bottom
        anchors.left: parent.left

        MouseArea {
            anchors.fill: parent
            onPressed: {
                console.log("left button pressed")
                xte.send(server, port, "mousedown 1")
            }
            onReleased: {
                console.log("left button released")
                xte.send(server, port, "mouseup 1")
            }
        }
    }

    Rectangle {
        id: middleButton
        border.width: 1
        border.color: "black"
        color: "gray"

        height: 60
        width: parent.width * 0.1

        anchors.bottom: parent.bottom
        anchors.left: leftButton.right
        anchors.top: leftButton.top

        Rectangle {
            id: scroll

            border.width: 1
            border.color: "black"
            color: "red"

            height: parent.height / 2
            y: (parent.height - height) / 2

            onYChanged: {
                if (y == scrollMA.drag.minimumY) {
                    console.log("Scroll up")
                    xte.send(server, port, "mouseclick 4")
                    repeaterTimer.button = 4
                    repeaterTimer.start()
                } else if (y == scrollMA.drag.maximumY) {
                    console.log("Scroll down")
                    xte.send(server, port, "mouseclick 5")
                    repeaterTimer.button = 5
                    repeaterTimer.start()
                } else {
                    repeaterTimer.stop()
                }
            }

            anchors {
                left: parent.left
                right: parent.right
            }

            MouseArea {
                id: scrollMA
                anchors.fill: parent
                drag.target: parent
                drag.axis: "YAxis"
                drag.minimumY: 0
                drag.maximumY: middleButton.height - scroll.height
                // drag.filterChildren: false
                onReleased: {
                    scroll.y = (middleButton.height - scroll.height) / 2
                }
                onClicked: {
                    console.log("middle clicked")
                    xte.send(server, port, "mouseclick 2");
                }
            }

            Behavior on y {
                NumberAnimation { duration: 200 }
            }
        }
    }

    Rectangle {
        id: rightButton
        border.width: 1
        border.color: "black"
        color: "gray"

        height: 60
        width: parent.width * 0.45

        anchors.bottom: parent.bottom
        anchors.left: middleButton.right
        anchors.top: leftButton.top

        MouseArea {
            anchors.fill: parent
            onPressed: {
                console.log("right button pressed")
                xte.send(server, port, "mousedown 3")
            }
            onReleased: {
                console.log("right button released")
                xte.send(server, port, "mouseup 3")
            }
        }
    }

    Timer {
        id: repeaterTimer

        property int button;
        interval: 300
        running: false
        repeat: true
        onTriggered: {
            console.log("scroll button " + button);
            xte.send(server, port, "mouseclick " + button)
        }
    }
}
