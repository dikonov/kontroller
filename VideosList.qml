import QtQuick 2.0
import QtQuick.Controls 1.1
import eu.tgcm 1.0

Rectangle
{
    color:"#000"
    Text {
        id: upbtn
        text: qsTr("Sources")
        MouseArea {
            id:area
            onClicked: if(stackedview.depth > 1)
                       popCurrentView();
            anchors.fill: parent
        }
        color: "#00D"
        font.bold: true
        anchors.top:parent.top
        anchors.topMargin: 5
        anchors.leftMargin: 10
        anchors.left: parent.left
        onTextChanged: trimText();
        height: 60
    }

    function trimText()
    {
        if(upbtn.paintedWidth > (width - upbtn.height - 20))
        {
            upbtn.text = upbtn.text.substring(0, 3) + "..." + upbtn.text.substring(13);
        }
    }

    Image {
        id:refreshbtn
        height: upbtn.height
        width:height
        source: "icons/refresh.png"
        anchors.right: parent.right
        anchors.top:parent.top
        anchors.topMargin: 5
        anchors.rightMargin: 10
        MouseArea {
            anchors.fill: parent
            onClicked: stackedview.currentItem.refresh()
            onPressAndHold: stackedview.currentItem.refreshCollection()
        }
    }

    Keys.onBackPressed: popCurrentView()

    StackView
    {
        anchors.top: upbtn.bottom
        anchors.topMargin: upbtn.height * 0.1
        anchors.bottom:parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        id: stackedview
        initialItem: VideoPage {
            browsingMode: ""
            browsingValue: ""
            label: ""
        }
        Component.onCompleted: {
            initialItem.mediaClicked.connect(pushNewPage)
            initialItem.fileClicked.connect(playTheFile)
        }
    }

    function pushNewPage(filetype, file, label)
    {
        if(filetype === "")
        {
            return;
        }
        upbtn.text = label;
        if(videoPageComponent.status === Component.Ready)
        {
            var newView = videoPageComponent.createObject(stackedview, {
                                                     browsingMode: filetype,
                                                     browsingValue: file,
                                                     label : label
                                                 });
            newView.mediaClicked.connect(pushNewPage)
            newView.fileClicked.connect(playTheFile)
            stackedview.push(newView)
        }
    }

    function playTheFile(file)
    {

    }

    function popCurrentView()
    {
        stackedview.pop()
        if(stackedview.depth > 1)
            upbtn.text = stackedview.get(stackedview.depth - 1).label
        else
            upbtn.text = "Sources";
    }

    property var videoPageComponent

    Component.onCompleted: {
        videoPageComponent = Qt.createComponent("VideoPage.qml")
    }
}



