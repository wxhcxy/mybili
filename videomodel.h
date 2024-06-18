#ifndef VIDEOMODEL_H
#define VIDEOMODEL_H

#include <QObject>
#include "videodata.h"
#include <QAbstractListModel>
#include <QList>

#include <QJsonArray>

//#include <QtQml/qqmlregistration.h>//注册qml的头文件
#include <QQmlEngine>

class VideoModel : public QAbstractListModel
{
    Q_OBJECT

    QML_ELEMENT
public:
    explicit VideoModel(QObject *parent = nullptr);

    Q_INVOKABLE void processData(const QJsonArray &recommendVideos);

    // Q_INVOKABLE int getIndex(QUrl videoSource);

    Q_INVOKABLE QUrl getSource(int index);

    enum Roles {
        titleRole = Qt::UserRole,
        authorNameRole,
        imageSourceRole,
        videoSourceRole
    };

protected:
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

signals:

private:
    QList<VideoData *> m_videoList;
};

#endif // VIDEOMODEL_H
