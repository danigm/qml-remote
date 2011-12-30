import QtQuick 1.0

Rectangle {
    property string text
    property string key
    width: parent.width / 4
    border.width: 1
    height: parent.height

    gradient: Gradient {
        GradientStop { position: 0.0; color: "white" }
        GradientStop { position: 0.75; color: "#ddd" }
        GradientStop { position: 1.0; color: "#aaa" }
    }

    Text {
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "black"
        text: parent.text
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            xte.send(server, port, "key " + key)
        }
    }
}
