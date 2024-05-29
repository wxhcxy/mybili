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



    RowLayout{
        anchors.fill: parent
        LeftSideBar{
            Layout.preferredWidth: 60
            Layout.preferredHeight: parent.height
            padding: 0//加上这个padding: 0，背景颜色画布动画才不会有左边和上边的方框
            z:1//设置这个是为了在切换页面时，左侧菜单栏在上方，否则切换界面时切换的界面会在其上方显示切换动画
        }
        ColumnLayout{
            Layout.preferredWidth: parent.width-80
            Layout.preferredHeight: parent.height
            //顶部工具栏
            HeadToolBar{
                id:headToolBar
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: 60
            }
            StackView {
                id: stackView
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: window.height-80
                focus: true
                initialItem:recommendPage//"RecommendPage.qml"//recommendPage

            }
        }

    }

    RecommendPage{
        id:recommendPage
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: window.height-80
    }

}
