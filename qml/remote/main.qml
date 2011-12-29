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

    TextInput {
        id: serverInput
        text: server

        onTextChanged: {
            server = text
        }
    }

    Rectangle {
        id: mouseDrag
        border.width: 1
        border.color: "black"
        color: "gray"

        anchors.top: serverInput.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("clicked");
            }
            onPressed: {
                prevX = mouseX;
                prevY = mouseY;
            }
            onReleased: {
                prevX = 0;
                prevY = 0;
            }
            onPositionChanged: {
                xpos += mouseX - prevX;
                ypos += mouseY - prevY;

                console.log("drag (" + xpos + ", " + ypos + ")");
                xte.send(server, port, "mousermove " + xpos + " " + ypos);

                prevX = mouseX;
                prevY = mouseY;
            }
        }
    }

}
