import QtQuick
import QtQuick.Controls 2.5
import QtQuick.Layouts

Item {
    // Rectangle{
    //     anchors.fill: parent
    //     color: "red"
    // }
    id:sliderItem

    Layout.alignment: Qt.AlignTop
    height: 16
    width: parent.width
    Layout.fillWidth: true
    Layout.topMargin: 20
    Slider{
        id:slider
        width: parent.width*0.98
        height: parent.height
        Layout.fillWidth: true
        anchors.centerIn: parent
        value:mediaPlayer.position/mediaPlayer.duration
        background: Rectangle{//进度条的背景
            x:slider.leftPadding
            y:slider.topPadding+(slider.availableHeight-height)/2
            width: slider.availableWidth//可用的宽度
            height: 4
            radius: 2
            color: "#bfbfbf"
            //进度条播放后句柄之前的进度条的颜色变化
            Rectangle{
                width: slider.visualPosition*parent.width//visualPosition的值为0.0~1.0,表示已播放过的进度条
                height: parent.height
                color: "#fa9bdb"
                radius: 2
            }
        }

        onMoved:{//监听句柄移动,句柄发生移动时触发
            mediaPlayer.setPosition(Math.floor(value*mediaPlayer.duration))
            //拖动或点击改变进度条位置时，更新视频播放的时间
        }

        handle:Image {//更改进度条句柄的图标
            source: "qrc:/icons/video_process_slider/my.png" // 自定义图标的路径
            width: 20
            height: 20
            x:slider.leftPadding+(slider.availableWidth-width)*slider.visualPosition
            y:slider.topPadding+(slider.availableHeight-height)/2//这里的x,y是相对父窗口Slider的定位
        }
    }


}
