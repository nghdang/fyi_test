#pragma once

#include <QObject>
#include <QUrl>

class FilePickerViewModel : public QObject
{
    Q_OBJECT


    Q_PROPERTY(QUrl currentDir READ getCurrentDir WRITE setCurrentDir NOTIFY currentDirChanged);
    Q_PROPERTY(QString videoPath READ getVideoPath NOTIFY videoPathChanged);
public:
    explicit FilePickerViewModel(QObject *parent = nullptr);
    virtual ~FilePickerViewModel();

    QUrl getCurrentDir();
    void setCurrentDir(QUrl value);

    QString getVideoPath();

    Q_INVOKABLE void selectFile();

signals:
    void currentDirChanged();
    void videoPathChanged();

private:
    QUrl m_currentDir;
    QString m_videoPath;
};

