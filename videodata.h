#ifndef VIDEODATA_H
#define VIDEODATA_H

#include <QObject>
#include <QUrl>

class VideoData : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged FINAL)
    Q_PROPERTY(QString authorName READ authorName WRITE setAuthorName NOTIFY authorNameChanged FINAL)
    Q_PROPERTY(QUrl imageSource READ imageSource WRITE setImageSource NOTIFY imageSourceChanged FINAL)
    Q_PROPERTY(QUrl videoSource READ videoSource WRITE setVideoSource NOTIFY videoSourceChanged FINAL)
public:
    explicit VideoData(QString title, QString authorName, QUrl imageSource, QUrl videoSource, QObject *parent = nullptr);

    QUrl imageSource() const;
    void setImageSource(const QUrl &newImageSource);

    QUrl videoSource() const;
    void setVideoSource(const QUrl &newVideoSource);

    QString title() const;
    void setTitle(const QString &newTitle);

    QString authorName() const;
    void setAuthorName(const QString &newAuthorName);

signals:
    void imageSourceChanged();

    void videoSourceChanged();

    void titleChanged();

    void authorNameChanged();

private:
    QString m_title;
    QString m_authorName;
    QUrl m_imageSource;
    QUrl m_videoSource;
};

#endif // VIDEODATA_H
