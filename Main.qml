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

    Rectangle{
        id:backgroundWindow
        anchors.fill: parent
    }
    Image {
        id: backgroundImage
        visible: false
    }

    PlayVideoWindow{
        id:playVideoWindow
    }



    Row{
        anchors.fill: parent
        LeftSideBar{
            width: 60
            height: parent.height
            padding: 0//加上这个padding: 0，背景颜色画布动画才不会有左边和上边的方框
        }
        Column{
            width: parent.width-80
            height: parent.height
            //顶部工具栏
            HeadToolBar{
                id:headToolBar
                height: 60
            }
            RecommendPage{
                id:recommendPage
             }
        }

    }

}
