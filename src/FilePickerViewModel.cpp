#include "inc/FilePickerViewModel.hpp"
#include <iostream>
#include <QDir>

FilePickerViewModel::FilePickerViewModel(QObject *parent)
    : m_currentDir(QDir::currentPath())
    ,  QObject(parent)
{
//    m_videoPath = "file:///media/sf_lwp/demo.wmv";
    m_videoPath = "file:///media/sf_lwp/AlarmLED_Segment_0_x264.mp4";
    std::cout << "Current dir: " << QDir::currentPath().toStdString() << std::endl;
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

void FilePickerViewModel::selectFile()
{
    std::cout << "Hello" << std::endl;

}
