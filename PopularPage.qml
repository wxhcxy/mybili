import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtMultimedia
import Qt5Compat.GraphicalEffects

import mybili //导入从c++注册的qml  有NetworkHttp类



GridView {
    id: gridView
    property alias videoModelAlias: videoModel
    focus: true
    //flickableDirection: Flickable.VerticalFlick
    leftMargin: window.width*0.02
    cellWidth: (window.width-60)*0.24
    cellHeight:(window.width-60)*0.22
    ScrollBar.vertical: ScrollBar{}//给GridView加上一个垂直的滚动条
    delegate: VideoDelegate {
        selectTapHandler.onTapped: {
            console.log(model.videoSource)
            playVideoWindow.videoSource = model.videoSource
            playVideoWindow.mediaPlay.index = gridView.model.getIndex(model.videoSource)  //获取视频索引
            playVideoWindow.mediaPlay.sum = gridView.model.rowCount()   //获取视频总个数
            playVideoWindow.show()    //playVideo是在Main.qml里用的自定义的PlayVideoView
            playVideoWindow.mediaPlay.play()//这一行代码，实现效果点击视频后弹出的窗口立马自动播放视频
            playVideoWindow.videoOutPutAlias.forceActiveFocus()//进入播放窗口后，将键盘焦点给播放窗口，控制快进后退等
        }

        Keys.onPressed: (event) =>{
                            switch (event.key) {
                                case Qt.Key_Return://Qt.Key_Return这个才是回车键Enter
                                //console.log("enter")
                                //playSignal(model.videoSource)//发射播放信号，携带视频信息参数
                                {
                                    console.log(model.videoSource)
                                    playVideoWindow.videoSource = model.videoSource
                                    playVideoWindow.show()    //playVideo是在Main.qml里用的自定义的PlayVideoView
                                    playVideoWindow.mediaPlay.play()//这一行代码，实现效果点击视频后弹出的窗口立马自动播放视频
                                    playVideoWindow.videoOutPutAlias.forceActiveFocus()//进入播放窗口后，将键盘焦点给播放窗口，控制快进后退等
                                }
                                break;
                            }
                        }
    }

    NetworkHttp {
        id: networkHttp
    }
    VideoModel {
        id: videoModel
    }

    //http网络请求，拿到视频数据
    Component.onCompleted: {
        getVideosList()
        console.log("PopularPage.qml In GridView")
    }

    function getVideosList() {
        function onReply(reply) { //这里的reply参数，是有networkputils.cpp中的replySignal信号发送传递过来的
            networkHttp.onReplySignal.disconnect(onReply);
            var popularVideos = JSON.parse(reply) //将string转成json数据
            videoModel.processData(popularVideos) //将请求到的数据传递给playercontroller的m_videosList
            gridView.model = videoModel
            console.log(gridView.count)
        }
        //绑定一个信号replySignal
        networkHttp.onReplySignal.connect(onReply); //绑定一个信号replySignal,要加on,首字母大写R
        networkHttp.sendRequest("popular");
    }
}



