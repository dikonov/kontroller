TEMPLATE = app
CONFIG += sailfish
QT += qml quick core
CONFIG(sailfish) {
  CONFIG += sailfishapp
  CONFIG += sailfishapp_i18n
  message(sailfish)
} else {
  QT += widgets
}

CONFIG+=c++11

SOURCES += main.cpp \
    downloadlocation.cpp \
    musicservice.cpp \
    statusservice.cpp \
    playlistservice.cpp \
    videoservice.cpp \
    deviceinformation.cpp \
    artistinformationservice.cpp \
    albumsrequest.cpp \
    songsrequest.cpp \
    albuminformationservice.cpp \
    musiccontrol.cpp \
    videocontrol.cpp \
    movieinformationservice.cpp \
    tvshowinformationservice.cpp \
    tvshowseasonsrequest.cpp \
    seasoninformationservice.cpp \
    tvshowepisodesrequest.cpp \
    utils.cpp \
    episodeinformationservice.cpp \
    playlistcontrol.cpp \
    playlistitem.cpp \
    playercontrol.cpp \
    subtitle.cpp \
    client.cpp \
    playinginformation.cpp \
    file.cpp \
    player.cpp \
    playerservice.cpp \
    settingsmanager.cpp \
    settings.cpp \
    remote.cpp \
    audiostream.cpp \
    server.cpp \
    themeinformation.cpp \
    downloadservice.cpp

RESOURCES += icons.qrc
CONFIG(sailfish) {
    RESOURCES += qml/sailfish/qml.qrc
#    OTHER_FILES += qml/sailfish/kontroller.qml \
#        qml/sailfish/cover/CoverPage.qml \
#        qml/sailfish/KontrollerMain.qml \
#        qml/sailfish/AlbumInformationPage.qml

} else {
#    RESOURCES += qml/generic/qml.qrc
#    message("Adding generic components to resources")
}

INCLUDEPATH += ../qjsonrpc/src

QMAKE_CXXFLAGS = -Wall

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)


equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
  LIBS += -L../qjsonrpc-Android_pour_armeabi_v7a_GCC_4_8_Qt_5_2_1-Release/src
  LIBS += -L../qjsonrpc-Android_pour_armeabi_v7a_GCC_4_8_Qt_5_5_1-Release/src
} else {
  CONFIG(sailfishapp) {
    LIBS += -L../qjsonrpc/src

#    LIBS += -L/home/whity/dev/build/qjsonrpc-MerSDK_SailfishOS_armv7hl-Release/src
  } else {
  LIBS += -L../qjsonrpc-Desktop_Qt_5_2_1_GCC_64bit-Debug/src
  LIBS += -L../qjsonrpc/src
  }
}

CONFIG(sailfishapp) {
  DEFINES+= SAILFISH_TARGET
  TARGET = harbour-kontroller
}

TRANSLATIONS += \
        translations/harbour-kontroller-en.ts \
        translations/harbour-kontroller-fr.ts \
        translations/harbour-kontroller-ru.ts \
        translations/harbour-kontroller-sv.ts

TRANSLATION_SOURCES += $$PWD/*.cpp

#LIBS += -L../build-qjsonrpc-Android_pour_armeabi_v7a_GCC_4_8_Qt_5_2_1-Debug/src
LIBS += -llibqjsonrpc.a

HEADERS += \
    downloadlocation.h \
    musicservice.h \
    statusservice.h \
    playlistservice.h \
    videoservice.h \
    deviceinformation.h \
    artistinformationservice.h \
    utils.h \
    albumsrequest.h \
    songsrequest.h \
    albuminformationservice.h \
    musiccontrol.h \
    videocontrol.h \
    movieinformationservice.h \
    tvshowinformationservice.h \
    tvshowseasonsrequest.h \
    seasoninformationservice.h \
    tvshowepisodesrequest.h \
    episodeinformationservice.h \
    playlistcontrol.h \
    playlistitem.h \
    playercontrol.h \
    subtitle.h \
    client.h \
    playinginformation.h \
    file.h \
    player.h \
    playerservice.h \
    settingsmanager.h \
    settings.h \
    remote.h \
    audiostream.h \
    server.h \
    themeinformation.h \
    downloadservice.h

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

    OTHER_FILES += \
        android/AndroidManifest.xml
}

CONFIG(sailfishapp) {
  OTHER_FILES +=
        translations/*.ts \

}

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
#    ANDROID_EXTRA_LIBS = ../qjsonrpc-Android_pour_armeabi_v7a_GCC_4_8_Qt_5_5_1-Release/src/libqjsonrpc.so
    ANDROID_EXTRA_LIBS = ../qjsonrpc-android/src/libqjsonrpc.so
}

CONFIG(sailfishapp) {
DISTFILES += kontroller.prf \
    harbour-kontroller.desktop

#lib.path = /usr/share/harbour-kontroller/lib/
#lib.files += ../qjsonrpc/src/libqjsonrpc.so.1

#INSTALLS += lib
}
