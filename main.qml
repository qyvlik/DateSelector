import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

ApplicationWindow {
    title: qsTr("Hello World")
    width: 640
    height: 480
    visible: true

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("E&xit")
                onTriggered: Qt.quit();
            }
        }
    }

    ScrollView{
        anchors.fill: parent
        GroupBox {
            title: qsTr("Date")
            anchors.centerIn: parent
            Column{
                spacing: 10
                ColumnLayout {
                    spacing: 10
                    DateSelector{
                        id: dateSelector
                        startYear: 2000
                        endYear: 2016
                    }
                    Text{
                        text: dateSelector.date
                    }
                }
                ColumnLayout {
                    spacing: 10
                    DateTumbler{
                        id: dateTumbler
                        startYear: 2000
                        endYear: 2016
                    }
                    Text{
                        text: dateTumbler.date
                    }
                }
            }
        }
    }
}
