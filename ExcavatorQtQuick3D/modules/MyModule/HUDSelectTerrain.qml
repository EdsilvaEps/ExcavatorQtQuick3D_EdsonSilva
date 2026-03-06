import QtQuick
import QtQuick.Controls.Basic

Item {
    id: hud
    anchors.top: parent.top
    anchors.right: parent.right
    anchors.margins: 20
    width: column.width
    height: column.height

    signal terrainSelected(int terrainType)

    Column {
        id: column
        spacing: 10

        Button {
            id: snowBtn
            text: "Snow"
            width: 100
            height: 30
            onClicked: hud.terrainSelected(Backend.Snow)

            contentItem: Text {
                text: snowBtn.text
                color: snowBtn.down ? "#17a81a" : "#21be2b"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

        }

        Button {
            id: desertBtn
            text: "Desert"
            width: 100
            height: 30

            onClicked: hud.terrainSelected(Backend.Desert)

            contentItem: Text {
                text: desertBtn.text
                color: desertBtn.down ? "#17a81a" : "#21be2b"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }


        }
    }
}
