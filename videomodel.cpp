#include "videomodel.h"
#include <QJsonArray>
#include <QJsonValue>
#include <QJsonObject>

VideoModel::VideoModel(QObject *parent)
    : QAbstractListModel{parent}
{

}

int VideoModel::rowCount(const QModelIndex &parent) const
{
    if(parent.isValid())
        return 0;
    return m_videoList.count();
}

QVariant VideoModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid())
        return QVariant();

    const VideoData* videoData = m_videoList.at(index.row());
    if(role == titleRole){
        return videoData->title();
    }
    else if(role == authorNameRole)
        return videoData->authorName();
    else if(role == imageSourceRole)
        return videoData->imageSource();
    else if(role == videoSourceRole)
        return videoData->videoSource();
    else
        return QVariant();
}

QHash<int, QByteArray> VideoModel::roleNames() const
{
    static QHash<int, QByteArray> mapping {
        {titleRole, "title"},
        {authorNameRole, "authorName"},
        {imageSourceRole, "imageSource"},
        {videoSourceRole, "videoSource"}
    };
    return mapping;
}


//解析json数据
void VideoModel::processData(const QJsonArray &recommendVideos)
{
    foreach (const QJsonValue &videoValue, recommendVideos) {
        if (videoValue.isObject()) {
            QJsonObject videoObject = videoValue.toObject();
            QUrl imageUrl(videoObject.value("imageUrl").toString());//获取到json数据里名为imageUrl的数据
            QUrl videoUrl(videoObject.value("videoUrl").toString());
            QString authorName = videoObject.value("anthorName").toString();
            QString title = videoObject.value("title").toString();

            // 创建 VideoModel 对象并存储到 m_videoList 中
            VideoData* videoData = new VideoData(title, authorName, imageUrl, videoUrl);
            m_videoList.append(videoData);
        } else {
            qDebug() << " no json object.";
        }
    }
}






