#include "videodata.h"

VideoData::VideoData(QString title,QString authorName,QUrl imageSource,QUrl videoSource,QObject *parent)
    : QObject{parent},
    m_title{title},
    m_authorName{authorName},
    m_imageSource{imageSource},
    m_videoSource{videoSource}
{}

QUrl VideoData::imageSource() const
{
    return m_imageSource;
}

void VideoData::setImageSource(const QUrl &newImageSource)
{
    if (m_imageSource == newImageSource)
        return;
    m_imageSource = newImageSource;
    emit imageSourceChanged();
}

QUrl VideoData::videoSource() const
{
    return m_videoSource;
}

void VideoData::setVideoSource(const QUrl &newVideoSource)
{
    if (m_videoSource == newVideoSource)
        return;
    m_videoSource = newVideoSource;
    emit videoSourceChanged();
}

QString VideoData::title() const
{
    return m_title;
}

void VideoData::setTitle(const QString &newTitle)
{
    if (m_title == newTitle)
        return;
    m_title = newTitle;
    emit titleChanged();
}

QString VideoData::authorName() const
{
    return m_authorName;
}

void VideoData::setAuthorName(const QString &newAuthorName)
{
    if (m_authorName == newAuthorName)
        return;
    m_authorName = newAuthorName;
    emit authorNameChanged();
}
