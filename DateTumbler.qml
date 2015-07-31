import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Private 1.0

Control{

    property int startYear: 2000
    property int endYear: 2015


    implicitHeight: rowLayout.height+2
    implicitWidth: rowLayout.width+2

    // I don't why the month value sub one will be success
    property date date: new Date(
                            Number(yearSelect.model[yearSelect.currentIndex]),
                            Number(monthSelect.model[monthSelect.currentIndex])-1,
                            Number(daySelect.model[daySelect.currentIndex]),
                            1,1,1)

    Rectangle{
        anchors.fill: parent
        color: "white"
        border.color: "#ccc"
        border.width: 2
    }

    RowLayout {
        id: rowLayout
        //spacing: 10
        clip: true
        anchors.centerIn: parent
        height: 60 * __screen()

        readonly property var leapYearMonthDaysCountList: [31,29,31,30,31,30,31,31,30,31,30,31]
        readonly property var yearMonthDaysCountList: [31,28,31,30,31,30,31,31,30,31,30,31]

        function __isLeapYear(year){ return ((year%4==0&&year%100!=0) ||year%400==0); }

        function __getDaysCount(year, month){
            var __year = Number(year);
            var __month = Number(month);
            return __isLeapYear(year) ? __get(1, leapYearMonthDaysCountList[__month-1]):
                              __get(1, yearMonthDaysCountList[__month-1]);
        }

        // 1970 ~ 2100
        function __get(from, to){
            var result = [];
            while(from <= to) {
                result.push(from++);
            }
            return result;
        }

        function __screen(){
            switch(Qt.platform.os)
            {
            case "android":
            case "blackberry":
            case "ios":
                return 1.0;
            case "linux":
            case "osx":
            case "unix":
            case "windows":
            case "wince":
            default:
                return 0.5
            }
        }

        ListView {
            id: yearSelect

            Layout.fillHeight: true
            Layout.minimumWidth: 100
            Layout.preferredWidth: 120

            model: rowLayout.__get(startYear, endYear)
            currentIndex: 1

            highlightRangeMode: ListView.StrictlyEnforceRange
            snapMode: ListView.SnapOneItem;
            boundsBehavior: ListView.StopAtBounds

            delegate:
                Rectangle{
                color: "transparent"
                border.color: "#ccc"
                border.width: 1
                width: yearSelect.width
                height: yearSelect.height
                Text{
                    anchors.centerIn: parent
                    font.family: "微软雅黑"
                    text: yearSelect.model[index]
                }
            }
        }

        Text{
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("年")
            font.family: "微软雅黑"
        }

        ListView {
            id: monthSelect

            Layout.fillHeight: true
            Layout.minimumWidth: 100
            Layout.preferredWidth: 120

            model:rowLayout.__get(1, 12)
            currentIndex: 1

            highlightRangeMode: ListView.StrictlyEnforceRange
            snapMode: ListView.SnapOneItem
            boundsBehavior: ListView.StopAtBounds

            delegate:
                Rectangle{
                color: "transparent"
                border.color: "#ccc"
                border.width: 1
                width: monthSelect.width
                height: monthSelect.height
                Text{
                    anchors.centerIn: parent
                    font.family: "微软雅黑"
                    text: monthSelect.model[index]
                }
            }
            Component.onCompleted: {
                console.log(monthSelect.model)
            }
        }

        Text{
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("月")
            font.family: "微软雅黑"
        }

        ListView {
            id: daySelect

            Layout.fillHeight: true
            Layout.minimumWidth: 100
            Layout.preferredWidth: 120

            highlightRangeMode: ListView.StrictlyEnforceRange
            snapMode: ListView.SnapOneItem
            boundsBehavior: ListView.StopAtBounds

            model: rowLayout.__getDaysCount(yearSelect.model[yearSelect.currentIndex],
                                            monthSelect.model[monthSelect.currentIndex])
            delegate:
                Rectangle{
                color: "transparent"
                border.color: "#ccc"
                border.width: 1
                width: daySelect.width
                height: daySelect.height
                Text{
                    anchors.centerIn: parent
                    font.family: "微软雅黑"
                    text: daySelect.model[index]
                }
            }
        }

        Text{
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("日")
            font.family: "微软雅黑"
        }
    }
}

