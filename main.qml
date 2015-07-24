import QtQuick 2.4
import QtQuick.Controls 1.3


ApplicationWindow {
    id: window
    title: qsTr("date selector");
    width: 600
    height: 400

    DateSelector{
        focus: true
        startYear: 2000
        endYear: 2016

        anchors.centerIn: parent

        onDateChanged: {
            console.log(date);
        }
    }
}
