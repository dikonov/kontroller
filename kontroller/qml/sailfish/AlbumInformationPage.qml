import QtQuick 2.0
import harbour.eu.tgcm 1.0
import Sailfish.Silica 1.0
import "."

Page {
    id:main
    signal remoteClicked()
    signal currentClicked()
    signal backToMenuClicked()

    SilicaFlickable {
        clip:true
        anchors.fill: parent
        contentHeight: txtTitle.height + col.childrenRect.height

        PageHeader {
            title:service.name
            id:txtTitle
            wrapMode: Text.WordWrap
            clip:true
        }

        PullDownMenu {
            MenuItem {
                text:qsTr("Remote control")
                onClicked: remoteClicked()
            }
            MenuItem {
                text:qsTr("Currently playing")
                onClicked: currentClicked()
            }
            MenuItem {
                text:qsTr("Back to menu")
                onClicked: backToMenuClicked();
            }
        }

        VerticalScrollDecorator {}

        Image {
            id: fanart
            source: service.thumbnail
            height:parent.width / 3
            width:parent.width / 3
            fillMode: Image.PreserveAspectFit
            anchors.right: parent.right
            anchors.top:txtTitle.bottom
        }

        Column {
            id:col
            anchors.top:txtTitle.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            spacing:Theme.paddingSmall

            Label {
                anchors.left: parent.left
                anchors.leftMargin: Theme.horizontalPageMargin
                width : main.width - fanart.width - 2 * Theme.horizontalPageMargin
                text:qsTr("<b>Artists:</b> %1").arg(service.artists[0])
                color:Theme.highlightColor
                verticalAlignment: Text.AlignTop
            }
            Label {
                anchors.left: parent.left
                anchors.leftMargin: Theme.horizontalPageMargin
                width : main.width - fanart.width - 2 * Theme.horizontalPageMargin
                text:qsTr("<b>Year:</b> %1").arg((service.year !== 0)? service.year:"")
                color:Theme.highlightColor
                verticalAlignment: Text.AlignTop
            }
            Label {
                anchors.left: parent.left
                anchors.leftMargin: Theme.horizontalPageMargin
                width : main.width - fanart.width - 2 * Theme.horizontalPageMargin
                text:qsTr("<b>Label:</b> %1").arg(service.label)
                color:Theme.highlightColor
                verticalAlignment: Text.AlignTop
            }
            Label {
                anchors.left: parent.left
                anchors.leftMargin: Theme.horizontalPageMargin
                width : main.width - fanart.width - 2 * Theme.horizontalPageMargin
                text:qsTr("<b>Genre:</b> %1").arg(service.genre)
                color:Theme.highlightColor
                verticalAlignment: Text.AlignTop
                wrapMode: Text.WordWrap
            }

            Label {
                id : songslbl
                text: qsTr("Songs :")
                font.bold: true
                x:Theme.horizontalPageMargin
                color:Theme.highlightColor
            }

            Item {
                width:parent.width
                height: service.songs.length * Theme.itemSizeSmall
                Repeater {
                    id:songs
                    model:service.songs
                    delegate: Item {
                        height:Theme.itemSizeSmall
                        anchors.left: parent.left
                        anchors.right: parent.right
                        y:index * Theme.itemSizeSmall
                        IconButton {
                            icon.source:"image://theme/icon-m-add"
                            id:btnaddtopl
                            x:Theme.horizontalPageMargin
                            height: Theme.itemSizeSmall
                            width:height
                            onClicked: control.addToPlaylist(model.modelData)
                        }
                        IconButton {
                            icon.source:"image://theme/icon-m-play"
                            id:btnplay
                            x:btnaddtopl.width + Theme.horizontalPageMargin
                            height:Theme.itemSizeSmall
                            width:height
                            onClicked: control.playFile(model.modelData)
                        }
                        Label {
                            height:Theme.itemSizeSmall
                            verticalAlignment: Text.AlignVCenter
                            x:btnplay.x + btnplay.width + Theme.paddingSmall
                            text:model.modelData.label
                            clip:true
                            elide: Text.ElideMiddle
                            anchors.left: btnplay.right
                            anchors.leftMargin: Theme.horizontalPageMargin
                            anchors.right: parent.right
                            anchors.rightMargin: Theme.horizontalPageMargin
                            color:Theme.highlightColor
                        }
                    }
                }
            }

            Label {
                id:theText
                color:Theme.highlightColor
                wrapMode: Text.WordWrap
                anchors.left: parent.left
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.right: parent.right
                anchors.rightMargin: Theme.horizontalPageMargin
                font.bold: true
                text:qsTr("Description")
            }
            Label {
                color:Theme.highlightColor
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.WordWrap
                anchors.left: parent.left
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.right: parent.right
                anchors.rightMargin: Theme.horizontalPageMargin
                text:service.description
            }
        }
    }

    property alias itemId : service.albumId
    property string label
    onItemIdChanged: service.refresh()

    AlbumInformationService
    {
        id : service
    }
    MusicControl
    {
        id: control
    }

    signal mediaInformationClicked(string filetype, string file, string label)
    function refresh() { service.refresh(); }
}


