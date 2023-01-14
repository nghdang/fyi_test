#include "inc/FilePickerViewModel.hpp"
#include <iostream>
#include <QDir>

FilePickerViewModel::FilePickerViewModel(QObject *parent)
    : m_currentDir(QDir::currentPath())
    , m_videoPath("file:///home/dang/workspace/fyi_test/res/graphics/that_girl.mp4")
    ,  QObject(parent)
{
}

FilePickerViewModel::~FilePickerViewModel()
{

}

QUrl FilePickerViewModel::getCurrentDir()
{
    return m_currentDir;
}

void FilePickerViewModel::setCurrentDir(QUrl value)
{
    if (value != m_currentDir)
    {
        m_currentDir = value;
        emit currentDirChanged();
    }
}

QString FilePickerViewModel::getVideoPath()
{
    return m_videoPath;
}

void FilePickerViewModel::setVideoPath(QString value)
{
    if (value != m_videoPath)
    {
        m_videoPath = value;
        emit videoPathChanged();
    }
}

void FilePickerViewModel::selectFile()
{
    std::cout << "Hello" << std::endl;

}
