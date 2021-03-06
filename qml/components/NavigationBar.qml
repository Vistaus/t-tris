import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

ToolBar {
    id:toolBar

    property color txtColor: "white"

    signal backPressed


    background: Rectangle{
        anchors.fill: toolBar
        color:toolBar.txtColor
        opacity: 0.2
    }

    RowLayout {

        anchors.fill: parent
        ToolButton {
            id: toolButtonLeft
            contentItem: Image {
                id:navImage
                fillMode: Image.Pad
                sourceSize.width: toolButtonLeft.height  * 0.4
                sourceSize.height: toolButtonLeft.height  * 0.4
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                source: "/assets/back.svg"
            }

            ColorOverlay{
                source: navImage
                anchors.fill: navImage
                color: "white"
            }

            onClicked: {
                toolBar.backPressed()
                pageStack.pop(null)
            }


        }

        Text {
            id: score
            anchors { horizontalCenter: parent.horizontalCenter;  verticalCenter: parent.verticalCenter;}
            color: toolBar.txtColor
            text: title


        }

    }
}
