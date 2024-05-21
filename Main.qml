// Written by group11
//Develop a bilibili application

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

ApplicationWindow{
    id:window
    width: 1200
    height: 740
    visible: true
    title: qsTr("Hello Bili")
    color: "#ffffff"

    Row{
        anchors.fill: parent
        LeftSideBar{
            width: 60
            height: parent.height
        }
    }

}
