import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Private 1.0
import QtQuick.Layouts 1.1

Control {
    id: dateSelector
    focus: true

    implicitHeight: _rowLayout.height
    implicitWidth: _rowLayout.width

    readonly property date date: _rowLayout.date
    property int startYear: 1970
    property int endYear: 2100

    Rectangle{
        anchors.fill: parent
        color: "transparent"
        border.width: 1
        border.color: "#ccc"
    }

    RowLayout{
        id: _rowLayout

        focus: true

        anchors.centerIn: parent

         // I don't why the month value sub one will be success
        property date date: new Date(Number(year.currentText), Number(month.currentText)-1, Number(day.currentText), 1,1,1)
        readonly property var leapYearMonthDaysCountList: [31,29,31,30,31,30,31,31,30,31,30,31]
        readonly property var yearMonthDaysCountList: [31,28,31,30,31,30,31,31,30,31,30,31]

        function __isLeapYear(year){ return ((year%4==0&&year%100!=0) ||year%400==0); }

        function __getDaysCount(year, month){
            var __year = Number(year);
            var __month = Number(month);
            var __isLeap = __isLeapYear(year);
            return __isLeap ? __get(1, leapYearMonthDaysCountList[__month-1]):
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

        ComboBox {
            id: year
            focus: true

            Layout.fillWidth: true
            Layout.minimumWidth: 100
            Layout.preferredWidth: 120

            KeyNavigation.left: day
            KeyNavigation.right: month

            model: _rowLayout.__get(startYear, endYear);

            onCurrentTextChanged: {
                _rowLayout.date.setFullYear(Number(year.currentText));
                dateSelector.dateChanged();
            }
        }

        Text{
            text: qsTr("年")
        }

        ComboBox {
            id: month
            focus: true

            Layout.fillWidth: true
            Layout.minimumWidth: 80
            Layout.preferredWidth: 100

            KeyNavigation.left: year
            KeyNavigation.right: day

            model:_rowLayout.__get(1, 12);

            onCurrentTextChanged: {
                _rowLayout.date.setMonth(Number(month.currentText));
                dateSelector.dateChanged();
            }
        }

        Text{
            text: qsTr("月")
        }

        ComboBox {
            id: day
            focus: true

            Layout.fillWidth: true
            Layout.minimumWidth: 80
            Layout.preferredWidth: 100

            KeyNavigation.left: month
            KeyNavigation.right: year

            model: _rowLayout.__getDaysCount(year.currentText, month.currentText);

            onCurrentTextChanged: {
                _rowLayout.date.setDate(Number(day.currentText));
                dateSelector.dateChanged();
            }
        }

        Text{
            text: qsTr("日")
        }
    }
}
