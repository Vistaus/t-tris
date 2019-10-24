import QtQuick 2.0
import Qt.labs.settings 1.0

import "../js/Configuration.js" as Config

MouseArea {
    id: root
    property point origin
    property real xStep: parent.width / settings.swipeRatio
    property real yStep: parent.height / settings.swipeRatio
    property int currentPos: 0
    property int currentYPos: 0
    property bool isMoving: false
    property int nbRound: 0
    property var lastSwipeDownActionDate: Date.now()
    property var lastSwipeHorizontalActionDate: Date.now()

    readonly property  int  minActionInterval: 300 //minimum time in ms between 2 actions
    signal move(int x, int y)
    signal swipe(int action)

    onNbRoundChanged: {
        root.isMoving = false
    }


    onPressed: {
        drag.axis = Drag.None
        origin = Qt.point(mouse.x, mouse.y)
        currentPos = Math.round(mouse.x / xStep)
        currentYPos = Math.round(mouse.y / yStep)
        root.isMoving = true
    }

    onPositionChanged: {
        if (!root.isMoving) return

        //y move ?
        var nbYSteps = Math.round(mouse.y / yStep)
        if (nbYSteps > currentYPos){
            drag.axis= Drag.YAxis
            swipe(Config.KEY_STEP_DOWN)
            lastSwipeDownActionDate = Date.now()

            currentYPos = nbYSteps
            return
        }



        //x move ?
        var nbSteps = Math.round(mouse.x / xStep)
        if (nbSteps !== currentPos) {
            drag.axis= Drag.XAxis
            if (nbSteps > currentPos){
                swipe(Config.KEY_RIGHT)
            }else if (nbSteps < currentPos) {
                swipe(Config.KEY_LEFT)
            }
        }
        currentPos = nbSteps




    }

    onClicked: {
        if (drag.axis===Drag.None) {
            swipe(Config.KEY_UP)
        }
    }

    onReleased: {
        if (!root.isMoving) return;
       //if (lastSwipeDownActionDate + minActionInterval >= Date.now() ) return
        var velocity

        if (drag.axis===Drag.YAxis ){

            velocity = (mouse.y - origin.y) / (Date.now() - lastSwipeDownActionDate)
            //console.log("velocity:" + velocity)
            if (velocity > 1.5){
                swipe(Config.KEY_DOWN)
                lastSwipeDownActionDate = Date.now()
                drag.axis = Drag.None
            }

        }


    }


}
