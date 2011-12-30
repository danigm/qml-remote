import QtQuick 1.0

Rectangle {
    property string text
    property string key
    width: 85
    height: 30

    color: "blue"
    radius: 5

    Text {
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "white"
        text: parent.text
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            xte.send(server, port, "key " + key)
        }
    }
}
